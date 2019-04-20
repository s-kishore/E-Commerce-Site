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
    public class ProductDAO
    {
        private SqlConnection dbconnection = new SqlConnection(ConfigurationManager.ConnectionStrings["azure"].ConnectionString);
        //private SqlConnection dbconnection = new SqlConnection(ConfigurationManager.ConnectionStrings["somee"].ConnectionString);
        private SqlDataReader reader;
        private SqlDataReader countreader;
        ProductVO retprod;
        int maxpid;
        public ProductDAO()
        {

        }

        public string createProduct(ProductVO product)
        {


            SqlCommand retcount = new SqlCommand("select max(productId) as count from [product]", dbconnection);

            try
            {
                dbconnection.Open();

                countreader = retcount.ExecuteReader();
                countreader.Read();
                maxpid = Convert.ToInt32(countreader["count"].ToString());
                maxpid = maxpid + 1;
                countreader.Close();

                
                SqlCommand insertRow = 
                    new SqlCommand("INSERT INTO [product] ([productId],[imgnm],[title],[category],[subCategory],[desc],[specs],[price],[condition],[sellerId],[quant],[sold],[avail]) VALUES (@pid,@pimgnm,@title,@category,@subcategory,@desc,@specs,@price,@condition,@sellerid,@quans,0,@avail)", dbconnection);

                SqlParameter idparam1 = new SqlParameter("@pid", maxpid);
                SqlParameter idparam2 = new SqlParameter("@pimgnm", product.imgnm);
                SqlParameter idparam3 = new SqlParameter("@category", product.category);
                SqlParameter idparam4 = new SqlParameter("@subcategory", product.subcategory);
                SqlParameter idparam5 = new SqlParameter("@desc", product.desc);
                SqlParameter idparam6 = new SqlParameter("@specs", product.specs);
                SqlParameter idparam7 = new SqlParameter("@price", product.price);
                SqlParameter idparam8 = new SqlParameter("@condition", product.condition);
                SqlParameter idparam9 = new SqlParameter("@sellerid", product.sellerid);
                SqlParameter idparam10 = new SqlParameter("@quans", product.quant);
                SqlParameter idparam11 = new SqlParameter("@avail", product.avail);
                SqlParameter idparam12 = new SqlParameter("@title", product.title);
                //SqlParameter idparam13 = new SqlParameter("@sold", 0);

                insertRow.Parameters.Add(idparam1);
                insertRow.Parameters.Add(idparam2);
                insertRow.Parameters.Add(idparam3);
                insertRow.Parameters.Add(idparam4);
                insertRow.Parameters.Add(idparam5);
                insertRow.Parameters.Add(idparam6);
                insertRow.Parameters.Add(idparam7);
                insertRow.Parameters.Add(idparam8);
                insertRow.Parameters.Add(idparam9);
                insertRow.Parameters.Add(idparam10);
                insertRow.Parameters.Add(idparam11);
                insertRow.Parameters.Add(idparam12);
                //insertRow.Parameters.Add(idparam13);

                insertRow.ExecuteNonQuery();
                dbconnection.Close();
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
                return "ERROR";
            }
            return maxpid.ToString();
        }
        public ArrayList getProdMinDetailsByUser(string userid)
        {
            SqlCommand retcmd = new SqlCommand("select [productId], [imgnm],[title] from [product] where [sellerId] =@userid", dbconnection);
            SqlParameter idparam = new SqlParameter("@userid", userid);
            ArrayList prodctList = null;

            retcmd.Parameters.Add(idparam);
            try
            {
                dbconnection.Open();
                reader = retcmd.ExecuteReader();


                prodctList = new ArrayList();
                while (reader.Read())
                {
                    retprod = new ProductVO(reader["productId"].ToString(),
                                            reader["imgnm"].ToString(),
                                                reader["title"].ToString(),
                                                1);
                    prodctList.Add(retprod);
                }
                if (prodctList.Count == 0)
                    prodctList = null;

                reader.Close();
                dbconnection.Close();
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
                prodctList = null;
            }
            return prodctList;
        }

        public ProductVO getProdMinDetails(string prodid)
        {
            SqlCommand retcmd = new SqlCommand("select [productId], [imgnm],[title] from [product] where [productId] =@prodid", dbconnection);
            SqlParameter idparam = new SqlParameter("@prodid", prodid);

            retcmd.Parameters.Add(idparam);
            try
            {
                dbconnection.Open();
                reader = retcmd.ExecuteReader();


                while (reader.Read())
                {
                    retprod = new ProductVO(reader["productId"].ToString(),
                                            reader["imgnm"].ToString(),
                                             reader["title"].ToString(),
                                             1);
                }
                if (retprod == null)
                    retprod = new ProductVO("ND");
                reader.Close();
                dbconnection.Close();

            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
                retprod = new ProductVO("ERROR");
            }
            return retprod;

        }
        public ProductVO getProductbyId(String prodid)
        {
            SqlCommand retcmd = new SqlCommand("select * from [product] where [productId] = @prodid", dbconnection);
            SqlParameter idparam = new SqlParameter("@prodid", prodid);

            retcmd.Parameters.Add(idparam);
            try
            {
                dbconnection.Open();
                reader = retcmd.ExecuteReader();

                while (reader.Read())
                {
                    retprod = new ProductVO(reader["productId"].ToString(),
                                             reader["title"].ToString(),
                                             reader["imgnm"].ToString(),
                                             reader["category"].ToString(),
                                             reader["subCategory"].ToString(),
                                             reader["desc"].ToString(),
                                             reader["specs"].ToString(),
                                             float.Parse(reader["price"].ToString()),
                                             reader["condition"].ToString(),
                                             reader["sellerId"].ToString(),
                                             reader.GetInt32(reader.GetOrdinal("quant")),
                                             reader.GetInt32(reader.GetOrdinal("sold")),
                                             reader["avail"].ToString(),
                                             1);
                }
                if (retprod == null)
                    retprod = new ProductVO("ND");

                reader.Close();
                dbconnection.Close();
            }

            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
                retprod = new ProductVO("ERROR");
            }
            return retprod;
        }

        public DataTable searchForProduct(string[] srchwords, string srchqry)
        {
            string querycond;
            DataTable prodlst = new DataTable();

            querycond = "[title] like \'%" + srchqry.Replace(' ', '%') + "%\' " + "OR [desc] like \'%" + srchqry.Replace(' ', '%') + "%\'";

            if (srchwords.Count() > 1)
            {
                foreach (var x in srchwords)
                {
                    string partq;
                    partq = " OR [title] like \'%" + x + "%\'" + "OR [desc] like \'%" + x + "%\'";
                    querycond = querycond + partq;
                }
            }
            SqlCommand retcmd = new SqlCommand("select [productId],[title],[imgnm],[category],[desc],[price] from [product] where " + querycond, dbconnection);
            try
            {
                dbconnection.Open();
                reader = retcmd.ExecuteReader();


                prodlst.Load(reader);
                dbconnection.Close();
                if (prodlst.Rows.Count == 0)
                    return null;
                else
                    return prodlst;

            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
                return null;
            }

        }

        public ArrayList getTopSellers()
        {
            SqlCommand retcmd = new SqlCommand("select top 10 [productId],[imgnm],[title] from [product] ORDER BY [sold] desc", dbconnection);
            ArrayList prodctList = new ArrayList();
            try
            {
                dbconnection.Open();
                reader = retcmd.ExecuteReader();

                while (reader.Read())
                {
                    retprod = new ProductVO(reader["productId"].ToString(),
                                            reader["imgnm"].ToString(),
                                             reader["title"].ToString(),
                                             10);
                    prodctList.Add(retprod);
                }

                if (prodctList.Count == 0)
                    prodctList.Add(new ProductVO("ND"));

                reader.Close();
                dbconnection.Close();
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
                prodctList.Add(new ProductVO("ERROR"));
            }
            return prodctList;
        }

        public ArrayList getNewProducts()
        {
            SqlCommand retcmd = new SqlCommand("select top 10 [productId],[imgnm],[title] from [product] ORDER BY [time] desc", dbconnection);
            ArrayList prodctList = new ArrayList();
            try
            {
                dbconnection.Open();
                reader = retcmd.ExecuteReader();

                while (reader.Read())
                {
                    retprod = new ProductVO(reader["productId"].ToString(),
                                            reader["imgnm"].ToString(),
                                             reader["title"].ToString(),
                                             10);
                    prodctList.Add(retprod);
                }
                if (prodctList.Count == 0)
                {
                    prodctList.Add(new ProductVO("ND"));
                }
                reader.Close();
                dbconnection.Close();
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
                prodctList.Add(new ProductVO("ERROR"));
            }
            return prodctList;
        }


        public DataTable searchForProductByCategory(string srchcategory)
        {
            string querycond;
            DataTable prodlst = new DataTable();

            querycond = "[category] like \'%" + srchcategory + "%\'";

            SqlCommand retcmd = new SqlCommand("select top 50 [productId],[title],[imgnm],[category],[desc],[price] from [product] where " + querycond, dbconnection);
            try
            {
                dbconnection.Open();
                reader = retcmd.ExecuteReader();


                prodlst.Load(reader);
                dbconnection.Close();

                if (prodlst.Rows.Count == 0)
                    return null;
                else
                    return prodlst;

            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
                return null;
            }
        }

        public DataTable searchForProductByCategoryAndKey(string[] srchkeywords, string srchquery, string srchcategory)
        {
            string querycond;
            DataTable prodlst = new DataTable();

            querycond = "[category] like \'%" + srchcategory + "%\' AND [title] like \'%" + srchquery.Replace(' ', '%') + "%\' " + "OR [desc] like \'%" + srchquery.Replace(' ', '%') + "%\'";

            if (srchkeywords.Count() > 1)
            {
                foreach (var x in srchkeywords)
                {
                    string partq;
                    partq = " OR [title] like \'%" + x + "%\'" + "OR [desc] like \'%" + x + "%\'";
                    querycond = querycond + partq;
                }
            }
            SqlCommand retcmd = new SqlCommand("select [productId],[title],[imgnm],[category],[desc],[price] from [product] where " + querycond, dbconnection);
            try
            {
                dbconnection.Open();
                reader = retcmd.ExecuteReader();

                prodlst.Load(reader);
                dbconnection.Close();
                return prodlst;
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                if (dbconnection.State != System.Data.ConnectionState.Closed)
                    dbconnection.Close();
                return null;
            }
        }

        public void updtSoldProducts(Dictionary<string, int> pcounts)
        {
            string[] prodIdArray = pcounts.Keys.ToArray();

            foreach (var x in prodIdArray)
            {
                int itemCount = pcounts[x];
                string query = "UPDATE [product] SET [sold] = [sold] + @count, [quant] = [quant] - @count WHERE [productId] = @pid";
                SqlCommand updtdata = new SqlCommand(query, dbconnection);

                SqlParameter idparam = new SqlParameter("@pid", x);
                SqlParameter idparam1 = new SqlParameter("@count", itemCount);

                updtdata.Parameters.Add(idparam);
                updtdata.Parameters.Add(idparam1);

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
}