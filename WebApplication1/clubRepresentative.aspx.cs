using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class clubRepresentative : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);


            if (Session["user"] != null)
            {
                SqlCommand info = new SqlCommand("clubInfo", conn);
                info.CommandType = CommandType.StoredProcedure;
                info.Parameters.Add(new SqlParameter("@username", Session["user"]));

                conn.Open();

                SqlDataReader rdr = info.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdr.Read())
                {
                    string namet = rdr.GetString(rdr.GetOrdinal("name"));
                    string locationt = rdr.GetString(rdr.GetOrdinal("location"));

                    name.InnerText = "Name: " + namet.ToString();
                    loc.InnerText = "Location: " + locationt.ToString();
                }
                conn.Close();

                SqlCommand matches = new SqlCommand("comingMatches", conn);
                matches.CommandType = CommandType.StoredProcedure;
                matches.Parameters.Add(new SqlParameter("@username", Session["user"]));

                conn.Open();
                SqlDataReader rdr1 = matches.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdr1.Read())
                {
                    string host = rdr1.GetString(rdr1.GetOrdinal("host"));
                    string guest = rdr1.GetString(rdr1.GetOrdinal("guest"));
                    DateTime st = rdr1.GetDateTime(rdr1.GetOrdinal("start_time"));
                    DateTime en = rdr1.GetDateTime(rdr1.GetOrdinal("end_time"));
                    string stad = rdr1.IsDBNull(4) ? "not assigned" : rdr1.GetString(rdr1.GetOrdinal("stad name"));

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

                    TableCell stc = new TableCell();
                    stc.Attributes["class"] = "cell";
                    stc.Text = st.ToString();
                    row.Controls.Add(stc);

                    TableCell enc = new TableCell();
                    enc.Attributes["class"] = "cell";
                    enc.Text = en.ToString();
                    row.Controls.Add(enc);

                    TableCell stadc = new TableCell();
                    stadc.Attributes["class"] = "cell";
                    if (stad == "not assigned") stadc.Attributes["style"] = "color:brown;";
                    stadc.Text = stad;
                    row.Controls.Add(stadc);

                    table1.Controls.Add(row);

                }
                conn.Close();
            }

        }

        protected void viewStads(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);


            if (DateTime.TryParse(startingfrom.Text, out DateTime value))
            {
                
                DateTime startingFrom = Convert.ToDateTime(startingfrom.Text);

                SqlCommand avalibleStads = new SqlCommand("avStads", conn);
                avalibleStads.CommandType = CommandType.StoredProcedure;
                avalibleStads.Parameters.Add(new SqlParameter("@datetime", startingFrom));

                conn.Open();
                SqlDataReader rdr = avalibleStads.ExecuteReader();
                while (rdr.Read())
                {
                    string name = rdr.GetString(rdr.GetOrdinal("name"));
                    string location = rdr.GetString(rdr.GetOrdinal("location"));
                    int capacity = rdr.GetInt32(rdr.GetOrdinal("capacity"));

                    TableRow row = new TableRow();
                    row.Attributes["class"] = "row";

                    TableCell namec = new TableCell();
                    namec.Attributes["class"] = "cell";
                    namec.Text = name;
                    row.Controls.Add(namec);

                    TableCell locationc = new TableCell();
                    locationc.Attributes["class"] = "cell";
                    locationc.Text = location;
                    row.Controls.Add(locationc);

                    TableCell capacityc = new TableCell();
                    capacityc.Attributes["class"] = "cell";
                    capacityc.Text = capacity.ToString();
                    row.Controls.Add(capacityc);

                    table2.Controls.Add(row);
                    table2.Attributes["style"] = "display:table";

                }
                conn.Close();
            }
        }
        protected void sentHostReq(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);

            if (DateTime.TryParse(date.Text, out DateTime value) && Session["user"] != null)
            {
                string stadiumname = stadname.Text;
                DateTime startTime = Convert.ToDateTime(date.Text);

                SqlCommand addReq = new SqlCommand("addHostRequest", conn);
                addReq.CommandType = CommandType.StoredProcedure;
                addReq.Parameters.Add(new SqlParameter("@username", Session["user"]));
                addReq.Parameters.Add(new SqlParameter("@stadium_name", stadiumname));
                addReq.Parameters.Add(new SqlParameter("@starttime", startTime));

                conn.Open();
                addReq.ExecuteNonQuery();
                conn.Close();
            }
        }
    }
}