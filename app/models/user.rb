class User < ApplicationRecord
  belongs_to :site
  belongs_to :manager, class_name: 'User', foreign_key: :manager_id

  has_secure_password

  validates :login, :firstname, :lastname, :email, presence: true
  validates :login, :email, uniqueness: true

  before_save :capitalize

  User::ROLES = [ User::EMPLOYEE = 'employee', User::MANAGER = 'manager',
                  User::HR = 'hr', User::ADMIN = 'admin']

  def fullname
    self.lastname.to_s + ' ' + self.firstname.to_s
  end

  def name
    self.firstname.to_s + ' ' + self.lastname.to_s
  end

  # Test role
  def manager?
    self.role == 'manager'
  end

  def hr?
    self.role == 'hr'
  end

  def admin?
    self.role == 'admin'
  end

  # Test user enabled
  def enabled?
    self.enabled
  end

  private
  def capitalize
    self.lastname.capitalize
    self.firstname.capitalize
  end
end
