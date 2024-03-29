module ApplicationHelper

	# Returns the full title on a per-page basis.
	def full_title(page_title)
		if page_title.empty?
			I18n.t :base_title
		else
			"#{I18n.t :base_title } | #{page_title}"
		end
	end

end
