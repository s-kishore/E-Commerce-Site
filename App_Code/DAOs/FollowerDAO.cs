using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

namespace dbproj.DAOs
{
    public class FollowerDAO
    {
        public FollowerVO[] followerArray;
        int count;
        private SqlConnection dbconnection = new SqlConnection(ConfigurationManager.ConnectionStrings["azure"].ConnectionString);
        //private SqlConnection dbconnection = new SqlConnection(ConfigurationManager.ConnectionStrings["somee"].ConnectionString);
        private SqlDataReader reader;
        private SqlDataReader countreader;
        private int arraycount;
        

        public void addRow(FollowerVO rowdata)
        {
           string query = "INSERT INTO [follower] ([userId], [followerId]) VALUES (N\'" + rowdata.userid + "\',N\'" + rowdata.followerid + "\')";
           SqlCommand retcount = new SqlCommand(query, dbconnection);
           try
           {
               dbconnection.Open();
               retcount.ExecuteNonQuery();
               dbconnection.Close();
           }
           catch
           {
               if (dbconnection.State != System.Data.ConnectionState.Closed)
                   dbconnection.Close();
           }

        }
        public void removeFollower(string userid, string followerid)
        {
            SqlCommand retcount = new SqlCommand("DELETE FROM [FOLLOWER] WHERE [userId]= @userid AND [followerId]= @followerid", dbconnection);
            SqlParameter idparam = new SqlParameter("@followerid", followerid);
            SqlParameter idparam1 = new SqlParameter("@userid", userid);

            retcount.Parameters.Add(idparam);
            retcount.Parameters.Add(idparam1);

            try
            {
                dbconnection.Open();
                retcount.ExecuteNonQuery();
                dbconnection.Close();
            }
            catch
            {
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
            }
        }

        public Boolean IsUserFollowed(string userid,string followerid)
        {
            SqlCommand retcount = new SqlCommand("select count(*) from [follower] where [followerId] = @followerid AND [userId] = @userid", dbconnection);
            SqlParameter idparam = new SqlParameter("@followerid", followerid);
            SqlParameter idparam1 = new SqlParameter("@userid", userid);
            
            retcount.Parameters.Add(idparam);
            retcount.Parameters.Add(idparam1);

            try
            {
                dbconnection.Open();
                countreader = retcount.ExecuteReader();
                countreader.Read();
                arraycount = countreader.GetInt32(0);
                dbconnection.Close();
                if (arraycount == 1)
                    return true;
                else
                    return false;
            }
            catch
            {
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
                return true;
            }
        }
        
        public FollowerVO[] getFollowedUsers(string userid)
        {
            SqlCommand retcount = new SqlCommand("select count(*) from [follower] where [followerId] = @userid", dbconnection);
            SqlCommand retcmd = new SqlCommand("select * from [follower] where [followerId] = @userid", dbconnection);
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
                    followerArray = new FollowerVO[arraycount];
                    reader = retcmd.ExecuteReader();
                   
                        while (reader.Read())
                        {
                            followerArray[count] = new FollowerVO(reader["userid"].ToString(),
                                                                  reader["followerid"].ToString(),
                                                                  arraycount);
                            count++;
                        }
                    
                    if(followerArray.Length == 0)
                    {
                        followerArray[0] = new FollowerVO("ERROR");

                    }
                }
                else
                {
                    followerArray = new FollowerVO[1];
                    followerArray[0] = new FollowerVO("ND");

                }
                reader.Close();
                dbconnection.Close();
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
                followerArray = new FollowerVO[1];
                followerArray[0] = new FollowerVO("ERROR");
            }
            return followerArray;
        }
    }
}