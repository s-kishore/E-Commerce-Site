<%@ Page Language="C#" MasterPageFile="proj.Master" AutoEventWireup="true" CodeFile="invalid.aspx.cs" Inherits="invalid" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title> E-Mart - Error Page</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageContent" runat="server">
    <div class="center-block pageContent">
        <div class="alert alert-info" role="alert"  style="max-width:400px; margin-left:auto; margin-right:auto;">
            <strong> Oops..!</strong> You have followed an invalid link
            <p style="padding-top:15px;">
                <a href="default.aspx" class="btn btn-info"> Go to Homepage </a>

                <a class="btn btn-info" onclick="history.go(-1); return false;"> Go Back </a>
            </p>
        </div>
    </div>
</asp:Content>
