using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace dbproj
{
    public partial class product1 : System.Web.UI.Page
    {
        /*int reviewcount = 0;
        int prating = 0;
        float averagerating = new float();
        String prodid;
        String[] specsfull;
        char[] delimiter ={';',':'};
        ProductVO proddt;
        ReviewVO[] reviewitem;
        ReviewDAO newrevdao = new ReviewDAO();
        UserDAO usrdao = new UserDAO();
        ReviewVO newreview = new ReviewVO();
        

        protected void Page_Load(object sender, EventArgs e)
        {
            prodid = Request.QueryString["x"];
            if (prodid != null)
            generatePageContent();
            else
            Response.Redirect("invalid.aspx");
        }

        public void likeBtnClicked(Object sender, EventArgs e)
        {
            prodtitle.Style["color"] = "green";
        }
        public void updaterating(Object sender, EventArgs e)
        { }
        /*              string starid= new string;
                   starid = sender;
                   switch (starid)
                   {
                       case "star1":
                           updateUserRating(1,Gusername);
                           break;
                       case "star2":
                           updateUserRating(2,Gusername);
                           break;
                       case "star3":
                           updateUserRating(3,Gusername);
                           break;
                       case "star4":
                           updateUserRating(4,Gusername);
                           break;
                   }

               }

        private void generatePageContent()
        {
            getProduct(prodid);
            if (proddt.status == "S")
            {
                prodtitle.InnerHtml = proddt.title;
                pagetitle.InnerText = "E-Mart - " + proddt.title;
                proddesc.InnerHtml = proddt.title;
                prodimg.ImageUrl = "/IMGs/product images/" + proddt.imgnm + ".jpg";
                priceamt.InnerHtml = proddt.price.ToString();
                proddesc.InnerHtml = proddt.desc;
                selrnm.InnerText = proddt.sellerid;
                selrnm.HRef = "profile.aspx?p=" + proddt.sellerid;
                condtion.InnerHtml = proddt.condition;
                writeSpecs(proddt.specs);
                writeReviews(prodid);
                revcount.InnerHtml = reviewcount + " Reviews";

                if (proddt.avail == "Y" && ((proddt.quant - proddt.sold) > 0))
                    avail.InnerHtml = "Currently " + (proddt.quant - proddt.sold) + " item available";

                else
                    avail.InnerHtml = "Out of Stock";

                if (reviewcount != 0)
                {
                    averagerating = ((float)prating / (float)reviewcount);
                    avgrating.Value = averagerating.ToString();
                }
                else
                    avgrating.Value = "0";
            }
            else takeToErrorPage();
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

        private void writeReviews(string pid)
        {
            reviewitem = newrevdao.getReviewsbyProduct(pid);
            if (reviewitem[0].status == "ND")
                rwcontent.InnerHtml = "No User Reviews";
            else if(reviewitem[0].status == "ERROR")
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
            //(generateUserRating(rating, count));
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
            usrimg.ImageUrl = "../images/users/" + usrimgsmall;
            usrimg.CssClass = "usr-rvw-img";
            usrimg.ID = "usrimg" + count;
            return usrimg;
        }

        private void takeToErrorPage()
        {
            Response.Redirect("invalid.aspx");
        }*/
    }
}