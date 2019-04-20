<%@ Page Title="" Language="C#" MasterPageFile="proj.Master" AutoEventWireup="true"%>
<%@ Import Namespace="dbproj.DAOs" %>
<%@ Import Namespace="System.Data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title> E-Mart - Search </title>
    <link rel="stylesheet" href="CSS/search.css" />
    <script type="text/javascript" src="JS/search.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageContent" runat="server">
    <div class="body-content pageContent">
        <h4 class="srch-rstls-title align-left"> Search Results</h4>

        <div id="invalidquery" runat="server" class="hide-elements">
            <h4> Invalid characters present in search string </h4>
        </div>

    <hr />

        <div id="search-box" class="center-block">

            <asp:GridView PageSize="9" AllowSorting="true" ShowHeader="true" GridLines="Horizontal" CssClass="grid-tbl table table-striped" ID="GridView1" runat="server" 
                            AllowPaging="True" AutoGenerateColumns="false" DataSourceID="SqlDataSource1" EmptyDataRowStyle-CssClass= "alert-info alert" 
                            EmptyDataText="No products found matching the search criteria">
                <Columns>
                    <asp:TemplateField ItemStyle-CssClass="prod-img-col" HeaderStyle-CssClass="grid-tbl-header">
                        <ItemTemplate>
                            <div>
                                <img class="prod-img" src ="IMGs/product images/<%# Eval("imgnm") %>.jpg" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Title" SortExpression="title" HeaderStyle-CssClass="grid-tbl-header" AccessibleHeaderText="Title">
                        <ItemTemplate>
                            <div class="prod-dtls">
                                <a href="product.aspx?x=<%# Eval("productId") %>">
                                    <span class="prod-title prod-dtls-cnt"> <%# Eval("title") %></span>
                                </a>
                                <p class="prod-desc prod-dtls-cnt"> <%# Eval("desc") %> </p>
                            
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-CssClass="prod-price-col" SortExpression="price" HeaderStyle-CssClass="grid-tbl-header" HeaderText="Price">
                        <ItemTemplate>
                                <p class="prod-price prod-dtls-cnt"> $<%# Eval("price") %></p>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="category" HeaderText="Category" SortExpression="category" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:azure %>">
            </asp:SqlDataSource>

        </div>
    </div>
</asp:Content>
<script runat="server">
            string srchquery;
            string srchcategory;
            string[] srchkeywords;
            ProductDAO newpdao = new ProductDAO();
            ProductVO[] srchrslt;
            DataTable prodlst = new DataTable();
            string querycond;
        
        protected void Page_Load(object sender, EventArgs e)
        {             
            
            srchquery = Request.QueryString["q"];
            srchcategory = Request.QueryString["cat"];
            if (srchquery != null)
            { 
            srchquery = srchquery.Replace("+", " ");
            srchkeywords = srchquery.Split(' ');
            Regex validexp = new Regex("[^A-Za-z0-9\x20]");
            bool isstringvalid = validexp.IsMatch(srchquery);

            if (!isstringvalid)
            {
                generatePageContent();
            }
            else
                invalidquery.Attributes.Add("class", "alert alert-danger show-elemets");
            }
            else if(srchcategory != null)
            {
                generatePageContent();
            }
            else
                invalidquery.Attributes.Add("class", "alert alert-danger show-elemets");
        }
        protected void generatePageContent()
        {
            if (srchcategory != null && srchquery != null)
            {
            }
            else if(srchquery != null)
            {
                querycond = "[title] like \'%" + srchquery.Replace(' ', '%') + "%\' " + "OR [desc] like \'%" + srchquery.Replace(' ', '%') + "%\'";

                if (srchkeywords.Count() > 1)
                {
                    foreach (var x in srchkeywords)
                    {
                        string partq;
                        partq = " OR [title] like \'%" + x + "%\'" + "OR [desc] like \'%" + x + "%\'";
                        querycond = querycond + partq;
                    }
                }
                SqlDataSource1.SelectCommand = "select [productId],[category],[title],[imgnm],[category],[desc],[price] from [product] where " + querycond;
            }
            else
            {

                SqlDataSource1.SelectCommand = "select [productId],[category],[title],[imgnm],[desc],[price] from [product] where [category] like \'%" + srchcategory + "%\'";
            }
        } 

/*
      protected void generatePageContent()
        {
            if (srchcategory != null && srchquery != null)
            {
               // prodlst = newpdao.searchForProductByCategoryAndKey(srchkeywords, srchquery,srchcategory);
            }
            else if(srchquery != null)
            {
               // prodlst = newpdao.searchForProduct(srchkeywords, srchquery);
                querycond = "[title] like \'%" + srchquery.Replace(' ', '%') + "%\' " + "OR [desc] like \'%" + srchquery.Replace(' ', '%') + "%\'";

                if (srchkeywords.Count() > 1)
                {
                    foreach (var x in srchkeywords)
                    {
                        string partq;
                        partq = " OR [title] like \'%" + x + "%\'" + "OR [desc] like \'%" + x + "%\'";
                        querycond = querycond + partq;
                    }
                }
                SqlDataSource1.SelectCommand = "select [productId],[title],[imgnm],[category],[desc],[price] from [product] where " + querycond;
            }
            else
            {
               // prodlst = newpdao.searchForProductByCategory(srchcategory);
                SqlDataSource1.SelectCommand = "select [productId],[title],[imgnm],[category],[desc],[price] from [product] where [category] like \'%" + srchcategory + "%\'";
            }
            if (prodlst != null)
            {
                prodlsttbl.DataSource = prodlst;
                prodlsttbl.DataBind();
            }
            else
            {
                nodatainfo.Attributes.Clear();
                nodatainfo.Attributes.Add("class", "no-data-div show-elements");
            }
        } */
</script>