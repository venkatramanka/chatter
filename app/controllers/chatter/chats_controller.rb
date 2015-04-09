require_dependency "chatter/application_controller"

module Chatter
  class ChatsController < ApplicationController

    def index
      render :text => "Model specified : #{model}, No.of #{model.to_s.pluralize} : #{model.count}"
    end

    def open_conversation
      person1=session[:user_id]
      person2=params[:recipient_id]
      conv = ConversationMapping.where(["(person1=? and person2=?) or (person1=? and person2=?)",person1,person2,person2,person1]).first
      conv = ConversationMapping.create({person1: person1, person2: person2, conversation_id: SecureRandom.uuid}) unless conv
      render :json => {:conversation_id => conv.conversation_id, :old_messages => old_messages(conv.conversation_id) }.to_json
    end

    private

    def old_messages(conversation_id)
      $redis.lrange(conversation_id,-10,-1).to_json
    end
  end
end
