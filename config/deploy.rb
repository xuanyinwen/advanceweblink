default_run_options[:pty] = true 

set :application, "weblink"

set :keep_releases, 5

# this stop capistrano from touch every single file after deployment
set :normalize_asset_timestamps, false

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/apps/#{application}/#{ENV['target']}"

set :port, 22

set :password, 'listenedwhilethebabyscreamed'
set :sudo_password, 'listenedwhilethebabyscreamed'

# Git Options
set :scm, :git
set :repository, "git@github.com:alisterchristie/WebLink.git"
set :git_shallow_clone, 1
         
role :app,   "deploy@173.203.86.167"
role :web,   "deploy@173.203.86.167"
role :db,    "deploy@173.203.86.167", :primary => true
role :job,   "deploy@173.203.86.167"

# possible target options are stage, dev, prod
set :target, ENV['target'] || raise("Specify the tag to deploy using the tag variable: `cap deploy tag=n.n.n.n target=stage|dev|prod`")

task :before_update_code do
  
  # if `git status` != "# On branch master\nnothing to commit (working directory clean)\n"
  #   raise("There are uncomitted or unpushed changes - #{real_revision}")
  # end

  # :branch is used by the git library, and can actually be a branch, commit or tag.
  # so to deploy a branch (ie not master) tag it and then deploy that tag
  
  set :branch, ENV['tag'] || 'HEAD' #raise("Specify the tag to deploy using the tag variable: `cap deploy tag=n.n.n.n target=stage|dev|prod`")
  
end

task :after_update_code do
  # symlink additional shared folders

  # link up server config files
  ['database.yml', 'thin.yml', 'unicorn_conf.rb'].each do |filename|
    run "rm -f #{release_path}/config/#{filename}"
    run "cd #{release_path}/config && ln -snf deploy/#{target}/#{filename} #{release_path}/config"
  end
  
  run "rm #{release_path}/public/robots.txt"
  run "cd #{release_path}/public && ln -snf ../config/deploy/#{target}/robots.txt ."

  # dragonfly
  run "rm -dfr #{release_path}/images/system"
  run "ln -s #{shared_path}/public/system #{latest_release}/public/"

end

task :before_symlink do
  #backup  can't really do a backup during deploy of addressfinder as it's so BIG.  Although this is postgres, 
  # so migrations are in transactions, so they'll roll back if there is an problems.
  # backup
  run "cd #{release_path} && rake db:migrate RAILS_ENV=production --trace"
end

task :backup, :roles => [:db] do
  
end

namespace :unicorn do

  set :unicorn_binary, "unicorn_rails"
  set :unicorn_config, "#{current_path}/config/unicorn_conf.rb"
  set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

  task :start, :roles => :app, :except => { :no_release => true } do 
    run "cd #{current_path} && #{unicorn_binary} -c #{unicorn_config} -E production -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do 
    run "kill `cat #{unicorn_pid}`"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "kill -s QUIT `cat #{unicorn_pid}`"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "kill -s HUP `cat #{unicorn_pid}`"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    reload
  end

end

namespace :deploy do

  # desc "Restarting mod_rails with restart.txt"
  # task :restart, :roles => :app, :except => { :no_release => true } do
  #   # run "touch #{current_path}/tmp/restart.txt"
  # end
  #  
  # [:start, :stop].each do |t|
  #   desc "#{t} task is a no-op with mod_rails"
  #   task t, :roles => :app do ; end
  # end
 
  task :start, :roles => [:web] do
    # run "cd #{current_path} && thin -C #{current_path}/config/thin.yml start"
    unicorn.start
    web.enable
  end
   
  task :stop, :roles => [:web] do
    web.disable
    # run "cd #{current_path} && thin -C #{current_path}/config/thin.yml stop"
    unicorn.stop
  end
     
  task :restart, :roles => [:web] do
    stop
    start
  end

  # copied from capistrano 2.1 source and modified somewhat
  task :finalize_update, :except => { :no_release => true } do
    
    # NTW TODO: need to investigate whether we actually need this or not
    run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)

    # mkdir -p is making sure that the directories are there for some SCM's that don't
    # save empty folders
    run <<-CMD
      ln -s #{shared_path}/tmp #{latest_release}/tmp &&
      ln -s #{shared_path}/log #{latest_release}/log
    CMD
    
  end 
  
  namespace :web do
    task :disable, :roles => :web, :except => { :no_release => true } do
      run "ln -snf #{current_path}/config/deploy/disabled #{current_path}/public/disabled"
    end

    task :enable, :roles => :web, :except => { :no_release => true } do
      run "rm #{current_path}/public/disabled"
    end
  end 
  
end