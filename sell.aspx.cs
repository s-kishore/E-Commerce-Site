using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Globalization;
using System.Web.Configuration;

namespace dbproj
{
    public partial class sell : System.Web.UI.Page
    {
       /* UserVO curuser;
        string[] cam ={"Digital Cameras","Lenses & Filters","Camcorders","Binoculars & Telescopes","Flashes & Flash Accessories","Others"};
        string[] car={"Car Audio & Video Installation", "Car Security", "GPS Accessories & Mounts","GPS Units & Equipment", "Others"};
        string[] cell={"Cell Phones & Smartphones","Cell Phone Accessories","Smart Watches","Replacement Parts & Tools","Other"};
        string[] computer = {"iPads & Tablets", "Laptops & Notebooks", "Desktops & All-In-Ones" ,"Printers & Scanners ", "Keyboards, Mice & Pointing", "Monitors & Projectors","Software","Other"};
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

            if(usravailyes.Checked)
                prodavail ="Y";
            else
                prodavail="N";

            if(usrcondnew.Checked)
                prodcond = "New";
            else
                prodcond = "Old";
            
            WebClient newclient = new WebClient();
            newclient.DownloadFile(url, Server.MapPath("~/project/IMGs/product images/") + filename + ".jpg");
            ProductVO newprod = new ProductVO(usrtitle.Text, filename, usrcat.SelectedValue,usrsubcat.SelectedValue, usrdesc.Text, formattedSpecs,
                                                Convert.ToDouble(usrprice.Text), prodcond, sellername, Convert.ToInt32(usrquant.Text), prodavail);
            string newprodid = newproddao.createProduct(newprod);
            Response.Redirect("profile.aspx?x=" + newprodid);
        }

        private string generateDescData()
        {
            string returndesc = "";
            string title="";
            string value="";
            Boolean titleset= false;
            
            int totalfields = Convert.ToInt32(speccount.Value);
            
            foreach(Control ctrl in specsbox.Controls)
            {
                if(ctrl is TextBox )
                {
                    TextBox newtextbox = (TextBox) ctrl;

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
            switch(usrcatsel)
            {
                case "car":
                    return car;
                case "cam":
                    return cam;
                case "cell":
                    return cell;
                case "computer":
                    return computer;
                case "tv":
                    return tv;
                default:
                    return others;
            }
        }

        protected void addfieldbtn_Click(object sender, EventArgs e)
        {
            string countstring = speccount.Value;
            specsCount = Convert.ToInt32(countstring);
            specsCount++;
            speccount.Value = specsCount.ToString();
            for (int i = 6; i <= specsCount; i++)
            {
                TextBox newtextbox1 = new TextBox();
                TextBox newtextbox2 = new TextBox();
                Literal newliteral = new Literal();
                newliteral.Text = "<br>";

                newtextbox1.CssClass = "spec-title-inpt usr-inp";
                newtextbox1.ID = "spectitle" + i;
                newtextbox1.MaxLength = 80;


                newtextbox2.CssClass = "spec-specs-inpt usr-inp";
                newtextbox2.ID = "specvalue" + i;
                newtextbox2.MaxLength = 100;
                newtextbox2.TextMode = TextBoxMode.MultiLine;

                try
                {
                    specsbox.Controls.Add(newtextbox1);
                    specsbox.Controls.Add(newtextbox2);

                }
                catch (Exception ee)
                {

                }
            }
        } */
    }
}