class AddPersonalityToPets < ActiveRecord::Migration[8.0]
  def change
    add_column :pets, :personality, :integer
  end
end
