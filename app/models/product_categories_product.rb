class ProductCategoriesProduct < ApplicationRecord
    belongs_to :product
    belongs_to :category, foreign_key: :product_category_id, class_name: "ProductCategory"
    belongs_to :product_score, -> (product_category) {where("category_id = :id", id: product_category.product_category_id)}, primary_key: :product_id, foreign_key: :product_id, :dependent => :destroy  
end
