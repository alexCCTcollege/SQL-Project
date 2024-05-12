USE GLOVO;
CREATE TABLE IF NOT EXISTS User_orders as

/*****************************************************************
This query is divided in 3 parts:

STEP 1 - WITH clauses for calculating favourite store by user
STEP 2 - WITH clauses for calculating the day passed between last and second to last order
STEP 3 - Main query body where joining the results of the with clauses plus the rest of the questions

*****************************************************************/

/*****************************************************************/
/* STEP 1*/

-- Create a table with user_id, store, and ranking function for best store as the store with more orders and if there is a tie use the one with the most recent order
with cte_Rank_store as (
	select 
        name, -- name of the store
        user_id,
        
		RANK() OVER (PARTITION BY user_id ORDER BY COUNT(orders.id) DESC, -- rank by number of orders
        max(creation_time) DESC) as best_store							  -- if tie rank by most recent order
        
	from users 
		INNER JOIN orders on 
		orders.user_id = users.Id
		INNER JOIN stores on 
		orders.store_id = stores.Id
        
	group by user_id, store_id),

-- Subsetting for stores where rank = 1 per user
cte_Rank_store_2 as (
	select * 
	from cte_Rank_store
    where best_store = 1 ),
    
/*****************************************************************/


/*****************************************************************/
/* STEP 2*/

-- WITH clause for calculating days passed between orders for user in ascending order
cte_last_second_to_last as(
	SELECT user_id,
		DATEDIFF(creation_time, LAG(creation_time) OVER (PARTITION BY user_id ORDER BY creation_time desc)) AS days_from_last_to_second_to_last_order, -- Day passed between orders
		rank() over(partition by user_id order by creation_time desc) as rank_get_second 														       -- Rank orders by creation time
	
    FROM 
		orders),

-- selecting only the day passed between last and second to last order AKA where rank by creation time = 2 
cte_last_second_to_last_final as (
	select user_id,
		   days_from_last_to_second_to_last_order 
           
	from cte_last_second_to_last
	WHERE rank_get_second = 2 )

/*****************************************************************/
  
/* Final query */
SELECT  
	orders.user_id, -- User ID
	DATEDIFF(CURRENT_DATE(), users.signed_up_time) AS days_since_signed_up, --  Time (in days) since the user signed up to the app
	count(*) as total_number_of_orders, -- Total number of orders placed by the user 
	round(avg(total_price),2) as average_order_value, -- - Average order value 
	cte_Rank_store_2.name as favourite_store, -- - Name of their favourite store (JOINED FROM STEP 1)
    
    
	round(SUM(
		CASE WHEN final_status = 'DeliveredStatus'  THEN 1 ELSE 0 END)   -- changing the delivered status to numeric value with CASE statement (delivered = 1 , else = 0)
        / count(*) 														 -- dividing by total number of orders
        * 100,1) AS "%_of_delivered_orders",                             -- calculating percentage, setting number of decimals 
        
	max(creation_time)  as last_order_placed,  -- Time when the last order was placed
    
	ABS(days_from_last_to_second_to_last_order) as days_from_last_to_second_to_last_order  -- Time that passed from the second last order to the last one (JOINED FROM STEP 2)

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
HAVING count(orders.Id) >= 5 ;  -- users with at least 5 orders

select * from User_orders

