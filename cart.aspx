<%@ Page Title="" Language="C#" Debug="true" MasterPageFile="proj.Master" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="dbproj.DAOs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title id="pagetitle" runat="server">E-Mart - Cart
    </title>
    <link rel="stylesheet" href="CSS/cart.css" />
    <script type="text/javascript" src="JS/cart.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="pageContent" runat="server">
    <asp:HiddenField runat="server" ID="cookiedata" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="ValidCart" Value="true" />

    <div class="pageContent cart-page">
        <div runat="server" id="cartemptydiv" class="hide-elements">
            <div class="alert alert-info">
                Your cart is empty. 
            </div>
        </div>
        <div id="loginND" class="hide-elements" role="alert">
            <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
            <p>You need to be signed-in to perform this action </p>
            <p>
                <a runat="server" id="loginpop" class="btn btn-default">Sign-In </a>
                <button type="button" class="btn btn-default" data-dismiss="alert">Dismiss </button>
            </p>
        </div>
        <div runat="server" id="removeItems" class="hide-elements">
            <div class="alert alert-danger">
                <strong>Oops..!</strong> Cart contains items that are not in stock or lesser quantity than required. Removed them to proceed.
            </div>
        </div>
        <div runat="server" id="invalidprod" class="hide-elements">
            <div class="alert alert-danger">
                <strong>Warning..!</strong> Cart contains items of low stock or that are not in stock. Checking out will remove all unavailable items.
            </div>
        </div>
        <div runat="server" id="orderconfirm" class="hide-elements">
            <div class="alert alert-success">
                <strong>Congratulations..!</strong> Your order has been placed. 
            </div>
        </div>
        <br />
        <div runat="server" id="cartnotemptydiv" class="show-elements">
            <asp:Table runat="server" ID="carttbl" CssClass="carttbl table table-striped">
                <asp:TableRow TableSection="TableHeader">
                    <asp:TableCell CssClass="carttbl-hd-img"> </asp:TableCell>
                    <asp:TableCell CssClass="carttbl-hd-item"> ITEM </asp:TableCell>
                    <asp:TableCell CssClass="carttbl-hd-quan"> QUANTITY </asp:TableCell>
                    <asp:TableCell CssClass="carttbl-hd-price"> PRICE </asp:TableCell>
                    <asp:TableCell CssClass="carttbl-hd-subtot"> SUBTOTAL </asp:TableCell>
                    <asp:TableCell CssClass="carttbl-hd-avial"> AVAILABILITY </asp:TableCell>
                    <asp:TableCell CssClass="carttbl-hd-remove"></asp:TableCell>
                </asp:TableRow>
            </asp:Table>

            <div class="sub-tot-dsp">
                <b>SUB TOTAL: </b>$ <span runat="server" class="sbt-tot-amt" id="subtotamt"></span>
            </div>

            <br />
            <h4 class="left-align">Shipping Method</h4>
            <div class="shpp-area">
                <div class="shpp-mthd">
                    <input type="radio" checked="true" name="shp-mth" value="regular" onchange="changeshipping()" />
                    Standard Shipping  
                    <span class="dlr-amt">$10 </span>
                    <br />
                    <input type="radio" name="shp-mth" value="two-day" onchange="changeshipping()" />
                    Two Day Shipping 
                    <span class="dlr-amt">$25 </span>
                    <br />
                    <input type="radio" name="shp-mth" value="one-day" onchange="changeshipping()" />
                    One Day Shipping 
                    <span class="dlr-amt">$30 </span>
                    <br />
                </div>
            </div>
            <br />
            <br />
            <br />
            <br />
            <h4 class="left-align">Shipping Address</h4>
            <div class="shpp-addr">
                <div>
                    <label for="address1">Address</label>
                    <asp:TextBox runat="server" placeholder ="if different from one in profile" TextMode="MultiLine" class="form-control address-box" name="address1" id="address1" maxlength="50" />
                    <br />
                    <label for="zip">ZIP</label>
                    <asp:TextBox runat="server"  placeholder ="if different from one in profile" class="form-control zip-box" name="zip" id="zip" maxlength="10" />
                </div>
            </div>
            <div class="tot-dsp">
                <b>TOTAL: </b>$ <span class="tot-amt" id="totamt" runat="server"></span>
            </div>
            <br />
            <div class="center-box">
                <a runat="server" id="loginbox" href="login.aspx?redirect=cart.aspx" class="btn btn-default hide-elements ">Sign-In to Order </a>
                <asp:Button CssClass="btn btn-default checkout-btn" ID="orderbtn" OnClick="orderbtn_Click" runat="server" Text="Submit Order" />
            </div>
        </div>
    </div>
</asp:Content>

<script runat="server">
    string[] prodids;
    string[] prodidsnr = { "hi" };
    string cdata;
    double totalprice = 0;
    char[] delimiter = { '*' };
    ProductVO[] proddtl;
    PurchaseDetailVO[] purchasedetails_array;
    ProductDAO proddao = new ProductDAO();
    int count = 0;
    Dictionary<string, int> pcounts;
    string logedinusr;

    HttpCookieCollection cookiecoll = new HttpCookieCollection();
    protected void Page_Load(object sender, EventArgs e)
    {
        retrieveCookieData();
        if (prodids == null)
        {
            cartemptydiv.Attributes.Add("class", "empty-box show-elements");
            cartnotemptydiv.Attributes.Add("class", "hide-elements");
        }
        else
        {
            if (Session["curruser"] == null)
            {

                logedinusr = "Anonymous";
                loginbox.Attributes.Add("class", "btn btn-default show-elements");
                orderbtn.CssClass = "hide-elements";

            }
            else
            {
                UserVO curusr = (UserVO)Session["curruser"];
                logedinusr = curusr.userid;
            }

            cartemptydiv.Attributes.Add("class", "hide-elements");
            cartnotemptydiv.Attributes.Add("class", "center-block show-elements");
            generateNoDuplicateIDs();
            getCartData();
            totamt.InnerHtml = (totalprice + 10).ToString();
        }
    }

    private void retrieveCookieData()
    {
        if (Request.Cookies["prodid"] != null)
        {
            cdata = Request.Cookies["prodid"].Value.ToString();
            prodids = cdata.Split(delimiter);
        }
    }

    private void generateNoDuplicateIDs()
    {
        pcounts = prodids.GroupBy(x => x).ToDictionary(g => g.Key,
                                                       g => g.Count());

        prodidsnr = pcounts.Keys.ToArray();
    }

    private int convertToNum(String num)
    {
        int result = 0,curr;
        foreach (char x in num.ToArray())
        {
            curr = -1;
            switch (x)
            {
                case '0':
                    curr = 0;
                    break;
                case '1':
                    curr = 1;
                    break;
                case '2':
                    curr = 2;
                    break;
                case '3':
                    curr = 3;
                    break;
                case '4':
                    curr = 4;
                    break;
                case '5':
                    curr = 5;
                    break;
                case '6':
                    curr = 6;
                    break;
                case '7':
                    curr = 7;
                    break;
                case '8':
                    curr = 8;
                    break;
                case '9':
                    curr = 9;
                    break;
            }
            if(curr >-1)
            {
                result = result * 10 + curr;
            }
        }
        return result;
    }
    private void getCartData()
    {
        count = 0;
        proddtl = new ProductVO[prodidsnr.Length];
        purchasedetails_array = new PurchaseDetailVO[prodidsnr.Length];

        foreach (var pid in prodidsnr)
        {
            int num_id = convertToNum(pid);
            proddtl[count] = proddao.getProductbyId(pid);
            purchasedetails_array[count] = new PurchaseDetailVO(0, num_id, pcounts[pid],(float) proddtl[count].price, "s", 1);
            count++;
        }
        foreach (var pdtl in proddtl)
        {
            int quantity = 0;

            if (pdtl.prodid != null && pcounts.ContainsKey(pdtl.prodid))
                quantity = pcounts[pdtl.prodid];

            writeProductToTable(pdtl, quantity);
        }
        subtotamt.InnerHtml = totalprice.ToString();
    }

    private void writeProductToTable(ProductVO pdtl, int quantity)
    {
        Button rembtn = new Button();
        rembtn.CssClass = "btn btn-danger";
        rembtn.Click += removeProduct;
        rembtn.CommandArgument = pdtl.prodid;
        rembtn.Text = "Remove";

        int availcount = (pdtl.quant - pdtl.sold);
        TableRow newrow = new TableRow();
        TableCell newcell1 = new TableCell();
        TableCell newcell2 = new TableCell();
        TableCell newcell3 = new TableCell();
        TableCell newcell4 = new TableCell();
        TableCell newcell5 = new TableCell();
        TableCell newcell6 = new TableCell();
        TableCell newcell7 = new TableCell();

        carttbl.Rows.Add(newrow);
        newcell1.Attributes.Add("class", "cart-tbl-pimg");
        newcell2.Attributes.Add("class", "cart-tbl-itm");
        newcell3.Attributes.Add("class", "cart-tbl-pquan");
        newcell4.Attributes.Add("class", "cart-tbl-pprice");
        newcell5.Attributes.Add("class", "cart-tbl-psubtot");
        newcell6.Attributes.Add("class", "cart-tbl-pavail");
        newcell7.Attributes.Add("class", "cart-tbl-remove");

        newcell1.Controls.Add(getprodimg(pdtl));
        newcell2.Text = "<a href=\"product.aspx?x=" + pdtl.prodid + "\" target=\"_blank\" > " + pdtl.title + "</a>";
        newcell3.Text = quantity.ToString();
        newcell4.Text = "$ " + pdtl.price.ToString();
        // newcell7.Text = "<asp:button runat=\"server\" ID=\"rmvProdBtn\" onClick=\"removeProduct(" + pdtl.prodid + ")\" class=\"btn btn-danger\"> Remove </button>";
        newcell7.Controls.Add(rembtn);
        if (pdtl.avail == "Y" && availcount > 0)
        {
            newcell5.Text = "$ " + (pdtl.price * quantity).ToString();
            totalprice = totalprice + pdtl.price * quantity;
            if (availcount >= quantity)
            {
                newcell6.Text = "Available";
            }
            else
            {
                newcell6.Text = "Only " + availcount + " Items Left";
                invalidprod.Attributes.Add("class", "show-elements");
                ValidCart.Value = "false";
            }
        }
        else
        {
            invalidprod.Attributes.Add("class", "show-elements");
            newcell5.Text = " --- ";
            newcell6.Text = "Product currently not in stock";
            ValidCart.Value = "false";

        }

        newrow.Cells.Add(newcell1);
        newrow.Cells.Add(newcell2);
        newrow.Cells.Add(newcell3);
        newrow.Cells.Add(newcell4);
        newrow.Cells.Add(newcell5);
        newrow.Cells.Add(newcell6);
        newrow.Cells.Add(newcell7);
    }

    private Image getprodimg(ProductVO pdtl)
    {
        Image pimg = new Image();
        pimg.ImageUrl = "IMGs/product images/" + pdtl.imgnm + ".jpg";
        pimg.CssClass = "cart-tbl-pimg";
        return pimg;
    }

    protected void removeProduct(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        removeFromCookie(btn.CommandArgument.ToString());
    }

    protected void removeFromCookie(string remvid)
    {
        string cookiedata = cdata;

        cookiedata = cookiedata.Replace(remvid + "*", "");
        cookiedata = cookiedata.Replace("*" + remvid, "");
        cookiedata = cookiedata.Replace(remvid, "");

        HttpCookie myCookie = new HttpCookie("prodid");

        if (cookiedata.Length != 0)
        {
            myCookie.Expires = DateTime.Now.AddDays(1d);
            myCookie.Value = cookiedata;
        }
        else
        {
            myCookie.Expires = DateTime.Now.AddDays(-1d);
        }

        Response.Cookies.Add(myCookie);
        Response.Redirect(Request.RawUrl);
    }

    protected void orderbtn_Click(object sender, EventArgs e)
    {
        if (ValidCart.Value == "true")
        {
            PurchaseDAO newpurchasedao = new PurchaseDAO();
            ProductDAO newproddao = new ProductDAO();
            PurchaseDetailDAO newPurchaseDetailDao = new PurchaseDetailDAO();
            String daddress = "",dzip;
            daddress = address1.Text;
            dzip = zip.Text;
            PurchaseVO purchdtl = new PurchaseVO(cdata, logedinusr, (float)totalprice,daddress,dzip);

            int pid = newpurchasedao.updatePurchasInfo(purchdtl,pcounts);
            newproddao.updtSoldProducts(pcounts);
            newPurchaseDetailDao.updatePurchaseDetailInfo(purchasedetails_array, pid);

            invalidprod.Attributes.Add("class", "hide-elements");
            orderconfirm.Attributes.Add("class", "show-elements");
            HttpCookie myCookie = new HttpCookie("prodid");
            myCookie.Expires = DateTime.Now.AddDays(-1d);
        }
        else
        {
            removeItems.Attributes.Add("class", "show-elements");
        }
    }
</script>
