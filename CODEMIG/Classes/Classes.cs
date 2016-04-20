using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CODEMIG.Classes
{
    public class Classes
    {
        public DataTable limpaData(DataTable dt)
        {
            for (int counter = dt.Columns.Count - 1; counter >= 0; counter--)
            {
                dt.Columns.RemoveAt(counter);
            }
            return dt;
        }



    }
}