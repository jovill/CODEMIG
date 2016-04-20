using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Submit(object sender, EventArgs e)
    {
        string customerName = Request.Form[txtSearch.UniqueID];
        string customerId = Request.Form[hfCustomerId.UniqueID];
    }
}
