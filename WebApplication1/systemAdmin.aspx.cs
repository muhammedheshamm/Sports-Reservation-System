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
    public partial class systemAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void addClub(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);

            string clubName = aName.Text;
            string clubLocation = Location.Text;

            SqlCommand addclub = new SqlCommand("addClub", conn);
            addclub.CommandType = CommandType.StoredProcedure;
            addclub.Parameters.Add(new SqlParameter("@clubName", clubName));
            addclub.Parameters.Add(new SqlParameter("@clubLocation", clubLocation));

            conn.Open();
            addclub.ExecuteNonQuery();
            conn.Close();

        }

        protected void deleteClub(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);

            string clubName = dName.Text;

            SqlCommand deleteclub = new SqlCommand("deleteClub", conn);
            deleteclub.CommandType = CommandType.StoredProcedure;
            deleteclub.Parameters.Add(new SqlParameter("@clubName", clubName));
            conn.Open();
            deleteclub.ExecuteNonQuery();
            conn.Close();

        }
        protected void addStadium(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);

            
            if (int.TryParse(sCapacity.Text, out int value))
            {
                string stadName = sName.Text;
                string stadLocation = sLocation.Text;
                SqlCommand addStadium = new SqlCommand("addStadium", conn);
                addStadium.CommandType = CommandType.StoredProcedure;
                addStadium.Parameters.Add(new SqlParameter("@name", stadName));
                addStadium.Parameters.Add(new SqlParameter("@location", stadLocation));
                int capacity = int.Parse(sCapacity.Text);
                addStadium.Parameters.Add(new SqlParameter("@capacity", capacity));
                conn.Open();
                addStadium.ExecuteNonQuery();
                conn.Close();
            }

        }
        protected void deleteStadium(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);

            string stadName = sdName.Text;

            SqlCommand deleteStadium = new SqlCommand("deleteStadium", conn);
            deleteStadium.CommandType = CommandType.StoredProcedure;
            deleteStadium.Parameters.Add(new SqlParameter("@name", stadName));
            conn.Open();
            deleteStadium.ExecuteNonQuery();
            conn.Close();

        }
        protected void blockFan(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);

            string nationalID = natID.Text;

            SqlCommand blockFan = new SqlCommand("blockFan", conn);
            blockFan.CommandType = CommandType.StoredProcedure;
            blockFan.Parameters.Add(new SqlParameter("@national_ID", nationalID));
            conn.Open();
            blockFan.ExecuteNonQuery();
            conn.Close();

        }
    }
}