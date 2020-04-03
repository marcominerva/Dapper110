using System;
using System.Collections.Generic;

namespace Dapper110.Models.CustomTypeHandling
{
    public class Review
    {
        public int Id { get; set; }

        public int UserId { get; set; }

        public int RestaurantId { get; set; }

        public int Rating { get; set; }

        public string Comment { get; set; }

        public DateTime Date { get; set; }

        public List<Tag> Tags { get; set; }
    }
}
