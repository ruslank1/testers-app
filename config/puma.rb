# Change to match your CPU core count
workers 1

# Min and Max threads per worker
threads 1, 6

app_dir = File.expand_path("../..", __FILE__)
shared_dir = "/var/www/light-it-03.tk/shared"

# Default to production
rails_env = ENV['RAILS_ENV'] || "production"
environment rails_env

# Set up socket location
bind "unix:///var/www/light-it-03.tk/shared/tmp/sockets/testers-app-puma.sock"

# Logging
stdout_redirect "/var/www/light-it-03.tk/shared/log/puma.stdout.log", "/var/www/light-it-03.tk/shared/log/puma.stderr.log", true

# Set master PID and state locations
pidfile "/var/www/light-it-03.tk/shared/tmp/pids/puma.pid"
state_path "/var/www/light-it-03.tk/shared/tmp/pids/puma.state"
activate_control_app

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("/var/www/light-it-03.tk/current/config/database.yml")[rails_env])
end