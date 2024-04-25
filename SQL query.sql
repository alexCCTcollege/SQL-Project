/* Your task is to build an SQL query that creates a new table: user_orders, for
users that have placed at least 5 orders, containing the following information:
- User ID
- Time (in days) since the user signed up to the app (3 points)
- Total number of orders placed by the user (3 points)
- Average order value (3 points)
- Name of their favourite store, understanding this as the store with
more orders (if there is a tie use the one with the most recent order)
(8 points)
- % of delivered orders (5 points)
- Time when the last order was placed (5 points)
- Time (in days) that passed from the second last order to the last one (8
points) */

USE GLOVO;
DROP TABLE IF EXISTS User_orders;
CREATE TABLE User_orders as

/* WITH clause for calculating favourite store by user*/
with cte_Rank_store as (select name, user_id,
		RANK() OVER (PARTITION BY user_id ORDER BY COUNT(orders.id) DESC, max(creation_time) DESC) as best_store
		from users 
		INNER JOIN orders on 
		orders.user_id = users.Id
		INNER JOIN stores on 
		orders.store_id = stores.Id
		group by user_id, store_id),
        
cte_Rank_store_2 as (select * 
	from cte_Rank_store
    where best_store = 1 ),

-- WITH clause for calculating days passed between orders for user in ascending order
cte_last_second_to_last as(
SELECT *,
    DATEDIFF(creation_time, LAG(creation_time) OVER (PARTITION BY user_id ORDER BY creation_time desc)) AS days_from_last_to_second_to_last_order,
    rank() over(partition by user_id order by creation_time desc) as rank_get_second
FROM 
    orders),


-- last WITH clause for selecting only the day passed between last and second to last order
cte_last_second_to_last_final as (select user_id, days_from_last_to_second_to_last_order from cte_last_second_to_last
WHERE rank_get_second = 2 )
  
/* Final query */
SELECT  orders.user_id, -- User ID
DATEDIFF(CURRENT_DATE(), users.signed_up_time) AS days_since_signed_up, --  Time (in days) since the user signed up to the app (3 points)
count(*) as total_number_of_orders, -- Total number of orders placed by the user (3 points)
round(avg(total_price),2) as average_order_value, -- - Average order value (3 points) (I've taken the liberty to round up at the 2 decimals)
cte_Rank_store_2.name as favourite_store, -- - Name of their favourite store as the store with more orders (if there is a tie use the one with the most recent order) (8 points) COMING FROM WITH CLAUSE NUMBER 1
round(SUM(
CASE
    WHEN final_status = 'DeliveredStatus'  THEN 1
    ELSE 0
END) / count(*) * 100,1) AS "%_of_delivered_orders", -- % of delivered orders (5 points)
max(creation_time)  as last_order_placed,  -- Time when the last order was placed (5 points)
ABS(days_from_last_to_second_to_last_order) as days_from_last_to_second_to_last_order  -- Time (in days) that passed from the second last order to the last one (8points) COMING FROM WITH CLAUSE NUMBER 2 and 3

FROM users 
INNER JOIN orders on 
orders.user_id = users.Id
INNER JOIN stores on 
orders.store_id = stores.Id
INNER JOIN cte_Rank_store_2
ON orders.user_id = cte_Rank_store_2.user_id
inner join cte_last_second_to_last_final
on cte_last_second_to_last_final.user_id = orders.user_id
GROUP BY user_id
HAVING count(orders.Id) >= 5 ;

select * from User_orders