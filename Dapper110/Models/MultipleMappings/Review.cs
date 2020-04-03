using System;

namespace Dapper110.Models.MultipleMappings
{
    public class Review
    {
        public int Id { get; set; }

        public User User { get; set; }

        public Restaurant Restaurant { get; set; }

        public int Rating { get; set; }

        public string Comment { get; set; }

        public DateTime Date { get; set; }
    }
}
