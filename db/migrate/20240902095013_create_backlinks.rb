class CreateBacklinks < ActiveRecord::Migration[7.0]
  def change
    create_table :backlinks do |t|
      t.date :added_on
      t.string :country
      t.string :site
      t.integer :price
      t.integer :traffic
      t.integer :domain_rank
      t.string :category
      t.string :duration
      t.boolean :article_writing
      t.boolean :cs_possible
      t.text :comments
      t.boolean :special_price
      t.boolean :available

      t.timestamps
    end
  end
end
