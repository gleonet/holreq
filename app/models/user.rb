class User < ApplicationRecord
  belongs_to :site
  belongs_to :manager, class_name: 'User', foreign_key: :manager_id
  has_secure_password

  validates :login, :firstname, :lastname, :email, presence: true
  validates :login, :email, uniqueness: true
  validates :manager_id, presence: false

  def fullname
    self.lastname.to_s + ' ' + self.firstname.to_s
  end
end
