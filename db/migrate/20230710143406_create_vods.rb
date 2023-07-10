class CreateVods < ActiveRecord::Migration[7.0]
  def change
    create_table :twitch_videos do |t|
      t.text :title
      t.text :description
      t.integer :view_count
      t.string :published_at
      t.string :url
      t.integer :duration
      t.string :language
      t.string :user_login
      t.string :user_name
    end
  end
end
