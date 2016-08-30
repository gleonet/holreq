module ApplicationHelper
  def class_if_error(record, field)
    if record.errors.any? and record.errors.include?(field.to_sym)
      'field_with_errors'
    end
  end
end
