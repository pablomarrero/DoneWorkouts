require 'rails_helper'

describe Profile, type: :model do
  let(:user){
    User.create!(email: 'foo@example.com',
                 password: 'cambiameya',
                 password_confirmation: 'cambiameya')
  }

  it "is valid with a firstname, lastname" do
    profile = Profile.new(  first_name: 'Pepe',
                            last_name: 'Perez',
                            birthday: Date.current,
                            user: user)
    expect(profile).to be_valid
  end

  it "is invalid without a firstname" do
    profile = Profile.new(  first_name: nil,
                            last_name: 'Perez',
                            birthday: Date.current,
                            user: user)
    profile.valid?
    expect(profile.errors[:first_name]).to include("can't be blank")
  end
  it "is invalid without a lastname" do
    profile = Profile.new(  first_name: 'Pepe',
                            last_name: nil,
                            birthday: Date.current,
                            user: user)
    profile.valid?
    expect(profile.errors[:last_name]).to include("can't be blank")
  end
  it "returns a contact's full name as a string" do
    profile = Profile.new(  first_name: 'Pepe',
                            last_name: 'Perez',
                            birthday: Date.current,
                            user: user)
    expect(profile.full_name).to eq 'Pepe Perez'
  end
  it "is invalid without unique full name" do
    profile1 = Profile.create!( first_name: 'Pepe',
                                last_name: 'Perez',
                                birthday: Date.current,
                                user: user)
    user2 =    User.create!(email: 'foo2@example.com',
                           password: 'cambiameya',
                           password_confirmation: 'cambiameya')
    profile2 = Profile.new( first_name: 'Pepe',
                            last_name: 'Perez',
                            birthday: Date.current,
                            user: user2)
    profile2.valid?
    expect(profile2.errors[:first_name]).to include('has already been taken')
  end

  it "is invalid without user" do
    profile = Profile.new(first_name: 'Pepe',
                          last_name: 'Perez',
                          birthday: Date.current,
                          user: nil)
    profile.valid?
    expect(profile.errors[:user]).to include("can't be blank")
  end

  it "is invalid with birthday after today" do
    profile = Profile.new(  first_name: 'Pepe',
                            last_name: 'Perez',
                            birthday: DateTime.now + 1.day,
                            user: user)
    profile.valid?
    expect(profile.errors[:birthday].to_s).to include("must be on or before")
  end
  it "is invalid with birthday before 110 years" do
    profile = Profile.new(  first_name: 'Pepe',
                            last_name: 'Perez',
                            birthday: DateTime.now - 111.years,
                            user: user)
    profile.valid?
    expect(profile.errors[:birthday].to_s).to include("must be on or after")
  end
end
