using Balance.Models;
using System.Data.SqlClient;
using System.Data;
using Microsoft.OpenApi.Expressions;

namespace Balance
{
    public class DBConnect
    {
        private static string connectionString = @"Data Source=DESKTOP-F1DVJI0;Initial Catalog=TestTaskBalance;Integrated Security=True";

        private static SqlConnection Connect()
        {
            var connection = new SqlConnection(connectionString);
            connection.Open();
            return connection;
        }

        public static void InsertData(string expression)
        {
            var connection = Connect();
            string sqlExpression = expression;
            SqlCommand command = new SqlCommand(sqlExpression, connection);
            command.ExecuteNonQuery();
            connection.Close();
        }

        public static DataSet GetData(string expression)
        {
            var connection = Connect();
            string sqlExpression = expression;
            SqlCommand command = new SqlCommand(sqlExpression, connection);
            SqlDataAdapter adapter = new SqlDataAdapter(command);
            DataSet ds = new DataSet();
            adapter.Fill(ds);
            connection.Close();
            return ds;
        }
    }
}
