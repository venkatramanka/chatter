#This file reads redis configuration from chatter_config.yml 
#and creates a redis-connection object
require 'yaml'
require 'redis'
config = YAML.load_file('config/chatter_config.yml')
redis_config = config['redis'][Rails.env]
$redis = Redis.new(:host => redis_config['host'], :port => redis_config['port'])