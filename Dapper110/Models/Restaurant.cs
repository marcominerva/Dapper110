namespace Dapper110.Models;

public class Restaurant
{
    public int Id { get; set; }

    public string Name { get; set; }

    public string Street { get; set; }

    public string ZipCode { get; set; }

    public int CityId { get; set; }

    public string Phone { get; set; }

    public string ImageUrl { get; set; }

    public string WebSite { get; set; }

    public IEnumerable<Review> Reviews { get; set; }
}
