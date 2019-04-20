using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace dbproj
{
    public partial class login : System.Web.UI.Page
    {
        /*protected void Page_Load(object sender, EventArgs e)
        {
            // check for user already login and if so redirect to homepage 
        }

        protected void loginbtn_Click(object sender, EventArgs e)
        {

            string usrnm = username.Text;
            string pass = password.Text;

            if ( !string.IsNullOrWhiteSpace(usrnm) && !string.IsNullOrWhiteSpace(pass))
            {
                verifyUserLogin(usrnm, pass);
            }
            else
            {

            }
            
        }
        private void verifyUserLogin(string usrnm, string pass)
        {
            UserVO curruser;
            UserDAO newuserdao = new UserDAO();

            curruser = newuserdao.getUserById(usrnm);
            if (curruser.status == "S" && pass == curruser.password)
            {
                //FormsAuthentication.RedirectFromLoginPage
                //   (curruser.userid, true);
                Session["curruser"] = curruser;
                Session.Timeout = 10080;
                Response.Redirect("default.aspx");
            }
            else
            {
                msgbox.InnerText = "Incorrect UserID & Password Combination";
            }
        }
        */
    }
}