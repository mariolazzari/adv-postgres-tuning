create table products
 (prod_id int not null,
  prod_name text not null,
  prod_descr text not null,
  prod_category text)
partition by list (prod_category);

create table product_clothing partition of products
 for values in (‘casual_clothing’, ‘business_attire’, ‘formal_clothing);

create table product_electronics partition of products
 for values in (‘mobile_phones’, ‘tablets’, ‘laptop_computers’);

create table product_kitches partition of products
 for values in (‘food_processor, ‘cutlery’, ‘blenders’);
