module Chatter
  module ApplicationHelper
  	def model
      @model ||= (YAML.load_file('config/chatter_config.yml')['chatter']['model']).constantize
    end
  end
end
