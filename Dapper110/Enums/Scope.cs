﻿namespace Dapper110.Enums;

public readonly struct Scope
{
    private readonly string value;

    public static Scope Read => "R";

    public static Scope Write => "W";

    public static Scope ReadWrite => "RW";

    public static Scope Contributor => "C";

    public static Scope Unknown => "UNK";

    private Scope(string value)
    {
        this.value = value;
    }

    public static implicit operator Scope(string value)
        => new(value);

    public static implicit operator string(Scope scope)
        => scope.value;
}
