namespace Dapper110.Enums;

[Flags]
public enum Role
{
    Administrator = 1,
    User = 2,
    Reviewer = 4,
    Contributor = 8
}
