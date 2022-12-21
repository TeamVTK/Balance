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

        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            DBGetBilling();

            var billing = billings.Where(p => p.user_id == id);

            if(billing.Count() < 1)
            {
                return NotFound();
            }

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

        [HttpPost("AddMoneyForm")]
        public IActionResult AddMoney(int id, decimal sum)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            DBGetBilling();
            var billing = billings.Where(p => p.user_id == id);
            if (billing.Count() < 1)
            {
                return NotFound();
            }

            DBConnect.InsertData("INSERT INTO Billings (user_id, billing_type, billing_sum) VALUES ('" + id + "', '1', '" + sum + "')");

            return Ok();
        }

        [HttpPost("AddMoney")]
        public IActionResult PostAddMoneyBody([FromBody] Billings billing) => AddMoney(billing.user_id, billing.billing_sum);

        [HttpPost("Buy")]
        public IActionResult PostBuyBody([FromBody] UserService userService)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            Users user = new Users();
            var dsUser = DBConnect.GetData("SELECT user_id, user_name, user_surname, user_patronymic FROM Users Where user_id = " + userService.user_id);
            if (dsUser.Tables[0].Rows.Count > 0)
            {
                user.user_id = Convert.ToInt32(dsUser.Tables[0].Rows[0][0]);
                user.user_name = dsUser.Tables[0].Rows[0][1].ToString();
                user.user_surname = dsUser.Tables[0].Rows[0][2].ToString();
                user.user_patronymic = dsUser.Tables[0].Rows[0][3].ToString();
            }
            else return BadRequest();

            DBGetBilling();
            var billing = billings.Where(p => p.user_id == userService.user_id);
            if (billing.Count() < 1)
            {
                return BadRequest();
            }

            Services service = new Services();
            var dsServices = DBConnect.GetData("SELECT service_id, service_price, service_title FROM Services Where service_id = " + userService.service_id);
            if (dsServices.Tables[0].Rows.Count > 0)
            {
                service.service_id = Convert.ToInt32(dsServices.Tables[0].Rows[0][0]);
                service.service_price = Convert.ToDecimal(dsServices.Tables[0].Rows[0][1]);
                service.service_title = dsServices.Tables[0].Rows[0][2].ToString();
            }
            else return BadRequest();

            decimal res = 0;
            foreach (Billings tempBilling in billing)
            {
                if (tempBilling.billing_type == 1)
                {
                    res += tempBilling.billing_sum;
                }
                else if (tempBilling.billing_type == 2)
                {
                    res -= tempBilling.billing_sum;
                }
            }

            if(res < service.service_price)
            {
                return BadRequest();
            }
            else
            {
                DBConnect.InsertData("INSERT INTO Billings (user_id, billing_type, billing_sum) VALUES ('" + user.user_id + "', '2', '" + service.service_price + "')");
            }

            int id_order = DBConnect.InsertData("INSERT INTO Orders (user_id, order_cost, order_date) VALUES ('" + user.user_id + "', '" + service.service_price + "', '" + DateTime.Now + "')", true);

            DBConnect.InsertData("INSERT INTO Order_positions (order_id, service_id, order_price) VALUES ('" + id_order + "', '" + service.service_id + "', '" + service.service_price + "')");

            return Ok();
        }

        public class UserService
        {
            public int user_id { get; set; }
            public int service_id { get; set; }
        }

        //public IActionResult Index()
        //{
        //    return View();
        //}
    }
}
