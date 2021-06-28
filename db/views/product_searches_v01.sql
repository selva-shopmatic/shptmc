SELECT t1.id,
      t1.product_name,
      t1.images,
      t1.list_price,
      t1.status,
      t1.description,
      t1.price,
      t1.site_id,
      t1.product_category_id,
      t1.category_name
     FROM ( SELECT products.id,
              products.name AS product_name,
              products.images,
              products.list_price,
              products.status,
              products.description,
              products.price,
              products.site_id,
              product_categories_products.product_category_id,
              product_categories.name AS category_name
             FROM ((products
               LEFT JOIN product_categories_products ON ((products.id = product_categories_products.product_id)))
               LEFT JOIN product_categories ON ((product_categories_products.product_category_id = product_categories.id)))) t1
    WHERE (t1.status = 1)
