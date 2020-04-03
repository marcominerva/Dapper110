-- Get all reviews of a given restaurant
SELECT rev.Id, rev.Rating, rev.Comment, rev.Date, 
	rev.RestaurantId, r.Name as RestaurantName, 
	rev.UserId, u.Name as UserName, u.Email
FROM Reviews rev
INNER JOIN Restaurants r on rev.RestaurantId = r.Id
INNER JOIN Users u ON rev.UserId = u.Id
WHERE r.Id = 5
ORDER BY rev.Date DESC

-- Get all restaurants with all reviews
SELECT r.Id, r.Name, rev.Date, rev.Comment, rev.Rating
FROM Restaurants r
INNER JOIN Reviews rev on rev.RestaurantId = r.Id
ORDER BY r.Name