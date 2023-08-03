class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :retweet, class_name: "Tweet", optional: true

  has_many :likes, dependent: :destroy
  has_many :retweet, class_name: "Tweet", foreign_key: "retweet_id", dependent: :destroy

  validates :body, presence: true

  def likes_count
    likes.count
  end

  def retweets_count
    retweets.count
  end

end
