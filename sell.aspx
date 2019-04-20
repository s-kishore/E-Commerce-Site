<%@ Page MaintainScrollPositionOnPostback="true" Title="Sell Product" Language="C#" MasterPageFile="proj.Master" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="dbproj.DAOs" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.Web.Configuration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>E-Mart - Sell Your Product</title>
    <link rel="stylesheet" href="CSS/sell.css" />
    <script type="text/javascript" src="JS/sell.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageContent" runat="server">
    <div class="pageContent">
        <br />
        <asp:HiddenField ID="imgurl" Value="IMGs/imgplaceholder.png" runat="server" />
        <input type="hidden" id="speccount" value="7" runat="server" />
        <div class="image-box center-block">
            <h4 class="left-align">Product Image</h4>
            <div class="center-block">
                <img runat="server" class="prod-img" id="prodimg" src="IMGs/imgplaceholder.png" /></div>
            <div class="form-group img-url-div">
                <asp:TextBox runat="server" ClientIDMode="Static" CssClass="form-control img-url-inp" ID="ursimgurl" AutoCompleteType="BusinessUrl" placeholder="e.g www.gstatic.com/webp/gallery/4.jpg"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server"
                    ValidationGroup="addprod"
                    ControlToValidate="ursimgurl"
                    ErrorMessage="URL is Required."><span class="red-text">Required*</span> 
                </asp:RequiredFieldValidator>
            </div>
            <input type="button" id="imgbtn" class="btn btn-default" value="Get Image" />
        </div>
        <span id="usrmsg" class="hide-elements">
            <b>Please enter a valid URL </b>
        </span>
        <hr />
        <div class="grp-holder">
            <label for="prodtitle">Title </label>
            <br />
            <asp:TextBox runat="server" ID="usrtitle" CssClass="prod-title-inp usr-inp form-control" MaxLength="100"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server"
                ValidationGroup="addprod"
                ControlToValidate="usrtitle"
                ErrorMessage="Title is Required."><span class="red-text">Required*</span> 
            </asp:RequiredFieldValidator>
        </div>

        <div class="grp-holder">
            <label for="category">Choose Product Catagory </label>
            <br />
            <asp:DropDownList ID="usrcat" CssClass="prod-cat-inp usr-inp form-control" AutoPostBack="true" OnSelectedIndexChanged="usrcat_SelectedIndexChanged" runat="server">
                <asp:ListItem Selected="True" Value="Cameras & Camcorders" Text="Cameras & Camcorders"></asp:ListItem>
                <asp:ListItem Value="Car Electronics & GPS" Text=" Car Electronics & GPS "></asp:ListItem>
                <asp:ListItem Value="Cell Phones & Accessories" Text=" Cell Phones & Accessories "></asp:ListItem>
                <asp:ListItem Value="Computers & Tablets" Text=" Computers & Tablets "></asp:ListItem>
                <asp:ListItem Value="TV, Audio & Surveillance" Text=" TV, Audio & Surveillance "></asp:ListItem>
                <asp:ListItem Value="Others" Text=" Others"></asp:ListItem>
            </asp:DropDownList>

        </div>

        <div class="grp-holder">
            <label for="subcategory">Choose Product Sub-Catagory </label>
            <br />
            <asp:DropDownList ID="usrsubcat" CssClass="prod-subcat-inp usr-inp form-control" runat="server">
                <asp:ListItem Selected="True" Value="Digital Cameras" Text="Digital Cameras"></asp:ListItem>
                <asp:ListItem Value="Camcorders" Text="Camcorders"></asp:ListItem>
                <asp:ListItem Value="Binoculars & Telescopes" Text="Binoculars & Telescopes"></asp:ListItem>
                <asp:ListItem Value="Flashes & Flash Accessories" Text="Flashes & Flash Accessories"></asp:ListItem>
                <asp:ListItem Value="Others" Text=" Others"></asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="grp-holder">
            <label for="description">Description </label>
            <br />
            <asp:TextBox runat="server" ID="usrdesc" CssClass="prod-desc-inp usr-inp form-control" MaxLength="80" TextMode="MultiLine"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server"
                ValidationGroup="addprod"
                ControlToValidate="usrtitle"
                ErrorMessage="Description is Required."><span class="red-text">Required*</span> 
            </asp:RequiredFieldValidator>
        </div>

        <div id="specsbox" class="grp-holder" runat="server">
            <label for="specs">Specifications </label>
            <br />
            <h6 style="color: darkgray">Note: Semicolons and colons are not allowed in both title and value fields</h6>
            <asp:TextBox runat="server" ID="spectitle1" CssClass="spec-title-inpt form-control usr-inp1" MaxLength="80" placeholder="Specification Title"></asp:TextBox>
            <asp:TextBox runat="server" ID="specvalue1" TextMode="MultiLine" CssClass="spec-specs-inpt form-control usr-inp" MaxLength="100" placeholder="Specification Value"></asp:TextBox>
            <br />
            <asp:TextBox runat="server" ID="spectitle2" CssClass="spec-title-inpt form-control usr-inp1" MaxLength="80" placeholder="Specification Title"></asp:TextBox>
            <asp:TextBox runat="server" ID="specvalue2" TextMode="MultiLine" CssClass="spec-specs-inpt form-control usr-inp" MaxLength="100" placeholder="Specification Value"></asp:TextBox>
            <br />
            <asp:TextBox runat="server" ID="spectitle3" CssClass="spec-title-inpt form-control usr-inp1" MaxLength="80" placeholder="Specification Title"></asp:TextBox>
            <asp:TextBox runat="server" ID="specvalue3" TextMode="MultiLine" CssClass="spec-specs-inpt form-control usr-inp" MaxLength="100" placeholder="Specification Value"></asp:TextBox>
            <br />
            <asp:TextBox runat="server" ID="spectitle4" CssClass="spec-title-inpt form-control usr-inp1" MaxLength="80" placeholder="Specification Title"></asp:TextBox>
            <asp:TextBox runat="server" ID="specvalue4" TextMode="MultiLine" CssClass="spec-specs-inpt form-control usr-inp" MaxLength="100" placeholder="Specification Value"></asp:TextBox>
            <br />
            <asp:TextBox runat="server" ID="spectitle5" CssClass="spec-title-inpt form-control usr-inp1" MaxLength="80" placeholder="Specification Title"></asp:TextBox>
            <asp:TextBox runat="server" ID="specvalue5" TextMode="MultiLine" CssClass="spec-specs-inpt form-control usr-inp" MaxLength="100" placeholder="Specification Value"></asp:TextBox>
            <br />
            <asp:TextBox runat="server" ID="spectitle6" CssClass="spec-title-inpt form-control usr-inp1" MaxLength="80" placeholder="Specification Title"></asp:TextBox>
            <asp:TextBox runat="server" ID="specvalue6" TextMode="MultiLine" CssClass="spec-specs-inpt form-control usr-inp" MaxLength="100" placeholder="Specification Value"></asp:TextBox>
            <br />
            <asp:TextBox runat="server" ID="spectitle7" CssClass="spec-title-inpt form-control usr-inp1" MaxLength="80" placeholder="Specification Title"></asp:TextBox>
            <asp:TextBox runat="server" ID="specvalue7" TextMode="MultiLine" CssClass="spec-specs-inpt form-control usr-inp" MaxLength="100" placeholder="Specification Value"></asp:TextBox>
            <br />
        </div>
        <div class="center-block">
            <asp:Button runat="server" CssClass="btn btn-default add-filed-btn" ID="addfieldbtn" OnClick="addfieldbtn_Click" Text="Add More Specs" />
        </div>


        <div class="input-group grp-holder">
            <h5><b>Price </b></h5>
            <asp:TextBox runat="server" ID="usrprice" CssClass=" usr-inp form-control" MaxLength="7" placeholder="300.67"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server"
                ValidationGroup="addprod"
                ControlToValidate="usrprice"
                ErrorMessage="Price is Required."><span class="red-text">Required*</span> 
            </asp:RequiredFieldValidator>
        </div>

        <h5><b>Product Condition </b></h5>
        <div class="grp-holder usr-inp">

            <label class="radio-inline">
                <input runat="server" type="radio" checked="true" name="inlineRadioOptions" id="usrcondnew" value="New" />
                New
            </label>
            <label class="radio-inline">
                <input runat="server" type="radio" name="inlineRadioOptions" id="usrcondold" value="Old" />
                Old
            </label>
        </div>
        <div class="grp-holder">
            <label for="usrquant">Quantity available </label>
            <br />
            <asp:TextBox runat="server" ID="usrquant" CssClass="prod-quan-inp usr-inp form-control" MaxLength="3"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server"
                ValidationGroup="addprod"
                ControlToValidate="usrquant"
                ErrorMessage="Quantity available is Required."> <span class="red-text">Required*</span> 
            </asp:RequiredFieldValidator>
        </div>

        <h5><b>Product Availability </b></h5>
        <div class="grp-holder usr-inp">
            <label class="radio-inline">
                <input runat="server" type="radio" checked="true" name="prod-avail" id="usravailyes" value="Yes" />
                Yes
            </label>
            <label class="radio-inline">
                <input runat="server" type="radio" name="prod-avail" id="usravailno" value="No" />
                No
            </label>
        </div>
        <div class="text-center">

            <asp:Button ValidationGroup="addprod" CssClass="btn btn-info sub-prod-btn" ID="subprodbtn" runat="server" OnClick="subprodbtn_Click" Text="Submit Product"></asp:Button>
        </div>
        <br />
        <hr />
    </div>
</asp:Content>

<script runat="server">
    UserVO curuser;
    string[] cam = { "Digital Cameras", "Lenses & Filters", "Camcorders", "Binoculars & Telescopes", "Flashes & Flash Accessories", "Others" };
    string[] car = { "Car Audio & Video Installation", "Car Security", "GPS Accessories & Mounts", "GPS Units & Equipment", "Others" };
    string[] cell = { "Cell Phones & Smartphones", "Cell Phone Accessories", "Smart Watches", "Replacement Parts & Tools", "Other" };
    string[] computer = { "iPads & Tablets", "Laptops & Notebooks", "Desktops & All-In-Ones", "Printers & Scanners ", "Keyboards, Mice & Pointing", "Monitors & Projectors", "Software", "Other" };
    string[] tv = { "Television", "Headphones", "Home Speakers & Subwoofers", "Home Surveillance", "DVD & Blu-ray Players", "iPods & MP3 Players", "Video Games & Consoles", " Other" };
    string[] others = { "Others" };
    string usrcatsel;
    int specsCount;

    public void Page_Init(object o, EventArgs e)
    {
        if (Session["curruser"] == null)
        {
            Response.Redirect("login.aspx?redirect=sell.aspx");
        }
        else
        {
            curuser = (UserVO)Session["curruser"];

        }

    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void subprodbtn_Click(object sender, EventArgs e)
    {

        updateProductTable();
    }

    private void updateProductTable()
    {
        string formattedSpecs = generateDescData();
        string sellername = curuser.userid.Replace(" ", "");
        string url = imgurl.Value;
        string filename = sellername + DateTime.Now.ToString("MdyyyyHHmmss", CultureInfo.InvariantCulture);
        string prodcond;
        string prodavail;

        ProductDAO newproddao = new ProductDAO();

        if (usravailyes.Checked)
            prodavail = "Y";
        else
            prodavail = "N";

        if (usrcondnew.Checked)
            prodcond = "New";
        else
            prodcond = "Old";

        WebClient newclient = new WebClient();
        try
        {
            newclient.DownloadFile(url, Server.MapPath("~/IMGs/product images/") + filename + ".jpg");
        }
        catch (Exception ee)
        {
            Console.WriteLine(ee.Data);
        }
        finally
        {
            ProductVO newprod = new ProductVO(usrtitle.Text, filename, usrcat.SelectedValue, usrsubcat.SelectedValue, usrdesc.Text, formattedSpecs,
                                                float.Parse(usrprice.Text), prodcond, sellername, Convert.ToInt32(usrquant.Text), prodavail);
            string newprodid = newproddao.createProduct(newprod);
            Response.Redirect("product.aspx?x=" + newprodid);
        }
    }

    private string generateDescData()
    {
        string returndesc = "";
        string title = "";
        string value = "";
        Boolean titleset = false;

        int totalfields = Convert.ToInt32(speccount.Value);

        foreach (Control ctrl in specsbox.Controls)
        {
            if (ctrl is TextBox)
            {
                TextBox newtextbox = (TextBox)ctrl;

                if (newtextbox.ID.Contains("title") && !String.IsNullOrWhiteSpace(newtextbox.Text))
                {
                    title = newtextbox.Text;
                    titleset = true;
                }

                else
                {
                    if (newtextbox.ID.Contains("value") && !String.IsNullOrWhiteSpace(newtextbox.Text) && titleset)
                    {
                        value = newtextbox.Text;
                        returndesc = returndesc + title + ":" + value + ";";
                        titleset = false;
                    }
                    else
                        titleset = false;
                }
            }
        }
        return returndesc;
    }

    protected void usrcat_SelectedIndexChanged(object sender, EventArgs e)
    {
        usrcatsel = usrcat.SelectedValue;
        usrsubcat.Items.Clear();

        foreach (var x in getArray(usrcatsel))
        {
            ListItem newlistitem = new ListItem();
            newlistitem.Value = x;
            newlistitem.Text = x;
            usrsubcat.Items.Add(newlistitem);
        }
    }

    private String[] getArray(string usrcatsel)
    {
        switch (usrcatsel)
        {
            case "Car Electronics & GPS":
                return car;
            case "Cameras & Camcorders":
                return cam;
            case "Cell Phones & Accessories":
                return cell;
            case "Computers & Tablets":
                return computer;
            case "TV, Audio & Surveillance":
                return tv;
            default:
                return others;
        }
    }

    protected void addfieldbtn_Click(object sender, EventArgs e)
    {
        string countstring = speccount.Value;
        specsCount = Convert.ToInt32(countstring);

        if (specsCount < 15)
        {
            specsCount++;
            speccount.Value = specsCount.ToString();
            for (int i = 8; i <= specsCount; i++)
            {
                TextBox newtextbox1 = new TextBox();
                TextBox newtextbox2 = new TextBox();
                Literal newliteral = new Literal();
                newliteral.Text = "<br>";
                newtextbox1.CssClass = "spec-title-inpt form-control usr-inp1";
                newtextbox1.ID = "spectitle" + i;
                newtextbox1.MaxLength = 80;


                newtextbox2.CssClass = "spec-specs-inpt form-control usr-inp";
                newtextbox2.ID = "specvalue" + i;
                newtextbox2.MaxLength = 100;
                newtextbox2.TextMode = TextBoxMode.MultiLine;

                try
                {
                    specsbox.Controls.Add(newtextbox1);
                    specsbox.Controls.Add(newtextbox2);
                    specsbox.Controls.Add(new LiteralControl("<br />"));
                }
                catch (Exception ee)
                {
                    Console.WriteLine(ee.Message);
                }
            }
        }
        prodimg.Src = imgurl.Value;
        //  ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "showNeedLogin();", true); */
    }
</script>
