using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace WebApplication1
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            msg.InnerText= string.Empty;
        }
        protected void onTypeChanged(object sender, EventArgs e)
        {
            switch (type.SelectedItem.Text)
            {
                case "Club Representative":
                    clubField.Attributes["style"]="display:block;";
                    nationalIdField.Attributes["style"] = "display:none;";
                    birthDateField.Attributes["style"] = "display:none;";
                    adressField.Attributes["style"] = "display:none;";
                    phoneField.Attributes["style"] = "display:none;";
                    stadiumField.Attributes["style"] = "display:none;";
                    field.Attributes["style"] = "flex-direction:row;";

                    break;

                case "Stadium Manager":
                    stadiumField.Attributes["style"] = "display:block;";
                    nationalIdField.Attributes["style"] = "display:none;";
                    birthDateField.Attributes["style"] = "display:none;";
                    adressField.Attributes["style"] = "display:none;";
                    phoneField.Attributes["style"] = "display:none;";
                    clubField.Attributes["style"] = "display:none;";
                    field.Attributes["style"] = "flex-direction:row;";

                    break;

                case "Fan": 
                    nationalIdField.Attributes["style"] = "display:block;";
                    birthDateField.Attributes["style"] = "display:block;";
                    adressField.Attributes["style"] = "display:block;";
                    phoneField.Attributes["style"] = "display:block;";
                    clubField.Attributes["style"] = "display:none;";
                    stadiumField.Attributes["style"] = "display:none;";
                    field.Attributes["style"] = "flex-direction:row;";

                    break;

                case "Association Manager":
                    nationalIdField.Attributes["style"] = "display:none;";
                    birthDateField.Attributes["style"] = "display:none;";
                    adressField.Attributes["style"] = "display:none;";
                    phoneField.Attributes["style"] = "display:none;";
                    clubField.Attributes["style"] = "display:none;";
                    stadiumField.Attributes["style"] = "display:none;";
                    field.Attributes["style"] = "flex-direction:column;";
                    break;
            }
            
        }
        protected void MultiTask(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);

            string rname = name.Text;
            string rusername = username.Text;
            string rpassword = password.Text;
            string rstadium = stadium.Text;
            string rclub = club.Text;
            Int64 rphone = Int64.TryParse(phone.Text, out Int64 res1) ? res1 : Int64.MinValue;
            Int64 rnationalID = Int64.TryParse(nationalID.Text, out Int64 res2) ? res2 : Int64.MinValue;
            string radress = adress.Text;
            DateTime rbirthdate = DateTime.TryParse(birthDate.Text, out DateTime res) ? res : DateTime.MinValue;

            SqlCommand check = new SqlCommand("checkIfExistingUser", conn);
            check.CommandType = CommandType.StoredProcedure;
            check.Parameters.Add(new SqlParameter("@user", rusername));
            SqlParameter exists = check.Parameters.Add("@exists", SqlDbType.Int);
            exists.Direction = ParameterDirection.Output;

            conn.Open();
            check.ExecuteNonQuery();
            conn.Close();

            if(username.Text!="" && exists.Value.ToString() == "1")
            {
                msg.InnerText="this username already exists";
                msg.Attributes["style"] = "color:red;";
                return;
            }

            switch (type.SelectedItem.Text)
            {
                case "Association Manager":
                    if (rname == "" || rusername == "" || rpassword == "")
                    {
                        msg.InnerText = "please fill out all fields";
                        msg.Attributes["style"] = "color:red;";
                        return;
                    }
                   
                    SqlCommand addAssociationManager = new SqlCommand("addAssociationManager", conn);
                    addAssociationManager.CommandType = CommandType.StoredProcedure;
                    addAssociationManager.Parameters.Add(new SqlParameter("@name", rname));
                    addAssociationManager.Parameters.Add(new SqlParameter("@username", rusername));
                    addAssociationManager.Parameters.Add(new SqlParameter("@password", rpassword));

                    conn.Open();
                    addAssociationManager.ExecuteNonQuery();
                    conn.Close();
                    
                    break;

                case "Club Representative":

                    SqlCommand existingClub = new SqlCommand("existingClub", conn);
                    existingClub.CommandType = CommandType.StoredProcedure;
                    existingClub.Parameters.Add(new SqlParameter("@club", rclub));
                    SqlParameter existsC = existingClub.Parameters.Add("@exists", SqlDbType.Int);
                    existsC.Direction = ParameterDirection.Output;

                    conn.Open();
                    existingClub.ExecuteNonQuery();
                    conn.Close();

                    if (rname == "" || rusername == "" || rpassword == "" || rclub=="")
                    {
                        msg.InnerText = "please fill out all fields";
                        msg.Attributes["style"] = "color:red;";
                        return;
                    }
                   
                    if(existsC.Value.ToString()=="0")
                    {
                        msg.InnerText = "the entered club does not exist";
                        msg.Attributes["style"] = "color:red;";
                        return;
                    }
                    SqlCommand addRepresentative = new SqlCommand("addRepresentative", conn);
                    addRepresentative.CommandType = CommandType.StoredProcedure;
                    addRepresentative.Parameters.Add(new SqlParameter("@name", rname));
                    addRepresentative.Parameters.Add(new SqlParameter("@name_of_club", rclub));
                    addRepresentative.Parameters.Add(new SqlParameter("@username", rusername));
                    addRepresentative.Parameters.Add(new SqlParameter("@password", rpassword));

                    conn.Open();
                    addRepresentative.ExecuteNonQuery();
                    conn.Close();
                    
                    break;

                case "Stadium Manager":

                    SqlCommand existingStadium = new SqlCommand("existingStadium", conn);
                    existingStadium.CommandType = CommandType.StoredProcedure;
                    existingStadium.Parameters.Add(new SqlParameter("@stadium", rstadium));
                    SqlParameter existsS = existingStadium.Parameters.Add("@exists", SqlDbType.Int);
                    existsS.Direction = ParameterDirection.Output;

                    conn.Open();
                    existingStadium.ExecuteNonQuery();
                    conn.Close();

                    if (rname == "" || rusername == "" || rpassword == "" || rstadium == "")
                    {
                        msg.InnerText = "please fill out all fields";
                        msg.Attributes["style"] = "color:red;";
                        return;
                    }
                    if (existsS.Value.ToString() == "0")
                    {
                        msg.InnerText = "the entered stadium does not exist";
                        msg.Attributes["style"] = "color:red;";
                        return;
                    }

                    SqlCommand addStadiumManager = new SqlCommand("addStadiumManager", conn);
                    addStadiumManager.CommandType = CommandType.StoredProcedure;
                    addStadiumManager.Parameters.Add(new SqlParameter("@name", rname));
                    addStadiumManager.Parameters.Add(new SqlParameter("@stadiumName", rstadium));
                    addStadiumManager.Parameters.Add(new SqlParameter("@username", rusername));
                    addStadiumManager.Parameters.Add(new SqlParameter("@password", rpassword));

                    conn.Open();
                    addStadiumManager.ExecuteNonQuery();
                    conn.Close();
                    
                    break;

                case "Fan":

                    SqlCommand existingNatID = new SqlCommand("existingNatID", conn);
                    existingNatID.CommandType = CommandType.StoredProcedure;
                    existingNatID.Parameters.Add(new SqlParameter("@natID", rnationalID));
                    SqlParameter existsID = existingNatID.Parameters.Add("@exists", SqlDbType.Int);
                    existsID.Direction = ParameterDirection.Output;

                    conn.Open();
                    existingNatID.ExecuteNonQuery();
                    conn.Close();

                    if (rname == "" || rusername == "" || rpassword == "" || rbirthdate == DateTime.MinValue 
                        || radress=="" || rnationalID==Int64.MinValue || rphone==Int64.MinValue)
                    {
                        msg.InnerText = "please fill out all fields";
                        msg.Attributes["style"] = "color:red;";
                        return;
                    }
                    if (existsID.Value.ToString()=="1")
                    {
                        msg.InnerText = "the entered national ID already exists";
                        msg.Attributes["style"] = "color:red;";
                        return;
                    }

                    SqlCommand addFan = new SqlCommand("addFan", conn);
                    addFan.CommandType = CommandType.StoredProcedure;
                    addFan.Parameters.Add(new SqlParameter("@Name", rname));
                    addFan.Parameters.Add(new SqlParameter("@Username", rusername));
                    addFan.Parameters.Add(new SqlParameter("@pass", rpassword));
                    addFan.Parameters.Add(new SqlParameter("@NatID", rnationalID));
                    addFan.Parameters.Add(new SqlParameter("@BirthDate", rbirthdate));
                    addFan.Parameters.Add(new SqlParameter("@Add", radress));
                    addFan.Parameters.Add(new SqlParameter("@phoneNo", rphone));

                    conn.Open();
                    addFan.ExecuteNonQuery();
                    conn.Close();
                    
                    break;
            }
            msg.InnerText = "successfully registered";
            msg.Attributes["style"] = "color:#04AA6D;";
            
        }
    }

}