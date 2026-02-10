-- CREATING RESTARUNT TABLE :
CREATE TABLE restraunts (
            restaurant_id INT PRIMARY KEY,
            restaurant_name VARCHAR (255),
            area VARCHAR(100),
            cost_for_two INT,
            delivery_rating FLOAT,
            delivery_reviews INT,
            dine_rating FLOAT,
            dine_reviews INT,
            restaurant_type VARCHAR(100),
            liked VARCHAR(10)
);