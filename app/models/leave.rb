class Leave < ApplicationRecord
  belongs_to :user
  belongs_to :leave_type

  def available(status = 'all')
    leave_available = self.nb_hours
    #requests = self.user.leave_requests.where("leave_type_id = ?", self.leave_type_id)
    #if status != 'all'
    #  requests.where("status = ?", status)
    #end
    #requests.each do |req|
    #   leave_available -= req.nb_hours
    #end
    leave_available
  end

  def taken(status = 'all')
    leave_taken = 0
    #requests = self.user.leave_requests.where("leave_type_id = ?", self.leave_type_id)
    #if status != 'all'
    #  requests.where("status = ?", status)
    #end
    #requests.each do |req|
    #   leave_taken += req.nb_hours
    #end
    leave_taken
  end
end
