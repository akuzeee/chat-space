server '54.65.87.124', user: 'ec2-user', roles: %w{app db web}
set :branch, ENV.fetch("CAPISTRANO_BRANCH", "master")
