class InstallGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_config
    copy_file "config.yml","config/chatter_config.yml"
    route "mount Chatter::Engine, :at => '/chat'"
    copy_file "redis.rb","config/initializers/chatter_redis.rb"
    copy_file "events.rb","config/events.rb"
    Dir.entries("app/views/layouts").select do |f|
      if !File.directory?(f)
        inject_into_file "app/views/layouts/"+f, "<%= render '/chat_footer' if session[:user_id] %>\n", before: '</body>'
      end
    end
    append_to_file "config/application.rb", "require 'websocket-rails'\n"
    append_to_file "app/assets/javascripts/application.js", "//= require websocket_rails/main\n"
    generate "model", "ConversationMapping person1:integer person2:integer conversation_id:string"
    rake "db:migrate"
  end
end
