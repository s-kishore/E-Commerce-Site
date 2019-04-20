<%@ Page Title="" Language="C#" MasterPageFile="proj.Master" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="dbproj.DAOs" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title id="pagetitle" runat="server">E-Mart </title>
    <link rel="stylesheet" href="CSS/product.css" />
    <script type="text/javascript" src="JS/product.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageContent" runat="server">
    <div class="pageContent">
        <div id="infobox" class="hide-elements">
            <strong> Success !! </strong>Added product to cart
        </div>
        <div id="loginND" class="hide-elements" role="alert">
            <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
            <p>You need to be signed-in to perform this action </p>
            <p>
                <a runat="server" id="loginpop" class="btn btn-default">Sign-In </a>
                <button type="button" class="btn btn-default" data-dismiss="alert">Dismiss </button>
            </p>
        </div>
        <input type="hidden" runat="server" id="avgrating" value="9" />
        <input type="hidden" runat="server" id="usrrating" value="9" />
        <asp:HiddenField runat="server" ID="username" Value="#####" />

        <div class="prod-top-box container">
            <div class="row">
                <div class="prod-img-a">
                    <asp:Image ID="prodimg" ImageUrl="../images/bikes/b1.jpg" CssClass="prod-img" runat="server" Enabled="true"></asp:Image>
                </div>
                <div class="col-md-6 col-sm-6 col-lg-5 prod-dtls">
                    <div class="row clear-element">
                            <div id="prodtitle" class="prod-title" runat="server">Samsung 64G</div>
                    </div>
                    <div class="row clear-element">
                            <h5 id="proddesc" runat="server">Product Description</h5>
                    </div>
                    <div class=" row">
                        <div class="col-md-8">
                            <hr />
                        </div>
                    </div>
                    <div class="usr-itms row">
                        <div class=" col-md-4 col-sm-5 col-lg-4 stars-box" onmouseout="resetstars()">
                            <button runat="server" id="star1" class="star-blank" onmouseover="mouseonstar(1)" onmouseout="mouseoutof(1)" onserverclick="updaterating">&#9733 </button>
                            <button runat="server" id="star2" class="star-blank" onmouseover="mouseonstar(2)" onmouseout="mouseoutof(2)" onserverclick="updaterating">&#9733 </button>
                            <button runat="server" id="star3" class="star-blank" onmouseover="mouseonstar(3)" onmouseout="mouseoutof(3)" onserverclick="updaterating">&#9733 </button>
                            <button runat="server" id="star4" class="star-blank" onmouseover="mouseonstar(4)" onmouseout="mouseoutof(4)" onserverclick="updaterating">&#9733 </button>
                            <button runat="server" id="star5" class="star-blank" onmouseover="mouseonstar(5)" onmouseout="mouseoutof(5)" onserverclick="updaterating">&#9733 </button>
                        </div>
                        <div class=" col-md-4 col-sm-4 col-lg-4">
                            <a href="#review-box" class="btn-link">Read Reviews </a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 col-sm-5 col-lg-4">
                            <div id="ratingDisp" class="dsp-rating" runat="server"> </div>
                            <div id="usrRatingDisp" class="hide-elements" runat="server"> </div>
                        </div>
                        <div >
                            <button runat="server" id="likebtn" onserverclick="likeBtnClicked" class="btn btn-default like-btn"> Like </button>
                        </div>
                    </div>

                    <div class=" row">
                        <div class="col-md-8">
                            <hr />
                        </div>
                    </div>

                    <div class="row price-row">
                        <div class="col-md-4 col-sm-5 col-lg-4 avail-row">
                            <span id="avail" runat="server"></span>
                            <span id="quantity" runat="server"></span>
                        </div>
                         <span class="col-md-3 price-box" id="priceamt" runat="server"></span>
                    </div>

                    <div class="row">
                        <span class="col-md-4 col-sm-5 col-lg-4" id="sellertag">Seller ID: <a id="selrnm" runat="server" href="profile.aspx" target="_blank"></a> </span>
                        
                    </div>
                    <div class="row">
                        <span runat="server" id="condtion" class="col-md-5 col-sm-6 col-lg-5">Product Condition: </span>
                    </div>
 
                    <div class="row cart-row">
                        <div class="col-md-4 col-sm-5 col-lg-4">
                            <button type="button" id="tocartbtn" class="addcartbtn" onclick="addtocart()"></button>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <hr />
        <div class="spec-box">
            <h4>Specification </h4>
            <asp:Table ID="specstb" runat="server" GridLines= "None" CssClass="specs-table table table-striped">
            </asp:Table>
        </div>

        <hr />
        <div id="review-box" class="review-box">
            <h4>User Reviews </h4>
            
            
            <div runat="server" id="usrmcmtrow" class="usr-inpt-row form-group">
                <asp:TextBox runat="server" ID="newusrcmt" CssClass=" form-control usr-inpt-cmt" MaxLength="200" placeholder="Enter your review" TextMode="MultiLine"></asp:TextBox>
                <br />
                <asp:Button runat="server" ID="submitcmt" Text="Submit Review" CssClass="btn btn-default sbmt-cmt-btn" OnClick="submitcmt_Click" />
            </div>


            <asp:GridView PageSize="8" ShowHeader="false" GridLines="Horizontal" CssClass="table-striped review-table" ID="GridView1" OnRowDataBound="GridView1_RowDataBound"
                 runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EmptyDataText="No reviews yet.">
                <PagerStyle CssClass="pageNum" />
                <Columns>
                    
                    <asp:TemplateField ItemStyle-CssClass="rvw-tabl-col1">

                        <ItemTemplate>
                            <a class="review-usr-name" href="profile.aspx?p=<%# Eval ("userid") %>" target="_blank"><%# Eval("userid") %></a>
                            <img class="usr-rvw-img" src="IMGs/users/<%# Eval("imgid") %>s.png" />
                            <span class="user-rating-rvw">Rated: <%# Eval("rating") %> stars</span>
                        </ItemTemplate>

                    </asp:TemplateField>

                    <asp:BoundField ItemStyle-CssClass="rvw-comment-col" DataField="comment" HeaderText="comment"/>

                    <asp:TemplateField ShowHeader="False">
                     
                       <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-info" runat="server" CausesValidation="True" CommandName="Update"
                                Text="Update"></asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" CssClass="btn btn-default" runat="server" CausesValidation="False" CommandName="Cancel"
                                Text="Cancel "></asp:LinkButton>
                        </EditItemTemplate>
                    
                        <ItemTemplate >
                            <asp:LinkButton CssClass="btn btn-default" ID="cmtEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                Text="Edit"></asp:LinkButton>
                        </ItemTemplate>

                    </asp:TemplateField>

                    <asp:TemplateField ShowHeader="False">

                        <ItemTemplate>
                            <asp:LinkButton  CssClass="btn btn-danger" ID="cmtDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                Text="Delete"></asp:LinkButton>
                        </ItemTemplate>

                    </asp:TemplateField>

                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:azure %>"
                SelectCommand="SELECT [comment], [review].[userId],[imgid], [rating] FROM [review] LEFT OUTER JOIN [user] ON [review].[userId] = [user].[userId] WHERE ([productId] = @pid) AND [comment] != 'ND' ORDER BY [time] DESC"
                DeleteCommand="DELETE FROM [review] WHERE [productId] = @pid AND [userId] = @userid"
                UpdateCommand="UPDATE [review] SET [comment] = @comment WHERE [productId] = @pid AND [userId] = @userid">
                <SelectParameters>
                    <asp:QueryStringParameter Name="pid" QueryStringField="x" Type="string" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:QueryStringParameter Name="pid" QueryStringField="x" Type="string" />
                    <asp:ControlParameter ControlID="username" PropertyName="Value" Name="userid" Type="String" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:QueryStringParameter Name="pid" QueryStringField="x" Type="string" />
                    <asp:ControlParameter ControlID="username" PropertyName="Value" Name="userid" Type="String" />
                    <asp:Parameter Name="comment" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>

        </div>
    </div>


    <script type="text/javascript">
        resetstars();
    </script>
</asp:Content>

<script runat="server">
    int reviewcount = 0;
    double prating = 0;
    float averagerating = new float();
    string prodid;
    string logedinusr;
    string[] specsfull;
    string usrcomment;
    Boolean userlike;
    char[] delimiter = { ';', ':' };
    ReviewVO[] reviewitem;
    ReviewVO prevreview;
    ReviewVO newreview = new ReviewVO();
    ReviewDAO newrevdao = new ReviewDAO();
    UserDAO usrdao = new UserDAO();
    UserVO curuser;
    ProductVO proddt;
    LikeDAO newlikedao = new LikeDAO();


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowState == DataControlRowState.Edit)
        {
            TextBox comments = (TextBox)e.Row.Cells[1].Controls[0];
            comments.TextMode = TextBoxMode.MultiLine;
            comments.CssClass = "form-control updt-cmt-box";

        }
        if (logedinusr != null && e.Row.RowType == DataControlRowType.DataRow && e.Row.FindControl("cmtEdit") != null)
        {
            DataRowView newvar = (DataRowView)e.Row.DataItem;
            string cmtusr = newvar.Row.ItemArray[1].ToString();

            if (cmtusr == logedinusr)
            {
                e.Row.FindControl("cmtEdit").Visible = true;
                e.Row.FindControl("cmtDelete").Visible = true;
            }
            else
            {
                e.Row.FindControl("cmtEdit").Visible = false;
                e.Row.FindControl("cmtDelete").Visible = false;
            }
        }
        else if (e.Row.RowType == DataControlRowType.DataRow && e.Row.FindControl("cmtEdit") != null)
        {
            e.Row.FindControl("cmtEdit").Visible = false;
            e.Row.FindControl("cmtDelete").Visible = false;
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        prodid = Request.QueryString["x"];
        if (prodid != null)
            generatePageContent();
        else
            Response.Redirect("invalid.aspx");
    }

    private void generatePageContent()
    {
        if (Session["curruser"] == null)
        {
            curuser = null;
            usrmcmtrow.Attributes.Add("class", "hide-elements");
        }
        else
        {
            curuser = (UserVO)Session["curruser"];
            logedinusr = curuser.userid;
            username.Value = logedinusr.ToString();
        }

        getProduct(prodid);
        if (proddt.status == "S")
        {
            loginpop.HRef = "login.aspx?redirect=product.aspx?x=" + prodid;
            loadUserData();
            prodtitle.InnerHtml = proddt.title;
            pagetitle.InnerText = "E-Mart  " + proddt.title;
            proddesc.InnerHtml = proddt.title;
            prodimg.ImageUrl = "IMGs/product images/" + proddt.imgnm + ".jpg";
            priceamt.InnerHtml = "$ " + proddt.price.ToString();
            proddesc.InnerHtml = proddt.desc;
            selrnm.InnerText = proddt.sellerid;
            selrnm.HRef = "profile.aspx?p=" + proddt.sellerid;
            condtion.InnerHtml = "Product Condition: " + proddt.condition;
            writeSpecs(proddt.specs);
            // writeReviews(prodid);
            // revcount.InnerHtml = reviewcount + " Reviews";

            if (proddt.avail == "Y" && ((proddt.quant - proddt.sold) > 0))

                if ((proddt.quant - proddt.sold) < 4)
                    avail.InnerHtml = "Currently " + (proddt.quant - proddt.sold) + " item available";
                else
                    avail.InnerHtml = "Product available";

            else
                avail.InnerHtml = "Out of Stock";

            prating = newrevdao.getProductRating(prodid);
            avgrating.Value = prating.ToString();
            float truckRating = (float)(Math.Round((double)prating, 1));
            ratingDisp.InnerHtml = "Avg. Rating: " + truckRating + " stars";
        }
        else takeToErrorPage();
    }

    private void loadUserData()
    {
        if (logedinusr != null)
        {
            prevreview = newrevdao.hasUsercommentedRated(prodid, logedinusr);
            userlike = newlikedao.IsProdLikedByUser(prodid, logedinusr);

            if (prevreview.status != "ND" && prevreview.status != "ERROR")
            {
                usrrating.Value = prevreview.rating.ToString();
                usrRatingDisp.InnerHtml = "Your Rating: " + prevreview.rating + " stars";
                usrRatingDisp.Attributes.Add("class", "dsp-rating show-elements");
            }

            if (prevreview.comment != ""  || logedinusr.Equals(proddt.sellerid)) 
            {
                usrmcmtrow.Attributes.Add("class", "hide-elements");
                usrcomment = prevreview.comment;
            }

            if (userlike)
                likebtn.Attributes.Add("class", "btn btn-info like-btn");
            else
                likebtn.Attributes.Add("class", "btn btn-default like-btn");
        }
    }
    private void getProduct(string pid)
    {
        ProductDAO retdao = new ProductDAO();
        proddt = retdao.getProductbyId(pid);
    }

    private void writeSpecs(string specsfrmdb)
    {
        specsfull = specsfrmdb.Split(delimiter, StringSplitOptions.RemoveEmptyEntries);

        for (int i = 0; i < (specsfull.Length / 2); i++)
        {
            TableRow newrow = new TableRow();
            specstb.Rows.Add(newrow);
            TableCell newcell1 = new TableCell();
            TableCell newcell2 = new TableCell();
            newcell1.Text = specsfull[(i * 2)];
            newcell2.Text = specsfull[(i * 2) + 1];
            newrow.Cells.Add(newcell1);
            newrow.Cells.Add(newcell2);
        }
    }

    /*  private void writeReviews(string pid)
      {
          reviewitem = newrevdao.getReviewsbyProduct(pid);
          if (reviewitem[0].status == "ND")
              rwcontent.InnerHtml = "No User Reviews";
          else if (reviewitem[0].status == "ERROR")
              rwcontent.InnerHtml = "We had a problem rendering user reviews";
          else
          {

              foreach (var x in reviewitem)
              {
                  fillReviewsTable(x.user_name,
                                   x.rating,
                                   x.comment,
                                   reviewcount);
                  prating = prating + reviewitem[reviewcount].rating;
                  reviewcount++;
              }
          }
      }

      private void fillReviewsTable(string username, int rating, string comment, int count)
      {
          TableRow newrow = new TableRow();
          reviewtb.Rows.Add(newrow);
          TableCell newcell1 = new TableCell();
          TableCell newcell2 = new TableCell();
          newcell1.Controls.Add(generateUserName(username, rating, count));
          newcell1.Controls.Add(generateUserImage(username, count));
          newcell1.Controls.Add(generateUserRatingLbl(rating, count));
          newcell1.Attributes.Add("class", "rvw-tabl-col1");
          newcell1.Attributes.Add("width", "48px");
          newcell2.Text = comment;
          newcell2.Attributes.Add("class", "rvw-comment-col");
          newrow.Cells.Add(newcell1);
          newrow.Cells.Add(newcell2);
      }

      private HyperLink generateUserName(string username, int rating, int count)
      {
          HyperLink user = new HyperLink();
          user.Text = username;
          user.CssClass = "review-usr-name";
          user.ID = "usrrw" + count;
          user.NavigateUrl = "profile.aspx?p=" + username;
          user.Target = "_blank";
          return user;
      }
      private Label generateUserRatingLbl(int rating, int count)
      {
          Label ratdesc = new Label();
          ratdesc.CssClass = "user-rating-rvw";
          ratdesc.ID = "usrrating" + count;
          if (rating == 0)
              ratdesc.Text = "Rated: No Rating";
          else
              ratdesc.Text = "Rated: " + rating + " stars";
          return ratdesc;
      }

      private Image generateUserImage(string username, int count)
      {
          UserVO usr = usrdao.getUserById(username);
          string usrimgsmall;
          if (usr.status != "ND" && usr.status != "ERROR")
          {
              usrimgsmall = usr.imgnm + "s.png";
          }
          else
          {
              usrimgsmall = "1" + "s.png";
          }
          Image usrimg = new Image();
          usrimg.ImageUrl = "IMGs/users/" + usrimgsmall;
          usrimg.CssClass = "usr-rvw-img";
          usrimg.ID = "usrimg" + count;
          return usrimg;
      }
    */

    public void updaterating(Object sender, EventArgs e)
    {
        if (logedinusr != null)
        {
            HtmlButton stars = (HtmlButton)sender;
            switch (stars.ID)
            {
                case "star1":
                    newrevdao.updateUserRating(1, prodid, logedinusr);
                    usrrating.Value = "1";
                    break;
                case "star2":
                    newrevdao.updateUserRating(2, prodid, logedinusr);
                    usrrating.Value = "2";
                    break;
                case "star3":
                    newrevdao.updateUserRating(3, prodid, logedinusr);
                    usrrating.Value = "3";
                    break;
                case "star4":
                    newrevdao.updateUserRating(4, prodid, logedinusr);
                    usrrating.Value = "4";
                    break;
                case "star5":
                    newrevdao.updateUserRating(5, prodid, logedinusr);
                    usrrating.Value = "5";
                    break;
            }

        }
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "showNeedLogin();", true);
        }
    }

    private void takeToErrorPage()
    {
        Response.Redirect("invalid.aspx");
    }

    protected void submitcmt_Click(object sender, EventArgs e)
    {
        usrcomment = newusrcmt.Text;
        newrevdao.updateUserComment(logedinusr, prodid, usrcomment);
        Response.Redirect(Request.RawUrl);
        // alert windows update
    }

    public void likeBtnClicked(Object sender, EventArgs e)
    {
        if (logedinusr != null)
        {
            if (userlike)
            {
                newlikedao.removeUserLike(prodid, logedinusr);
                userlike = false;
                likebtn.Attributes.Add("class", "btn btn-default");
            }
            else
            {
                newlikedao.updateUserLike(prodid, logedinusr);
                userlike = true;
                likebtn.Attributes.Add("class", "btn btn-info");
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "showNeedLogin();", true);
        }
    }


</script>
