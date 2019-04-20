using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
namespace dbproj.DAOs
{
    public class LikeDAO
    {
        public LikeVO[] likesarray;
        int count;

        private SqlConnection dbconnection = new SqlConnection(ConfigurationManager.ConnectionStrings["azure"].ConnectionString);
        //private SqlConnection dbconnection = new SqlConnection(ConfigurationManager.ConnectionStrings["somee"].ConnectionString);
        private SqlDataReader reader;
        private SqlDataReader countreader;
        private int arraycount;

        public LikeVO[] getLikesbyUser(string userid)
        {
            SqlCommand retcount = new SqlCommand("select count(*) from [like] where [userId] = @userid", dbconnection);
            SqlCommand retcmd = new SqlCommand("select * from [like] where [userId] = @userid", dbconnection);
            SqlParameter idparam = new SqlParameter("@userid", userid);
            SqlParameter idparam1 = new SqlParameter("@userid", userid);
            
            retcmd.Parameters.Add(idparam);
            retcount.Parameters.Add(idparam1);
           
            try
            {
                dbconnection.Open();
                countreader = retcount.ExecuteReader();
                countreader.Read();
                arraycount = countreader.GetInt32(0);
                countreader.Close();
                if (arraycount > 0)
                {
                    likesarray = new LikeVO[arraycount];
                    reader = retcmd.ExecuteReader();
                   
                        while (reader.Read())
                        {
                            likesarray[count] = new LikeVO(reader["userid"].ToString(),
                                                        reader["productId"].ToString(),
                                                        arraycount);
                            count++;
                        }
                   if(likesarray.Length == 0)
                    {
                        likesarray[0] = new LikeVO("ERROR");
                    }
                }
                else
                {
                    likesarray = new LikeVO[1];
                    likesarray[0] = new LikeVO("ND");

                }
                reader.Close();
                dbconnection.Close();
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
                likesarray = new LikeVO[1];
                likesarray[0] = new LikeVO("ERROR");
            }
            return likesarray;
        }


        public bool IsProdLikedByUser(string prodid, string logedinusr)
        {
            string query = "SELECT * FROM [LIKE] WHERE [userId]= @userid AND [productId]= @pid";
            Boolean result = false;
            SqlCommand updtdata = new SqlCommand(query, dbconnection);

            SqlParameter idparam1 = new SqlParameter("@userid", logedinusr);
            SqlParameter idparam2 = new SqlParameter("@pid", prodid);

            updtdata.Parameters.Add(idparam1);
            updtdata.Parameters.Add(idparam2);

            try
            {
                dbconnection.Open();
                reader = updtdata.ExecuteReader();
                if(reader.HasRows)
                {
                    result = true;
                }
                dbconnection.Close();
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
            }
            return result;
        }

        public void updateUserLike(string prodid, string logedinusr)
        {
            string query = "INSERT INTO [like] ([productId], [userId]) VALUES (@pid,@userid)";
            SqlCommand updtdata = new SqlCommand(query, dbconnection);

            SqlParameter idparam1 = new SqlParameter("@userid", logedinusr);
            SqlParameter idparam2 = new SqlParameter("@pid", prodid);

            updtdata.Parameters.Add(idparam1);
            updtdata.Parameters.Add(idparam2);

            try
            {
                dbconnection.Open();
                updtdata.ExecuteNonQuery();
                dbconnection.Close();
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
            }
        }

        public void removeUserLike(string prodid, string logedinusr)
        {
            string query = "DELETE FROM [like] WHERE [productId] = @pid AND [userId] = @userid";
            SqlCommand updtdata = new SqlCommand(query, dbconnection);

            SqlParameter idparam1 = new SqlParameter("@userid", logedinusr);
            SqlParameter idparam2 = new SqlParameter("@pid", prodid);

            updtdata.Parameters.Add(idparam1);
            updtdata.Parameters.Add(idparam2);

            try
            {
                dbconnection.Open();
                updtdata.ExecuteNonQuery();
                dbconnection.Close();
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
            }
        }
    }
}