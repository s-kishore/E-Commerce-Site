using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Collections;

namespace dbproj.DAOs
{
    public class PurchaseDAO
    {
        private SqlConnection dbconnection = new SqlConnection(ConfigurationManager.ConnectionStrings["azure"].ConnectionString);
        //private SqlConnection dbconnection = new SqlConnection(ConfigurationManager.ConnectionStrings["somee"].ConnectionString);
        private SqlDataReader reader;

        public PurchaseDAO()
        {

        }

        public int updatePurchasInfo(PurchaseVO purchdtl, Dictionary<string,int> prod_count)
        {
            object newKey= new object();
            string query = "INSERT INTO [purchase] ([userId],[amount],[deliveryAddress],[deliveryZip]) VALUES (@userid,@amt,@address,'02067'); select scope_identity()";
            SqlCommand updtdata = new SqlCommand(query, dbconnection);
            

            //SqlParameter idparam1 = new SqlParameter("@prodids", purchdtl.prodids);
            SqlParameter idparam2 = new SqlParameter("@userid", purchdtl.userid);
            SqlParameter idparam3 = new SqlParameter("@amt", purchdtl.totalamt);
            SqlParameter idparam4 = new SqlParameter("@address", purchdtl.address1);

            //updtdata.Parameters.Add(idparam1);
            updtdata.Parameters.Add(idparam2);
            updtdata.Parameters.Add(idparam3);
            updtdata.Parameters.Add(idparam4);

            try
            {
                dbconnection.Open();
                newKey = updtdata.ExecuteScalar();                

                dbconnection.Close();
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
            }
            return int.Parse(newKey.ToString());
        }
    }
}