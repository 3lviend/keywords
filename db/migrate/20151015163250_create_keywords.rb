class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :query, null: false, default: ""
      t.integer :impressions, default: 0, null: false
      t.integer :clicks, default: 0, null: false
      t.decimal :ctr, precision: 4, scale: 2
      t.decimal :avg_position, precision: 10, scale: 2
      t.date :date
      t.boolean :new, default: true
      t.timestamps null: false
    end
  end
end
