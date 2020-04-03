using Dapper110.Samples;
using System.Threading.Tasks;

namespace Dapper110
{
    internal class Program
    {
        private const string connectionString = @"Data Source=(localdb)\mssqllocaldb;Initial Catalog=Dapper110;Integrated Security=True";

        private static Task Main(string[] args)
        {
            //return Parameters.RunSampleAsync(connectionString);

            return MultipleResultsets.RunSampleAsync(connectionString);

            //return MultipleMappings.RunSampleAsync(connectionString);

            //return CustomColumnMapping.RunSampleAsync(connectionString);

            //return CustomTypeHandling.RunSampleAsync(connectionString);

            //return Resiliency.RunSampleAsync(connectionString);
        }
    }
}
