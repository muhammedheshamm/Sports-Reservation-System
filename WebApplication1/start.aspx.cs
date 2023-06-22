using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class start : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login(object sender, EventArgs e)
        {
            Response.Redirect("login.aspx");
        }
        protected void register(object sender, EventArgs e)
        {
            Response.Redirect("register.aspx");

        }

    }
}