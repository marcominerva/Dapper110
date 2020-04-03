using Dapper;
using Microsoft.Data.SqlClient;
using Dapper110.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace Dapper110
{
    public static class Parameters
    {
        public static async Task RunSampleAsync(string connectionString)
        {
            await AnonymousObjectAsync(connectionString);

            //await AnonymousObjectListAsync(connectionString);

            //await DbStringAsync(connectionString);

            //await DynamicParametersAsync(connectionString);

            //await DynamicParametersStoredProcedureAsync(connectionString);
        }

        private static async Task AnonymousObjectAsync(string connectionString)
        {
            using var connection = new SqlConnection(connectionString);

            //var restaurants = await connection.QueryAsync<Restaurant>("SELECT Id, Name FROM Restaurants WHERE ID = @id",
            //    new
            //    {
            //        Id = 11
            //    });

            var restaurants = await connection.QueryAsync<Restaurant>("SELECT Id, Name FROM Restaurants WHERE Name = @Name",
                new
                {
                    Name = "Ristorante Pizzeria Tre Poli"
                });

            //exec sp_executesql N'SELECT Id, Name FROM Restaurants WHERE Name = @Name',N'@Name nvarchar(4000)',@Name = N'Ristorante Pizzeria Tre Poli'

            Print(restaurants);
        }

        private static async Task AnonymousObjectListAsync(string connectionString)
        {
            using var connection = new SqlConnection(connectionString);

            var restaurants = await connection.QueryAsync<Restaurant>("SELECT Id, Name FROM Restaurants WHERE CityID IN @ids",
                new
                {
                    Ids = new List<int> { 1, 2 }
                });

            //exec sp_executesql N'SELECT Id, Name FROM Restaurants WHERE CityID IN (@ids1,@ids2)',N'@Ids1 int,@Ids2 int',@Ids1=1,@Ids2=2

            Print(restaurants);
        }

        private static async Task DbStringAsync(string connectionString)
        {
            using var connection = new SqlConnection(connectionString);

            var restaurants = await connection.QueryAsync<Restaurant>("SELECT Id, Name FROM Restaurants WHERE Name = @Name",
               new
               {
                   Name = new DbString
                   {
                       IsAnsi = true,
                       Value = "Ristorante Pizzeria Tre Poli",
                       Length = 100
                   }
               });

            //exec sp_executesql N'SELECT Id, Name FROM Restaurants WHERE Name = @Name',N'@Name varchar(100)',@Name = 'Ristorante Pizzeria Tre Poli'

            Print(restaurants);
        }

        private static async Task DynamicParametersAsync(string connectionString)
        {
            using var connection = new SqlConnection(connectionString);

            var parameters = new DynamicParameters();
            parameters.Add("Name", "Ristorante Pizzeria Tre Poli", DbType.String, ParameterDirection.Input, 100);

            var restaurants = await connection.QueryAsync<Restaurant>("SELECT Id, Name FROM Restaurants WHERE Name = @Name", parameters);

            //exec sp_executesql N'SELECT Id, Name FROM Restaurants WHERE Name = @Name',N'@Name varchar(100)',@Name = 'Ristorante Pizzeria Tre Poli'

            Print(restaurants);
        }

        private static async Task DynamicParametersStoredProcedureAsync(string connectionString)
        {
            using var connection = new SqlConnection(connectionString);

            var parameters = new DynamicParameters();
            parameters.Add("Name", "Il Pozzo dei Desideri", DbType.String, ParameterDirection.Input, 100);
            parameters.Add("ZipCode", "18038", DbType.String, ParameterDirection.Input, 5);
            parameters.Add("CityId", 4, DbType.Int32, ParameterDirection.Input);
            parameters.Add("Result", null, DbType.Int32, ParameterDirection.ReturnValue);

            await connection.ExecuteAsync("AddRestaurant", parameters, commandType: CommandType.StoredProcedure);

            var id = parameters.Get<int>("Result");

            Console.WriteLine($"Id of the inserted restaurant: {id}.");
        }

        private static void Print(IEnumerable<Restaurant> restaurants)
        {
            foreach (var restaurant in restaurants)
            {
                Console.WriteLine(restaurant.Name);
            }
        }
    }
}
