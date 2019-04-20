<%@ Page Title="" Language="C#" MasterPageFile="proj.Master" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="dbproj.DAOs" %>
<%@ Import Namespace="System.Web.Security" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="CSS/login.css" />
    <title>E-Mart - Login Page</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageContent" runat="server">

    <div class="container pageContent">
        <div runat="server" id="infobox" class="alert alert-info info-box hide-elements" role="alert">
            Please Login to access to the requested resource
        </div>

        <div class="form-signin loginctrl" role="form">
            <h2 class="form-signin-heading">Login </h2>
            <br />
            <label for="inputEmail" class="sr-only">Email address</label>
            <label for="username" class="sr-only">User ID</label>
            <asp:TextBox runat="server" ID="username" CssClass="form-control login-usrnm" placeholder="UserID" />
            <br />
            <label for="password" class="sr-only">Password</label>
            <asp:TextBox ID="password" TextMode="password" runat="server" placeholder="Password" CssClass="login-password form-control"></asp:TextBox>
            <div class="checkbox">
                <label>
                    <input id="rememberMe" runat="server" type="checkbox" value="remember-me" />
                    Remember me
                </label>
            </div>
            <asp:Button ID="loginbtn" UseSubmitBehavior="false" CssClass="login-btn btn btn-lg btn-primary btn-block" runat="server" OnClick="loginbtn_Click" Text="Login"></asp:Button>
            <a runat="server" id="goback" class="login-btn btn btn-lg btn-primary btn-block" onclick="history.go(-1); return false;">Go Back </a>
            <a class="btn btn-lg btn-primary btn-block" href="register.aspx">Register </a>
        </div>
        <br />
        <div runat="server" id="msgbox" class="alert alert-danger msg-box ">
        </div>
    </div>
</asp:Content>

<script runat="server">
    string prevPage;
    protected void Page_Load(object sender, EventArgs e)
    {
        prevPage = Request.QueryString["redirect"];
        if (prevPage != null)
            infobox.Attributes.Add("class", "alert alert-info info-box show-elements");
        else
            goback.Attributes.Add("class", "hide-elements");
        // check for user already login and if so redirect to homepage 
        msgbox.Attributes.Add("class", "alert alert-danger msg-box hide-elements");
    }

    protected void loginbtn_Click(object sender, EventArgs e)
    {

        string usrnm = username.Text;
        string pass = password.Text;

        if (!string.IsNullOrWhiteSpace(usrnm) && !string.IsNullOrWhiteSpace(pass))
        {
            verifyUserLogin(usrnm, pass);
        }
        else
        {
            msgbox.Attributes.Add("class", "alert alert-danger msg-box show-elements");
            msgbox.InnerHtml = "<b>Try again !!! </b> UserID & Password can not be empty";
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
            if (rememberMe.Checked)
                Session.Timeout = 10080;
            else
                Session.Timeout = 180;
            if (prevPage == null)
                Response.Redirect("default.aspx");
            else
                Response.Redirect(prevPage);
        }
        else
        {
            msgbox.Attributes.Add("class", "alert alert-danger msg-box show-elements");
            msgbox.InnerHtml = "<b>Try again !!! </b> Incorrect UserID & Password Combination";
        }
    }
</script>
