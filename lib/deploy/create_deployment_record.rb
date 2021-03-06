unless Capistrano::Configuration.respond_to?(:instance)
    abort "capistrano/shared_files requires Capistrano 2"
end

if Capistrano::Configuration.instance
  Capistrano::Configuration.instance.load do

    after 'deploy:update' do
      deploy.create_deployment_record
    end

    namespace :deploy do
      task :create_deployment_record, on_error: :continue do
        require 'net/http'
        require 'socket'

        branchName = branch.nil? ? "HEAD" : branch
        availableTags = `git tag`.split( /\r?\n/ )
        haveToShowHash = !availableTags.any? { |s| s.include?(branchName) }
        current_deployed_version = branchName
        if (haveToShowHash)
          availableBranches = `git branch -a`.split( /\r?\n/ )
          fullBranchName = (branchName.eql?("HEAD")) ? branchName : availableBranches.select { |s| s.include?(branchName) }.first.to_s.strip
          fullBranchName.gsub!('*','').strip! if fullBranchName.include?('*')
          current_deployed_version += " (sha1:" + `git rev-parse --short #{fullBranchName}`.strip + ")"
        end

        server_url = find_servers[0].to_s.eql?("") ? Socket.gethostname : find_servers[0].to_s

        url = URI.parse('http://deployment-tracker.intersect.org.au/deployments/api_create')
        post_args = {'app_name'=>application,
                     'deployer_machine'=>"#{ENV['USER']}@#{Socket.gethostname}",
                     'environment'=>rails_env,
                     'server_url'=> server_url,
                     'tag'=> current_deployed_version}
        begin
          print "Sending Post request with args: #{post_args}\n"
          resp, data = Net::HTTP.post_form(url, post_args)
          case resp
            when Net::HTTPSuccess
              puts "Deployment record saved"
            else
              puts data
          end
        rescue StandardError => e
          puts e.message
        end
      end
    end
  end
end
