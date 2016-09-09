class User < ApplicationRecord
  belongs_to :site
  belongs_to :team

  has_secure_password

  validates :login, :lastname, :email, presence: true
  validates :login, :email, uniqueness: true

  before_save :capitalize

  User::ROLES = [ User::EMPLOYEE = 'employee',
                  User::MANAGER = 'manager',
                  User::HR = 'HR',
                  User::ADMIN = 'admin' ]

  def fullname
    self.lastname.to_s + ' ' + self.firstname.to_s
  end

  def name
    self.firstname.to_s + ' ' + self.lastname.to_s
  end

  # Test role
  def manager?
    self.role == User::MANAGER
  end

  def hr?
    self.role == User::HR
  end

  def admin?
    self.role == User::ADMIN
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
