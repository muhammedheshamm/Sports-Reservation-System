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
    public partial class associationManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //hostName.Text= string.Empty;
            //guestName.Text= string.Empty;
            //startTime.Text= string.Empty;
            //endTime.Text= string.Empty;
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);

            SqlCommand comingMatches = new SqlCommand("allUpcomingMatches", conn);
            comingMatches.CommandType = CommandType.StoredProcedure;

            SqlCommand playedMatches = new SqlCommand("alreadyPlayedMatches", conn);
            playedMatches.CommandType = CommandType.StoredProcedure;

            SqlCommand neverPlayed = new SqlCommand("clubsNeverMatched", conn);
            neverPlayed.CommandType = CommandType.StoredProcedure;

            conn.Open();

            SqlDataReader rdr = comingMatches.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                string host = rdr.GetString(rdr.GetOrdinal("host_club"));
                string guest = rdr.GetString(rdr.GetOrdinal("guest_club"));
                DateTime st = rdr.GetDateTime(rdr.GetOrdinal("start_time"));
                DateTime en = rdr.GetDateTime(rdr.GetOrdinal("end_time"));

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

                table1.Controls.Add(row);
            }
            conn.Close();

            conn.Open();

            SqlDataReader rdr1 = playedMatches.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr1.Read())
            {
                string host = rdr1.GetString(rdr1.GetOrdinal("host_club"));
                string guest = rdr1.GetString(rdr1.GetOrdinal("guest_club"));
                DateTime st = rdr1.GetDateTime(rdr1.GetOrdinal("start_time"));
                DateTime en = rdr1.GetDateTime(rdr1.GetOrdinal("end_time"));

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

                table2.Controls.Add(row);
            }
            conn.Close();

            conn.Open();

            SqlDataReader rdr2 = neverPlayed.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr2.Read())
            {
                string club1 = rdr2.GetString(rdr2.GetOrdinal("first_Club_name"));
                string club2 = rdr2.GetString(rdr2.GetOrdinal("second_club_name"));

                TableRow row = new TableRow();
                row.Attributes["class"] = "row";

                TableCell hostc = new TableCell();
                hostc.Attributes["class"] = "cell";
                hostc.Text = club1;
                row.Controls.Add(hostc);

                TableCell guestc = new TableCell();
                guestc.Attributes["class"] = "cell";
                guestc.Text = club2;
                row.Controls.Add(guestc);


                table3.Controls.Add(row);
            }
            conn.Close();
        }

        protected void addMatch(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);

            string hostclub = hostName.Text;
            string guestclub = guestName.Text;


            if (DateTime.TryParse(startTime.Text, out DateTime starttime) && DateTime.TryParse(startTime.Text, out DateTime endtime))
            {

                SqlCommand add = new SqlCommand("addNewMatch", conn);
                add.CommandType = CommandType.StoredProcedure;
                add.Parameters.Add(new SqlParameter("@name_host_club", hostclub));
                add.Parameters.Add(new SqlParameter("@name_guest_club", guestclub));
                add.Parameters.Add(new SqlParameter("@start_time", starttime));
                add.Parameters.Add(new SqlParameter("@end_time", endtime));

                conn.Open();
                add.ExecuteNonQuery();
                conn.Close();
            }
            Response.Redirect("associationManager.aspx");
        }

        protected void deleteMatch(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);

            string hostclub = hostName.Text;
            string guestclub = guestName.Text;


            if (DateTime.TryParse(startTime.Text, out DateTime starttime) && DateTime.TryParse(startTime.Text, out DateTime endtime))
            {

                SqlCommand delete = new SqlCommand("deleteMatch", conn);
                delete.CommandType = CommandType.StoredProcedure;
                delete.Parameters.Add(new SqlParameter("@name_host_club", hostclub));
                delete.Parameters.Add(new SqlParameter("@name_guest_club", guestclub));
                delete.Parameters.Add(new SqlParameter("@start_time", starttime));
                delete.Parameters.Add(new SqlParameter("@end_time", endtime));

                conn.Open();
                delete.ExecuteNonQuery();
                conn.Close();
                Response.Redirect("associationManager.aspx");
            }
        }
    }
}