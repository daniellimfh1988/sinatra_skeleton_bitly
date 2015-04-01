class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :short_url
      t.string :long_url
      t.integer :user_id
      t.integer :click_count
      t.timestamps null:false
    end
  end
end

