using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Services;

namespace CODEMIG.Classes
{
    public class Empresa
    {

        public string GetEmpresa(string prefix)
        {
            String empresa = "";
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                        .ConnectionStrings["MyConnString"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "select COD_CLI, COD_PROCESSO_PK, RAZAO_SOCIAL, COD_EMPRESA_PK from PROCESSO, EMPRESA where " +
                    "COD_EMPRESA_FK = COD_EMPRESA_PK AND COD_CLI = @SearchText + '%'";
                    cmd.Parameters.AddWithValue("@SearchText", prefix);
                    cmd.Connection = conn;
                    conn.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            empresa = string.Format("{0}", sdr["COD_CLI"]);
                        }
                    }
                    conn.Close();
                }

                return empresa;
            }
        }


    }
}