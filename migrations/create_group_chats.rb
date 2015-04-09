class CreateGroupChats < ActiveRecord::Migration
  def change
    create_table :group_chats do |t|
      t.integer       :conversation_id
      t.integer       :user_id
    end
  end
end
