class Account < ActiveRecord::Base
  belongs_to :user
  validates :domain, :name, :user, presence: true
  validates :domain, uniqueness: true 
end
