--1. Finding 5 oldest users

SELECT * FROM users
ORDER BY created_at
LIMIT 5;

--2. Most polpular registration day

SELECT 
   DAYNAME(created_at) AS day,
   COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 2;

--3. Identify inactive users(users with no photos

--Full info
SELECT 
     username ,
     image_url,
     COUNT(image_url) AS total
FROM users
LEFT JOIN photos
ON users.id = photos.user_id
GROUP BY username
ORDER BY total DESC;

-- Another solution
    SELECT username
    FROM users
    LEFT JOIN photos
        ON users.id = photos.user_id
    WHERE photos.id IS NULL;
    


-- 4. Identify most popular photo (and user who created it)

SELECT 
        username,
        photos.id,
        photos.image_url, 
        COUNT(*) AS total
FROM photos
INNER JOIN likes
        ON likes.photo_id = photos.id
    INNER JOIN users
        ON photos.user_id = users.id
    GROUP BY photos.id
    ORDER BY total DESC
    LIMIT 1;

-- 5. Calculate average number of photos per user

 SELECT (SELECT Count(*) 
    FROM   photos) / (SELECT Count(*) FROM   users) AS avg; 

--6. 5 Most popular hashtags

SELECT tag_name,COUNT(tag_name) AS total
FROM tags
INNER JOIN photo_tags
ON tags.id=photo_tags.tag_id
GROUP BY tags.id
ORDER BY total DESC
;
-- Alternate solution
SELECT tags.tag_name, 
       Count(*) AS total 
FROM   photo_tags 
       JOIN tags 
         ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total DESC 
LIMIT  5; 

--7. Finding bots-users who have liked every photos

SELECT username,
       COUNT(*) AS num_likes
FROM users
INNER JOIN likes
  ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_likes= (SELECT COUNT(*) FROM photos);  
