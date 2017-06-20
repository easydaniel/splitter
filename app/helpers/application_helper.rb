module ApplicationHelper
  def flash_class(level)
    case level
    when 'success' then "ui positive message"
    when 'error', 'alert' then "ui negative message"
    when 'notice' then "ui info message"
    when 'warning' then "ui warning message"
    end
  end
end
