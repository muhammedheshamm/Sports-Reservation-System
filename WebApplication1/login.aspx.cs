using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void loginn(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);

            string user = username.Text;
            string pass = password.Text;

            SqlCommand Login = new SqlCommand("login", conn);
            Login.CommandType = CommandType.StoredProcedure;
            Login.Parameters.Add(new SqlParameter("@user", user));
            Login.Parameters.Add(new SqlParameter("@pass", pass));


            SqlParameter exists = Login.Parameters.Add("@exists", SqlDbType.Int);
            SqlParameter type = Login.Parameters.Add("@type", SqlDbType.NVarChar ,20);

            exists.Direction = ParameterDirection.Output;
            type.Direction = ParameterDirection.Output;

            conn.Open();
            Login.ExecuteNonQuery();
            conn.Close();

            if (exists.Value.ToString() == "1")
            {
                Session["user"] = user;
                Response.Redirect(type.Value.ToString() + ".aspx");

            }
            else
            {
                msg.InnerText = "incorrect username or password";
                msg.Attributes["style"] = "color:brown";
            }
        }
    }
}