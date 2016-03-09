require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:user){
    User.create!(email: 'foo@example.com',
                 password: 'cambiameya',
                 password_confirmation: 'cambiameya')
  }

  it "is valid with a domain, name and user(admin)" do
    account = Account.new(  domain: 'pepe.com',
                            name: 'Perez',
                            user: user)
    expect(account).to be_valid
  end

  it "is invalid without a domain" do
    account = Account.new(  domain: nil,
                            name: 'Perez',
                            user: user)
    account.valid?
    expect(account.errors[:domain]).to include("can't be blank")
  end
  it "is invalid without a name" do
    account = Account.new(  domain: 'pepe.com',
                            name: nil,
                            user: user)
    account.valid?
    expect(account.errors[:name]).to include("can't be blank")
  end
  it "is invalid without unique domain" do
    account1 = Account.create!( domain: 'pepe.com',
                                name: 'Perez',
                                user: user)
    user2 =    User.create!(email: 'foo2@example.com',
                           password: 'cambiameya',
                           password_confirmation: 'cambiameya')
    account2 = Account.new( domain: 'pepe.com',
                            name: 'Perez',
                            user: user2)
    account2.valid?
    expect(account2.errors[:domain]).to include('has already been taken')
  end

  it "is invalid without user" do
    account = Account.new(domain: 'pepe.com',
                          name: 'Perez',
                          user: nil)
    account.valid?
    expect(account.errors[:user]).to include("can't be blank")
  end

end
