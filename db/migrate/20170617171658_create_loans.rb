class CreateLoans < ActiveRecord::Migration[5.1]
  def change
    create_table :loans do |t|
      t.integer    :amount
      t.references :from
      t.references :to

      t.timestamps
    end
    add_index :loans, :from
    add_index :loans, :to
  end
end
