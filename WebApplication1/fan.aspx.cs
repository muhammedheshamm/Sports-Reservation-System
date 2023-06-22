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
    public partial class fan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void PurchaseTicket(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);

            string hostclub = hostName.Text;
            string guestclub = guestName.Text;
           

            if(DateTime.TryParse(startTime.Text , out DateTime value) && Session["user"] != null)
            {
                SqlCommand idd = new SqlCommand("SELECT national_ID FROM Fan WHERE username = @user", conn);
                idd.Parameters.AddWithValue("@user", Session["user"]);
                conn.Open();
                string id = idd.ExecuteScalar().ToString();
                conn.Close();

                DateTime starttime = Convert.ToDateTime(startTime.Text);
                SqlCommand purchaseticket = new SqlCommand("purchaseTicket", conn);
                purchaseticket.CommandType = CommandType.StoredProcedure;
                purchaseticket.Parameters.Add(new SqlParameter("@nID", id));
                purchaseticket.Parameters.Add(new SqlParameter("@hostname", hostclub));
                purchaseticket.Parameters.Add(new SqlParameter("@guestname", guestclub));
                purchaseticket.Parameters.Add(new SqlParameter("@starttime", starttime));

                conn.Open();
                purchaseticket.ExecuteNonQuery();
                conn.Close();
            }
        }

        protected void viewMatches(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);


            if (DateTime.TryParse(startingfrom.Text, out DateTime value))
            {


                DateTime startingFrom = Convert.ToDateTime(startingfrom.Text);

                SqlCommand avalibleMatches = new SqlCommand("availableMatchesToAttend", conn);
                avalibleMatches.CommandType = CommandType.StoredProcedure;
                avalibleMatches.Parameters.Add(new SqlParameter("@date", startingFrom));

                conn.Open();
                SqlDataReader rdr = avalibleMatches.ExecuteReader();
                while (rdr.Read())
                {
                    string host = rdr.GetString(rdr.GetOrdinal("HOST"));
                    string guest = rdr.GetString(rdr.GetOrdinal("GUEST"));
                    string stadName = rdr.GetString(rdr.GetOrdinal("STAD NAME"));
                    string stadLoc = rdr.GetString(rdr.GetOrdinal("STAD LOCATION"));
                    DateTime starttime = rdr.GetDateTime(rdr.GetOrdinal("START TIME"));

                    TableRow row = new TableRow();
                    row.Attributes["class"] = "row";

                    TableCell hostc = new TableCell();
                    hostc.Attributes["class"] = "cell";
                    hostc.Text = host;
                    row.Controls.Add(hostc);

                    TableCell guestc = new TableCell();
                    guestc.Attributes["class"] = "cell";
                    guestc.Text = guest;
                    row.Controls.Add(guestc);

                    TableCell stadNamec = new TableCell();
                    stadNamec.Attributes["class"] = "cell";
                    stadNamec.Text = stadName;
                    row.Controls.Add(stadNamec);

                    TableCell stadLocc = new TableCell();
                    stadLocc.Attributes["class"] = "cell";
                    stadLocc.Text = stadLoc;
                    row.Controls.Add(stadLocc);

                    TableCell starttimec = new TableCell();
                    starttimec.Attributes["class"] = "cell";
                    starttimec.Text = starttime.ToString();
                    row.Controls.Add(starttimec);

                    table1.Controls.Add(row);
                    scroll.Attributes["style"] = "display:block";

                }
                conn.Close();
            }
        }

    }
}