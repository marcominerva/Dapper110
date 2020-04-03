using Dapper;
using Dapper110.Models.CustomTypeHandling;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text.Json;
using System.Threading.Tasks;

namespace Dapper110.Samples
{
    public static class CustomTypeHandling
    {
        public static async Task RunSampleAsync(string connectionString)
        {
            await RoleMappingAsync(connectionString);

            // await JsonMappingReadAsync(connectionString);

            // await JsonMappingWriteAsync(connectionString);
        }

        private static async Task RoleMappingAsync(string connectionString)
        {
            using var connection = new SqlConnection(connectionString);

            var users = await connection.QueryAsync<User>(@"
                SELECT Id, Name, Email, Role
                FROM USERS                
                ORDER BY Name"
                );

            Print(users);
        }

        private static async Task JsonMappingReadAsync(string connectionString)
        {
            SqlMapper.AddTypeHandler(new TagsTypeHandler());

            using var connection = new SqlConnection(connectionString);

            var reviews = await connection.QueryAsync<Review>(@"
                SELECT Id, UserId, RestaurantId, Rating, Comment, Date, Tags
                FROM Reviews                
                WHERE RestaurantId = @restaurantId
                ORDER BY Date DESC",
                param: new { RestaurantId = 5 });

            Print(reviews);
        }

        private static async Task JsonMappingWriteAsync(string connectionString)
        {
            SqlMapper.AddTypeHandler(new TagsTypeHandler());

            using var connection = new SqlConnection(connectionString);

            // Aggiunge una recensione.
            await connection.ExecuteAsync(@"INSERT INTO Reviews(UserId, RestaurantId, Rating, Comment, [Date], Tags)
                VALUES (@userId, @restaurantId, @rating, @comment, @date, @tags)",
                param: new
                {
                    UserId = 1,
                    RestaurantId = 5,
                    Date = DateTime.UtcNow.AddDays(-5),
                    Rating = 5,
                    Comment = "Evviva la Darsena",
                    Tags = new List<Tag>
                    {
                        new Tag
                        {
                            Value = "#happy"
                        },
                        new Tag
                        {
                            Value = "#food" }
                    }
                });

            await JsonMappingReadAsync(connectionString);
        }

        private static void Print(IEnumerable<User> users)
        {
            foreach (var user in users)
            {
                Console.WriteLine($"{user.Name} - {user.Role}");
            }
        }

        private static void Print(IEnumerable<Review> reviews)
        {
            foreach (var review in reviews)
            {
                Console.WriteLine($"{review.Date.ToShortDateString()}: {review.Comment} - {review.Rating}");
                if (review.Tags != null)
                {
                    foreach (var tag in review.Tags)
                    {
                        Console.Write(tag.Value + " ");
                    }
                }

                Console.WriteLine("\n");
            }
        }
    }

    public class TagsTypeHandler : SqlMapper.TypeHandler<List<Tag>>
    {
        public override List<Tag> Parse(object value)
        {
            var json = value.ToString();
            return JsonSerializer.Deserialize<List<Tag>>(json);
        }

        public override void SetValue(IDbDataParameter parameter, List<Tag> value)
        {
            var json = JsonSerializer.Serialize(value);
            parameter.Value = json;
        }
    }
}
