class CreateUrlTable < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string  :long_url
      t.string  :short_url
      t.integer :clicks
      t.integer :user_id
      t.timestamps
    end
  end
end
