class Product < ApplicationRecord
    include Searchable
    has_many :product_categories_products, :dependent => :destroy
    has_many :categories, through: :product_categories_products, class_name: "ProductCategory"
end
