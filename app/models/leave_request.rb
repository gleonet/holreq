class LeaveRequest < ApplicationRecord
  belongs_to :user
  belongs_to :leave
  belongs_to :leave_type
  belongs_to :approval_user, class_name: 'User', foreign_key: :approved_by_id, optional: true

  before_save :compute_nb_hours

  LeaveRequest::STATUS = [  LeaveRequest::SUBMITTED = 'submitted',
                            LeaveRequest::APPROVED  = 'approved',
                            LeaveRequest::REJECTED  = 'rejected' ]


  def submitted?
    self.status == LeaveRequest::SUBMITTED
  end

  def approved?
    self.status == LeaveRequest::APPROVED
  end

  def rejected?
    self.status == LeaveRequest::REJECTED
  end

  def dates
    (self.start_date.to_datetime .. self.end_date.to_datetime)
  end

  def type_name
    self.leave_type_id? ? '' : self.leave_type.name
  end

  # FIXME - Has to use the rules table
  def compute_nb_hours
    self.nb_hours = 0
    self.dates.each do |date|
      if date.wday != 0 and date.wday != 6 # not saturday or sunday
        if LegalDay.where("site_id = ? and start_date = ?", self.user.site_id, date).empty? # not a bank holiday
          self.nb_hours += 8
          # self.nb_hours += self.user.rule.hours_per_day
        end
      end
    end
    self.nb_hours
  end

  class LeaveDate
    attr_accessor :start_time, :name, :status

    def initialize(date, name, status)
      self.start_time = date
      self.name = name
      self.status = status
    end

    def submitted?
      self.status == LeaveRequest::SUBMITTED
    end

    def approved?
      self.status == LeaveRequest::APPROVED
    end

    def rejected?
      self.status == LeaveRequest::REJECTED
    end
  end
end
