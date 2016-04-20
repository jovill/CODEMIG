using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Services;
using System.Data;
using System.Collections;
using System.Web.UI.WebControls;
using CODEMIG;
using CODEMIG.Classes;
using System.Web.Script.Serialization;

/// <summary>
/// Summary description for Service_CS
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Service : System.Web.Services.WebService
{
    CODEMIG.Classes.DbUtils.DbConn conexao = new CODEMIG.Classes.DbUtils.DbConn();
    SqlConnection conn = new SqlConnection();
    SqlCommand cmd = new SqlCommand();
    
    public Service()
    {
        
        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string[] GetUsuario(string prefix)
    {
        List<string> historicos = new List<string>();
        List<string> lotes = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {

            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                

                cmd.CommandText = "select DISTINCT COD_LOGIN_PK,USERNAME, EMAIL, NOME_COMPLETO, TIPOPERMISSAO, PROCESSO, HISTORICO, IMOVEL, CONTRATO, RECEBE_EMAIL, EMPRESAS from USUARIO " +
                "INNER JOIN PERMISSAO ON USUARIO.COD_LOGIN_PK = PERMISSAO.COD_LOGIN_FK ";

                //"select COD_CLI, COD_EMPRESA_PK, COD_ENDERECO_EMPRESA_PK, CEP, NOME, NUMERO, TIPO, COMPLEMENTO, MUN, UF, BAIRRO from ENDERECO_EMPRESA END, EMPRESA EMP, PROCESSO PRO where END.COD_EMPRESA_FK = COD_EMPRESA_PK AND COD_CLI LIKE @SearchText + '%' ;";

                cmd.Connection = conn;
                conn.Open();

                using (SqlDataReader sdr = cmd.ExecuteReader())
                {

                    while (sdr.Read())
                    {



                        historicos.Add(string.Format("{0}&&{1}&&{2}&&{3}&&{4}&&{5}", sdr["COD_LOGIN_PK"], sdr["USERNAME"], sdr["NOME_COMPLETO"], sdr["EMAIL"], sdr["TIPOPERMISSAO"], sdr["RECEBE_EMAIL"]));
                        lotes.Add(string.Format("{0}&&{1}&&{2}&&{3}", sdr["PROCESSO"], sdr["HISTORICO"], sdr["IMOVEL"], sdr["CONTRATO"], sdr["EMPRESAS"]));



                    }

                }


                conn.Close();
            }

            //return x;
            if (historicos.Count == 0)
            {
                historicos.Add("Zero()Zero");
            }

            String[] customers2 = historicos.ToArray();
            String[] lotes2 = lotes.ToArray();

            if (historicos[0] == "Zero()Zero")
            {
                return customers2;
            }


            String txt = "";
            String txtLotes = "";

            for (int x = 0; x < customers2.Length; x++)
            {
                if (x == 0)
                {
                    txt += customers2[x];
                }
                else
                {
                    txt += "," + customers2[x];


                }

            }
            for (int y = 0; y < lotes2.Length; y++)
            {
                if (y == 0)
                {
                    txtLotes += lotes2[y];

                }
                else
                {
                    txtLotes += "," + lotes2[y];

                }
            }
            String[] customers3 = new String[1];
            customers3[0] = txt + "()" + txtLotes;
            return customers3;

        }
    }

    /**
     * 
     * WebServices para página processo.aspx
     * 
     */
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetProps(string prefix)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("select DISTINCT NOME, CPF, COD_EMPRESA_PK, COD_PROPRIETARIO_PK from PROPRIETARIO, EMPRESA, EMPRESA_PROPRIETARIO  where " +
                    "CNPJ = @SearchText AND COD_PROPRIETARIO_PK = EMPRESA_PROPRIETARIO.COD_PROPRIETARIO_FK AND COD_EMPRESA_PK = EMPRESA_PROPRIETARIO.COD_EMPRESA_FK", conn))
            {
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetProcessoGrid(string codempresa)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("SELECT COD_CLI, COD_PROCESSO_PK FROM PROCESSO " +
                "INNER JOIN EMPRESA ON COD_EMPRESA_PK = PROCESSO.COD_EMPRESA_FK " +
                "WHERE COD_EMPRESA_FK = @codempresa " +
                "ORDER BY COD_CLI", conn))
            {
                cmd.Parameters.AddWithValue("@codempresa", codempresa);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetPastasGrid(string imovelPK)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("SELECT COD_PASTA_CODEMIG, COD_PASTA_PK FROM PASTA " +
                "INNER JOIN PASTA_IMOVEL ON COD_PASTA_PK = PASTA_IMOVEL.COD_PASTA_FK " +
                "INNER JOIN IMOVEL ON COD_IMOVEL_PK = COD_IMOVEL_FK WHERE COD_IMOVEL_PK = @imovelPK " +
                "ORDER BY COD_PASTA_CODEMIG", conn))
            {
                cmd.Parameters.AddWithValue("@imovelPK", imovelPK);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetDadosCartoriais(string imovelPK)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("SELECT * FROM MATRICULA WHERE COD_IMOVEL_FK = @imovelPK", conn))
            {
                cmd.Parameters.AddWithValue("@imovelPK", imovelPK);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetTributos(string imovelPK)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("SELECT * FROM TRIBUTO WHERE COD_IMOVEL_FK = @imovelPK", conn))
            {
                cmd.Parameters.AddWithValue("@imovelPK", imovelPK);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetContratosGrid(string imovelPK)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("SELECT * FROM CONTRATO " +
                "INNER JOIN CONTRATO_IMOVEL ON COD_CONTRATO_PK = CONTRATO_IMOVEL.COD_CONTRATO_FK " +
                "INNER JOIN IMOVEL ON COD_IMOVEL_PK = CONTRATO_IMOVEL.COD_IMOVEL_FK WHERE COD_IMOVEL_PK = @imovelPK " +
                "ORDER BY COD_CONTRATO_PK", conn))
            {
                cmd.Parameters.AddWithValue("@imovelPK", imovelPK);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                string x;
                x = serializer.Serialize(rows);
                return serializer.Serialize(rows);

            }

        }
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetContratos(string prefix)
    {

        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("SELECT NUM_CONTRATO, COD_CONTRATO_PK FROM CONTRATO WHERE NUM_CONTRATO LIKE @SearchText + '%'" +
                "ORDER BY NUM_CONTRATO", conn))

            {
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int cadastraContrato(int contratoPK, int imovelPK)
    {

        try
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                        .ConnectionStrings["MyConnString"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    int codContratoImovelPK = 0;
                    try
                    {

                        codContratoImovelPK = conexao.insertReturn(
                        "Declare @count int " +
                        "Declare @existe int " +
                        "SELECT @count = COUNT(*) FROM CONTRATO_IMOVEL " +
                        "SELECT @existe = COUNT(*) FROM CONTRATO_IMOVEL WHERE COD_CONTRATO_FK = " + contratoPK + " AND COD_IMOVEL_FK = " + imovelPK + " " +
                        "IF(@existe = 0) " +
                        "BEGIN " +
                            "IF(@count > 0) " +
                            "BEGIN " +
                            "INSERT INTO CONTRATO_IMOVEL([COD_CONTRATO_IMOVEL],[COD_CONTRATO_FK], [COD_IMOVEL_FK]) OUTPUT Inserted.COD_CONTRATO_IMOVEL VALUES( ((SELECT TOP 1 COD_CONTRATO_IMOVEL FROM CONTRATO_IMOVEL ORDER BY COD_CONTRATO_IMOVEL DESC) + 1) ," + contratoPK + ", " + imovelPK + ") " +
                            "END " +
                            "ELSE " +
                            "BEGIN " +
                            "INSERT INTO CONTRATO_IMOVEL([COD_CONTRATO_IMOVEL],[COD_CONTRATO_FK], [COD_IMOVEL_FK]) OUTPUT Inserted.COD_CONTRATO_IMOVEL VALUES( 1, " + contratoPK + ", " + imovelPK + ") " +
                            "END " +
                        "END", "COD_CONTRATO_IMOVEL"
                        );
                    }
                    catch (Exception exception)
                    {
                        return 0;
                    }
                    return codContratoImovelPK;

                }

            }
        }

        catch (Exception e)
        {
            HttpContext.Current.Response.Write("<script>alert('" + e.Message + "')</script>");
            return 0;
        }

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int deleteProcesso(string PROCESSOPK)
    {
        int rowsAffected = 0;
        try
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "DELETE FROM PROCESSO_LOTE WHERE COD_PROCESSO_FK = @PROCESSOPK " +
                    "DELETE FROM VOLUME WHERE COD_PROCESSO_FK = @PROCESSOPK " +
                    "DELETE FROM PROCESSO WHERE COD_PROCESSO_PK = @PROCESSOPK ";
                   
                    cmd.Parameters.AddWithValue("@PROCESSOPK", PROCESSOPK);
                  
                    cmd.Connection = conn;
                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();

                    conn.Close();
                }
                return rowsAffected;
            }
        }
        catch (Exception e)
        {
            HttpContext.Current.Response.Write("<script>alert('" + e.Message + "')</script>");
            return 0;
        }

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int removeProcesso(int PROCESSOPK)
    {
        int rowsAffected = 0;
        try
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "UPDATE PROCESSO SET COD_EMPRESA_FK=NULL WHERE COD_PROCESSO_PK = @PROCESSOPK";
                    cmd.Parameters.AddWithValue("@PROCESSOPK", PROCESSOPK);

                    cmd.Connection = conn;
                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();

                    conn.Close();
                }
                return rowsAffected;
            }
        }
        catch (Exception e)
        {
            HttpContext.Current.Response.Write("<script>alert('" + e.Message + "')</script>");
            return 0;
        }

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int removeProp(int propPK, int empresaPK)
    {
        int rowsAffected = 0;
        try
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "DELETE FROM EMPRESA_PROPRIETARIO WHERE COD_PROPRIETARIO_FK = @propPK AND COD_EMPRESA_FK = @empresaPK";
                    cmd.Parameters.AddWithValue("@propPK", propPK);
                    cmd.Parameters.AddWithValue("@empresaPK", empresaPK);
                    cmd.Connection = conn;
                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();

                    conn.Close();
                }
                return rowsAffected;
            }
        }
        catch (Exception e)
        {
            HttpContext.Current.Response.Write("<script>alert('" + e.Message + "')</script>");
            return 0;
        }

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetVolumes(string codProcessoCLI)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {

            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;


            using (SqlCommand cmd = new SqlCommand("select COD_VOLUME_CODEMIG, COD_VOLUME_PK, COD_CLI, COD_PROCESSO_PK, RAZAO_SOCIAL, CNPJ from PROCESSO, VOLUME, EMPRESA  where " +
                "COD_PROCESSO_FK = COD_PROCESSO_PK AND COD_EMPRESA_FK = COD_EMPRESA_PK AND COD_CLI = @codProcessoCLI ORDER BY RIGHT(COD_VOLUME_CODEMIG,3) ", conn))
            {
                cmd.Parameters.AddWithValue("@codProcessoCLI", codProcessoCLI);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int removeVolume(string volumePK)
    {
        int rowsAffected = 0;
        try
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "DELETE  FROM VOLUME WHERE COD_VOLUME_PK= @volumePK";
                    cmd.Parameters.AddWithValue("@volumePK", volumePK);
                    cmd.Connection = conn;
                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();

                    conn.Close();
                }
                return rowsAffected;
            }
        }
        catch (Exception e)
        {
            HttpContext.Current.Response.Write("<script>alert('" + e.Message + "')</script>");
            return 0;
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int removePastaImovel(int pastaPK, int imovelPK)
    {
        int rowsAffected = 0;
        
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            SqlCommand cmd1 = new SqlCommand();
            //SqlCommand cmd2 = new SqlCommand();

            cmd1.CommandText = "DELETE FROM PASTA_IMOVEL WHERE COD_PASTA_FK = @pastaPK AND COD_IMOVEL_FK = @imovelPK";
            cmd1.Parameters.AddWithValue("@pastaPK", pastaPK);
            cmd1.Parameters.AddWithValue("@imovelPK", imovelPK);
            cmd1.Connection = conn;

            /*cmd2.CommandText = "DELETE FROM PASTA WHERE COD_PASTA_PK = @pastaPK";
            cmd2.Parameters.AddWithValue("@pastaPK", pastaPK);
            cmd2.Connection = conn;*/

            conn.Open();

            SqlTransaction trx = conn.BeginTransaction();
            cmd1.Transaction = trx;
            //cmd2.Transaction = trx;
            try
            {
                rowsAffected = cmd1.ExecuteNonQuery();

                trx.Commit();
                    
            }
            catch (SqlException ex)
            {
                trx.Rollback();
            }
            finally
            {
                //clean up resources
                conn.Close();
            }
                
            return rowsAffected;
        }
        
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int removeContratoImovel(int contratoPK, int imovelPK)
    {
        int rowsAffected = 0;

        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            SqlCommand cmd1 = new SqlCommand();
            //SqlCommand cmd2 = new SqlCommand();

            cmd1.CommandText = "DELETE FROM CONTRATO_IMOVEL WHERE COD_CONTRATO_FK = @contratoPK AND COD_IMOVEL_FK = @imovelPK";
            cmd1.Parameters.AddWithValue("@contratoPK", contratoPK);
            cmd1.Parameters.AddWithValue("@imovelPK", imovelPK);
            cmd1.Connection = conn;

            /*cmd2.CommandText = "DELETE FROM PASTA WHERE COD_PASTA_PK = @pastaPK";
            cmd2.Parameters.AddWithValue("@pastaPK", pastaPK);
            cmd2.Connection = conn;*/

            conn.Open();

            SqlTransaction trx = conn.BeginTransaction();
            cmd1.Transaction = trx;
            //cmd2.Transaction = trx;
            try
            {
                rowsAffected = cmd1.ExecuteNonQuery();

                trx.Commit();

            }
            catch (SqlException ex)
            {
                trx.Rollback();
            }
            finally
            {
                //clean up resources
                conn.Close();
            }

            return rowsAffected;
        }

    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int removeDCartoriaisImovel(int dCartoriaisPK)
    {
        int rowsAffected = 0;

        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "DELETE FROM MATRICULA WHERE COD_MATRICULA_PK = @dCartoriaisPK";
            cmd.Parameters.AddWithValue("@dCartoriaisPK", dCartoriaisPK);
            cmd.Connection = conn;

            conn.Open();

            try
            {
                rowsAffected = cmd.ExecuteNonQuery();

            }
            catch (SqlException ex)
            {
                HttpContext.Current.Response.Write("<script>alert('" + ex.Message + "')</script>");
                return 0;
            }
            finally
            {
                conn.Close();
            }

            return rowsAffected;
        }

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int removeTributosImovel(int tributoPK)
    {
        int rowsAffected = 0;

        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "DELETE FROM TRIBUTO WHERE COD_TRIBUTO_PK = @tributoPK";
            cmd.Parameters.AddWithValue("@tributoPK", tributoPK);
            cmd.Connection = conn;

            conn.Open();

            try
            {
                rowsAffected = cmd.ExecuteNonQuery();

            }
            catch (SqlException ex)
            {
                HttpContext.Current.Response.Write("<script>alert('" + ex.Message + "')</script>");
                return 0;
            }
            finally
            {
                conn.Close();
            }

            return rowsAffected;
        }

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetProcessosGeral(string texto)
    {

        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("SELECT DISTINCT   COD_PROCESSO_PK, COD_CLI,COD_EMPRESA_FK, COD_DI FROM PROCESSO " +
               " LEFT OUTER JOIN PROCESSO_LOTE "+
               " ON PROCESSO.COD_PROCESSO_PK=PROCESSO_LOTE.COD_PROCESSO_FK "+
               " LEFT OUTER JOIN LOTE "+
               " ON PROCESSO_LOTE.COD_LOTE_FK=COD_LOTE_PK "+
               " LEFT OUTER JOIN QUADRA "+
               " ON LOTE.COD_QUADRA_FK=QUADRA.COD_QUADRA_PK "+
               " LEFT OUTER JOIN DISTRITO "+
               " ON QUADRA.COD_DISTRITO_FK=DISTRITO.COD_DISTRITO_PK "+
                "WHERE COD_CLI LIKE @texto + '%' " +
                "ORDER BY COD_CLI,COD_PROCESSO_PK,COD_EMPRESA_FK,COD_DI", conn))
            {

                cmd.Parameters.AddWithValue("@texto", texto);
               

                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetProcessos(string texto, string distritoCODEMIG)
    {

        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("SELECT TOP 99 COD_CLI, COD_DI, COD_PROCESSO_PK, RAZAO_SOCIAL, CNPJ, COD_EMPRESA_PK, EMAIL, TELEFONE, TIPO_MONETARIO, FATURAMENTO_ANUAL, NUM_FUNC, NUM_EMPREG_GERADOS, ATIVIDADE FROM PROCESSO INNER JOIN PROCESSO_LOTE " +
                "ON PROCESSO.COD_PROCESSO_PK=PROCESSO_LOTE.COD_PROCESSO_FK " +
                "INNER JOIN LOTE " +
                "ON LOTE.COD_LOTE_PK=PROCESSO_LOTE.COD_LOTE_FK " +
                "INNER JOIN EMPRESA " +
                "ON EMPRESA.COD_EMPRESA_PK=PROCESSO.COD_EMPRESA_FK " +
                "INNER JOIN QUADRA " +
                "ON QUADRA.COD_QUADRA_PK=LOTE.COD_QUADRA_FK " +
                "INNER JOIN DISTRITO " +
                "ON DISTRITO.COD_DISTRITO_PK=QUADRA.COD_DISTRITO_FK " +
                "WHERE COD_DI = @distritoCODEMIG AND COD_CLI LIKE @texto + '%' " +
                "GROUP BY COD_CLI, COD_DI, COD_PROCESSO_PK, RAZAO_SOCIAL, CNPJ, COD_EMPRESA_PK, EMAIL, TELEFONE, TIPO_MONETARIO, FATURAMENTO_ANUAL, NUM_FUNC, NUM_EMPREG_GERADOS, ATIVIDADE ORDER BY RIGHT(COD_CLI,5)", conn))
            {

                cmd.Parameters.AddWithValue("@texto", texto);
                cmd.Parameters.AddWithValue("@distritoCODEMIG", distritoCODEMIG);

                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetProcessosAD(string texto)
    {

        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("SELECT TOP 99 COD_CLI, COD_PROCESSO_PK, RAZAO_SOCIAL, CNPJ, COD_EMPRESA_PK, EMAIL, TELEFONE, TIPO_MONETARIO, FATURAMENTO_ANUAL, NUM_FUNC, NUM_EMPREG_GERADOS, ATIVIDADE FROM PROCESSO "+
                " INNER JOIN EMPRESA  ON EMPRESA.COD_EMPRESA_PK=PROCESSO.COD_EMPRESA_FK " +                
                "WHERE COD_CLI LIKE @texto + '%' " +
                "GROUP BY COD_CLI, COD_PROCESSO_PK, RAZAO_SOCIAL, CNPJ, COD_EMPRESA_PK, EMAIL, TELEFONE, TIPO_MONETARIO, FATURAMENTO_ANUAL, NUM_FUNC, NUM_EMPREG_GERADOS, ATIVIDADE ORDER BY RIGHT(COD_CLI,5)", conn))
            {

                cmd.Parameters.AddWithValue("@texto", texto);
                

                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetDadosEmpresa(string empresaPK)
    {

        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("select distinct EMPRESA.*, ENDERECO_EMPRESA.* from EMPRESA LEFT OUTER JOIN ENDERECO_EMPRESA ON ENDERECO_EMPRESA.COD_EMPRESA_FK = COD_EMPRESA_PK WHERE COD_EMPRESA_PK = @empresaPK", conn))
            {
                cmd.Parameters.AddWithValue("@empresaPK", empresaPK);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);
            }
        }

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetCidades(string prefix, string UF)
    {

        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("select  id_cidade, tb_cidades.nome from tb_cidades where " +
                "tb_cidades.uf = @estado AND  tb_cidades.nome LIKE @SearchText + '%'", conn))
            {
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Parameters.AddWithValue("@estado", UF);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);
            }
        }
    }
    /**
     * 
     * WebServices para página processo.aspx --------------------- FIM
     * 
     */


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int CadEnd(string prefix)
    {
        string[] prefix1 = prefix.Split('$');
        //prefix = prefix.Replace(" ", "");

        try
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                        .ConnectionStrings["MyConnString"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    int IDENDERECO = 0;
                    DataTable dt = new DataTable();
                    dt.Clear();
                    dt = conexao.SELECT("SELECT TOP 1 COD_END_IMOVEL_PK FROM ENDERECO_IMOVEL ORDER BY COD_END_IMOVEL_PK DESC");
                    if (dt.Rows.Count > 0)
                    {
                        IDENDERECO = (int)dt.Rows[0]["COD_END_IMOVEL_PK"] + 1;
                    }
                    else
                    {
                        IDENDERECO = 1;
                    }


                    cmd.CommandText = "INSERT INTO ENDERECO_IMOVEL([COD_END_IMOVEL_PK],[COD_IMOVEL_FK],[TIPO_LOGRADOURO],[NOME_LOGRADOURO],[CEP],[SHAPE],[BAIRRO],[CIDADE],[ESTADO],[COMPLEMENTO],[NUMERO],[PRECISAO],[TYPES]) VALUES(" + IDENDERECO + ",@CODIMOVELFK,@TIPO,@NOME,@CEP,geometry::STGeomFromText('POINT('+convert(varchar(20),@LONG)+' '+convert(varchar(20),@LAT)+')',4674),@BAIRRO,@CIDADE,@ESTADO,@COMPLEMENTO,@NUMERO,@PRECISAO,@TYPES)";
                    //"select COD_CLI, COD_EMPRESA_PK, COD_ENDERECO_EMPRESA_PK, CEP, NOME, NUMERO, TIPO, COMPLEMENTO, MUN, UF, BAIRRO from ENDERECO_EMPRESA END, EMPRESA EMP, PROCESSO PRO where END.COD_EMPRESA_FK = COD_EMPRESA_PK AND COD_CLI LIKE @SearchText + '%' ;";
                    cmd.Parameters.AddWithValue("@TIPO", prefix1[0]);
                    cmd.Parameters.AddWithValue("@NOME", prefix1[1]);
                    cmd.Parameters.AddWithValue("@CEP", prefix1[2]);
                    cmd.Parameters.AddWithValue("@LAT", prefix1[3]);
                    cmd.Parameters.AddWithValue("@LONG", prefix1[4]);
                    cmd.Parameters.AddWithValue("@CODIMOVELFK", prefix1[5]);
                    cmd.Parameters.AddWithValue("@BAIRRO", prefix1[6]);
                    cmd.Parameters.AddWithValue("@CIDADE", prefix1[7]);
                    cmd.Parameters.AddWithValue("@ESTADO", prefix1[8]);
                    cmd.Parameters.AddWithValue("@COMPLEMENTO", prefix1[9]);
                    cmd.Parameters.AddWithValue("@NUMERO", prefix1[10]);
                    cmd.Parameters.AddWithValue("@PRECISAO", prefix1[11]);
                    cmd.Parameters.AddWithValue("@TYPES", prefix1[12]);
                    cmd.Connection = conn;
                    conn.Open();
                    cmd.ExecuteNonQuery();

                    conn.Close();
                }
                return 1;
            }
        }

        catch (Exception e)
        {
            HttpContext.Current.Response.Write("<script>alert('" + e.Message + "')</script>");
            return 0;
        }
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int cadastraPasta(int pastaPK, int imovelPK)
    {
        
        try
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                        .ConnectionStrings["MyConnString"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    int codPastaImovelPK = 0;
                    try
                    {
                        
                        codPastaImovelPK = conexao.insertReturn(
                        "Declare @count int " +
                        "Declare @existe int " +
                        "SELECT @count = COUNT(*) FROM PASTA_IMOVEL " +
                        "SELECT @existe = COUNT(*) FROM PASTA_IMOVEL WHERE COD_PASTA_FK = " + pastaPK + " AND COD_IMOVEL_FK = " + imovelPK + " " +
                        "IF(@existe = 0) " +
                        "BEGIN " +
                            "IF(@count > 0) " +
                            "BEGIN " +
                            "INSERT INTO PASTA_IMOVEL([COD_PASTA_IMOVEL_PK],[COD_PASTA_FK], [COD_IMOVEL_FK]) OUTPUT Inserted.COD_PASTA_IMOVEL_PK VALUES( ((SELECT TOP 1 COD_PASTA_IMOVEL_PK FROM PASTA_IMOVEL ORDER BY COD_PASTA_IMOVEL_PK DESC) + 1) ," + pastaPK + ", " + imovelPK + ") " +
                            "END " +
                            "ELSE " +
                            "BEGIN " +
                            "INSERT INTO PASTA_IMOVEL([COD_PASTA_IMOVEL_PK],[COD_PASTA_FK], [COD_IMOVEL_FK]) OUTPUT Inserted.COD_PASTA_IMOVEL_PK VALUES(1," + pastaPK + ", " + imovelPK + ") " +
                            "END " +
                        "END", "COD_PASTA_IMOVEL_PK"
                        );
                    }
                    catch (Exception exception)
                    {
                        
                        return 0;
                    }
                    return codPastaImovelPK;

                }
                
            }
        }

        catch (Exception e)
        {
            HttpContext.Current.Response.Write("<script>alert('" + e.Message + "')</script>");
            return 0;
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int getContratoImovel(string prefix)
    {

        string numero = prefix.Split('|')[0];
        string objeto = prefix.Split('|')[1];
        int pk = 0;
        try
        {

            ArrayList list = new ArrayList();
            String strConnString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;
            String strQuery = "select COD_CONTRATO_PK from CONTRATO where OBJETO=@objeto AND NUM_CONTRATO=@numero;";
            using (SqlConnection con = new SqlConnection(strConnString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@numero", numero);
                    cmd.Parameters.AddWithValue("@objeto", objeto);
                    cmd.CommandText = strQuery;
                    cmd.Connection = con;
                    con.Open();
                    SqlDataReader sdr = cmd.ExecuteReader();
                    if (sdr.Read())
                    {
                        pk = Convert.ToInt32(sdr["COD_CONTRATO_PK"]);   
                    }
                    con.Close();
                    return pk;
                }
            }

        }

        catch (Exception e)
        {
            HttpContext.Current.Response.Write("<script>alert('" + e.Message + "')</script>");

            return 0;


        }

    }
	[WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int removeHistorico(string prefix)
    {
        //string[] prefix1 = prefix.Split('$');

        try
        {
            using (SqlConnection conn = new SqlConnection())
            {

                conn.ConnectionString = ConfigurationManager
                        .ConnectionStrings["MyConnString"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {


                    cmd.CommandText = "DELETE  FROM HISTORICO WHERE COD_HISTORICO_PK = @HISTORICO";
                    //"select COD_CLI, COD_EMPRESA_PK, COD_ENDERECO_EMPRESA_PK, CEP, NOME, NUMERO, TIPO, COMPLEMENTO, MUN, UF, BAIRRO from ENDERECO_EMPRESA END, EMPRESA EMP, PROCESSO PRO where END.COD_EMPRESA_FK = COD_EMPRESA_PK AND COD_CLI LIKE @SearchText + '%' ;";
                    cmd.Parameters.AddWithValue("@HISTORICO", prefix);
                    cmd.Connection = conn;
                    conn.Open();
                    cmd.ExecuteNonQuery();


                    cmd.CommandText = "DELETE FROM HISTORICO_LOTE WHERE COD_HISTORICO_FK = @HISTORICO2";
                    cmd.Parameters.AddWithValue("@HISTORICO2", prefix);
                    cmd.ExecuteNonQuery();




                    conn.Close();

                }
                return 1;



            }



        }

        catch (Exception e)
        {
            HttpContext.Current.Response.Write("<script>alert('" + e.Message + "')</script>");

            return 0;


        }

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int removeContrato(string prefix)
    {
        
        try
        {
            using (SqlConnection conn = new SqlConnection())
            {

                conn.ConnectionString = ConfigurationManager
                        .ConnectionStrings["MyConnString"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    
                    cmd.CommandText = "DELETE  FROM CONTRATO_VT WHERE COD_CONTRATO_VT_PK = @CONTRATO";
                    cmd.Parameters.AddWithValue("@CONTRATO", prefix);
                    cmd.Connection = conn;
                    conn.Open();
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "DELETE FROM CONTRATO_LOTE WHERE COD_CONTRATO_FK = @CONTRATO2";
                    cmd.Parameters.AddWithValue("@CONTRATO2", prefix);
                    cmd.ExecuteNonQuery();

                    conn.Close();
                    
                }
                return 1;
            }

        }

        catch (Exception e)
        {
            HttpContext.Current.Response.Write("<script>alert('Erro')</script>");
            return 0;
        }

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int SetHora(string prefix)
    {
        string[] prefix1 = prefix.Split('$');
        DataTable da = new DataTable();
        try
        {
            using (SqlConnection conn = new SqlConnection())
            {

                conn.ConnectionString = ConfigurationManager
                        .ConnectionStrings["MyConnString"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    da.Clear();
                    String SAIDA = DateTime.Now.ToString();
                    String ENTRADA = prefix1[1].ToString();
                    TimeSpan resultado = Convert.ToDateTime(SAIDA).Subtract(Convert.ToDateTime(ENTRADA));
                    double CONECTADO = Convert.ToInt32(resultado.TotalSeconds);
                    double TESTECONECTADO = CONECTADO;
                    double ATIVIDADE = Convert.ToInt32(prefix1[0]);
                    if(ATIVIDADE>CONECTADO)
                    {
                        CONECTADO = ATIVIDADE;
                    }
                    double APROVEITAMENTO = (ATIVIDADE * 100) / CONECTADO;
                    string[] horaconectado = ((CONECTADO / 60) / 60).ToString().Split(',');
                    string[] minutoconectado = ((CONECTADO / 60) % 60).ToString().Split(',');
                    string[] horaatividade = ((ATIVIDADE / 60) / 60).ToString().Split(',');
                    string[] minutoatividade = ((ATIVIDADE / 60) % 60).ToString().Split(','); 
                    string setCONECTADO = "" + horaconectado[0] + ":" + minutoconectado[0] + ":" + Convert.ToInt32(CONECTADO % 60);
                    string setATIVIDADE = "" + horaatividade[0] + ":" + minutoatividade[0] + ":" + Convert.ToInt32(ATIVIDADE % 60);

                    if (TESTECONECTADO >=5)
                    {
                        cmd.CommandText = "SELECT COD_CONTROLE_PK FROM CONTROLE_USUARIO ORDER BY COD_CONTROLE_PK";
                        conn.Open();
                        SqlDataAdapter sdr = new SqlDataAdapter(cmd.CommandText,conn);
                       
                            sdr.Fill(da);
                        int IDCONTROLE=0;
                        if(da.Rows.Count>0)
                        {
                            
                                IDCONTROLE = (int)da.Rows[da.Rows.Count-1]["COD_CONTROLE_PK"];                           
                                IDCONTROLE++;
                        }
                        else
                        {
                            IDCONTROLE = 1;
                        }
                        String[] datahora = ENTRADA.Split(' ');
                        String[] data = datahora[0].Split('/');
                        String novadataENTRADA = data[2] + "-" + data[1] + "-" + data[0] +" "+datahora[1];
                        datahora = SAIDA.Split(' ');
                        data = datahora[0].Split('/');
                        String novadataSAIDA = data[2] + "-" + data[1] + "-" + data[0] + " " + datahora[1];
                        conn.Close();

                        cmd.CommandText = "INSERT INTO CONTROLE_USUARIO([COD_CONTROLE_PK],[COD_LOGIN_FK],[DATAHORA_ENTRADA],[DATAHORA_SAIDA],[HORA_ATIVIDADE],[HORA_CONECTADO],[APROVEITAMENTO]) VALUES(@CONTROLE,@IDUSER,@ENTRADA,@SAIDA,@ATIVIDADE,@CONECTIVIDADE,@APROVEITAMENTO)";
                        //"select COD_CLI, COD_EMPRESA_PK, COD_ENDERECO_EMPRESA_PK, CEP, NOME, NUMERO, TIPO, COMPLEMENTO, MUN, UF, BAIRRO from ENDERECO_EMPRESA END, EMPRESA EMP, PROCESSO PRO where END.COD_EMPRESA_FK = COD_EMPRESA_PK AND COD_CLI LIKE @SearchText + '%' ;";
                        cmd.Parameters.AddWithValue("@ENTRADA", novadataENTRADA);
                        cmd.Parameters.AddWithValue("@SAIDA", novadataSAIDA);
                        cmd.Parameters.AddWithValue("@ATIVIDADE", setATIVIDADE);
                        cmd.Parameters.AddWithValue("@CONECTIVIDADE", setCONECTADO);
                        cmd.Parameters.AddWithValue("@APROVEITAMENTO", Convert.ToInt32(APROVEITAMENTO));
                        cmd.Parameters.AddWithValue("@IDUSER", prefix1[2]);
                        cmd.Parameters.AddWithValue("@CONTROLE", IDCONTROLE);
                        cmd.Connection = conn;
                        conn.Open();
                        cmd.ExecuteNonQuery();




                        conn.Close();
                       
                    }
                    
                    return 1;



                }



            }
        }
        catch (Exception e)
        {
            HttpContext.Current.Response.Write("<script>alert('" + e.Message + "')</script>");

            return 0;


        }

    }


	[WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string PopulateVolumes(string prefix)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {

            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;


            using (SqlCommand cmd = new SqlCommand("select COD_VOLUME_PK, COD_VOLUME_CODEMIG from VOLUME inner join PROCESSO on PROCESSO.COD_PROCESSO_PK=VOLUME.COD_PROCESSO_FK where COD_CLI=@COD ORDER BY RIGHT(COD_VOLUME_CODEMIG,3);", conn))
            {
                cmd.Parameters.AddWithValue("@COD", prefix);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public ArrayList PopulateQuadras(string prefix)
    {
        ArrayList list = new ArrayList();
        String strConnString = ConfigurationManager
            .ConnectionStrings["MyConnString"].ConnectionString;
        String strQuery = "select COD_VOLUME_PK, COD_VOLUME_CODEMIG from VOLUME inner join PROCESSO on PROCESSO.COD_PROCESSO_PK=VOLUME.COD_PROCESSO_FK where COD_CLI=@COD ORDER BY RIGHT(COD_VOLUME_CODEMIG,3);";
        using (SqlConnection con = new SqlConnection(strConnString))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@COD", prefix);
                cmd.CommandText = strQuery;
                cmd.Connection = con;
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    list.Add(new ListItem(
                   sdr["COD_VOLUME_CODEMIG"].ToString(),
                   sdr["COD_VOLUME_PK"].ToString()
                    ));
                }
                con.Close();
                return list;
            }
        }
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetLotesProcesso(string prefix)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("select COD_LOTE_FK,COD_DI from PROCESSO_LOTE inner join LOTE on LOTE.COD_LOTE_PK=PROCESSO_LOTE.COD_LOTE_FK  " +
                    " INNER JOIN QUADRA ON QUADRA.COD_QUADRA_PK=LOTE.COD_QUADRA_FK"+
                    " INNER JOIN DISTRITO ON DISTRITO.COD_DISTRITO_PK=QUADRA.COD_DISTRITO_FK "+
                    " where COD_PROCESSO_FK = @SearchText", conn))
            {
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetLotesHistorico(string prefix)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("select COD_LOTE_FK from HISTORICO_LOTE  where " +
                    "COD_HISTORICO_FK = @SearchText", conn))
            {
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string PopulateLotesDistrito(string distrito)
    {

        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("SELECT COD_LOTE_CODEMIG, COD_LOTE_PK FROM LOTE "  +
                "INNER JOIN QUADRA " +
                "ON QUADRA.COD_QUADRA_PK=LOTE.COD_QUADRA_FK " +
                "INNER JOIN DISTRITO " +
                "ON DISTRITO.COD_DISTRITO_PK=QUADRA.COD_DISTRITO_FK " +
                "WHERE COD_DI = @distrito ORDER BY RIGHT(COD_LOTE_CODEMIG,4)", conn))
            {
                
                cmd.Parameters.AddWithValue("@distrito", distrito);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string PopulateLotesEmpresas(string codempresa,string distrito)
    {

        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("SELECT COD_LOTE_CODEMIG, COD_LOTE_PK FROM PROCESSO INNER JOIN PROCESSO_LOTE " +
                "ON PROCESSO.COD_PROCESSO_PK=PROCESSO_LOTE.COD_PROCESSO_FK " +
                "INNER JOIN LOTE " +
                "ON LOTE.COD_LOTE_PK=PROCESSO_LOTE.COD_LOTE_FK " +
                "INNER JOIN EMPRESA " +
                "ON EMPRESA.COD_EMPRESA_PK=PROCESSO.COD_EMPRESA_FK " +
                "INNER JOIN QUADRA " +
                "ON QUADRA.COD_QUADRA_PK=LOTE.COD_QUADRA_FK " +
                "INNER JOIN DISTRITO " +
                "ON DISTRITO.COD_DISTRITO_PK=QUADRA.COD_DISTRITO_FK " +
                "WHERE COD_DI = @distrito AND COD_EMPRESA_PK= @codempresa ORDER BY RIGHT(COD_LOTE_CODEMIG,4)", conn))
            {
                
                cmd.Parameters.AddWithValue("@distrito", distrito);
                cmd.Parameters.AddWithValue("@codempresa", codempresa);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }

    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string PopulateLotes(string processo, string distrito)
    {

        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("SELECT COD_LOTE_CODEMIG, COD_LOTE_PK FROM PROCESSO INNER JOIN PROCESSO_LOTE " +
                "ON PROCESSO.COD_PROCESSO_PK=PROCESSO_LOTE.COD_PROCESSO_FK " +
                "INNER JOIN LOTE " +
                "ON LOTE.COD_LOTE_PK=PROCESSO_LOTE.COD_LOTE_FK " +
                "INNER JOIN EMPRESA " +
                "ON EMPRESA.COD_EMPRESA_PK=PROCESSO.COD_EMPRESA_FK " +
                "INNER JOIN QUADRA " +
                "ON QUADRA.COD_QUADRA_PK=LOTE.COD_QUADRA_FK " +
                "INNER JOIN DISTRITO " +
                "ON DISTRITO.COD_DISTRITO_PK=QUADRA.COD_DISTRITO_FK " +
                "WHERE COD_DI = @distrito AND COD_CLI = @processo ORDER BY RIGHT(COD_LOTE_CODEMIG,4)", conn))
            {
                cmd.Parameters.AddWithValue("@processo", processo);
                cmd.Parameters.AddWithValue("@distrito", distrito);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }

    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public ArrayList PopulateLotesCont(string prefix)
    {
        string[] words = prefix.Split('$');
        prefix = words[0];
        String distrito = words[1];
        ArrayList list = new ArrayList();
        String strConnString = ConfigurationManager
            .ConnectionStrings["MyConnString"].ConnectionString;
        String strQuery = "SELECT COD_LOTE_CODEMIG, COD_LOTE_PK FROM PROCESSO INNER JOIN PROCESSO_LOTE " +
                "ON PROCESSO.COD_PROCESSO_PK=PROCESSO_LOTE.COD_PROCESSO_FK " +
                "INNER JOIN LOTE " +
                "ON LOTE.COD_LOTE_PK=PROCESSO_LOTE.COD_LOTE_FK " +
                "INNER JOIN EMPRESA " +
                "ON EMPRESA.COD_EMPRESA_PK=PROCESSO.COD_EMPRESA_FK " +
                "INNER JOIN QUADRA " +
                "ON QUADRA.COD_QUADRA_PK=LOTE.COD_QUADRA_FK " +
                "INNER JOIN DISTRITO " +
                "ON DISTRITO.COD_DISTRITO_PK=QUADRA.COD_DISTRITO_FK " +
                "WHERE COD_DI = @distrito AND CNPJ = @SearchText ORDER BY RIGHT(COD_LOTE_CODEMIG,4)";





        using (SqlConnection con = new SqlConnection(strConnString))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Parameters.AddWithValue("@distrito", distrito);
                cmd.CommandText = strQuery;
                cmd.Connection = con;
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    list.Add(new ListItem(
                   sdr["COD_LOTE_CODEMIG"].ToString(),
                   sdr["COD_LOTE_PK"].ToString()
                    ));
                }
                con.Close();
                return list;
            }
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetPastas(string prefix)
    {

        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("SELECT COD_PASTA_CODEMIG, COD_PASTA_PK FROM PASTA WHERE COD_PASTA_CODEMIG LIKE @SearchText + '%'" +
                "ORDER BY COD_PASTA_CODEMIG", conn))
            {
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }

    }


	[WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetDistritos(string prefix, string distrito)
    
    {


        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("SELECT  TOP 100 COD_CLI, COD_DI, COD_PROCESSO_PK, RAZAO_SOCIAL, CNPJ, COD_EMPRESA_PK, EMAIL, TELEFONE, TIPO_MONETARIO, FATURAMENTO_ANUAL FROM PROCESSO INNER JOIN PROCESSO_LOTE " +
                "ON PROCESSO.COD_PROCESSO_PK=PROCESSO_LOTE.COD_PROCESSO_FK " +
                "INNER JOIN LOTE " +
                "ON LOTE.COD_LOTE_PK=PROCESSO_LOTE.COD_LOTE_FK " +
                "INNER JOIN EMPRESA " +
                "ON EMPRESA.COD_EMPRESA_PK=PROCESSO.COD_EMPRESA_FK " +
                "INNER JOIN QUADRA " +
                "ON QUADRA.COD_QUADRA_PK=LOTE.COD_QUADRA_FK " +
                "INNER JOIN DISTRITO " +
                "ON DISTRITO.COD_DISTRITO_PK=QUADRA.COD_DISTRITO_FK " +
                "WHERE COD_DI = @distrito AND COD_CLI LIKE @SearchText + '%' " +
                "GROUP BY COD_CLI, COD_DI, COD_PROCESSO_PK, RAZAO_SOCIAL, CNPJ, COD_EMPRESA_PK, EMAIL, TELEFONE, TIPO_MONETARIO, FATURAMENTO_ANUAL ORDER BY RIGHT(COD_CLI,5)", conn))
            {

                cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Parameters.AddWithValue("@distrito", distrito);

                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string[] GetRazao(string prefix)
    {

       

        List<string> customers = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT CNPJ, RAZAO_SOCIAL, COD_EMPRESA_PK FROM EMPRESA"+
                " WHERE RAZAO_SOCIAL LIKE @SearchText + '%' ";

                //cmd.CommandText = "select  from PROCESSO, EMPRESA, DISTRITO  where " +
                //"COD_CLI LIKE @SearchText + '%'";
                //"select COD_CLI, COD_EMPRESA_PK, COD_ENDERECO_EMPRESA_PK, CEP, NOME, NUMERO, TIPO, COMPLEMENTO, MUN, UF, BAIRRO from ENDERECO_EMPRESA END, EMPRESA EMP, PROCESSO PRO where END.COD_EMPRESA_FK = COD_EMPRESA_PK AND COD_CLI LIKE @SearchText + '%' ;";
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(string.Format("{0}${1}${2}", sdr["RAZAO_SOCIAL"], sdr["CNPJ"],sdr["COD_EMPRESA_PK"]));
                    }
                }
                conn.Close();
            }

            return customers.ToArray();
        }
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int removeEmpresa(string empresaPK)
    {
        int rowsAffected = 0;
        try
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "begin transaction " +
                    "DELETE FROM EMPRESA_PROPRIETARIO WHERE COD_EMPRESA_FK = @empresaPK " +
                    "DELETE FROM ENDERECO_EMPRESA WHERE COD_EMPRESA_FK = @empresaPK " +
                    "DELETE FROM EMPRESA WHERE COD_EMPRESA_PK = @empresaPK " +
                    "UPDATE  PROCESSO SET COD_EMPRESA_FK=NULL WHERE COD_EMPRESA_FK=@empresaPK "+
                     "if @@ERROR <> 0 " +
                     "rollback " +
                     "else " +
                     "commit ";
                    
                    cmd.Parameters.AddWithValue("@empresaPK", empresaPK);
                    cmd.Connection = conn;
                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();

                    //cmd.CommandText = "DELETE FROM EMPRESA_PROPRIETARIO WHERE COD_EMPRESA_FK = @empresaPK";
                    //cmd.Parameters.AddWithValue("@empresaPK", empresaPK);
                    //cmd.Connection = conn;
                    //conn.Open();
                    //cmd.ExecuteNonQuery();

                    //cmd.CommandText = "DELETE FROM ENDERECO_EMPRESA WHERE COD_EMPRESA_FK = @empresaPK2";
                    //cmd.Parameters.AddWithValue("@empresaPK2", empresaPK);
                   
                    
                    //cmd.ExecuteNonQuery();

                    //cmd.CommandText = "DELETE FROM EMPRESA WHERE COD_EMPRESA_PK = @empresaPK3";
                    //cmd.Parameters.AddWithValue("@empresaPK3", empresaPK);
                    
                    //rowsAffected=cmd.ExecuteNonQuery();


                    

                    conn.Close();
                }
                return rowsAffected;
            }
        }
        catch (Exception e)
        {
            HttpContext.Current.Response.Write("<script>alert('" + e.Message + "')</script>");
            return 0;
        }

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int removeImovel(string imovelPK)
    {
        int rowsAffected = 0;
        try
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "begin transaction " +
                    "DELETE FROM PASTA_IMOVEL WHERE COD_IMOVEL_FK = @imovelPK " +
                    "DELETE FROM CONTRATO_IMOVEL WHERE COD_IMOVEL_FK = @imovelPK " +
                    "DELETE FROM MATRICULA WHERE COD_IMOVEL_FK = @imovelPK " +
                    "DELETE FROM TRIBUTO WHERE COD_IMOVEL_FK=@imovelPK " +
                     "DELETE FROM IMOVEL WHERE COD_IMOVEL_PK=@imovelPK " +
                     "if @@ERROR <> 0 " +
                     "rollback " +
                     "else " +
                     "commit ";

                    cmd.Parameters.AddWithValue("@imovelPK", imovelPK);
                    cmd.Connection = conn;
                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();

                    //cmd.CommandText = "DELETE FROM EMPRESA_PROPRIETARIO WHERE COD_EMPRESA_FK = @empresaPK";
                    //cmd.Parameters.AddWithValue("@empresaPK", empresaPK);
                    //cmd.Connection = conn;
                    //conn.Open();
                    //cmd.ExecuteNonQuery();

                    //cmd.CommandText = "DELETE FROM ENDERECO_EMPRESA WHERE COD_EMPRESA_FK = @empresaPK2";
                    //cmd.Parameters.AddWithValue("@empresaPK2", empresaPK);


                    //cmd.ExecuteNonQuery();

                    //cmd.CommandText = "DELETE FROM EMPRESA WHERE COD_EMPRESA_PK = @empresaPK3";
                    //cmd.Parameters.AddWithValue("@empresaPK3", empresaPK);

                    //rowsAffected=cmd.ExecuteNonQuery();




                    conn.Close();
                }
                return rowsAffected;
            }
        }
        catch (Exception e)
        {
            HttpContext.Current.Response.Write("<script>alert('" + e.Message + "')</script>");
            return 0;
        }

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int removeUser(string usuarioPK)
    {
        int rowsAffected = 0;
        try
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "begin transaction " +
                    "DELETE FROM USUARIO WHERE COD_LOGIN_PK = @usuarioPK " +
                    "DELETE FROM PERMISSAO WHERE COD_LOGIN_FK = @usuarioPK " +
                    "DELETE FROM CONTROLE_USUARIO WHERE COD_LOGIN_FK = @usuarioPK " +
                    "if @@ERROR <> 0 " +
                     "rollback " +
                     "else " +
                     "commit ";
                        
                  
                    cmd.Parameters.AddWithValue("@usuarioPK", usuarioPK);
                    cmd.Connection = conn;
                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();

                    //cmd.CommandText = "DELETE FROM EMPRESA_PROPRIETARIO WHERE COD_EMPRESA_FK = @empresaPK";
                    //cmd.Parameters.AddWithValue("@empresaPK", empresaPK);
                    //cmd.Connection = conn;
                    //conn.Open();
                    //cmd.ExecuteNonQuery();

                    //cmd.CommandText = "DELETE FROM ENDERECO_EMPRESA WHERE COD_EMPRESA_FK = @empresaPK2";
                    //cmd.Parameters.AddWithValue("@empresaPK2", empresaPK);


                    //cmd.ExecuteNonQuery();

                    //cmd.CommandText = "DELETE FROM EMPRESA WHERE COD_EMPRESA_PK = @empresaPK3";
                    //cmd.Parameters.AddWithValue("@empresaPK3", empresaPK);

                    //rowsAffected=cmd.ExecuteNonQuery();




                    conn.Close();
                }
                return rowsAffected;
            }
        }
        catch (Exception e)
        {
            HttpContext.Current.Response.Write("<script>alert('" + e.Message + "')</script>");
            return 0;
        }

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string[] PopulateCNPJ(string prefix)
    {
        string cnpj = prefix;
       
        
        

        List<string> customers = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT DISTINCT TOP 99 CNPJ, RAZAO_SOCIAL,COD_EMPRESA_PK FROM EMPRESA INNER JOIN PROCESSO ON EMPRESA.COD_EMPRESA_PK=PROCESSO.COD_EMPRESA_FK" +
                    " INNER JOIN PROCESSO_LOTE ON PROCESSO.COD_PROCESSO_PK=PROCESSO_LOTE.COD_PROCESSO_FK"+
                    " INNER JOIN LOTE ON PROCESSO_LOTE.COD_LOTE_FK=LOTE.COD_LOTE_PK"+
                    " INNER JOIN QUADRA ON LOTE.COD_QUADRA_FK=QUADRA.COD_QUADRA_PK"+
                    " INNER JOIN DISTRITO ON QUADRA.COD_DISTRITO_FK=DISTRITO.COD_DISTRITO_PK"+
                    " WHERE  CNPJ LIKE @SearchText + '%' ";

                //cmd.CommandText = "select  from PROCESSO, EMPRESA, DISTRITO  where " +
                //"COD_CLI LIKE @SearchText + '%'";
                //"select COD_CLI, COD_EMPRESA_PK, COD_ENDERECO_EMPRESA_PK, CEP, NOME, NUMERO, TIPO, COMPLEMENTO, MUN, UF, BAIRRO from ENDERECO_EMPRESA END, EMPRESA EMP, PROCESSO PRO where END.COD_EMPRESA_FK = COD_EMPRESA_PK AND COD_CLI LIKE @SearchText + '%' ;";
                cmd.Parameters.AddWithValue("@SearchText", cnpj);
                

                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(string.Format("{0}${1}${2}", sdr["RAZAO_SOCIAL"], sdr["CNPJ"],sdr["COD_EMPRESA_PK"]));
                    }
                }
                conn.Close();
            }

            return customers.ToArray();
        }
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string[] PopulateEmpresaCNPJ(string prefix)
    {
        string razao = prefix.Split('$')[0];
        string distrito = prefix.Split('$')[1];



        List<string> customers = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "SELECT DISTINCT CNPJ, RAZAO_SOCIAL,COD_EMPRESA_PK FROM EMPRESA INNER JOIN PROCESSO ON EMPRESA.COD_EMPRESA_PK=PROCESSO.COD_EMPRESA_FK" +
                    " INNER JOIN PROCESSO_LOTE ON PROCESSO.COD_PROCESSO_PK=PROCESSO_LOTE.COD_PROCESSO_FK" +
                    " INNER JOIN LOTE ON PROCESSO_LOTE.COD_LOTE_FK=LOTE.COD_LOTE_PK" +
                    " INNER JOIN QUADRA ON LOTE.COD_QUADRA_FK=QUADRA.COD_QUADRA_PK" +
                    " INNER JOIN DISTRITO ON QUADRA.COD_DISTRITO_FK=DISTRITO.COD_DISTRITO_PK" +
                    " WHERE COD_DI=@Distrito AND RAZAO_SOCIAL LIKE @SearchText + '%' ";

                //cmd.CommandText = "select  from PROCESSO, EMPRESA, DISTRITO  where " +
                //"COD_CLI LIKE @SearchText + '%'";
                //"select COD_CLI, COD_EMPRESA_PK, COD_ENDERECO_EMPRESA_PK, CEP, NOME, NUMERO, TIPO, COMPLEMENTO, MUN, UF, BAIRRO from ENDERECO_EMPRESA END, EMPRESA EMP, PROCESSO PRO where END.COD_EMPRESA_FK = COD_EMPRESA_PK AND COD_CLI LIKE @SearchText + '%' ;";
                cmd.Parameters.AddWithValue("@SearchText", razao);
                cmd.Parameters.AddWithValue("@Distrito", distrito);

                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(string.Format("{0}${1}${2}", sdr["RAZAO_SOCIAL"], sdr["CNPJ"], sdr["COD_EMPRESA_PK"]));
                    }
                }
                conn.Close();
            }

            return customers.ToArray();
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetEmployessJSON(string prefix)
    {
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                
                cmd.CommandText = "select DISTINCT NOME, CPF, COD_PROPRIETARIO_PK from PROPRIETARIO, EMPRESA, EMPRESA_PROPRIETARIO  where " +
                        "CNPJ = @SearchText AND COD_PROPRIETARIO_PK = EMPRESA_PROPRIETARIO.COD_PROPRIETARIO_FK AND COD_EMPRESA_PK = EMPRESA_PROPRIETARIO.COD_EMPRESA_FK";

                cmd.Parameters.AddWithValue("@SearchText", prefix);
                List<Employee> proprietarios = new List<Employee>();
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {

                    while (sdr.Read())
                    {
                        proprietarios.Add(new Employee()
                        {
                            Id = Convert.ToInt32(sdr["COD_PROPRIETARIO_PK"].ToString()),
                            Nome = sdr["NOME"].ToString(),
                            CPF = sdr["CPF"].ToString()
                        });
                    }
                }
                conn.Close();
                return new JavaScriptSerializer().Serialize(proprietarios);
            }

            
        }
        
    }  


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetHistorico(string prefix)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand("select DISTINCT DE, PARA, PAGINA, OBSERVECAO, TIPO_OCORRENCIA, DATA, COD_HISTORICO_PK from HISTORICO " +
                "INNER JOIN HISTORICO_LOTE ON HISTORICO.COD_HISTORICO_PK = HISTORICO_LOTE.COD_HISTORICO_FK " +
                "INNER JOIN LOTE ON HISTORICO_LOTE.COD_LOTE_FK = LOTE.COD_LOTE_PK " +
                "WHERE HISTORICO_LOTE.COD_VOLUME_FK = @SearchText ORDER BY COD_HISTORICO_PK", conn))
            {
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);

            }

        }

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string[] GetContrato(string prefix)
    {
        List<string> contrato = new List<string>();
        List<string> lotes = new List<string>();
        
        using (SqlConnection conn = new SqlConnection())
        {

            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {

                cmd.CommandText = "select DISTINCT DATA_APRESENTACAO, DATA_AQUISICAO, DATA_FIM_OBRA, DATA_INICIO_OBRA, DATA_INICIO_OPERACAO, COD_CONTRATO_VT_PK,COD_LOTE_CODEMIG,COD_LOTE_PK from CONTRATO_VT "+
                "INNER JOIN CONTRATO_LOTE ON CONTRATO_VT.COD_CONTRATO_VT_PK = CONTRATO_LOTE.COD_CONTRATO_FK "+
                "INNER JOIN LOTE ON CONTRATO_LOTE.COD_LOTE_FK = LOTE.COD_LOTE_PK "+
                "INNER JOIN PROCESSO_LOTE ON LOTE.COD_LOTE_PK=PROCESSO_LOTE.COD_LOTE_FK "+
                "INNER JOIN PROCESSO ON PROCESSO_LOTE.COD_PROCESSO_FK=PROCESSO.COD_PROCESSO_PK " +
				"INNER JOIN EMPRESA ON PROCESSO.COD_EMPRESA_FK=EMPRESA.COD_EMPRESA_PK "+
                "WHERE CNPJ=@SearchText ORDER BY COD_CONTRATO_VT_PK";

                //"select COD_CLI, COD_EMPRESA_PK, COD_ENDERECO_EMPRESA_PK, CEP, NOME, NUMERO, TIPO, COMPLEMENTO, MUN, UF, BAIRRO from ENDERECO_EMPRESA END, EMPRESA EMP, PROCESSO PRO where END.COD_EMPRESA_FK = COD_EMPRESA_PK AND COD_CLI LIKE @SearchText + '%' ;";
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Connection = conn;
                conn.Open();

                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    String X = "";
                    while (sdr.Read())
                    {

                        if (sdr["COD_CONTRATO_VT_PK"].ToString() == X)
                        {
                            lotes.Add(string.Format("{0}&&{1}&&{2}", sdr["COD_LOTE_CODEMIG"], sdr["COD_LOTE_PK"], sdr["COD_CONTRATO_VT_PK"]));
                        }
                        else
                        {
                            contrato.Add(string.Format("{0}&&{1}&&{2}&&{3}&&{4}&&{5}", sdr["DATA_APRESENTACAO"], sdr["DATA_AQUISICAO"], sdr["DATA_INICIO_OPERACAO"], sdr["DATA_INICIO_OBRA"], sdr["DATA_FIM_OBRA"], sdr["COD_CONTRATO_VT_PK"]));
                            lotes.Add(string.Format("{0}&&{1}&&{2}", sdr["COD_LOTE_CODEMIG"], sdr["COD_LOTE_PK"], sdr["COD_CONTRATO_VT_PK"]));
                            X = sdr["COD_CONTRATO_VT_PK"].ToString();
                        }

                    }
                    //while (sdr.Read())
                   // {

                        //contrato.Add(string.Format("{0}&&{1}&&{2}&&{3}&&{4}&&{5}", sdr["DATA_APRESENTACAO"], sdr["DATA_AQUISICAO"], sdr["DATA_INICIO_OPERACAO"], sdr["DATA_INICIO_OBRA"], sdr["DATA_FIM_OBRA"], sdr["COD_CONTRATO_VT_PK"]));

                   // }

                }


                conn.Close();
            }

            //return x;
            if (contrato.Count == 0)
            {
                contrato.Add("Zero");
            }
            String[] customers2 = contrato.ToArray();
            String[] lotes2 = lotes.ToArray();
            if (contrato[0] == "Zero")
            {
                return customers2;
            }


            String txt = "";
            String txtLotes = "";

            for (int x = 0; x < customers2.Length; x++)
            {
                if (x == 0)
                {
                    txt += customers2[x];


                }
                else
                {
                    txt += "," + customers2[x];


                }

            }
            for (int y = 0; y < lotes2.Length; y++)
            {
                if (y == 0)
                {
                    txtLotes += lotes2[y];

                }
                else
                {
                    txtLotes += "," + lotes2[y];

                }

            }

            String[] customers3 = new String[1];
            customers3[0] = txt + "()" + txtLotes;
            return customers3;
            
            


           

        }
    }




    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string[] GetEndereco(string prefix)
    {
        List<string> customers = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {

            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {

                string cont = "oioi";
                
                cmd.CommandText = "select TIPO, NOME, NUMERO, COMPLEMENTO, BAIRRO, CEP, UF, MUN FROM PROCESSO INNER JOIN EMPRESA ON EMPRESA.COD_EMPRESA_PK=PROCESSO.COD_EMPRESA_FK"
                                   + " INNER JOIN ENDERECO_EMPRESA"
                                  + " ON EMPRESA.COD_EMPRESA_PK=ENDERECO_EMPRESA.COD_EMPRESA_FK"
                                   + " WHERE COD_CLI=@SearchText";

                //"select COD_CLI, COD_EMPRESA_PK, COD_ENDERECO_EMPRESA_PK, CEP, NOME, NUMERO, TIPO, COMPLEMENTO, MUN, UF, BAIRRO from ENDERECO_EMPRESA END, EMPRESA EMP, PROCESSO PRO where END.COD_EMPRESA_FK = COD_EMPRESA_PK AND COD_CLI LIKE @SearchText + '%' ;";
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {

                    while (sdr.Read())
                    {

                        customers.Add(string.Format("{0}${1}${2}${3}${4}${5}${6}${7}", sdr["TIPO"], sdr["NOME"], sdr["NUMERO"], sdr["COMPLEMENTO"], sdr["BAIRRO"], sdr["CEP"], sdr["UF"], sdr["MUN"]));
                       
                    }

                }
                conn.Close();
            }
            //return x;
            return customers.ToArray();
        }
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetCodImovel(string prefix,string municipio)
    {

        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;
            if (municipio == "0")
            {
                using (SqlCommand cmd = new SqlCommand("select [NUM_PATRIMONIO],[COD_IMOVEL_PK], [COD_END_IMOVEL_PK] " +
                  " from IMOVEL LEFT OUTER JOIN ENDERECO_IMOVEL ON IMOVEL.COD_IMOVEL_PK=ENDERECO_IMOVEL.COD_IMOVEL_FK WHERE NUM_PATRIMONIO LIKE @NUMPATRIMONIO +'%' ", conn))
                {
                    cmd.Parameters.AddWithValue("@NUMPATRIMONIO", prefix);

                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                    Dictionary<string, object> row;
                    foreach (DataRow dr in dt.Rows)
                    {
                        row = new Dictionary<string, object>();
                        foreach (DataColumn col in dt.Columns)
                        {
                            row.Add(col.ColumnName, dr[col]);
                        }
                        rows.Add(row);
                    }
                    return serializer.Serialize(rows);
                }

            }
            using (SqlCommand cmd = new SqlCommand("select [NUM_PATRIMONIO],[COD_IMOVEL_PK], [COD_END_IMOVEL_PK]" +
            " from IMOVEL LEFT OUTER JOIN ENDERECO_IMOVEL ON IMOVEL.COD_IMOVEL_PK=ENDERECO_IMOVEL.COD_IMOVEL_FK WHERE NUM_PATRIMONIO LIKE @NUMPATRIMONIO +'%' AND CIDADE=@MUNICIPIO", conn))
            {
                cmd.Parameters.AddWithValue("@NUMPATRIMONIO", prefix);
                cmd.Parameters.AddWithValue("@MUNICIPIO", municipio);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);
            }
            
            
        }

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetDadosImovel(string prefix)
    {

        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;
           
                using (SqlCommand cmd = new SqlCommand("select IMOVEL.*, [COD_END_IMOVEL_PK] " +
             " ,[CEP],[TIPO_LOGRADOURO] ,[NOME_LOGRADOURO],[NUMERO] ,[COMPLEMENTO] " +
             " ,[BAIRRO] ,[CIDADE] ,[ESTADO] ,[COD_IMOVEL_FK] " +
             " ,  [SHAPE].STX AS [Latitude], [SHAPE].STY AS [Longitude] from IMOVEL LEFT OUTER JOIN ENDERECO_IMOVEL ON IMOVEL.COD_IMOVEL_PK=ENDERECO_IMOVEL.COD_IMOVEL_FK WHERE COD_IMOVEL_PK = @CODIMOVEL ", conn))
                {
                    cmd.Parameters.AddWithValue("@CODIMOVEL", prefix);

                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                    Dictionary<string, object> row;
                    foreach (DataRow dr in dt.Rows)
                    {
                        row = new Dictionary<string, object>();
                        foreach (DataColumn col in dt.Columns)
                        {
                            row.Add(col.ColumnName, dr[col]);
                        }
                        rows.Add(row);
                    }
                    return serializer.Serialize(rows);
                }

            

           
        }

    }



    public object distrito { get; set; }
}