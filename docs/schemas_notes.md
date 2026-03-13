# Schema Notes - Olist

## Overview
The Olist dataset was modeled as a relational database for analytical purposes.

## Main Relationships
- `orders.customer_id -> customers.customer_id`
- `order_items.order_id -> orders.order_id`
- `order_items.product_id -> products.product_id`
- `order_items.seller_id -> sellers.seller_id`
- `order_payments.order_id -> orders.order_id`
- `order_reviews.order_id -> orders.order_id`

## Special Case
The relationship between `products.product_category_name` and
`product_category_name_translation.product_category_name`
is logically valid, but some categories do not have translation entries in the dataset.
Therefore, it may be documented as a logical relationship instead of a strict physical FK.