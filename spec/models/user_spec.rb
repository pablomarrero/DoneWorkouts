require 'rails_helper'

describe User, type: :model do
  let(:user){
    User.create!(email: 'foo@example.com',
                 password: 'cambiameya',
                 password_confirmation: 'cambiameya')
  }

  it "is invalid without an email" do
    user = User.new( email: nil,
                         password: 'cambiameya',
                         password_confirmation: 'cambiameya')
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
end
