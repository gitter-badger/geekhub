require 'codeclimate-test-reporter'
CodeClimate::TestReporter.configure do |config|
  config.path_prefix = "backend" #the root of your Rails application relative to the repository root
  config.git_dir = "../" #the relative or absolute location of your git root compared to where your tests are run
end