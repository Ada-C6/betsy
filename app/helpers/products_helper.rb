module ProductsHelper
  def category_options
    @category_options = []
    Category.all.each do |category|
      @category_options << category
    end
    return @category_options
  end
end
