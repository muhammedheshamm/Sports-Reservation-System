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
    public partial class stadiumManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);


            if (Session["user"] != null)
            {
                SqlCommand info = new SqlCommand("viewStadInfo", conn);
                info.CommandType = CommandType.StoredProcedure;
                info.Parameters.Add(new SqlParameter("@username", Session["user"]));

                SqlCommand reqs = new SqlCommand("allReqForManager", conn);
                reqs.CommandType = CommandType.StoredProcedure;
                reqs.Parameters.Add(new SqlParameter("@username", Session["user"]));

                conn.Open();

                SqlDataReader rdr = info.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdr.Read())
                {
                    string namet = rdr.GetString(rdr.GetOrdinal("name"));
                    string locationt = rdr.GetString(rdr.GetOrdinal("location"));
                    int capacityt = rdr.GetInt32(rdr.GetOrdinal("capacity"));
                    bool statust = rdr.GetBoolean(rdr.GetOrdinal("status"));

                    name.InnerText ="Name: "+ namet.ToString();
                    loc.InnerText ="Location: "+ locationt.ToString();
                    cap.InnerText ="Capacity: "+ capacityt.ToString();

                    status.InnerText ="Status: "+ (statust ? "available" : "unavailable");
                }
                conn.Close();

                conn.Open();
                SqlDataReader rdr1 = reqs.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdr1.Read())
                {
                    string rname = rdr1.GetString(rdr1.GetOrdinal("rname"));
                    string host = rdr1.GetString(rdr1.GetOrdinal("host"));
                    string guest = rdr1.GetString(rdr1.GetOrdinal("guest"));
                    DateTime st = rdr1.GetDateTime(rdr1.GetOrdinal("start_time"));
                    DateTime en = rdr1.GetDateTime(rdr1.GetOrdinal("end_time"));
                    string stat = rdr1.GetString(rdr1.GetOrdinal("status"));

                    TableRow row = new TableRow();
                    row.Attributes["class"] = "row";

                    TableCell rnamec = new TableCell();
                    rnamec.Attributes["class"] = "cell";
                    rnamec.Text = rname;
                    row.Controls.Add(rnamec);

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

                    TableCell statc = new TableCell();
                    statc.Attributes["class"] = "cell";
                    statc.Attributes["style"] = stat == "accepted" ? "color:#04AA6D;" : "color:red;";
                    statc.Text = stat;
                    row.Controls.Add(statc);

                    table1.Controls.Add(row);

                }



                conn.Close();
            }
        }


        protected void acceptReq(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);

            string hostclub = hostName.Text;
            string guestclub = guestName.Text;


            if (DateTime.TryParse(startTime.Text, out DateTime value) && Session["user"] != null)
            {
                
                DateTime starttime = Convert.ToDateTime(startTime.Text);

                SqlCommand acc = new SqlCommand("acceptRequest", conn);
                acc.CommandType = CommandType.StoredProcedure;
                acc.Parameters.Add(new SqlParameter("@usernameOfManager", Session["user"]));
                acc.Parameters.Add(new SqlParameter("@hostname", hostclub));
                acc.Parameters.Add(new SqlParameter("@gusetname", guestclub));
                acc.Parameters.Add(new SqlParameter("@starttime", starttime));

                conn.Open();
                acc.ExecuteNonQuery();
                conn.Close();
            }
            Response.Redirect("stadiummanager.aspx");
        }

        protected void rejectReq(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);

            string hostclub = hostName.Text;
            string guestclub = guestName.Text;


            if (DateTime.TryParse(startTime.Text, out DateTime value) && Session["user"] != null)
            {
               
                DateTime starttime = Convert.ToDateTime(startTime.Text);

                SqlCommand rej = new SqlCommand("rejectRequest", conn);
                rej.CommandType = CommandType.StoredProcedure;
                rej.Parameters.Add(new SqlParameter("@usernameOfManager", Session["user"]));
                rej.Parameters.Add(new SqlParameter("@hostname", hostclub));
                rej.Parameters.Add(new SqlParameter("@gusetname", guestclub));
                rej.Parameters.Add(new SqlParameter("@starttime", starttime));

                conn.Open();
                rej.ExecuteNonQuery();
                conn.Close();
            }
            Response.Redirect("stadiummanager.aspx");

        }

    }
}