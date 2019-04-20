using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
namespace dbproj.DAOs
{
    public class ZipDAO
    {
        int count;

        private SqlConnection dbconnection = new SqlConnection(ConfigurationManager.ConnectionStrings["azure"].ConnectionString);
        //private SqlConnection dbconnection = new SqlConnection(ConfigurationManager.ConnectionStrings["somee"].ConnectionString);
        private SqlDataReader reader;
        private SqlDataReader countreader;
        private int arraycount;
        public ZipDAO()
        {

        }
    }
}