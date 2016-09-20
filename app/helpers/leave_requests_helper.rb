module LeaveRequestsHelper

  def class_for_status(status)
    case status
    when LeaveRequest::SUBMITTED
      content_tag :i, '? '
    when LeaveRequest::APPROVED
      content_tag :i, ' ', class: 'fi-check', style: 'color: green;'
    when LeaveRequest::REJECTED
      content_tag :i, ' ', class: 'fi-x', style: 'color: red;'
    end
  end
end
