class Tweet < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy

  validates :body, presence: true

  def likes_count
    likes.count
  end
  
end
