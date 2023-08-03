class AddRetweetToTweet < ActiveRecord::Migration[7.0]
  def change
    add_reference :tweets, :retweet, null: true, foreign_key: { to_table: :tweets }
  end
end
