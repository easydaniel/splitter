class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string     :name
      t.integer    :amount
      t.references :from
      t.references :to

      t.timestamps
    end
    add_index :items, :from
    add_index :items, :to
  end
end
