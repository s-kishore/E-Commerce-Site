using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PurchaseDetailDAO
/// </summary>
public class PurchaseDetailDAO
{
    private SqlConnection dbconnection = new SqlConnection(ConfigurationManager.ConnectionStrings["azure"].ConnectionString);
    //private SqlConnection dbconnection = new SqlConnection(ConfigurationManager.ConnectionStrings["somee"].ConnectionString);
    //private SqlDataReader reader;

    public PurchaseDetailDAO()
    {
     
    }

    public void updatePurchaseDetailInfo(PurchaseDetailVO[] purchdtl,int newKey)
    {

        string query = "INSERT INTO [purchaseDetail] ([purchaseId],[productId],[quantity],[price]) VALUES ";
        int count = 0;
        foreach(PurchaseDetailVO curr in purchdtl)
        {
            if (count > 0)
                query = query + ",";
            count++;
            query = query + "(" + newKey + "," + curr.productId + "," + curr.quantity + "," + curr.price + ")";
        }

        query = query + ";";


        SqlCommand updtdata = new SqlCommand(query, dbconnection);
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