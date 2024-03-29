﻿using System.ComponentModel;
using System.Data;
using Dapper;
using Microsoft.Data.SqlClient;
using Polly;
using Polly.Retry;

namespace Dapper110.Polly;

public static class DapperExtensions
{
    private static readonly IEnumerable<TimeSpan> retryTimes = new[]
    {
        TimeSpan.FromSeconds(1),
        TimeSpan.FromSeconds(3),
        TimeSpan.FromSeconds(5),
        TimeSpan.FromSeconds(10),
        TimeSpan.FromSeconds(20),
        TimeSpan.FromSeconds(30)
    };

    private static readonly AsyncRetryPolicy retryPolicy = Policy
                                            .Handle<SqlException>(SqlServerTransientExceptionDetector.ShouldRetryOn)
                                            .OrInner<Win32Exception>(SqlServerTransientExceptionDetector.ShouldRetryOn)
                                            .WaitAndRetryAsync(retryTimes,
                                            (exception, timeSpan, retryCount, context) =>
                                            {
                                                Console.WriteLine($"Exception '{exception.Message}', will retry after {timeSpan}. Retry attempt {retryCount}");
                                            });

    public static Task<int> ExecuteWithRetryAsync(this IDbConnection conn, string sql, object param = null,
                                                        IDbTransaction transaction = null, int? commandTimeout = null,
                                                        CommandType? commandType = null)
        => retryPolicy.ExecuteAsync(async () => await conn.ExecuteAsync(sql, param, transaction, commandTimeout, commandType));

    public static Task<IEnumerable<T>> QueryWithRetryAsync<T>(this IDbConnection conn, string sql, object param = null,
                                                                    IDbTransaction transaction = null, int? commandTimeout = null,
                                                                    CommandType? commandType = null)
        => retryPolicy.ExecuteAsync(async () => await conn.QueryAsync<T>(sql, param, transaction, commandTimeout, commandType));
}
