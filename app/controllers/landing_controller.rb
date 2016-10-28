class LandingController < ApplicationController
  def index
    @featured_products = Product.order('id ASC').limit(5)
  end
end
