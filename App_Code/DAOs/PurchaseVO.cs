using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace dbproj.DAOs
{
    public class PurchaseVO
    {
        public string purchid;
        public string prodids;
        public string userid;
        public float totalamt;
        public string zip;
        public string address1;
        public string status;

        public PurchaseVO()
        {

        }
        public PurchaseVO(string prodids, string userid, float totamt,string address,string zip)
        {   
            this.prodids = prodids;
            this.userid = userid;
            this.totalamt = totamt;
            this.address1 = address;
            this.zip = zip;
            this.status = "S";
        }

        public PurchaseVO(string purid, string prodids, string userid, float totamt)
        {
            this.purchid = purid;
            this.prodids = prodids;
            this.userid = userid;
            this.totalamt = totamt;
            this.status = "S";
        }
        public PurchaseVO(string status)
        {
            this.status = status;
        }
        	
    }
}