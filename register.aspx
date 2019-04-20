<%@ Page Title="" Language="C#" MasterPageFile="proj.Master" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="register" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="CSS/login.css" />
    <title>E-Mart - New User Registration</title>
    <script src="JS/login.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageContent" runat="server">

    <div class="container pageContent registerctrl" style="max-width=400px">
        <div id="diff_user" runat="server" class="alert alert-info info-box hide-elements" role="alert">  Passwords do not match </div>
        
        <h2 class="form-signin-heading">Registration </h2>
        <div id="register_form">
            <input type="email" id="regis_email" required="required" runat="server" placeholder="Email ID" class="form-control regis-email" />

            <br />
            <input type="text" id="regis_fname" required="required" placeholder="First Name" pattern="[a-zA-Z0-9]{2,20}" title="Only characters and numbers. Must be 2 to 20 characters" class="form-control" runat="server" />

            <br />
            <input type="text" id="regis_lname" required="required" placeholder="Last Name" pattern="[a-zA-Z0-9]{2,20}" title="Only characters and numbers. Must be 2 to 20 characters" class="form-control" runat="server" />

            <br />
            <input type="text" id="regis_usrname" required="required" placeholder="UserID" pattern="^[a-zA-Z][a-zA-Z0-9-_\.]{1,20}$" title="Must begin with character.Allowed Character, Number, Underscore and Dot. Max 20 chars" class="form-control login-usrnm" runat="server" />

            <br />
            <input type="password" id="regis_password" required="required" runat="server" onblur="checkPassword()" placeholder="Enter Password" class="login-password form-control" />

            <br />
            <input type="password" id="regis_confirmpass" required="required" runat="server" onblur="checkPassword()" placeholder="Confirm Password" class="login-password form-control" />

            <br />
            <asp:TextBox ID="regis_address" required="required" MaxLines="4" MaxLength="100" TextMode="MultiLine" runat="server" placeholder="Enter your address" CssClass="form-control" />

            <br />
            <asp:TextBox ID="regis_zip" required="required" runat="server" placeholder="Enter Zipcode" CssClass=" form-control" />
            <br />
            <asp:Button Text="Register" runat="server" ID="regis_submit" OnClick="CreateUser" CssClass="btn btn-lg btn-primary btn-block regis-submit-btn" ToolTip="Fill Matching passwords to Enable" disabled="disabled" value="Register"></asp:Button>
        </div>
    </div>
</asp:Content>
