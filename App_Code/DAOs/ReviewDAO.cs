using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

namespace dbproj.DAOs
{
    public class ReviewDAO
    {
        private SqlConnection dbconnection = new SqlConnection(ConfigurationManager.ConnectionStrings["azure"].ConnectionString);
        //private SqlConnection dbconnection = new SqlConnection(ConfigurationManager.ConnectionStrings["somee"].ConnectionString);

        private SqlDataReader reader;
        private SqlDataReader countreader;
        private int rowcount = 0;
        private int count = 0;
        ReviewVO[] reviewarray;
        ReviewVO review;

        public void createReview()
        {

        }

        public ReviewVO[] getReviewsbyProduct(String prodid)
        {

            SqlCommand retcount = new SqlCommand("select count(*) from [review] where [productId] = @prodid AND [comment] != 'ND'", dbconnection);
            SqlCommand retcmd = new SqlCommand("select * from [review] where [productId] = @prodid AND [comment] != 'ND'", dbconnection);
            SqlParameter idparam = new SqlParameter("@prodid", prodid);
            SqlParameter idparam1 = new SqlParameter("@prodid", prodid);

            retcmd.Parameters.Add(idparam);
            retcount.Parameters.Add(idparam1);
            try
            {
                dbconnection.Open();

                countreader = retcount.ExecuteReader();
                countreader.Read();
                rowcount = countreader.GetInt32(0);
                countreader.Close();

                if (rowcount > 0)
                {
                    reviewarray = new ReviewVO[rowcount];
                    reader = retcmd.ExecuteReader();

                    while (reader.Read())
                    {
                        reviewarray[count] = new ReviewVO(reader["productId"].ToString(),
                                                 reader["userid"].ToString(),
                                                 reader["comment"].ToString(),
                                                 reader.GetInt32(reader.GetOrdinal("rating")),
                                                 rowcount);
                        count++;
                    }

                    if (reviewarray.Length == 0)
                    {
                        reviewarray[0] = new ReviewVO("ERROR");
                    }

                }
                else
                {
                    reviewarray = new ReviewVO[1];
                    reviewarray[0] = new ReviewVO("ND");
                }
                dbconnection.Close();
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
                reviewarray = new ReviewVO[1];
                reviewarray[0] = new ReviewVO("ERROR");
            }
            return reviewarray;
        }

        public ReviewVO[] getCommentsByUser(string userid)
        {
            SqlCommand retcount = new SqlCommand("select count(*) from [review] where [userId] = @userid AND [comment] != 'ND'", dbconnection);
            SqlCommand retcmd = new SqlCommand("select [productId] from [review] where [userId] = @userid AND [comment] != 'ND'", dbconnection);
            SqlParameter idparam = new SqlParameter("@userid", userid);
            SqlParameter idparam1 = new SqlParameter("@userid", userid);

            retcmd.Parameters.Add(idparam);
            retcount.Parameters.Add(idparam1);
            try
            {
                dbconnection.Open();

                countreader = retcount.ExecuteReader();
                countreader.Read();
                rowcount = countreader.GetInt32(0);
                countreader.Close();

                if (rowcount > 0)
                {
                    reviewarray = new ReviewVO[rowcount];
                    reader = retcmd.ExecuteReader();


                    while (reader.Read())
                    {
                        reviewarray[count] = new ReviewVO(reader["productId"].ToString(),
                                                    rowcount);
                        count++;
                    }

                    if (reviewarray.Length == 0)
                    {
                        reviewarray[0] = new ReviewVO("ERROR");
                    }

                }
                else
                {
                    reviewarray = new ReviewVO[1];
                    reviewarray[0] = new ReviewVO("ND");
                }
                dbconnection.Close();
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
                reviewarray = new ReviewVO[1];
                reviewarray[0] = new ReviewVO("ERROR");
            }
            return reviewarray;
        }

        public void updateUserRating(int usrrating, string pid, string logedinusr)
        {
            string query = "UPDATE [review] SET [rating] = @rating WHERE [productId] = @pid AND [userId] = @userid IF (@@ROWCOUNT = 0 ) INSERT INTO [review] ([productId], [userId], [rating]) VALUES (@pid,@userid,@rating)";
            SqlCommand updtdata = new SqlCommand(query, dbconnection);


            SqlParameter idparam = new SqlParameter("@rating", usrrating);
            SqlParameter idparam1 = new SqlParameter("@userid", logedinusr);
            SqlParameter idparam2 = new SqlParameter("@pid", pid);

            updtdata.Parameters.Add(idparam);
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

        public ReviewVO hasUsercommentedRated(string prodid, string logedinusr)
        {
            SqlCommand retcmd = new SqlCommand("select * from [review] where [userId] = @userid AND [productId] =@pid", dbconnection);

            SqlParameter idparam1 = new SqlParameter("@userid", logedinusr);
            SqlParameter idparam2 = new SqlParameter("@pid", prodid);


            retcmd.Parameters.Add(idparam1);
            retcmd.Parameters.Add(idparam2);

            try
            {
                dbconnection.Open();
                reader = retcmd.ExecuteReader();

                while (reader.Read())
                {
                    review = new ReviewVO(reader["productId"].ToString(),
                                          reader["userid"].ToString(),
                                          reader["comment"].ToString(),
                                          reader.GetInt32(reader.GetOrdinal("rating")),
                                          1);
                }
                if (review == null)
                {
                    review = new ReviewVO("ND");
                }
                dbconnection.Close();
            }

            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
                review = new ReviewVO("ERROR");
            }
            return review;
        }

        public double getProductRating(string pid)
        {
            SqlCommand retcmd = new SqlCommand("select avg(cast(rating as float)) from [review] where [productId] = @pid AND [rating] !=0", dbconnection);
            SqlParameter idparam = new SqlParameter("@pid", pid);
            double avgrating;

            retcmd.Parameters.Add(idparam);
            try
            {
                dbconnection.Open();
                reader = retcmd.ExecuteReader();

                while (reader.Read())
                {
                    avgrating = reader.GetDouble(0);
                    dbconnection.Close();
                    return avgrating;
                }
            }

            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();

            }
            return 0;
        }

        public void updateUserComment(string logedinusr, string prodid, string usrcomment)
        {
            string query = "UPDATE [review] SET [comment] = @comment WHERE [productId] = @pid AND [userId] = @userid IF (@@ROWCOUNT = 0 ) INSERT INTO [review] ([productId], [userId], [comment]) VALUES (@pid,@userid,@comment)";
            SqlCommand updtdata = new SqlCommand(query, dbconnection);


            SqlParameter idparam = new SqlParameter("@comment", usrcomment);
            SqlParameter idparam1 = new SqlParameter("@userid", logedinusr);
            SqlParameter idparam2 = new SqlParameter("@pid", prodid);

            updtdata.Parameters.Add(idparam);
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