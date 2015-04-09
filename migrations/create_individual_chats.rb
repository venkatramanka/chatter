class CreateIndividualChats < ActiveRecord::Migration
  def change
    create_table :individual_chats do |t|
      t.integer       :user1_id
      t.integer       :user2_id
      t.integer       :conversation_id
    end
  end
end
