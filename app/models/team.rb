class Team < ApplicationRecord
  belongs_to :manager, class_name: 'User', foreign_key: 'manager_id'
  has_many :users

  validates :name, presence: true
end
