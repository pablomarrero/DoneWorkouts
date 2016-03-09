class Profile < ActiveRecord::Base
  belongs_to :user
  validates :first_name, :last_name, :user, presence: true
  validates_uniqueness_of :first_name, scope: :last_name
  validates_date :birthday, :on_or_before => lambda { Date.current }
  validates_date :birthday, :on_or_after => lambda { Date.current - 110.years }

  def full_name
    [first_name, last_name].join ' '
  end
end
