-- Create vine table:
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

-- Check if data is upload correctly:
SELECT * FROM vine_table;

-- Create a temporary table where total_votes count is equal or greather than 20:
SELECT *
INTO total_votes_table
FROM vine_table
WHERE total_votes >= 20
ORDER BY total_votes DESC;

-- Check if table is filtered properly:
SELECT * FROM total_votes_table;
SELECT COUNT(*) FROM total_votes_table;

-- Create a temporary table where the number of helpful_votes/total_votes  is equal to or greater than 50%:
-- Create vine table:
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

-- Check if data is upload correctly:
SELECT * FROM vine_table;

-- Create a temporary table where total_votes count is equal or greather than 20:
SELECT *
INTO total_votes_table
FROM vine_table
WHERE total_votes >= 20;

-- Check if table is filtered properly:
SELECT * FROM total_votes_table;
SELECT COUNT(*) FROM total_votes_table;

-- Create a temporary table where the number of helpful_votes/total_votes is equal to or greater than 50%:
SELECT *
INTO helpful_votes
FROM total_votes_table
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >= 0.5;
-- Check helpful_votes table:
SELECT * FROM helpful_votes
ORDER BY total_votes DESC;
SELECT COUNT(*) FROM helpful_votes;

-- Retrieve all the rows where a review was written as part of the Vine program paid('Y'):
SELECT *
INTO vine_program_paid
FROM helpful_votes
WHERE verified_purchase = 'Y';
-- Check vine_program_paid table:
SELECT * FROM vine_program_paid;
SELECT COUNT(*) FROM vine_program_paid;

-- Retrieve all the rows where a review was not written as part of the Vine program unpaid('N'):
SELECT *
INTO vine_program_unpaid
FROM helpful_votes
WHERE verified_purchase =  'N';
-- Check vine_program_paid table:
SELECT * FROM vine_program_unpaid;
SELECT COUNT(*) FROM vine_program_unpaid;

-- Determine the total number of reviews:

-- Paid:
SELECT COUNT(review_id) FROM vine_program_paid;
-- Unpaid:
SELECT COUNT(review_id) FROM vine_program_unpaid;

-- Determine the number of 5-star reviews:

-- Paid:
-- SELECT COUNT(review_id), star_rating FROM vine_program_paid
-- GROUP BY vine_program_paid.star_rating;
CREATE VIEW five_star_paid  AS
SELECT review_id
FROM vine_program_paid
WHERE star_rating = 5;


-- Unpaid:
/*SELECT COUNT(review_id), star_rating FROM vine_program_unpaid
GROUP BY vine_program_unpaid.star_rating;*/
CREATE VIEW five_star_unpaid  AS
SELECT review_id
FROM vine_program_unpaid
WHERE star_rating = 5;

-- Determine the percentage of 5-star reviews: (total 5 stars reviews * 100 / total reviews)

-- Paid:
SELECT COUNT(f.review_id) AS "Total Numbers Reviews 5-stars",
	   COUNT(v.review_id) AS "Total Numbers Reviews",
	   (COUNT(f.review_id) * 100 / COUNT(v.review_id)) AS "Percentage Review 5-stars"
FROM five_star_paid as f RIGHT JOIN vine_program_paid as v ON f.review_id = v.review_id;

-- Unpaid:
SELECT COUNT(f.review_id) AS "Total Numbers Reviews 5-stars",
	   COUNT(v.review_id) AS "Total Numbers Reviews",
	   (COUNT(f.review_id) * 100 / COUNT(v.review_id))  AS "Percentage Review 5-stars"
FROM five_star_unpaid AS f RIGHT JOIN vine_program_unpaid AS v ON f.review_id = v.review_id;
