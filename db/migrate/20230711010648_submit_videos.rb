class SubmitVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :submit_videos do |t|
      t.string :player_name
      t.string :discord_user
      t.string :instagram
      t.string :twitter
      t.string :category
      t.text :gameplay_url
      t.timestamps
    end
  end
end
