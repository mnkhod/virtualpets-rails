class AddPetToChats < ActiveRecord::Migration[8.0]
  def change
    add_reference :chats, :pet, null: false, foreign_key: true
  end
end
