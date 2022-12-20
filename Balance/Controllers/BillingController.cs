using Balance.Models;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using System.Data.SqlClient;

namespace Balance.Controllers
{
    [Route("/api/[controller]")]

    public class BillingController : Controller
    {
        private static List<Billings> billings = new List<Billings>();

        private void DBGetBilling()
        {
            billings.Clear();
            var ds = DBConnect.GetData("SELECT billing_id, user_id, billing_type, billing_sum FROM Billings");
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                Billings tempBilling = new Billings() { billings_id = Convert.ToInt32(ds.Tables[0].Rows[i][0]), user_id = Convert.ToInt32(ds.Tables[0].Rows[i][1]), billing_type = Convert.ToInt32(ds.Tables[0].Rows[i][2]), billing_sum = Convert.ToDecimal(ds.Tables[0].Rows[i][3]) };
                billings.Add(tempBilling);
            }
        }

        //[HttpGet]
        //public IEnumerable<Billings> Get()
        //{
        //    DBGetBilling();
        //    return billings;
        //}

        //[HttpGet("{id}")]
        //public IActionResult Get(int id)
        //{
        //    DBGetBilling();

        //    var billing = billings.Where(p => p.user_id == id);

        //    if(billing == null)
        //    {
        //        return NotFound();
        //    }

        //    return Ok(billing);
        //}

        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            DBGetBilling();

            var billing = billings.Where(p => p.user_id == id);

            decimal res = 0;
            foreach(Billings tempBilling in billing)
            {
                if(tempBilling.billing_type == 1)
                {
                    res += tempBilling.billing_sum;
                }
                else if (tempBilling.billing_type == 2)
                {
                    res -= tempBilling.billing_sum;
                }
            }

            if (billing == null)
            {
                return NotFound();
            }

            return Ok(new { user_id = id, balance = res });
        }

        [HttpPost]
        public IActionResult Post(int id, decimal sum)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            DBConnect.InsertData("INSERT INTO Billings (user_id, billing_type, billing_sum) VALUES ('"+id+"', '1', '"+sum+"')");
            return Ok();
        }

        [HttpPost("AddMoney")]
        public IActionResult PostBody([FromBody] int id, decimal sum) => Post(id, sum);



        //public IActionResult Index()
        //{
        //    return View();
        //}
    }
}
