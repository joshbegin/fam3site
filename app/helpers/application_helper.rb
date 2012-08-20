module ApplicationHelper
  def twitterized_type(type)
    case type
      when :alert
        "alert"
      when :failure
        "alert alert-error"
      when :notice
        "alert alert-info"
      when :success
        "alert alert-success"
      else
        type.to_s
    end
  end

  def full_title(page_title)
    base_title = "Family Site"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def format_phone_number(phone_number)
    formatted_phone_number = ""
    
    unless phone_number.nil?
      digits = phone_number.to_s.gsub(/[^0-9]/, "").to_s
      case digits.length
      when 10 
        formatted_phone_number = number_to_phone(digits, :area_code => true)
      when 11
        formatted_phone_number = number_to_phone(digits, :area_code => true)
      when 7
        formatted_phone_number = number_to_phone(digits)
      else
        if digits.length > 11
          if digits[0] == "1" || digits[0] == "0"
            extension = digits[11..digits.length - 1]
            digits = digits[0..10]
          else
            extension = digits[10..digits.length - 1]
            digits = digits[0..9]
          end
          formatted_phone_number = number_to_phone(digits, :area_code => true, :extension => extension)
        else
          formatted_phone_number = digits
        end
      end 
    end
    
    formatted_phone_number
  end
end
