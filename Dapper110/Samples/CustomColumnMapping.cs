using Dapper;
using Dapper.FluentMap;
using Dapper.FluentMap.Mapping;
using Dapper110.Models.MultipleMappings;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Reflection;
using System.Threading.Tasks;

namespace Dapper110.Samples
{
    public static class CustomColumnMapping
    {
        public static async Task RunSampleAsync(string connectionString)
        {
            await MappingAsync(connectionString);

            //await FluentMappingAsync(connectionString);
        }

        private static async Task MappingAsync(string connectionString)
        {
            var columnMaps = new Dictionary<string, string>(StringComparer.InvariantCultureIgnoreCase)
            {
                // Column => Property
                ["RestaurantId"] = "Id",
                ["RestaurantName"] = "Name",
                ["UserId"] = "Id",
                ["UserName"] = "Name"
            };

            var mapper = new Func<Type, string, PropertyInfo>((type, columnName) =>
                columnMaps.ContainsKey(columnName) ?
                type.GetProperty(columnMaps[columnName]) :
                type.GetProperty(columnName)
            );

            // Notify Dapper to use these mappings.
            SqlMapper.SetTypeMap(typeof(Restaurant), new CustomPropertyTypeMap(typeof(Restaurant), (type, columnName) => mapper(type, columnName)));
            SqlMapper.SetTypeMap(typeof(User), new CustomPropertyTypeMap(typeof(User), (type, columnName) => mapper(type, columnName)));

            using var connection = new SqlConnection(connectionString);

            var reviews = await connection.QueryAsync<Review, Restaurant, User, Review>(@"
                SELECT rev.Id, rev.Rating, rev.Comment, rev.Date, rev.RestaurantId, r.Name as RestaurantName, rev.UserId, u.Name as UserName, u.Email
                FROM Reviews rev
                INNER JOIN Restaurants r on rev.RestaurantId = r.Id
                INNER JOIN Users u ON rev.UserId = u.Id
                WHERE r.Id = @id
                ORDER BY rev.Date DESC",
                param: new { Id = 5 },
                map: (review, restaurant, user) =>
                {
                    review.Restaurant = restaurant;
                    review.User = user;
                    return review;
                }, splitOn: "RestaurantId, UserId"); // A comma-separated string that tells Dapper when the returned columns must be mapped to the next object.

            Print(reviews);
        }

        private static async Task FluentMappingAsync(string connectionString)
        {
            FluentMapper.Initialize(config =>
            {
                config.AddMap(new RestaurantMap());
                config.AddMap(new UserMap());
            });

            using var connection = new SqlConnection(connectionString);

            var reviews = await connection.QueryAsync<Review, Restaurant, User, Review>(@"
                SELECT rev.Id, rev.Rating, rev.Comment, rev.Date, rev.RestaurantId, r.Name as RestaurantName, rev.UserId, u.Name as UserName, u.Email
                FROM Reviews rev
                INNER JOIN Restaurants r on rev.RestaurantId = r.Id
                INNER JOIN Users u ON rev.UserId = u.Id
                WHERE r.Id = @id
                ORDER BY rev.Date DESC",
                param: new { Id = 5 },
                map: (review, restaurant, user) =>
                {
                    review.Restaurant = restaurant;
                    review.User = user;
                    return review;
                }, splitOn: "RestaurantId, UserId"); // A comma-separated string that tells Dapper when the returned columns must be mapped to the next object.

            Print(reviews);
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

    public class RestaurantMap : EntityMap<Restaurant>
    {
        public RestaurantMap()
        {
            Map(p => p.Id)
                .ToColumn("RestaurantId", caseSensitive: false);

            Map(p => p.Name)
                .ToColumn("RestaurantName", caseSensitive: false);
        }
    }

    public class UserMap : EntityMap<User>
    {
        public UserMap()
        {
            Map(p => p.Id)
                .ToColumn("UserId", caseSensitive: false);

            Map(p => p.Name)
                .ToColumn("UserName", caseSensitive: false);
        }
    }
}
