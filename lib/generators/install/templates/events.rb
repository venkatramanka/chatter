WebsocketRails::EventMap.describe do
  subscribe :client_connected, :to => TasksController, :with_method => :connected
  subscribe :client_disconnected, :to => TasksController, :with_method => :disconnected
  namespace :tasks do
    subscribe :new_message, :to => TasksController, :with_method => :new_message
    subscribe :push_typing, :to => TasksController, :with_method => :push_typing
  end
end
