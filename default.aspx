<%@ Page Title="" Language="C#" MasterPageFile="proj.Master"%>
<%@ Import Namespace="dbproj.DAOs" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.IO" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title> E-Mart </title>
    <link rel="stylesheet" href="CSS/default.css" />
    <script type="text/javascript" src="JS/default.js"></script>
    <script type="text/javascript" src="JS/jquery-2.1.1.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageContent" runat="server">
    <div class="pageContent main-body">
        <div class="row banner-box">
            <div class="col-md-6 left-half">
                <h2> Buy for Less </h2>
                <img src="IMGs/Banner/m1.png" class="banner-img" />
            </div>

            <div class="col-md-6 right-half center-block">
                <h2> Sell for More </h2>
                <img src="IMGs/Banner/m2.png" class="banner-img"/>
            </div>
        </div>

        <div class="jumbotron desc-box">
        <h2>Welcome!</h2>
        <p>
            E-Mart is a one stop destination for buying and selling electronic products
        </p>
        <p><a href="docs.aspx" class="btn btn-primary btn-lg" role="button"> Learn more »</a></p>
      </div>
        <img class="slideshow" id="sldshw" src="IMGs/Banner/5.JPG" />
        <br />
        <br />
        <div class="scoll-box-high panel panel panel-primary">
            <div class="panel-heading align-left">
            <h4 class="panel-title"> Best Sellers</h4></div>
            <div class="panel-body scrollable-box" id="topsellers" runat="server">

            </div>
        </div>
        <hr />
            <div class="scoll-box-high panel panel panel-primary">
            <div class="panel-heading align-left">
            <h4 class="panel-title"> New Arrivals</h4></div>
            <div class="panel-body scrollable-box" id="newarrivals" runat="server">

            </div>
        </div>
        <br />
    </div>
    <script type="text/javascript">
        slideit();
    </script>
</asp:Content>

<script runat="server">
    string[] prodtitle = new string[10];
    string[] prodid = new string[10];
    ProductDAO newproddao = new ProductDAO();
    ProductVO proddtl;
    ArrayList prodarray;
    int count = 0;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        writeTopSeller();
        writeNewProducts();
    }
    
    protected void writeTopSeller()
    {
        StringWriter stringWriter = new StringWriter();
        using (HtmlTextWriter topsellhtm = new HtmlTextWriter(stringWriter))
        {
            topsellhtm.AddAttribute(HtmlTextWriterAttribute.Class, "usr-data-scrl-tbl");
            topsellhtm.AddAttribute(HtmlTextWriterAttribute.Cellpadding, "100");
            topsellhtm.AddAttribute(HtmlTextWriterAttribute.Cellspacing, "100");
            topsellhtm.RenderBeginTag(HtmlTextWriterTag.Table);
            topsellhtm.RenderBeginTag(HtmlTextWriterTag.Tr);

            prodarray = newproddao.getTopSellers();
            IEnumerable prodenumlst = prodarray;
            foreach (var x in prodarray)
            {
                proddtl = (ProductVO)x;
                if (proddtl.status == "S")
                {
                    prodtitle[count] = proddtl.title;
                    prodid[count] = proddtl.prodid;
                    count++;
                    topsellhtm.RenderBeginTag(HtmlTextWriterTag.Td);
                    topsellhtm.AddAttribute(HtmlTextWriterAttribute.Href, "product.aspx?x=" + proddtl.prodid);
                    topsellhtm.AddAttribute(HtmlTextWriterAttribute.Target, "_blank");
                    topsellhtm.RenderBeginTag(HtmlTextWriterTag.A);
                    topsellhtm.AddAttribute(HtmlTextWriterAttribute.Src, "IMGs/product images/" + proddtl.imgnm + ".jpg");
                    topsellhtm.AddAttribute(HtmlTextWriterAttribute.Class, "scroll-box-img");
                    topsellhtm.RenderBeginTag(HtmlTextWriterTag.Img);
                    topsellhtm.RenderEndTag();
                    topsellhtm.RenderEndTag();
                    topsellhtm.RenderEndTag();
                }
            }

            // Ends the row tag after inserting all row1 images and hyperlinks
            topsellhtm.RenderEndTag();
            // Creates new row for the image description
            topsellhtm.RenderBeginTag(HtmlTextWriterTag.Tr);
            count = 0;

            foreach (var x in prodtitle)
            {
                topsellhtm.AddAttribute(HtmlTextWriterAttribute.Class, "scroll-tbl-desc-col");
                topsellhtm.RenderBeginTag(HtmlTextWriterTag.Td);
                topsellhtm.AddAttribute(HtmlTextWriterAttribute.Href, "product.aspx?x=" + prodid[count]);
                topsellhtm.AddAttribute(HtmlTextWriterAttribute.Target, "_blank");
                topsellhtm.RenderBeginTag(HtmlTextWriterTag.A);
                topsellhtm.Write(x);
                topsellhtm.RenderEndTag();
                topsellhtm.RenderEndTag();
                count++;
            }
            topsellhtm.RenderEndTag();
            topsellhtm.RenderEndTag();
        }
        topsellers.InnerHtml = stringWriter.ToString();
    }

    protected void writeNewProducts()
    {
        StringWriter stringWriter = new StringWriter();
        count = 0;
        using (HtmlTextWriter topsellhtm = new HtmlTextWriter(stringWriter))
        {
            topsellhtm.AddAttribute(HtmlTextWriterAttribute.Class, "usr-data-scrl-tbl");
            topsellhtm.RenderBeginTag(HtmlTextWriterTag.Table);
            topsellhtm.RenderBeginTag(HtmlTextWriterTag.Tr);

            prodarray = newproddao.getNewProducts();
            IEnumerable prodenumlst = prodarray;
            foreach (var x in prodarray)
            {
                proddtl = (ProductVO)x;
                if (proddtl.status == "S")
                {
                    prodtitle[count] = proddtl.title;
                    prodid[count] = proddtl.prodid;
                    count++;
                    topsellhtm.RenderBeginTag(HtmlTextWriterTag.Td);
                    topsellhtm.AddAttribute(HtmlTextWriterAttribute.Href, "product.aspx?x=" + proddtl.prodid);
                    topsellhtm.AddAttribute(HtmlTextWriterAttribute.Target, "_blank");
                    topsellhtm.RenderBeginTag(HtmlTextWriterTag.A);
                    topsellhtm.AddAttribute(HtmlTextWriterAttribute.Src, "IMGs/product images/" + proddtl.imgnm + ".jpg");
                    topsellhtm.AddAttribute(HtmlTextWriterAttribute.Class, "scroll-box-img");
                    topsellhtm.RenderBeginTag(HtmlTextWriterTag.Img);
                    topsellhtm.RenderEndTag();
                    topsellhtm.RenderEndTag();
                    topsellhtm.RenderEndTag();
                }
            }

            // Ends the row tag after inserting all row1 images and hyperlinks
            topsellhtm.RenderEndTag();
            // Creates new row for the image description
            topsellhtm.RenderBeginTag(HtmlTextWriterTag.Tr);
            count = 0;

            foreach (var x in prodtitle)
            {
                topsellhtm.AddAttribute(HtmlTextWriterAttribute.Class, "scroll-tbl-desc-col");
                topsellhtm.RenderBeginTag(HtmlTextWriterTag.Td);
                topsellhtm.AddAttribute(HtmlTextWriterAttribute.Href, "product.aspx?x=" + prodid[count]);
                topsellhtm.AddAttribute(HtmlTextWriterAttribute.Target, "_blank");
                topsellhtm.RenderBeginTag(HtmlTextWriterTag.A);
                topsellhtm.Write(x);
                topsellhtm.RenderEndTag();
                topsellhtm.RenderEndTag();
                count++;
            }
            topsellhtm.RenderEndTag();
            topsellhtm.RenderEndTag();
        }
        newarrivals.InnerHtml = stringWriter.ToString();
    }
</script>