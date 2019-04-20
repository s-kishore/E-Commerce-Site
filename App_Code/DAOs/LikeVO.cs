using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace dbproj.DAOs
{
    public class LikeVO
    {
        public string userid;
        public string pid;
        public string status;
        public int count;
        public LikeVO(string usrid, string prodid,int count)
        {
            this.userid = usrid;
            this.pid = prodid;
            this.count = count;
            this.status = "S";
        }
        public LikeVO(string status)
        {
            this.status = status;
        }
        public  LikeVO()
        {

        }
    }
}