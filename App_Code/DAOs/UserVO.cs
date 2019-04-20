using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace dbproj.DAOs
{
    public class UserVO
    {   public string userid;
        public string password;
        public string imgnm;
        public string fname;
        public string lname;
        public string email;
        public string status;
        public string address;
        public string zip;
        public int count;


        public UserVO(string userid,string password,string imgid,string fname,string lname, string address, string email)
        {
            this.userid = userid;
            this.password = password;
            this.imgnm = imgid;
            this.fname = fname;
            this.lname = lname;
            this.email = email;
            this.address = address;
            this.status = "S";
            this.count = 1;
        }
        public UserVO (string status)
        {
            this.status = status;
        }

        public UserVO(string userid, string password, string imgid, string fname, string lname, string address, string email, string zip)
        {
            this.userid = userid;
            this.password = password;
            this.imgnm = imgid;
            this.fname = fname;
            this.lname = lname;
            this.email = email;
            this.address = address;
            this.zip = zip;
            this.status = "S";
            this.count = 1;
        }
    }
}