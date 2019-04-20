using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace dbproj.DAOs
{
    public class FollowerVO
    {
        public string followerid;
        public string userid;    
        public string status;
        public int count;

        public FollowerVO(string userid, string followerid, int count)
        {
            this.userid = userid;
            this.followerid = followerid;
            this.count = count;
            this.status = "S";
        }
        public FollowerVO(string status)
        {
            this.status = status;
            this.count = 1;
        }
        public FollowerVO()
        {

        }
    }
}