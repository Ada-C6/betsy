module ApplicationHelper
	def get_product_categories
		Product.uniq.pluck(:category)
	end
end
