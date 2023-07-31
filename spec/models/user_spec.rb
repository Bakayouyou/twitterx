require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to have_many :email_verification_tokens }
  it { is_expected.to have_many :password_reset_tokens }
  it { is_expected.to have_many :sessions }
  it { is_expected.to have_many :posts }

  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_presence_of :email }

  it { is_expected.to validate_presence_of :username }


  describe "#name" do
    it "concatenates first and last name" do
      user = User.new(first_name: "John", last_name: "Doe")
      expect(user.name).to eq("John Doe")
    end
  end
end
