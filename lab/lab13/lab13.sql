.read data.sql


CREATE TABLE average_prices AS
  SELECT category, avg(MSRP) AS average_price
    FROM products
    GROUP BY category;


CREATE TABLE lowest_prices AS
  SELECT store, item, min(price) AS lowes_price
    FROM inventory
    GROUP BY item;

CREATE TABLE best AS
  SELECT name, min(MSRP/rating) AS ratio FROM products
    GROUP BY category;

CREATE TABLE shopping_list AS
  SELECT item, store FROM best, lowest_prices
    WHERE best.name = lowest_prices.item;


CREATE TABLE total_bandwidth AS
  SELECT sum(Mbs)
    FROM stores, shopping_list
    WHERE stores.store = shopping_list.store;

