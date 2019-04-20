<%@ Page Title="" Language="C#" MasterPageFile="proj.Master" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="dbproj.DAOs" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.IO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title id="pagetitle" runat="server">
        E-Mart
    </title>
    <link rel="stylesheet" href="CSS/profile.css" />
    <script type="text/javascript" src="JS/profile.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageContent" runat="server">
    <div class="pageContent">
        <div class="usr-dtl">
            <br/>
            <br/>
            <table id="usrdtltbl" class="usr-data-tbl">
                <tr>
                    <td rowspan="6" class="img-row"> <asp:Image ID="usrimg" CssClass="usr-img" runat="server" /> </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="coll-1"> <span class="lbl-usrid"> User ID  </span> </td>
                    <td class="coll-2"> <span runat="server" id="usrname"></span> </td>
                </tr>
                <tr> 
                    <td class="coll-1"> <span class="lbl-fname"> First Name </span> </td>
                    <td class="coll-2"> <span runat="server" id="fname"> </span> </td>
                </tr>
                <tr>
                    <td class="coll-1"> <span class="lbl-lname"> Last Name  </span></td>
                    <td class="coll-2"> <span runat="server" id="lname"> </span> </td>
                </tr>
                <tr>
                    <td class="coll-1"> <span class="lbl-email"> E-Mail ID  </span> </td>
                    <td class="coll-2"> <span runat="server" id="email"></span> </td>
                </tr>

                <tr id="emailidcol" runat="server">
                    <td class="coll-1"> <span runat="server" id="emailtxtbox">Change Email</span> </td>
                    <td class="coll-2"> <asp:TextBox ID="emailNew" runat ="server" CssClass="email-updt-box" type="email"></asp:TextBox> </td>                        
                </tr>
                <tr id="emailidbtn" runat="server">
                   <td colspan="4" class="coll-3" > <asp:Button ID="emailupdtbtn" text="Update E-Mail ID" onclick="updtbtn_Click" runat="server"/></td>
                </tr>
            </table>
            <hr />
            <div class="follow-btn-box" > 
                <asp:Button ID="followbtn" CssClass="follow-btn" Text="Follow User" OnClick="followbtn_Click" runat="server"/>
                <asp:Button ID="unfollowbtn" CssClass="unfollow-btn" Text="Unfollow User" OnClick="unfollowbtn_Click" runat="server"/> 
            </div>
        </div>
            <div class="scoll-box-high panel panel panel-primary">
            <div class="panel-heading">
            <h4 class="panel-title"> Selling Products</h4></div>
            <div class="panel-body scrollable-box" id="sellbox" runat="server">

            </div>
        </div>
        <div class="scoll-box-high panel panel panel-primary">
            <div class="panel-heading">
            <h4 class="panel-title"> Products Liked</h4></div>
            <div class="panel-body scrollable-box" id="likebox" runat="server">

            </div>
        </div>
        <hr />
        <div class="scoll-box-high panel panel panel-primary">
            <div class="panel-heading">
                <h4 class="panel-title"> Products commented on</h4>
            </div>
            <div class="panel-body scrollable-box" id="commentbox" runat="server">

            </div>
        </div>
        <hr />
        <div class="scoll-box-high panel panel-primary">
            <div class="panel-heading">
                <h4 class="panel-title"> Members Followed</h4>
            </div>
            <div class=" panel-body scrollable-box" id="followbox" runat="server">

            </div>
        </div>
        <br />
    </div>
</asp:Content>

<script runat="server">
    UserVO userdtl;
    UserDAO newuserdao = new UserDAO();
    UserVO curruser;
    string userid;
    string logedinusr;
    int count = 0;
    ProductDAO newproddao = new ProductDAO();
    FollowerDAO newfollowdao = new FollowerDAO();
    FollowerVO newdata;
    protected void page_Init(object sender, EventArgs e)
    {
        userid = Request.QueryString["p"];
        if (Session["curruser"] == null)
        {
            Response.Redirect("login.aspx?redirect=profile.aspx?p="+userid);
        }
        else
        {
            curruser = (UserVO)Session["curruser"];
            logedinusr = curruser.userid.Replace(" ", "");
        }
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (userid != null)
        {
            userdtl = newuserdao.getUserById(userid);

            if (userdtl.status == "S")
            {
                newdata = new FollowerVO(userid, logedinusr, 1);
                generateUserData();
                generateButtons();
                generateSellingList();
                generateLikesData();
                generateCommentsData();
                generatefollowingData();

            }

            else
                Response.Redirect("invalid.aspx");
        }
        else
            Response.Redirect("invalid.aspx");
    }

    protected void updtbtn_Click(object sender, EventArgs e)
    {
        newuserdao.updateEmail(logedinusr, emailNew.Text);
        Response.Redirect(Request.RawUrl);

    }

    private void generateButtons()
    {
        
        if (userid == logedinusr)
        {
            followbtn.CssClass = "hide-elements";
            unfollowbtn.CssClass = "hide-elements";
            emailidcol.Attributes.Add("class", "show-elements");
            emailidbtn.Attributes.Add("class", "show-elements");
            emailupdtbtn.CssClass = "btn btn-default updt-btn show-elements";
         
        }
        else
        {
            
            emailidcol.Attributes.Add("class", "hide-elements");
            emailidbtn.Attributes.Add("class", "hide-elements");
            emailupdtbtn.CssClass = "hide-elements";
            emailupdtbtn.Attributes.Add("disabled", "true");
            if (newfollowdao.IsUserFollowed(userid, logedinusr))
            {
                unfollowbtn.CssClass = "btn btn-warning show-elements";
                followbtn.CssClass = "hide-elements";
            }
            else
            {
                unfollowbtn.CssClass = "hide-elements";
                followbtn.CssClass = "btn btn-info show-elements";
            }
        }

    }

    private void generateUserData()
    {
        usrimg.ImageUrl = "IMGs/users/" + userdtl.imgnm + ".png";
        usrname.InnerHtml = userdtl.userid;
        fname.InnerHtml = userdtl.fname;
        lname.InnerHtml = userdtl.lname;
        email.InnerHtml = userdtl.email;    
    }

    private void generateSellingList()
    {
        ProductVO proddtl;
        StringWriter stringWriter = new StringWriter();
        ArrayList Sellinglist = newproddao.getProdMinDetailsByUser(userid);

        if (Sellinglist != null)
        {
            int rowcount = Sellinglist.Count;
            string[] prodtitle = new string[rowcount];
            string[] prodid = new string[rowcount];
            count = 0;
            
            using (HtmlTextWriter sellhtm = new HtmlTextWriter(stringWriter))
            {
                sellhtm.AddAttribute(HtmlTextWriterAttribute.Class, "usr-data-scrl-tbl");
                sellhtm.RenderBeginTag(HtmlTextWriterTag.Table);
                sellhtm.RenderBeginTag(HtmlTextWriterTag.Tr);
                foreach (var x in Sellinglist)
                {
                    proddtl = (ProductVO)x;
                    if (proddtl.status == "S")
                    {
                        prodtitle[count] = proddtl.title;
                        prodid[count] = proddtl.prodid;
                        count++;
                        sellhtm.RenderBeginTag(HtmlTextWriterTag.Td);
                        sellhtm.AddAttribute(HtmlTextWriterAttribute.Href, "product.aspx?x=" + proddtl.prodid);
                        sellhtm.AddAttribute(HtmlTextWriterAttribute.Target, "_blank");
                        sellhtm.RenderBeginTag(HtmlTextWriterTag.A);
                        sellhtm.AddAttribute(HtmlTextWriterAttribute.Src, "IMGs/product images/" + proddtl.imgnm + ".jpg");
                        sellhtm.AddAttribute(HtmlTextWriterAttribute.Class, "scroll-box-img");
                        sellhtm.RenderBeginTag(HtmlTextWriterTag.Img);
                        sellhtm.RenderEndTag();
                        sellhtm.RenderEndTag();
                        sellhtm.RenderEndTag();
                    }
                }

                // Ends the row tag after inserting all row1 images and hyperlinks
                sellhtm.RenderEndTag();
                // Creates new row for the image description
                sellhtm.RenderBeginTag(HtmlTextWriterTag.Tr);
            count = 0;

            foreach (var x in prodtitle)
            {
                sellhtm.AddAttribute(HtmlTextWriterAttribute.Class, "scroll-tbl-desc-col");
                sellhtm.RenderBeginTag(HtmlTextWriterTag.Td);
                sellhtm.AddAttribute(HtmlTextWriterAttribute.Href, "product.aspx?x=" + prodid[count]);
                sellhtm.AddAttribute(HtmlTextWriterAttribute.Target, "_blank");
                sellhtm.RenderBeginTag(HtmlTextWriterTag.A);
                sellhtm.Write(x);
                sellhtm.RenderEndTag();
                sellhtm.RenderEndTag();
                count++;
            }
            sellhtm.RenderEndTag();
            sellhtm.RenderEndTag();
        }
        sellbox.InnerHtml = stringWriter.ToString();
    
        }
        else
        {
            sellbox.InnerHtml = "No products listed for selling yet";
        }

    }
    
    private void generateLikesData()
    {
        LikeDAO newlikedao = new LikeDAO();
        LikeVO[] userlikes;
        userlikes = newlikedao.getLikesbyUser(userid);
        if (userlikes[0].status != "ND" && userlikes[0].status != "ERROR")
        {
            writeToScreen(userlikes);
        }
        else
        {
            likebox.InnerHtml = "No liked products";
        }
    }

    private void writeToScreen(LikeVO[] userlikes)
    {
        StringWriter stringWriter = new StringWriter();
        int likesrowcount = userlikes[0].count;
        string[] prodtitle = new string[likesrowcount];
        string[] prodid = new string[likesrowcount];
        count = 0;
        using (HtmlTextWriter likeshtm = new HtmlTextWriter(stringWriter))
        {
            likeshtm.AddAttribute(HtmlTextWriterAttribute.Class, "usr-data-scrl-tbl");
            likeshtm.RenderBeginTag(HtmlTextWriterTag.Table);
            likeshtm.RenderBeginTag(HtmlTextWriterTag.Tr);
            foreach (var x in userlikes)
            {
                ProductVO proddtl = newproddao.getProdMinDetails(x.pid);
                if (x.status == "S")
                {
                    prodtitle[count] = proddtl.title;
                    prodid[count] = proddtl.prodid;
                    count++;
                    likeshtm.RenderBeginTag(HtmlTextWriterTag.Td);
                    likeshtm.AddAttribute(HtmlTextWriterAttribute.Href, "product.aspx?x=" + proddtl.prodid);
                    likeshtm.AddAttribute(HtmlTextWriterAttribute.Target, "_blank");
                    likeshtm.RenderBeginTag(HtmlTextWriterTag.A);
                    likeshtm.AddAttribute(HtmlTextWriterAttribute.Src, "IMGs/product images/" + proddtl.imgnm + ".jpg");
                    likeshtm.AddAttribute(HtmlTextWriterAttribute.Class, "scroll-box-img");
                    likeshtm.RenderBeginTag(HtmlTextWriterTag.Img);
                    likeshtm.RenderEndTag();
                    likeshtm.RenderEndTag();
                    likeshtm.RenderEndTag();
                }
            }

            // Ends the row tag after inserting all row1 images and hyperlinks
            likeshtm.RenderEndTag();
            // Creates new row for the image description
            likeshtm.RenderBeginTag(HtmlTextWriterTag.Tr);
            count = 0;

            foreach (var x in prodtitle)
            {
                likeshtm.AddAttribute(HtmlTextWriterAttribute.Class, "scroll-tbl-desc-col");
                likeshtm.RenderBeginTag(HtmlTextWriterTag.Td);
                likeshtm.AddAttribute(HtmlTextWriterAttribute.Href, "product.aspx?x=" + prodid[count]);
                likeshtm.AddAttribute(HtmlTextWriterAttribute.Target, "_blank");
                likeshtm.RenderBeginTag(HtmlTextWriterTag.A);
                likeshtm.Write(x);
                likeshtm.RenderEndTag();
                likeshtm.RenderEndTag();
                count++;
            }
            likeshtm.RenderEndTag();
            likeshtm.RenderEndTag();
        }
        likebox.InnerHtml = stringWriter.ToString();
    }

    private void generateCommentsData()
    {
        ReviewDAO newReviewdao = new ReviewDAO();
        ReviewVO[] userreviews;
        userreviews = newReviewdao.getCommentsByUser(userid);
        if (userreviews[0].status != "ND" && userreviews[0].status != "ERROR")
        {
            writeCommentsProducts(userreviews);
        }
        else
        {
            commentbox.InnerHtml = "No products have been reviewed";
        }
    }

    private void writeCommentsProducts(ReviewVO[] userreviews)
    {
        StringWriter stringWriter = new StringWriter();
        int rowcount = userreviews[0].count;
        count = 0;
        string[] prodtitle = new string[rowcount];
        string[] prodid = new string[rowcount];
        using (HtmlTextWriter commentWriter = new HtmlTextWriter(stringWriter))
        {
            commentWriter.AddAttribute(HtmlTextWriterAttribute.Class, "usr-data-scrl-tbl");
            commentWriter.RenderBeginTag(HtmlTextWriterTag.Table);
            commentWriter.RenderBeginTag(HtmlTextWriterTag.Tr);
            foreach (var x in userreviews)
            {
                ProductVO proddtl = newproddao.getProdMinDetails(x.pid);
                if (x.status == "S")
                {
                    prodtitle[count] = proddtl.title;
                    prodid[count] = proddtl.prodid;
                    count++;
                    commentWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                    commentWriter.AddAttribute(HtmlTextWriterAttribute.Href, "product.aspx?x=" + proddtl.prodid);
                    commentWriter.AddAttribute(HtmlTextWriterAttribute.Target, "_blank");
                    commentWriter.RenderBeginTag(HtmlTextWriterTag.A);
                    commentWriter.AddAttribute(HtmlTextWriterAttribute.Src, "IMGs/product images/" + proddtl.imgnm + ".jpg");
                    commentWriter.AddAttribute(HtmlTextWriterAttribute.Class, "scroll-box-img");
                    commentWriter.RenderBeginTag(HtmlTextWriterTag.Img);
                    commentWriter.RenderEndTag();
                    commentWriter.RenderEndTag();
                    commentWriter.RenderEndTag();
                }
            }

            //Ends the row tag after inserting all row1 images and hyperlinks
            commentWriter.RenderEndTag();
            // Creates new row for the image description
            commentWriter.RenderBeginTag(HtmlTextWriterTag.Tr);
            count = 0;

            foreach (var x in prodtitle)
            {
                commentWriter.AddAttribute(HtmlTextWriterAttribute.Class, "scroll-tbl-desc-col");
                commentWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                commentWriter.AddAttribute(HtmlTextWriterAttribute.Href, "product.aspx?x=" + prodid[count]);
                commentWriter.AddAttribute(HtmlTextWriterAttribute.Target, "_blank");
                commentWriter.RenderBeginTag(HtmlTextWriterTag.A);
                commentWriter.Write(x);
                commentWriter.RenderEndTag();
                commentWriter.RenderEndTag();
                count++;
            }
            commentWriter.RenderEndTag();
            commentWriter.RenderEndTag();
        }
        commentbox.InnerHtml = stringWriter.ToString();
    }


    private void generatefollowingData()
    {
        FollowerDAO newfollower = new FollowerDAO();
        FollowerVO[] userfollows;
        userfollows = newfollower.getFollowedUsers(userid);
        if (userfollows[0].status != "ND" && userfollows[0].status != "ERROR")
        {
            writeFollowingUserList(userfollows);
        }
        else
        {
            followbox.InnerHtml = "Currently not following any other users";
        }
    }

    private void writeFollowingUserList(FollowerVO[] userfollows)
    {
        StringWriter stringWriter = new StringWriter();
        int rowcount = userfollows[0].count;
        UserDAO newuserdao = new UserDAO();
        count = 0;
        string[] userid = new string[rowcount];

        using (HtmlTextWriter commentWriter = new HtmlTextWriter(stringWriter))
        {
            commentWriter.AddAttribute(HtmlTextWriterAttribute.Class, "usr-data-scrl-tbl");
            commentWriter.RenderBeginTag(HtmlTextWriterTag.Table);
            commentWriter.RenderBeginTag(HtmlTextWriterTag.Tr);

            foreach (var x in userfollows)
            {
                UserVO userdtl = newuserdao.getUserById(x.userid);
                if (x.status == "S")
                {
                    userid[count] = userdtl.userid;
                    count++;

                    commentWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                    commentWriter.AddAttribute(HtmlTextWriterAttribute.Href, "profile.aspx?p=" + userdtl.userid);
                    commentWriter.AddAttribute(HtmlTextWriterAttribute.Target, "_blank");
                    commentWriter.RenderBeginTag(HtmlTextWriterTag.A);
                    commentWriter.AddAttribute(HtmlTextWriterAttribute.Src, "IMGs/users/" + userdtl.imgnm + ".png");
                    commentWriter.AddAttribute(HtmlTextWriterAttribute.Class, "scroll-box-img");
                    commentWriter.RenderBeginTag(HtmlTextWriterTag.Img);
                    commentWriter.RenderEndTag();
                    commentWriter.RenderEndTag();
                    commentWriter.RenderEndTag();
                }
            }

            //Ends the row tag after inserting all row1 images and hyperlinks
            commentWriter.RenderEndTag();
            // Creates new row for the image description
            commentWriter.RenderBeginTag(HtmlTextWriterTag.Tr);
            count = 0;

            foreach (var x in userid)
            {
                commentWriter.AddAttribute(HtmlTextWriterAttribute.Class, "scroll-tbl-desc-col");
                commentWriter.RenderBeginTag(HtmlTextWriterTag.Td);
                commentWriter.AddAttribute(HtmlTextWriterAttribute.Href, "profile.aspx?p=" + userid[count]);
                commentWriter.AddAttribute(HtmlTextWriterAttribute.Target, "_blank");
                commentWriter.RenderBeginTag(HtmlTextWriterTag.A);
                commentWriter.Write(x);
                commentWriter.RenderEndTag();
                commentWriter.RenderEndTag();
                count++;
            }
            commentWriter.RenderEndTag();
            commentWriter.RenderEndTag();
        }
        followbox.InnerHtml = stringWriter.ToString();
    }

    protected void followbtn_Click(object sender, EventArgs e)
    {
        newfollowdao.addRow(newdata);
        generateButtons();
    }

    protected void unfollowbtn_Click(object sender, EventArgs e)
    {
        newfollowdao.removeFollower(userid, logedinusr);
        generateButtons();
    }
</script>