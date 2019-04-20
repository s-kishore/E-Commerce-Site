using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using dbproj.DAOs;
using System.Web.UI.WebControls;
using System.Web.Security;


public partial class register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void CreateUser(object sender, EventArgs e)
    {
        UserVO curr_user = new UserVO(regis_usrname.Value,
                                      regis_password.Value,
                                      "2",
                                      regis_fname.Value,
                                      regis_lname.Value,
                                      regis_address.Text,
                                      regis_email.Value,
                                      //regis_zip.Text
                                      "02067");
        UserDAO userDB = new UserDAO();
        int success = userDB.CreateUser(curr_user);
        if (success == 1)
        {
            curr_user.password = "";
            Session["curruser"] = curr_user;
            Session.Timeout = 60;
            Response.Redirect("default.aspx");
        }
        else
        {
            if (success == 0)
                diff_user.InnerText = " Username taken. Please choose a different Username";
            else
                diff_user.InnerText = "Error Occured. Please try again later.";

            diff_user.Attributes.Add("class", "alert alert-danger msg-box show-elements");
        }
    }
}