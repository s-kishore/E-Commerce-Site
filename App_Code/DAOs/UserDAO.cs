using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

namespace dbproj.DAOs
{
    public class UserDAO
    {
        String ConnectionStringAbv;

        private SqlConnection dbconnection;
        private SqlDataReader reader;

        public UserDAO()
        {
            ConnectionStringAbv = "azure";
            //ConnectionStringAbv = "somee";
            dbconnection = new SqlConnection(ConfigurationManager.ConnectionStrings[ConnectionStringAbv].ConnectionString);
            
        }
        public UserVO getUserById(String userid)
        {
           
            UserVO crruser = new UserVO("ND");
            SqlCommand retcmd = new SqlCommand("select * from [user] where [userId] = @userid", dbconnection);
            SqlParameter useridparam = new SqlParameter("@userid", userid);

            retcmd.Parameters.Add(useridparam);
            
            try
            { 
                dbconnection.Open();
                reader = retcmd.ExecuteReader();

                while (reader.Read())
                {
                    crruser = new UserVO(reader["userId"].ToString(),
                                                reader["pass"].ToString(),
                                                reader["imgid"].ToString(),
                                                reader["firstName"].ToString(),
                                                reader["lastName"].ToString(),
                                                reader["streetAddress"].ToString(),
                                                reader["email"].ToString());
                }
                dbconnection.Close();
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
                crruser = new UserVO("ERROR");
            }
            return crruser;
        }

        public int CreateUser(UserVO user)
        {
            int val=-1;
            string checkQuery = "select count(*) as count FROM [user] WHERE [userId] = '" + user.userid + "'";
            string query = "INSERT INTO [user] VALUES (@userid,@pass,@imgnm,@fname,@lname,@email,@address,@zip)";


            SqlCommand updtdata = new SqlCommand(query, dbconnection);
            SqlCommand chkdata = new SqlCommand(checkQuery, dbconnection);

            SqlParameter idparam = new SqlParameter("@userid", user.userid);
            SqlParameter idparam1 = new SqlParameter("@imgnm", user.imgnm);
            SqlParameter idparam2 = new SqlParameter("@fname", user.fname);
            SqlParameter idparam3 = new SqlParameter("@lname", user.lname);
            SqlParameter idparam4 = new SqlParameter("@email", user.email);
            SqlParameter idparam5 = new SqlParameter("@address", user.address);
            SqlParameter idparam6 = new SqlParameter("@zip", user.zip);
            SqlParameter idparam7 = new SqlParameter("@pass", user.password);

            updtdata.Parameters.Add(idparam);
            updtdata.Parameters.Add(idparam1);
            updtdata.Parameters.Add(idparam2);
            updtdata.Parameters.Add(idparam3);
            updtdata.Parameters.Add(idparam4);
            updtdata.Parameters.Add(idparam5);
            updtdata.Parameters.Add(idparam6);
            updtdata.Parameters.Add(idparam7);

            try
            {
                dbconnection.Open();
                SqlDataReader data = chkdata.ExecuteReader();
                if (data.Read())
                {
                    String count = data["count"].ToString();
                    data.Close();
                    if (count == "0")
                    {
                        updtdata.ExecuteNonQuery();
                        val = 1;
                    }
                }
                else
                {
                    val = 0;
                }
                dbconnection.Close();
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
                val = -1;
            }
            return val;
        }

        public void updateEmail(string logedinusr, string emailid)
        {
            string query = "UPDATE [user] SET [email] = \'" + emailid + "\' where [userId] =\'" + logedinusr + "\'";
            SqlCommand updtcmd = new SqlCommand(query, dbconnection);
            try
            {
                dbconnection.Open();
                updtcmd.ExecuteNonQuery();
                dbconnection.Close();
            }
            catch
            {
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
            }
        }
    }
}