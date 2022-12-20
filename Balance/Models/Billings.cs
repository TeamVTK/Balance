using System.ComponentModel.DataAnnotations;

namespace Balance.Models
{
    public class Billings
    {
        public int billings_id { get; set; }
        public int user_id { get; set; }
        public int billing_type { get; set; }
        public decimal billing_sum { get; set; }
    }
}
