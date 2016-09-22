json.extract! leave_request, :id, :user_id, :leave_id, :leave_type_id, :start_date, :end_date, :status, :approved_by_id, :nb_hours, :description, :created_at, :updated_at
json.url user_leave_request_url(leave_request.user, leave_request, format: :json)
