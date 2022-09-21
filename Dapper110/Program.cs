using Dapper110.Samples;

const string connectionString = @"Data Source=(localdb)\mssqllocaldb;Initial Catalog=Dapper110;Integrated Security=True";

//await Parameters.RunSampleAsync(connectionString);

await MultipleResultsets.RunSampleAsync(connectionString);

//await MultipleMappings.RunSampleAsync(connectionString);

//await CustomColumnMapping.RunSampleAsync(connectionString);

//await CustomTypeHandling.RunSampleAsync(connectionString);

//await Resiliency.RunSampleAsync(connectionString);

