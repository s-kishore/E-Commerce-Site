using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace dbproj
{
    public partial class profile : System.Web.UI.Page
    {
      /*  UserVO userdtl;
        UserDAO newuserdao = new UserDAO();
        string userid;
        int count = 0;
        ProductDAO newproddao = new ProductDAO();
        protected void Page_Load(object sender, EventArgs e)
        {
            userid = Request.QueryString["p"];
            if (userid != null)
            {
                userdtl = newuserdao.getUserById(userid);

                if (userdtl.status == "S")
                {
                    generateUserData();
                    generateButtons();
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

        }

        private void generateButtons()
        {
            //at position fllowupdatespace
            //<asp:Button ID="updtbtn" runat="server" OnClick="updtbtn_Click" Text="Update My Data" CssClass="updt-btn"/>
        }

        private void generateUserData()
        {
            usrimg.ImageUrl = "../images/users/" + userdtl.imgnm + ".png";
            usrname.InnerHtml = userdtl.userid;
            fname.InnerHtml = userdtl.fname;
            lname.InnerHtml = userdtl.lname;
            email.InnerHtml = userdtl.email;
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
                likebox.InnerHtml = "You have not liked any products yet";
            }
        }

        private void writeToScreen(LikeVO[] userlikes)
        {
            StringWriter stringWriter = new StringWriter();
            int likesrowcount = userlikes[0].count;
            string[] prodtitle = new string[likesrowcount];
            string[] prodid = new string[likesrowcount];
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
                        likeshtm.AddAttribute(HtmlTextWriterAttribute.Src, "../images/product images/" + proddtl.prodid + ".jpg");
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
                likebox.InnerHtml = "You have not reviewed on any products yet";
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
                        commentWriter.AddAttribute(HtmlTextWriterAttribute.Src, "../images/product images/" + proddtl.prodid + ".jpg");
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
            userfollows = newfollower.getFollowedUsers("krish");
            if (userfollows[0].status != "ND" && userfollows[0].status != "ERROR")
            {
                writeFollowingUserList(userfollows);
            }
            else
            {
                likebox.InnerHtml = "You have not reviewed on any products yet";
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
                        commentWriter.AddAttribute(HtmlTextWriterAttribute.Src, "../images/users/" + userdtl.imgnm + ".png");
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
        }*/
    }
}