class CreateIncomes < ActiveRecord::Migration[7.1]
  def change
    create_table :incomes do |t|
      t.decimal "amount", precision: 10, scale: 2
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
