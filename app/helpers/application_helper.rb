module ApplicationHelper
	def flash_class(level)
        case level.to_sym
        when :notice then "alert alert-custom alert-notice alert-success"
        when :success then "alert alert-custom alert-notice alert-success"
        when :error then "alert alert-custom alert-notice alert-danger" 
        when :alert then "alert alert-custom alert-notice alert-warning"
        end
    end
end
