-- table :
   SELECT * FROM restaurants



-- Restaurant Density by Area :
SELECT area ,COUNT(*) AS total_restaurant 
FROM restaurants 
GROUP BY area 
ORDER BY total_restaurant DESC ;

-- Top Cuisine by Supply :
SELECT rc.cuisine, COUNT(*) AS restaurant_count
FROM restaurant_cuisine rc 
JOIN restaurants r 
ON rc.restaurant_id = r.restaurant_id
GROUP BY rc.cuisine
ORDER BY restaurant_count DESC;

-- High Demand Cuisines (Using reviews as proxy) :
SELECT rc.cuisine, SUM(r.delivery_reviews) AS total_delivery_reviews
FROM restaurant_cuisine rc FULL JOIN restaurants r ON rc.restaurant_id = r.restaurant_id
GROUP BY rc.cuisine
ORDER BY total_delivery_reviews DESC;

--Areas with AVG reviews :
SELECT area , COUNT(delivery_reviews) AS total_reviews
FROM restaurants 
GROUP BY area
HAVING COUNT(delivery_reviews) > 100 
ORDER BY total_reviews ASC;
 
 -- Areas with HIGH dine rating and dine Low reviews :
 SELECT area , AVG(dine_rating) AS avg_dine_ratings ,AVG(dine_reviews) AS avg_dine_reviews,
 CASE 
    WHEN AVG(dine_rating) >= 4.1 AND AVG(dine_reviews) > 750 
    THEN 'Strong market' 

    WHEN AVG(dine_rating) >= 3.9 AND AVG(dine_reviews) < 500 THEN 'Undiscorved Opporunity'
    
    WHEN AVG(dine_rating) < 3.9 AND AVG (dine_reviews) < 400 THEN 'Need Improvement'

    ELSE 'Weak Market'
    END AS market_segment

 FROM restaurants
 GROUP BY area
 ORDER BY  avg_dine_rating DESC ;


-- 