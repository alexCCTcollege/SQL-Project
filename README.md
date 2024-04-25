As part of my interview with a Famous delivery company I was ask to create a report in a single query; the resulting query is a long query comprised of WITH CLAUSES, Multiple JOINS, WINDOW FUNCTIONS and RANKINGF FUNCTIONS

TASK
Your task is to build an SQL query that creates a new table: user_orders, for users that have placed at least 5 orders, containing the following information:
-	User ID
-	Time (in days) since the user signed up to the app (3 points)
-	Total number of orders placed by the user (3 points)
-	Average order value (3 points)
-	Name of their favourite store, understanding this as the store with more orders (if there is a tie use the one with the most recent order) (8 points)
-	% of delivered orders (5 points)
-	Time when the last order was placed (5 points)
-	Time (in days) that passed from the second last order to the last one (8 points)
