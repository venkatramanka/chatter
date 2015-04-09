require 'yaml'

module Chatter
  class ApplicationController < ActionController::Base
    def model
      @model ||= (YAML.load_file('config/chatter_config.yml')['chatter']['model']).constantize
    end
  end
end
