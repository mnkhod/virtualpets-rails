class CreatePets < ActiveRecord::Migration[8.0]
  def change
    create_table :pets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :gender
      t.integer :animal
      t.integer :hunger, default: 0
      t.integer :age, default: 1
      t.integer :level, default: 1

      t.timestamps
    end
  end
end
