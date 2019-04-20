using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace dbproj
{
    public partial class proj : System.Web.UI.MasterPage
    {
        /*UserVO curruser;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["curruser"] == null)
            {
                renderUserSpecifics(false);
            }
            else
            {
                curruser = (UserVO)Session["curruser"];
                renderUserSpecifics(true);
            }
        }

        private void renderUserSpecifics(bool userexists)
        {
            StringWriter stringWriter = new StringWriter();
            HtmlTextWriter createbutton = new HtmlTextWriter(stringWriter);

            if (userexists)
            {
                welcomemsg.InnerHtml = "Welcome, " + curruser.userid;
                loginout.Click += new EventHandler(this.logout_Click);
                loginout.CssClass = "signout-btn";
            }
            else
            {
                loginout.Click += new EventHandler(this.redirectToPage);
                loginout.CssClass = "signin-btn";
            }
        }


        protected void logout_Click(object sender, EventArgs e)
        {
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.Abandon();
            HttpContext.Current.User = null;
            Response.Redirect(Request.RawUrl);
        }

        protected void redirectToPage(object sender, EventArgs e)
        {
            Button clickedbutton = (Button)sender;
            string buttonid = clickedbutton.ID;
            string viewcart = "viewcart";
            if (buttonid == viewcart)
                Response.Redirect("cart.aspx");
            else
                Response.Redirect("login.aspx");
        }

        protected void searchbtn_Click(object sender, EventArgs e)
        {
            string searchstring = searchq.Text;
            Regex validexp = new Regex("[^A-Za-z0-9\x20]");
            bool isstringvalid = validexp.IsMatch(searchstring);

            if (!string.IsNullOrWhiteSpace(searchstring) && !isstringvalid)
            {
                searchstring = searchstring.Replace(" ", "+");
                Response.Redirect("search.aspx?q=" + searchstring);
            }
            else
            {
                // Display information window
            }
        }*/
    }
}