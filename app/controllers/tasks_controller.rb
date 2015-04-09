require 'digest/sha1'
class TasksController < WebsocketRails::BaseController

  def connected
    $online_users << session[:user_id]
    WebsocketRails[:online_offline].trigger('offline_to_online', session[:user_id])
  end

  def disconnected
    $online_users.delete(session[:user_id])
    WebsocketRails[:online_offline].trigger('online_to_offline', session[:user_id])
  end

  def push_typing
    to = message[:msg_to]
    @key ||= YAML.load_file('config/chatter_config.yml')['chatter']['key']
    channel = Digest::SHA1.hexdigest "#{@key}_#{to.to_s}"
    WebsocketRails[channel].trigger 'typing', {:msg_from => message[:msg_from], :action => message[:action]}.to_json
  end

  def new_message
    to = message[:msg_to]
    conv_id=message[:conversation_id]
    msg_json={:msg_from => message[:msg_from], :msg => message[:msg]}.to_json
    @key ||= YAML.load_file('config/chatter_config.yml')['chatter']['key']
    channel = Digest::SHA1.hexdigest "#{@key}_#{to.to_s}"
    WebsocketRails[channel].trigger 'new', msg_json
    begin
      $redis.rpush conv_id, msg_json
    rescue Exception => e
      Rails.logger.info e.inspect
    end
  end

  def authorize_channel
  	channel = WebsocketRails[message[:channel]]
  	if message[:channel] == session[:user_id]
  	  accept_channel session[:user_id].to_s
  	else
      deny_channel({:message => 'authorization failed!'})
    end
  end

end
