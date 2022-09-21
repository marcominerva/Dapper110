using Dapper;
using Dapper110.Models;
using Microsoft.Data.SqlClient;

namespace Dapper110.Samples;

public static class MultipleResultsets
{
    public static async Task RunSampleAsync(string connectionString)
    {
        await OneRoundtripAsync(connectionString);

        //await JoinAsync(connectionString);
    }

    private static async Task OneRoundtripAsync(string connectionString)
    {
        using var connection = new SqlConnection(connectionString);

        var results = await connection.QueryMultipleAsync(@"
                    SELECT Id, Name FROM Cities ORDER BY Name; 
                    SELECT Id, Name, Email FROM Users ORDER By Name;
                ");

        var cities = await results.ReadAsync<City>();
        var users = await results.ReadAsync<User>();

        Print(cities);
        Console.WriteLine();
        Print(users);
    }

    private static async Task JoinAsync(string connectionString)
    {
        using var connection = new SqlConnection(connectionString);

        var results = await connection.QueryMultipleAsync(@"
                    SELECT Id, Name FROM Restaurants WHERE Id = @id; 
                    SELECT Id, Rating, Comment, Date FROM Reviews WHERE RestaurantId = @id ORDER BY Date DESC;",
                new { Id = 5 });

        var restaurant = await results.ReadFirstAsync<Restaurant>();
        var reviews = await results.ReadAsync<Review>();

        restaurant.Reviews = reviews;

        Print(restaurant);
    }

    private static void Print(IEnumerable<City> cities)
    {
        Console.WriteLine("Cities:");
        foreach (var city in cities)
        {
            Console.WriteLine(city.Name);
        }
    }

    private static void Print(IEnumerable<User> users)
    {
        Console.WriteLine("Users:");
        foreach (var user in users)
        {
            Console.WriteLine($"Name: {user.Name}, E-mail: {user.Email}");
        }
    }

    private static void Print(Restaurant restaurant)
    {
        Console.WriteLine($"Reviews for {restaurant.Name}:");
        foreach (var review in restaurant.Reviews)
        {
            Console.WriteLine($"{review.Date.ToShortDateString()}: {review.Comment} - {review.Rating}");
        }
    }
}
