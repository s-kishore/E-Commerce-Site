using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PurchaseDetailVO
/// </summary>
public class PurchaseDetailVO
{
    public int purchaseId=0;
    public int productId=0;
    public int quantity=0;
    public float price=0.00f;
    public string status="";
    public int count=0;
    public PurchaseDetailVO()
    {
       
    }

    public PurchaseDetailVO(int purchaseId, int productId, int quantity, float price, string status, int count)
    {
        this.purchaseId = purchaseId;
        this.productId = productId;
        this.price = price;
        this.status = status;
        this.quantity = quantity;
        this.count = count;
    }
    public PurchaseDetailVO(string status)
    {
        this.status = status;
    }
}