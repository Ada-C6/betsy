class HomeController < ApplicationController
    def index
      @products = Product.all.shuffle.first(4)
    end
end
