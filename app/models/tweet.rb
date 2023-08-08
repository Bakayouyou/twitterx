class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :retweet, class_name: "Tweet", optional: true

  has_many :likes, dependent: :destroy
  has_many :retweets, class_name: "Tweet", foreign_key: :retweet_id


  validates :body, presence: true

  def likes_count
    likes.count
  end

  def retweets_count
    retweets.count
  end

  def retweet?
    retweet_id.present?
  end

end
