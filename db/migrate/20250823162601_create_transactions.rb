class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0
      t.string :tx

      t.timestamps
    end
  end
end
