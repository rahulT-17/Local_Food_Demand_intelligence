-- table :
   SELECT * FROM restaurants

-- Restaurants Denisty by area :
SELECT area , COUNT(*) AS total_restaurant 
FROM restaurants
GROUP BY area
ORDER BY total_restaurant;
 
-- Restaurants Supply vs Demand Effciency :
SELECT area ,COUNT(*) AS supply, AVG(delivery_reviews) AS demand_intensity 
FROM restaurants 
GROUP BY area 
ORDER BY demand_intensity DESC ;

-- Top Cuisine by Supply :
SELECT rc.cuisine, COUNT(*) AS supply ,
      ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),2) AS supply_percentage
FROM restaurant_cuisine rc 
JOIN restaurants r 
ON rc.restaurant_id = r.restaurant_id
GROUP BY rc.cuisine
ORDER BY supply DESC;

-- High Demand Cuisines (Using reviews as proxy) :
SELECT rc.cuisine, SUM(r.delivery_reviews) AS total_delivery_reviews
FROM restaurant_cuisine rc JOIN restaurants r ON rc.restaurant_id = r.restaurant_id
GROUP BY rc.cuisine
ORDER BY total_delivery_reviews DESC;

-- Cusinies Demand vs Supply :
SELECT
    rc.cuisine,
    COUNT(*) AS supply,
    SUM(r.delivery_reviews) AS demand
FROM restaurant_cuisine rc
JOIN restaurants r
ON rc.restaurant_id = r.restaurant_id
GROUP BY rc.cuisine
ORDER BY demand DESC;


--Areas with AVG reviews :
SELECT area , AVG(delivery_reviews) AS total_reviews
FROM restaurants 
GROUP BY area
ORDER BY total_reviews ASC;
 
 -- Areas with HIGH dine rating and dine Low reviews :
 SELECT area , AVG(dine_rating) AS avg_dine_ratings ,AVG(dine_reviews) AS avg_dine_reviews,
 CASE 
    WHEN AVG(dine_rating) >= 4.1 AND AVG(dine_reviews) > 750 
    THEN 'Strong market' 

    WHEN AVG(dine_rating) >= 4.1 AND AVG(dine_reviews) < 750 THEN 'High quality but Low Visiblity'
    
    WHEN AVG(dine_rating) < 4.1 AND AVG (dine_reviews) < 750 THEN 'Low quality but High Visibility'

    ELSE 'Weak Market'
    END AS market_segment

 FROM restaurants
 GROUP BY area
 ORDER BY  avg_dine_rating DESC ;


-- Price vs Rating Analysis (Dine) :
SELECT
   CASE
      WHEN cost_for_two < 750 THEN 'Budget' 
      WHEN cost_for_two BETWEEN 750 AND 1500 THEN 'Mid'
      ELSE 'Premium'  
   END AS price_segment,
   AVG(dine_rating) AS avg_dine_experience
FROM restaurants
GROUP BY price_segment;

-- Underrated Restaurants :
SELECT restaurant_name,area,dine_rating,delivery_rating,delivery_reviews
FROM restaurants
WHERE dine_rating > 4.0 AND delivery_rating >= 4.5 AND delivery_reviews < 500
ORDER BY delivery_reviews ASC;