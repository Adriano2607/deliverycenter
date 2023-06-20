

/* 1 - Qual o número de hubs por cidade? */
SELECT COUNT(hub_id) AS hubs, hub_city FROM hubs GROUP BY hub_city ORDER BY hubs ASC;

/* 2 - Qual o número de pedidos (orders) por status? */
SELECT COUNT(order_id) AS orders, order_status FROM orders GROUP BY order_status
ORDER BY orders ASC;

/* 3 - Qual o número de lojas (stores) por cidade dos hubs? */
SELECT COUNT(store_id) AS store, hub_city FROM stores INNER JOIN hubs ON stores.hub_id = hubs.hub_id
GROUP BY hubs.hub_city ORDER BY store ASC;

/* 4 - Qual o maior e o menor valor de pagamento (payment_amount) registrado? */
SELECT MAX(payment_amount) AS maior_pagamento, MIN(payment_amount) AS menor_pagamento FROM payments;

/* 5 - Qual tipo de driver (driver_type) fez o maior número de entregas? */
SELECT COUNT(delivery_id) AS amount, driver_type FROM drivers INNER JOIN deliveries 
ON drivers.driver_id = deliveries.driver_id GROUP BY drivers.driver_type 
ORDER BY amount DESC LIMIT 1;

/* 6 - Qual a distância média das entregas por tipo de driver (driver_modal)? */
SELECT AVG(delivery_distance_meters) AS average_distance, driver_modal FROM drivers 
INNER JOIN deliveries ON drivers.driver_id = deliveries.driver_id GROUP BY drivers.driver_modal 
ORDER BY average_distance DESC;

/* 7 - Qual a média de valor de pedido (order_amount) por loja, em ordem
decrescente? */
SELECT AVG(order_amount) AS average_amount, store_name FROM stores INNER JOIN orders 
ON stores.store_id = orders.store_id GROUP BY stores.store_id, store_name 
ORDER BY average_amount DESC;

/* 8 - Existem pedidos que não estão associados a lojas? Se caso positivo,
quantos? */
SELECT COUNT(*) AS no_store_orders FROM orders WHERE store_id IS NULL;

/* 9 - Qual o valor total de pedido (order_amount) no channel 'FOOD PLACE'? */
SELECT SUM(order_amount) AS total_amount FROM orders INNER JOIN channels ON 
orders.channel_id = channels.channel_id WHERE channel_name = 'FOOD PLACE';

/* 10 - Quantos pagamentos foram cancelados (chargeback)? */
SELECT COUNT(*) AS cancelled_payments FROM payments WHERE payment_status = 'chargeback';

/* 11 - Qual foi o valor médio dos pagamentos cancelados (chargeback)? */
SELECT AVG(payment_amount) AS average_cancelled_payment FROM payments WHERE 
payment_status = 'chargeback';

/* 12 - Qual a média do valor de pagamento por método de pagamento
(payment_method) em ordem decrescente? */
SELECT AVG(payment_amount) AS average_payment, payment_method FROM payments GROUP BY payment_method
ORDER BY average_payment DESC;

/* 13 - Quais métodos de pagamento tiveram valor médio superior a 100? */
SELECT AVG(payment_amount) AS average_payment, payment_method FROM payments GROUP BY payment_method
HAVING average_payment > '100';

/* 14 - Qual a média de valor de pedido (order_amount) por estado do hub
(hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)? */


/* 15 - Qual estado do hub (hub_state), segmento da loja (store_segment) e tipo
de canal (channel_type) teve média de valor de pedido (order_amount) maior que
450? */
