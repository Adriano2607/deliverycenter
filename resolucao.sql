use db_deliverycenter;
-- 1 - Qual o número de hubs por cidade? 
SELECT COUNT(hub_id) AS numberHubs, hub_city FROM db_deliverycenter.hubs GROUP BY hub_city ORDER BY numberHubs ASC;

-- 2 - Qual o número de pedidos (orders) por status? 
SELECT COUNT(order_id) AS numberOrders, order_status FROM orders GROUP BY order_status
ORDER BY numberOrders ASC;

-- 3 - Qual o número de lojas (stores) por cidade dos hubs? 
SELECT COUNT(store_id) AS numberStore, hub_city FROM stores INNER JOIN hubs ON stores.hub_id = hubs.hub_id
GROUP BY hubs.hub_city ORDER BY numberStore ASC;

-- 4 - Qual o maior e o menor valor de pagamento (payment_amount) registrado? 
SELECT MAX(payment_amount) AS maiorPagamento, MIN(payment_amount) AS menorPagamento FROM payments;

-- 5 - Qual tipo de driver (driver_type) fez o maior número de entregas? 
SELECT COUNT(delivery_id) AS numberAmount, driver_type FROM drivers INNER JOIN deliveries 
ON drivers.driver_id = deliveries.driver_id GROUP BY drivers.driver_type 
ORDER BY numberAmount DESC LIMIT 1;

-- 6 - Qual a distância média das entregas por tipo de driver (driver_modal)? 
SELECT AVG(delivery_distance_meters) AS averageDistance, driver_modal
FROM drivers
LEFT JOIN deliveries ON drivers.driver_id = deliveries.driver_id
GROUP BY drivers.driver_modal
ORDER BY averageDistance DESC;

-- 7 - Qual a média de valor de pedido (order_amount) por loja, em ordem decrescente? 
SELECT AVG(orders.order_amount) AS averageAmount, stores.store_name
FROM stores
RIGHT JOIN orders ON stores.store_id = orders.store_id
GROUP BY stores.store_id, stores.store_name
ORDER BY averageAmount DESC;

-- 8 - Existem pedidos que não estão associados a lojas? Se caso positivo, quantos? 
SELECT COUNT(*) AS numberOrders FROM orders WHERE store_id IS NULL;

-- 9 - Qual o valor total de pedido (order_amount) no channel 'FOOD PLACE'? 
SELECT SUM(order_amount) AS somaAmount FROM orders INNER JOIN channels ON 
orders.channel_id = channels.channel_id WHERE channel_name = 'FOOD PLACE';

-- 10 - Quantos pagamentos foram cancelados (chargeback)? 
SELECT COUNT(*) AS cancelledPayments FROM payments WHERE payment_status = 'chargeback';

-- 11 - Qual foi o valor médio dos pagamentos cancelados (chargeback)? 
SELECT AVG(payment_amount) AS averageCancelledPayment FROM payments WHERE 
payment_status = 'chargeback';

-- 12 - Qual a média do valor de pagamento por método de pagamento (payment_method) em ordem decrescente? 
SELECT AVG(payment_amount) AS averagePayment, payment_method FROM payments GROUP BY payment_method
ORDER BY averagePayment DESC;

-- 13 - Quais métodos de pagamento tiveram valor médio superior a 100? 
SELECT AVG(payment_amount) AS averagePayment, payment_method FROM payments GROUP BY payment_method
HAVING averagePayment > '100';

-- 14 - Qual a média de valor de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)? 
SELECT AVG(order_amount) AS averageOrderAmount, hub_state, store_segment, channel_type FROM hubs
INNER JOIN stores ON hubs.hub_id = stores.hub_id INNER JOIN orders ON stores.store_id = orders.store_id
INNER JOIN channels ON orders.channel_id = channels.channel_id GROUP BY hub_state, store_segment,
channel_type;

/* 15 - Qual estado do hub (hub_state), segmento da loja (store_segment) e tipo
de canal (channel_type) teve média de valor de pedido (order_amount) maior que
450? */
SELECT hub_state, store_segment, channel_type, AVG(order_amount) AS averageOrderAmount FROM hubs
INNER JOIN stores ON hubs.hub_id = stores.hub_id INNER JOIN orders ON stores.store_id = orders.store_id
INNER JOIN channels ON orders.channel_id = channels.channel_id GROUP BY hub_state, store_segment,
channel_type HAVING averageOrderAmount > '450';


