using Dapper;
using Dapper110.Models.MultipleMappings;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Dapper110.Samples
{
    public static class MultipleMappings
    {
        public static async Task RunSampleAsync(string connectionString)
        {
            await SimpleMappingAsync(connectionString);

            //await ListMappingAsync(connectionString);

            //await AliasMappingAsync(connectionString);
        }

        private static async Task SimpleMappingAsync(string connectionString)
        {
            using var connection = new SqlConnection(connectionString);

            var restaurants = await connection.QueryAsync<Restaurant, Address, Restaurant>(@"
                SELECT r.Id, r.Name, r.Street, r.ZipCode, c.Name as City
                FROM Restaurants r
                LEFT JOIN Cities c ON r.CityId = c.Id
                ORDER BY r.Name",
                map: (restaurant, address) =>
                {
                    restaurant.Address = address;
                    return restaurant;
                }, splitOn: "Street"); // A comma-separated string that tells Dapper when the returned columns must be mapped to the next object.

            Print(restaurants);
        }

        private static async Task ListMappingAsync(string connectionString)
        {
            using var connection = new SqlConnection(connectionString);

            var restaurantsDictionary = new Dictionary<int, Restaurant>();

            var restaurants = await connection.QueryAsync<Restaurant, Review, Restaurant>(@"
                SELECT r.Id, r.Name, rev.Id AS ReviewId, rev.Date, rev.Comment, rev.Rating
                FROM Restaurants r
                INNER JOIN Reviews rev on rev.RestaurantId = r.Id
                ORDER BY r.Name",
                map: (restaurant, review) =>
                {
                    if (!restaurantsDictionary.TryGetValue(restaurant.Id, out var restaurantEntry))
                    {
                        restaurantEntry = restaurant;
                        restaurantEntry.Reviews = new List<Review>();
                        restaurantsDictionary.Add(restaurantEntry.Id, restaurantEntry);
                    }

                    restaurantEntry.Reviews.Add(review);
                    return restaurantEntry;

                }, splitOn: "ReviewId"); // A comma-separated string that tells Dapper when the returned columns must be mapped to the next object.

            PrintRestaurantsWithReviews(restaurantsDictionary.Values);    // OR restaurants.Distinct()
        }

        private static async Task AliasMappingAsync(string connectionString)
        {
            using var connection = new SqlConnection(connectionString);

            var reviews = await connection.QueryAsync<Review, Restaurant, User, Review>(@"
                SELECT rev.Id, rev.Rating, rev.Comment, rev.Date, rev.RestaurantId, r.Name as RestaurantName, rev.UserId, u.Name as UserName, u.Email
                FROM Reviews rev
                INNER JOIN Restaurants r on rev.RestaurantId = r.Id
                INNER JOIN Users u ON rev.UserId = u.Id
                WHERE r.Id = @id
                ORDER BY rev. Date DESC",
                param: new { Id = 5 },
                map: (review, restaurant, user) =>
                {
                    review.Restaurant = restaurant;
                    review.User = user;
                    return review;
                }, splitOn: "RestaurantId, UserId"); // A comma-separated string that tells Dapper when the returned columns must be mapped to the next object.

            Print(reviews);
        }

        private static void Print(IEnumerable<Restaurant> restaurants)
        {
            foreach (var restaurant in restaurants)
            {
                Console.WriteLine($"{restaurant.Name} in {restaurant.Address.Street}, {restaurant.Address.ZipCode}, {restaurant.Address.City}");
            }
        }

        private static void PrintRestaurantsWithReviews(IEnumerable<Restaurant> restaurants)
        {
            foreach (var restaurant in restaurants)
            {
                Console.WriteLine($"Reviews for {restaurant.Name}:");

                foreach (var review in restaurant.Reviews)
                {
                    Console.WriteLine($"{review.Date.ToShortDateString()}: {review.Comment} - {review.Rating}");
                }

                Console.WriteLine();
            }
        }

        private static void Print(IEnumerable<Review> reviews)
        {
            foreach (var review in reviews)
            {
                Console.WriteLine($"Reviews for {review.Restaurant.Name}:");
                Console.WriteLine($"{review.Date.ToShortDateString()} by {review.User.Name}: {review.Comment} - {review.Rating}");
            }
        }
    }
}
