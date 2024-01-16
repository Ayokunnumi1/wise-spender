class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
    t.string "name"
    t.integer "amount"
    t.references :author, foreign_key: { to_table: :users }, null: false
    t.references :category, foreign_key: true, null: false
    t.timestamps
    end
  end
end
