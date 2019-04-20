using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace dbproj.DAOs
{
    public class ReviewVO
    {
        public string pid;
        public string user_name;
        public string comment;
        public string status;
        public int rating;
        public int count;
        
        public ReviewVO(string pid, string usernm, string comment, int rating,int count)
        {
            this.pid = pid;
            this.user_name = usernm;
            this.comment = comment;
            this.rating = rating;
            this.status = "S";
            this.count = count;
        }
        public ReviewVO (string status)
        {
            this.status = status;
        }

        public ReviewVO()
        {
            // TODO: Complete member initialization
        }

        public ReviewVO(string pid, int rowcount)
        {
            this.pid = pid;
            this.count = rowcount;
            this.status = "S";
        }
    }
}