class User < ApplicationRecord
  include Avatarable

  attribute :terms_and_conditions

  has_secure_password

  has_many :email_verification_tokens, dependent: :destroy
  has_many :password_reset_tokens, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy


  has_one_attached :avatar

  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, allow_nil: true, length: { minimum: 8 }
  validates :terms_and_conditions, acceptance: true, on: :create

  before_validation if: -> { email.present? } do
    self.email = email.downcase.strip
  end

  before_validation if: :email_changed?, unless: :new_record? do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).destroy_all
  end

  def name
    [first_name, last_name].compact.join(" ")
  end
end
