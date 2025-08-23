class AddPhraseToPets < ActiveRecord::Migration[8.0]
  def change
    add_column :pets, :phrase, :string
  end
end
