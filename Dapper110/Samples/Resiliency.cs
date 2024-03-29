﻿using Dapper110.Models;
using Dapper110.Polly;
using Microsoft.Data.SqlClient;

namespace Dapper110.Samples;

public static class Resiliency
{
    public static async Task RunSampleAsync(string connectionString)
    {
        await GetRestaurantListAsync(connectionString);
    }

    private static async Task GetRestaurantListAsync(string connectionString)
    {
        using var connection = new SqlConnection(connectionString);

        var restaurants = await connection.QueryWithRetryAsync<Restaurant>("SELECT Name FROM Restaurants ORDER By Name");

        Print(restaurants);
    }

    private static void Print(IEnumerable<Restaurant> restaurants)
    {
        foreach (var restaurant in restaurants)
        {
            Console.WriteLine(restaurant.Name);
        }
    }
}
