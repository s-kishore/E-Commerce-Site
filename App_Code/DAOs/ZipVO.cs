using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace dbproj.DAOs
{
    public class ZipVO
    {
        public string zip;
        public string state;
        public string city;
        public string status;
        public int count;
        public ZipVO(string zip, string state,String city,int count)
        {
            this.zip = zip;
            this.state = state;
            this.city = city;
            this.count = count;
            this.status = "S";
        }
        public ZipVO(string status)
        {
            this.status = status;
        }
        public ZipVO()
        {

        }
    }
}