# Info on join tables: http://shilpi2189.blogspot.com/2013/01/implementing-hasandbelongstomany.html

class Category < ActiveRecord::Base
  has_and_belongs_to_many :products
end
