using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
namespace dbproj.DAOs
{
    public class ProductVO
    {
        public string prodid { set; get; }
        public string title { set; get; }
        public string imgnm { set; get; }
        public string category { set; get; }
        public string subcategory { set; get; }
        public string desc { set; get; }
        public string specs { set; get; }
        public float price { set; get; }
        public string condition { set; get; }
        public string sellerid { set; get; }
        public int quant { set; get; }
        public int sold { set; get; }
        public string avail { set; get; }
        public string status { set; get; }

        public int count;

        public ProductVO(string prodid,string title,string imgnm, string category,string subcategory, string desc, string specs, float price, string condition, string sellerid, int quant, int sold, string avail,int count)
        {
            this.prodid = prodid;
            this.title = title;
            this.imgnm = imgnm;
            this.category = category;
            this.subcategory = subcategory;
            this.desc = desc;
            this.specs = specs;
            this.price = price;
            this.condition = condition;
            this.sellerid = sellerid;
            this.quant = quant;
            this.sold = sold;
            this.avail = avail;
            this.count = count;
            this.status = "S";
        }

        public ProductVO(string title,string imgnm, string category,string subcategory, string desc, string specs, float price, string condition, string sellerid, int quant, string avail)
        {
            this.title = title;
            this.imgnm = imgnm;
            this.category = category;
            this.subcategory = subcategory;
            this.desc = desc;
            this.specs = specs;
            this.price = price;
            this.condition = condition;
            this.sellerid = sellerid;
            this.quant = quant;
            this.avail = avail;
        }

        public ProductVO(string p)
        {
            // TODO: Complete member initialization
            this.status = p;
        }

        public ProductVO()
        {
            // TODO: Complete member initialization
        }

        public ProductVO(string pid,string imgnm, string ptitle,int count)
        {
            // TODO: Complete member initialization
            this.prodid = pid;
            this.title = ptitle;
            this.imgnm = imgnm;
            this.count = count;
            this.status = "S";
        }

    }
}
