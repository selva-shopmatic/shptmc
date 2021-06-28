class ProductCategory < ApplicationRecord
    has_many :product_categories_products
    has_many :products, through: :product_categories_products
  
end
