class LegalDay < ApplicationRecord
  belongs_to :site

  validates :year, :start_date, :name, :site_id, presence: true
end
