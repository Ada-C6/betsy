class Product < ActiveRecord::Base
  belongs_to :merchant
  has_many :orderitems
  has_many :reviews
  has_and_belongs_to_many :categories

  validates :name,
            presence: true,
            uniqueness: true

  validates :price,
            presence: true,
            numericality: { greater_than: 0 }

  validates :merchant_id,
            presence: true


  def review_average(reviews)
    # Review.where(product_id: params[:id])
    average = 0
    reviews.each do |review|
      average += review.rating.to_i
    end
    if average > 0
      average = sprintf('%.2f', (average / reviews.length.to_f))
    else
      average = "No ratings yet"
    end
    return average
  end


end
