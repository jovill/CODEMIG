using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CODEMIG.Classes;
using System.Configuration;
using iTextSharp.text.pdf;
using iTextSharp.text;
using System.Text;
using System.IO;
using System.Net;
using System.Data.OleDb;
using System.Web.UI.HtmlControls;

namespace CODEMIG
{
    public partial class usuarios : System.Web.UI.Page
    {
        CODEMIG.Classes.DbUtils.DbConn conexao = new Classes.DbUtils.DbConn();
        CODEMIG.Classes.Classes classes = new Classes.Classes();
        /*
         * Carregamento da página
         */
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                this.PopulateDistritos();

            StringData webUserStringData = (StringData)Session["webuser"];

            if (Session["webuser"] != null)
            {
                if (webUserStringData.userPermission != "0" && webUserStringData.userPermission.ToString() != "2" && webUserStringData.userPermission.ToString() != "3")
                {
                    Response.Write("<script>alert('Você não tem permissão para acessar esta página');</script>");
                    Response.Redirect("~/home.aspx?per=5");
                }

                hfPermissao.Value = webUserStringData.userPermission;
                hfLoginPk.Value = webUserStringData.userID;

                manutencaoSis();
            }
            else
            {
                Response.Write("<script>alert('Faça login para ter acesso ao sistema');</script>");
                Response.Redirect("~/login.aspx", true);
            }
        }

        /*
         * Popula drop down de distritos
         */
        /*
         * 
         * */


        protected void FindEndereco_Click1(object sender, EventArgs e)
        {
            CODEMIG.Classes.import import = new CODEMIG.Classes.import();
            DataTable dt = new DataTable();



            if ((File1.PostedFile != null) && (File1.PostedFile.ContentLength > 0))
            {
                if (!Directory.Exists(Server.MapPath("Data")))
                {
                    Directory.CreateDirectory(Server.MapPath("Data"));
                }
                string fn = System.IO.Path.GetFileName(File1.PostedFile.FileName);
                string SaveLocation = Server.MapPath("Data") + "\\" + fn;
                string url = string.Empty;
                string erro = "Erro:";
                string teste = string.Empty;
                string tab = "";
                string attachment = "attachment; filename=" + DateTime.Now.Year + DateTime.Now.Month + DateTime.Now.Day + "_GeocodeReverso.xls";
                Response.ClearContent();
                Response.AddHeader("content-disposition", attachment);
                Response.ContentType = "application/vnd.ms-excel";
                Response.ContentEncoding = System.Text.Encoding.Unicode;
                Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());
                try
                {
                    if (!File.Exists(SaveLocation))
                    {
                        File1.PostedFile.SaveAs(SaveLocation);
                    }

                    dt.Clear();
                    dt = import.excel(SaveLocation);

                    if (!dt.Columns.Contains("Estado"))
                    {
                        dt.Columns.Add(new DataColumn("Estado", typeof(string)));
                    }
                    if (!dt.Columns.Contains("Cidade"))
                    {
                        dt.Columns.Add(new DataColumn("Cidade", typeof(string)));
                    }
                    if (!dt.Columns.Contains("Bairro"))
                    {
                        dt.Columns.Add(new DataColumn("Bairro", typeof(string)));
                    }
                    if (!dt.Columns.Contains("Tipo_Logradouro"))
                    {
                        dt.Columns.Add(new DataColumn("Tipo_Logradouro", typeof(string)));
                    }
                    if (!dt.Columns.Contains("Logradouro"))
                    {
                        dt.Columns.Add(new DataColumn("Logradouro", typeof(string)));
                    }
                    if (!dt.Columns.Contains("Numero"))
                    {
                        dt.Columns.Add(new DataColumn("Numero", typeof(string)));
                    }
                    foreach (DataColumn dc in dt.Columns)
                    {
                        Response.Write(tab + dc.ColumnName.Trim());
                        tab = "\t";
                    }
                    Response.Write("\n");


                    //Declaro o StreamReader para o caminho onde se encontra o arquivo

                    //Declaro uma string que será utilizada para receber a linha completa do arquivo

                    //Declaro um array do tipo string que será utilizado para adicionar o conteudo da linha separado
                    //string[] linhaseparada = null;



                    //realizo o while para ler o conteudo da linha

                    string resultStatus = "";

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        try
                        {
                            teste = dt.Rows[i]["Latitude"].ToString() + "," + dt.Rows[i]["Longitude"].ToString();
                            //string[] addres =linha.ToString();

                            url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + teste ;
                            WebRequest request = WebRequest.Create(url);
                            using (WebResponse response = (HttpWebResponse)request.GetResponse())
                            {
                                using (StreamReader reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
                                {
                                    DataSet dsResult = new DataSet();
                                    dsResult.ReadXml(reader);
                                    DataTable dtCoordinates = new DataTable();
                                    dtCoordinates.Columns.AddRange(new DataColumn[4] { new DataColumn("Id", typeof(int)),
                                     new DataColumn("Address", typeof(string)),
                                     new DataColumn("Latitude",typeof(string)),
                                     new DataColumn("Longitude",typeof(string)) });
                                    foreach (DataRow row in dsResult.Tables["result"].Rows)
                                    {
                                        string geometry_id = dsResult.Tables["geometry"].Select("result_id = " + row["result_id"].ToString())[0]["geometry_id"].ToString();
                                        DataRow location = dsResult.Tables["location"].Select("geometry_id = " + geometry_id)[0];
                                        dtCoordinates.Rows.Add(row["result_id"], row["formatted_address"], location["lat"], location["lng"]);
                                    }
                                    //System.Threading.Thread.Sleep(50);


                                    resultStatus = dsResult.Tables["GeocodeResponse"].Rows[0]["status"].ToString();
                                    if (resultStatus == "OK")
                                    {

                                        //dt.Rows[i]["Estado"] = dtCoordinates.Rows[0][2].ToString();
                                        //dt.Rows[i]["Cidade"] = dtCoordinates.Rows[0][3].ToString();
                                        //dt.Rows[i]["Bairro"] = dtCoordinates.Rows[0][1].ToString();

                                        if (dsResult.Tables["result"].Columns.Contains("type"))
                                        {
                                            dt.Rows[i]["Types"] = dsResult.Tables["result"].Rows[0]["type"].ToString();
                                        }
                                        else
                                        {
                                            dt.Rows[i]["Types"] = "";
                                        }

                                        dt.Rows[i]["Location_Types"] = dsResult.Tables["geometry"].Rows[0]["location_type"].ToString();

                                    }
                                    else
                                    {
                                        erro += "Numero de geocode excedido";
                                        dt.Rows[i]["Latitude_Google"] = "Numero de geocode excedido";
                                        dt.Rows[i]["Longitude_Google"] = "Numero de geocode excedido";
                                        dt.Rows[i]["Endereco_Saida"] = "";
                                        dt.Rows[i]["Location_Types"] = "";
                                        dt.Rows[i]["Types"] = "";
                                    }

                                    tab = "";
                                    for (int j = 0; j < dt.Columns.Count; j++)
                                    {
                                        Response.Write(tab + dt.Rows[i][j].ToString().Trim());
                                        tab = "\t";
                                    }
                                    Response.Write("\n");
                                    dsResult.Clear();
                                    dtCoordinates.Clear();


                                }

                            }

                        }
                        catch (Exception ex)
                        {

                            tab = "";
                            for (int j = 0; j < dt.Columns.Count; j++)
                            {
                                Response.Write(tab + dt.Rows[i][j].ToString().Trim());
                                tab = "\t";
                            }
                            Response.Write("\n");


                            erro = erro + "ID:" + i + "-" + ex.Message + ";";

                        }



                    }










                }

                catch (Exception ex)
                {
                    conexao.Message("  Error: " + ex.Message);

                }


                Response.End();

                if (erro != "Erro:")
                {
                    conexao.Message(erro);
                }
                else
                {
                    conexao.Message("Concluido!");
                }

            }
            else
            {
                conexao.Message("Por favor selecione um arquivo para carregar.");
            }
        }
        protected void FindCoordinates_Click1(object sender, EventArgs e)
        {
            CODEMIG.Classes.import import = new CODEMIG.Classes.import();
            DataTable dt = new DataTable();
          


             if ((File1.PostedFile != null) && (File1.PostedFile.ContentLength > 0))
            {
                if(!Directory.Exists(Server.MapPath("Data") ))
                {
                    Directory.CreateDirectory(Server.MapPath("Data"));
                }
                string fn = System.IO.Path.GetFileName(File1.PostedFile.FileName);
                string SaveLocation = Server.MapPath("Data") + "\\" + fn;
                string url = string.Empty;
                string erro = "Erro:";
                string teste = string.Empty;
                string tab = "";
                string attachment = "attachment; filename=" + DateTime.Now.Year + DateTime.Now.Month + DateTime.Now.Day + "_EnderecoGeocodificados.xls";
                Response.ClearContent();
                Response.AddHeader("content-disposition", attachment);
                Response.ContentType = "application/vnd.ms-excel";
                Response.ContentEncoding = System.Text.Encoding.Unicode;
                Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());
                try
                {
                    if (!File.Exists(SaveLocation))
                    {
                        File1.PostedFile.SaveAs(SaveLocation);
                    }

                    dt.Clear();
                    dt = import.excel(SaveLocation);
                    if(!dt.Columns.Contains("Latitude_Google"))
                    {
                        dt.Columns.Add(new DataColumn("Latitude_Google", typeof(string)));
                    }
                    if (!dt.Columns.Contains("Longitude_Google"))
                    {
                        dt.Columns.Add(new DataColumn("Longitude_Google", typeof(string)));
                    }
                    if (!dt.Columns.Contains("Location_Types"))
                    {
                        dt.Columns.Add(new DataColumn("Location_Types", typeof(string)));
                    }
                    if (!dt.Columns.Contains("Types"))
                    {
                        dt.Columns.Add(new DataColumn("Types", typeof(string)));
                    }
                    if (!dt.Columns.Contains("Endereco_Saida"))
                    {
                        dt.Columns.Add(new DataColumn("Endereco_Saida", typeof(string)));
                    }
                    foreach (DataColumn dc in dt.Columns)
                    {
                        Response.Write(tab + dc.ColumnName.Trim());
                        tab = "\t";
                    }
                    Response.Write("\n");
                    
                   
                    //Declaro o StreamReader para o caminho onde se encontra o arquivo
                   
                    //Declaro uma string que será utilizada para receber a linha completa do arquivo
                    
                    //Declaro um array do tipo string que será utilizado para adicionar o conteudo da linha separado
                    //string[] linhaseparada = null;
                  
                    

                    //realizo o while para ler o conteudo da linha

                    string resultStatus = "";
                    
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        try
                        {
                             teste = dt.Rows[i]["Logradouro"].ToString() + "," + dt.Rows[i]["Número"].ToString() + "," + dt.Rows[i]["Bairro"].ToString() + "," + dt.Rows[i]["Município"].ToString() + "," + dt.Rows[i]["UF"].ToString();
                            //string[] addres =linha.ToString();

                            url = "http://maps.google.com/maps/api/geocode/xml?address=" + teste + "&sensor=false";
                            WebRequest request = WebRequest.Create(url);
                            using (WebResponse response = (HttpWebResponse)request.GetResponse())
                            {
                                using (StreamReader reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
                                {
                                    DataSet dsResult = new DataSet();
                                    dsResult.ReadXml(reader);
                                    DataTable dtCoordinates = new DataTable();
                                    dtCoordinates.Columns.AddRange(new DataColumn[4] { new DataColumn("Id", typeof(int)),
                                     new DataColumn("Address", typeof(string)),
                                     new DataColumn("Latitude",typeof(string)),
                                     new DataColumn("Longitude",typeof(string)) });
                                    foreach (DataRow row in dsResult.Tables["result"].Rows)
                                    {
                                        string geometry_id = dsResult.Tables["geometry"].Select("result_id = " + row["result_id"].ToString())[0]["geometry_id"].ToString();
                                        DataRow location = dsResult.Tables["location"].Select("geometry_id = " + geometry_id)[0];
                                        dtCoordinates.Rows.Add(row["result_id"], row["formatted_address"], location["lat"], location["lng"]);
                                    }
                                    //System.Threading.Thread.Sleep(50);


                                    resultStatus = dsResult.Tables["GeocodeResponse"].Rows[0]["status"].ToString();
                                    if (resultStatus == "OK")
                                    {
                                        
                                        dt.Rows[i]["Latitude_Google"] = dtCoordinates.Rows[0][2].ToString();
                                        dt.Rows[i]["Longitude_Google"] = dtCoordinates.Rows[0][3].ToString();
                                        dt.Rows[i]["Endereco_Saida"] = dtCoordinates.Rows[0][1].ToString();

                                        if (dsResult.Tables["result"].Columns.Contains("type"))
                                        {
                                            dt.Rows[i]["Types"] = dsResult.Tables["result"].Rows[0]["type"].ToString();
                                        }
                                        else
                                        {
                                            dt.Rows[i]["Types"] = "";
                                        }
                                        
                                        dt.Rows[i]["Location_Types"] = dsResult.Tables["geometry"].Rows[0]["location_type"].ToString();
                                   
                                    }
                                    else
                                    {
                                        erro += "Numero de geocode excedido";
                                        dt.Rows[i]["Latitude_Google"] = "Numero de geocode excedido";
                                        dt.Rows[i]["Longitude_Google"] = "Numero de geocode excedido";
                                        dt.Rows[i]["Endereco_Saida"] = "";
                                        dt.Rows[i]["Location_Types"] = "";
                                        dt.Rows[i]["Types"] = "";
                                    }
                                   
                                        tab = "";
                                        for (int j = 0; j < dt.Columns.Count; j++)
                                        {
                                            Response.Write(tab + dt.Rows[i][j].ToString().Trim());
                                            tab = "\t";
                                        }
                                        Response.Write("\n");
                                        dsResult.Clear();
                                        dtCoordinates.Clear();
                                    
                                    
                                }

                            }

                        }catch(Exception ex)
                        {
                           
                             tab = "";
                                        for (int j = 0; j < dt.Columns.Count; j++)
                                        {
                                            Response.Write(tab + dt.Rows[i][j].ToString().Trim());
                                            tab = "\t";
                                        }
                                        Response.Write("\n");
                                        
                           
                            erro = erro+"ID:"+i +"-"+ ex.Message+";";
                            
                        }
                      


                    }



                    

                    
                    

                    
                    
                }
                
                catch (Exception ex)
                {
                    conexao.Message("  Error: " + ex.Message);
                    
                }


                Response.End();

                if (erro != "Erro:")
                {
                    conexao.Message(erro);
                }
                else
                {
                    conexao.Message("Concluido!");
                }

            }
             else
             {
                 conexao.Message("Por favor selecione um arquivo para carregar.");
             }
        }
        private void PopulateDistritos()
        {
            String strConnString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;
            String strQuery = "select COD_DI, NOME_DISTRITO from DISTRITO";
            using (SqlConnection con = new SqlConnection(strConnString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strQuery;
                    cmd.Connection = con;
                    con.Open();
                    ddlDistritos.DataSource = cmd.ExecuteReader();
                    ddlDistritos.DataTextField = "NOME_DISTRITO";
                    ddlDistritos.DataValueField = "COD_DI";
                    ddlDistritos.DataBind();
                    con.Close();
                   
                }
            }
        }

        /*
         * Pega informações de usuário para grid -> deletar e editar
         */
        public void getUsuario ()
        {
            DataTable data = new DataTable();
            String strConnString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;
            String strQuery = "select USERNAME, NOME_COMPLETO, EMAIL, TIPOPERMISSAO from USUARIO INNER JOIN PERMISSAO ON USUARIO.COD_LOGIN_PK=PERMISSAO.COD_LOGIN_FK";
            using (SqlConnection con = new SqlConnection(strConnString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strQuery;
                    cmd.Connection = con;
                    con.Open();
                }
            }
        }

        /*
         * Verifica situação do sistema para mudar o botão ativa desativa
         */
        public void manutencaoSis()
        {
            DataTable dt = new DataTable();
            dt.Clear();
            classes.limpaData(dt);
            dt = conexao.SELECT("SELECT SISTEMA FROM USUARIO WHERE SISTEMA = 0");

            if (dt.Rows.Count > 0)
            {
                bntManutencao.Text = "Desativar Manutenção";
                bntManutencao.CssClass = "btn btn-danger btn-sm pull-right cadastrar";
            }
            else
            {
                bntManutencao.Text = "Ativar Manutenção";
                bntManutencao.CssClass = "btn btn-danger btn-sm pull-right cadastrar";
            }
        }


        protected void bntIrregular_Click1(object sender, EventArgs e)
        {
            string arquivoPDF= "Relatorio_" + DateTime.Now.Year + "_" + DateTime.Now.Month + "_" + DateTime.Now.Day + ".pdf";
            string filepatch = Server.MapPath(".") + "\\img\\logocodemig.PNG";
           
                int resposta = tabelaPDF(filepatch);
                if (resposta != 0)
                {

                    //Response.Redirect("~/" + arquivoPDF);
                    string finalerPfad = Request.PhysicalApplicationPath + "\\" + arquivoPDF;
                    string fileLength;
                    FileInfo myFileInfo = new FileInfo(finalerPfad);
                    fileLength = myFileInfo.Length.ToString();

                    Response.Clear();

                    Response.AddHeader("Accept-Ranges", "ascii");
                    Response.AddHeader("Content-Length", fileLength);
                    Response.AddHeader("Cache-Control", "post-check=0, pre-check=0");
                    Response.ContentType = "application/octet-stream";
                    Response.AddHeader("Content-Disposition", "inline; filename=\"" + arquivoPDF + "\"");
                    Response.AddHeader("Cache-Control", "no-store, no-cache, must-revalidate");
                    Response.AddHeader("Pragma", "no-cache");

                    Response.Flush();
                   
                    Response.TransmitFile(Server.MapPath("~/" + arquivoPDF));


                    //Response.WriteFile(finalerPfad);


                    Response.End();






                }

            
           

           /* DataTable dt = new DataTable();

            dt = difSelect();

            string attachment = "attachment; filename=Empresas_Irregulares.xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/vnd.ms-excel";
            Response.ContentEncoding = System.Text.Encoding.Unicode;
            Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());
            string tab = "";
            foreach (DataColumn dc in dt.Columns)
            {
                Response.Write(tab + dc.ColumnName.Trim());
                tab = "\t";
            }
            Response.Write("\n");
            int i;
            foreach (DataRow dr in dt.Rows)
            {
                tab = "";
                for (i = 0; i < dt.Columns.Count; i++)
                {
                    Response.Write(tab + dr[i].ToString().Trim());
                    tab = "\t";
                }
                Response.Write("\n");
            }
            Response.End();*/



        }
        public int tabelaPDF(string filepatch)
        {


            string arquivoPDF = "Relatorio_" + DateTime.Now.Year + "_" + DateTime.Now.Month + "_" + DateTime.Now.Day + ".pdf";
            DataTable dt = new DataTable();
            Classes.DbUtils.DbConn conexao = new Classes.DbUtils.DbConn();
            Classes.PageEventHelper HeaderFooter = new Classes.PageEventHelper();




            dt = conexao.SELECT(

     "(SELECT                dbo.LOTE.COD_LOTE_CODEMIG, dbo.EMPRESA.CNPJ, dbo.EMPRESA.RAZAO_SOCIAL,PROCESSO.COD_CLI, CONVERT(varchar(24), " +
     "                    dbo.CONTRATO_VT.DATA_APRESENTACAO, 103) AS DATA_APRESENTACAO, CONVERT(varchar(24), dbo.CONTRATO_VT.DATA_AQUISICAO, 103) AS DATA_AQUISICAO, " +
     "                  CONVERT(varchar(24), dbo.CONTRATO_VT.DATA_INICIO_OBRA, 103) AS DATA_INICIO_OBRA, CONVERT(varchar(24), dbo.CONTRATO_VT.DATA_FIM_OBRA, 103)  " +
     "                    AS DATA_FIM_OBRA, CONVERT(varchar(24), dbo.CONTRATO_VT.DATA_INICIO_OPERACAO, 103) AS DATA_INICIO_OPERACAO " +
     "FROM                dbo.EMPRESA INNER JOIN " +
     "                    dbo.PROCESSO ON dbo.EMPRESA.COD_EMPRESA_PK = dbo.PROCESSO.COD_EMPRESA_FK INNER JOIN " +
     "                    dbo.PROCESSO_LOTE ON dbo.PROCESSO.COD_PROCESSO_PK = dbo.PROCESSO_LOTE.COD_PROCESSO_FK INNER JOIN " +
     "                    dbo.LOTE ON dbo.LOTE.COD_LOTE_PK = dbo.PROCESSO_LOTE.COD_LOTE_FK INNER JOIN " +
     "                    dbo.HISTORICO_LOTE ON dbo.LOTE.COD_LOTE_PK = dbo.HISTORICO_LOTE.COD_LOTE_FK INNER JOIN " +
     "                    dbo.HISTORICO ON dbo.HISTORICO.COD_HISTORICO_PK = dbo.HISTORICO_LOTE.COD_HISTORICO_FK INNER JOIN " +
     "                    dbo.CONTRATO_LOTE ON dbo.LOTE.COD_LOTE_PK = dbo.CONTRATO_LOTE.COD_LOTE_FK INNER JOIN " +
     "                    dbo.CONTRATO_VT ON dbo.CONTRATO_VT.COD_CONTRATO_VT_PK = dbo.CONTRATO_LOTE.COD_CONTRATO_FK " +
     "WHERE                (dbo.HISTORICO.TIPO_OCORRENCIA = 'Termo de Anuência' AND dbo.HISTORICO.OBSERVECAO NOT LIKE '*%' AND dbo.CONTRATO_VT.DATA_APRESENTACAO < GETDATE())  " +
     "                    OR " +
     "                    (dbo.HISTORICO.TIPO_OCORRENCIA = 'Alvará de Construção' AND dbo.HISTORICO.OBSERVECAO NOT LIKE '*%' AND dbo.CONTRATO_VT.DATA_APRESENTACAO < GETDATE())  " +
     "                    OR " +
     "                    (dbo.HISTORICO.TIPO_OCORRENCIA = 'Aprovação de Projeto' AND dbo.HISTORICO.OBSERVECAO NOT LIKE '*%' AND dbo.CONTRATO_VT.DATA_APRESENTACAO < GETDATE())  " +
     "                    OR " +
     "                    (dbo.HISTORICO.TIPO_OCORRENCIA <> 'Termo de Anuência' AND  dbo.CONTRATO_VT.DATA_APRESENTACAO < GETDATE())  " +
     "                    OR " +
     "                    (dbo.HISTORICO.TIPO_OCORRENCIA <> 'Alvará de Construção' AND dbo.CONTRATO_VT.DATA_APRESENTACAO<GETDATE()) " +
     "                    OR  " +
     "                    (dbo.HISTORICO.TIPO_OCORRENCIA <> 'Aprovação de Projeto' AND  dbo.CONTRATO_VT.DATA_APRESENTACAO<GETDATE()) " +
     "GROUP BY             dbo.LOTE.COD_LOTE_CODEMIG, dbo.EMPRESA.CNPJ, dbo.EMPRESA.RAZAO_SOCIAL,PROCESSO.COD_CLI, dbo.CONTRATO_VT.DATA_APRESENTACAO,  " +
     "                    dbo.CONTRATO_VT.DATA_AQUISICAO, dbo.CONTRATO_VT.DATA_INICIO_OBRA, dbo.CONTRATO_VT.DATA_FIM_OBRA,  " +
     "                    dbo.CONTRATO_VT.DATA_INICIO_OPERACAO) " +

     "                    EXCEPT " +

     "(SELECT             dbo.LOTE.COD_LOTE_CODEMIG, dbo.EMPRESA.CNPJ, dbo.EMPRESA.RAZAO_SOCIAL, PROCESSO.COD_CLI, CONVERT(varchar(24), " +
     "                    dbo.CONTRATO_VT.DATA_APRESENTACAO, 103) AS DATA_APRESENTACAO, CONVERT(varchar(24), dbo.CONTRATO_VT.DATA_AQUISICAO, 103) AS DATA_AQUISICAO, " +
     "                    CONVERT(varchar(24), dbo.CONTRATO_VT.DATA_INICIO_OBRA, 103) AS DATA_INICIO_OBRA, CONVERT(varchar(24), dbo.CONTRATO_VT.DATA_FIM_OBRA, 103)  " +
     "                    AS DATA_FIM_OBRA, CONVERT(varchar(24), dbo.CONTRATO_VT.DATA_INICIO_OPERACAO, 103) AS DATA_INICIO_OPERACAO " +

     "FROM                 dbo.EMPRESA INNER JOIN " +
     "                    dbo.PROCESSO ON dbo.EMPRESA.COD_EMPRESA_PK = dbo.PROCESSO.COD_EMPRESA_FK INNER JOIN " +
     "                    dbo.PROCESSO_LOTE ON dbo.PROCESSO.COD_PROCESSO_PK = dbo.PROCESSO_LOTE.COD_PROCESSO_FK INNER JOIN " +
     "                    dbo.LOTE ON dbo.LOTE.COD_LOTE_PK = dbo.PROCESSO_LOTE.COD_LOTE_FK INNER JOIN " +
     "                    dbo.HISTORICO_LOTE ON dbo.LOTE.COD_LOTE_PK = dbo.HISTORICO_LOTE.COD_LOTE_FK INNER JOIN " +
     "                    dbo.HISTORICO ON dbo.HISTORICO.COD_HISTORICO_PK = dbo.HISTORICO_LOTE.COD_HISTORICO_FK INNER JOIN " +
     "                    dbo.CONTRATO_LOTE ON dbo.LOTE.COD_LOTE_PK = dbo.CONTRATO_LOTE.COD_LOTE_FK INNER JOIN " +
     "                    dbo.CONTRATO_VT ON dbo.CONTRATO_VT.COD_CONTRATO_VT_PK = dbo.CONTRATO_LOTE.COD_CONTRATO_FK " +

     "WHERE                (dbo.HISTORICO.TIPO_OCORRENCIA='Termo de Anuência' AND dbo.HISTORICO.OBSERVECAO  LIKE '*%')  " +
     "                     OR " +

     "                    (dbo.HISTORICO.TIPO_OCORRENCIA='Alvará de Construção' AND dbo.HISTORICO.OBSERVECAO  LIKE '*%')  " +
     "                     OR " +

     "                    (dbo.HISTORICO.TIPO_OCORRENCIA='Aprovação de Projeto' AND dbo.HISTORICO.OBSERVECAO  LIKE '*%')  " +
     "                     OR " +

     "                    (dbo.HISTORICO.TIPO_OCORRENCIA='Termo de Anuência' AND HISTORICO.OBSERVECAO NOT LIKE '*%'   AND dbo.CONTRATO_VT.DATA_APRESENTACAO > GETDATE()-1) OR " +
     "                    (dbo.HISTORICO.TIPO_OCORRENCIA = 'Alvará de Construção' AND HISTORICO.OBSERVECAO NOT LIKE '*%'   AND  dbo.CONTRATO_VT.DATA_APRESENTACAO > GETDATE()-1) OR (dbo.HISTORICO.TIPO_OCORRENCIA = 'Aprovação de Projeto' AND HISTORICO.OBSERVECAO NOT LIKE '*%'   AND   dbo.CONTRATO_VT.DATA_APRESENTACAO >= GETDATE()) " +
     "                     OR " +

     "                    (dbo.HISTORICO.TIPO_OCORRENCIA <> 'Termo de Anuência' AND  dbo.CONTRATO_VT.DATA_APRESENTACAO > GETDATE()-1) OR  " +
     "                    (dbo.HISTORICO.TIPO_OCORRENCIA <> 'Alvará de Construção' AND  dbo.CONTRATO_VT.DATA_APRESENTACAO > GETDATE()-1) OR  " +
     "                    (dbo.HISTORICO.TIPO_OCORRENCIA <> 'Aprovação de Projeto' AND   dbo.CONTRATO_VT.DATA_APRESENTACAO > GETDATE()-1) " +

     " GROUP BY             dbo.LOTE.COD_LOTE_CODEMIG, dbo.EMPRESA.CNPJ, dbo.EMPRESA.RAZAO_SOCIAL, PROCESSO.COD_CLI, dbo.CONTRATO_VT.DATA_APRESENTACAO,  " +
     "                    dbo.CONTRATO_VT.DATA_AQUISICAO, dbo.CONTRATO_VT.DATA_INICIO_OBRA, dbo.CONTRATO_VT.DATA_FIM_OBRA,  " +
     "                    dbo.CONTRATO_VT.DATA_INICIO_OPERACAO) ");








            /// SE RETORNA ALGUMA EMPRESA CRIAR PDF
            if (dt.Rows.Count > 0)
            {
                //CRIA DOCUMENTO
                Document document = new Document(PageSize.LETTER, 72, 72, 72, 72);
                ///DEFINE MARGEM
                document.SetMargins(20f, 20f, 50f, 50f);
                document.AddCreationDate();
                //GRAVA O ARQUIVO NA RAIZ
                iTextSharp.text.pdf.PdfWriter writer = iTextSharp.text.pdf.PdfWriter.GetInstance(document, new FileStream(Request.PhysicalApplicationPath + "\\" + arquivoPDF, FileMode.Create));
                iTextSharp.text.Font subtitulo = FontFactory.GetFont(FontFactory.TIMES_ROMAN, 9, BaseColor.BLACK);
                iTextSharp.text.Font d = FontFactory.GetFont(FontFactory.TIMES_ROMAN, 6, BaseColor.RED);
                iTextSharp.text.Font l = FontFactory.GetFont(FontFactory.TIMES_BOLD, 6, BaseColor.BLACK);
                iTextSharp.text.Font f = FontFactory.GetFont(FontFactory.TIMES_ROMAN, 8, BaseColor.WHITE);
                iTextSharp.text.Font f2 = FontFactory.GetFont(FontFactory.TIMES_ROMAN, 6, BaseColor.BLACK);


                writer.PageEvent = HeaderFooter;
                iTextSharp.text.Font titulo = FontFactory.GetFont(FontFactory.TIMES_ROMAN, 12, BaseColor.BLACK);

                HeaderFooter.Title = "Relatório de Situação Contratual Irregular por Lotes e Empresas";
                // HeaderFooter.HeaderRight = "tester";
                //HeaderFooter.HeaderLeft = "testel";

                HeaderFooter.HeaderFont = titulo;
                
                HeaderFooter.TESTE = filepatch;
                //ABRE O DOCUMENTO PARA EDIÇÃO
                document.Open();


                //document.Add(pic);
                HeaderFooter.OnStartPage(writer, document);
                HeaderFooter.OnEndPage(writer, document);
                // HeaderFooter.OnCloseDocument(writer, document);
                //DEFINI DOIS TIPO DE FONTES


                //CRIA UMA TABELA 
                float[] colsWidth = { 0.8f, 0.7f, 1.2f, 2.8f, 1.0f, 0.8f, 0.7f, 0.7f, 0.8f }; // Code 1  

                PdfPTable tab = new PdfPTable(colsWidth);
                tab.WidthPercentage = 100;
                


                //CRIA UMA CELULA
                PdfPCell cell = new PdfPCell();
                //INFORMAÇÕES 


                //iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance("logo.PNG");
                // logo.ScaleAbsolute(150f, 50f);
                // document.Add(logo);


                // Paragraph p = new Paragraph("Relatório de Situação Contratual Irregular por Lotes e Empresas\n",titulo);
                // p.Alignment=1;
                // document.Add(p);
                // p = new Paragraph("Data de Emissão:" + DateTime.Now.Day + "/" + DateTime.Now.Month + "/" + DateTime.Now.Year + "\n\n",subtitulo);
                // p.Alignment = 0;
                //  document.Add(p);
                tab.DefaultCell.VerticalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
                cell.BackgroundColor = new iTextSharp.text.BaseColor(215, 23, 31);



                //CABEÇALHO DA TABELA


                cell.Phrase = new Phrase("Lote", f);
                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                tab.AddCell(cell);


                cell.Phrase = new Phrase("Processo", f);
                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                tab.AddCell(cell);

                cell.Phrase = new Phrase("C.N.P.J.", f);
                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                tab.AddCell(cell);

                cell.Phrase = new Phrase("Razão Social", f);
                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                tab.AddCell(cell);


                cell.Phrase = new Phrase("Data de Apresentação", f);
                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                tab.AddCell(cell);
                cell.Phrase = new Phrase("Data de Aquisição", f);

                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                tab.AddCell(cell);
                cell.Phrase = new Phrase("Data de Inicio da Obra", f);

                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                tab.AddCell(cell);
                cell.Phrase = new Phrase("Data do Fim da Obra", f);

                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                tab.AddCell(cell);
                cell.Phrase = new Phrase("Data do Inicio da Operação", f);

                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                tab.AddCell(cell);


                cell.BackgroundColor = BaseColor.WHITE;


                //REPETE CABEÇALHO EM TODAS AS PAGINAS
                tab.HeaderRows = 1;







                int cont = 0;
                int x = 1;
                int j = 0;
                int troca = 0;
                //REPETE NUMERO DE DADOS RETORNADOS DA CONSULTA
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (troca == 0)
                    {
                        if (x == 1 && cont == 0)
                        {
                            cell.BackgroundColor = BaseColor.WHITE;
                            cont = 1;
                        }
                        else if (x > 1 && cont > 0)
                        {
                            cell.BackgroundColor = BaseColor.WHITE;
                        }
                        else
                        {
                            cell.BackgroundColor = new iTextSharp.text.BaseColor(205, 205, 205);
                            troca = 1;

                        }
                    }
                    if (troca == 1)
                    {
                        if (x == 1 && cont > 0)
                        {
                            cell.BackgroundColor = new iTextSharp.text.BaseColor(205, 205, 205);
                            cont = 0;
                        }
                        else if (x > 1 && cont == 0)
                        {
                            cell.BackgroundColor = new iTextSharp.text.BaseColor(205, 205, 205);
                        }
                        else
                        {
                            cell.BackgroundColor = BaseColor.WHITE;
                            troca = 0;
                            cont = 1;
                        }
                    }
                   



                    //ADICIONA CODIGO LOTE NA TABELA
                    cell.Rowspan = 1;
                    cell.Phrase = new Phrase(dt.Rows[i]["COD_LOTE_CODEMIG"].ToString(), l);
                    cell.HorizontalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
                    cell.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                    tab.AddCell(cell);

                    //ADICIONA PROCESSO NA TABELA
                    cell.Rowspan = 1;
                    cell.Phrase = new Phrase(dt.Rows[i]["COD_CLI"].ToString(), f2);
                    cell.HorizontalAlignment = iTextSharp.text.Element.ALIGN_CENTER;
                    cell.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                    tab.AddCell(cell);





                    if (x == 1)
                    {
                        j = i;
                        //REPETE ENQUANDO CNPJ E RAZAO FOREM IGUAIS AO PROXIMOS NA POSIÇÃO DA MATRIZ
                        while (true)
                        {

                            if (j + 1 < dt.Rows.Count && dt.Rows[j]["RAZAO_SOCIAL"].ToString() == dt.Rows[j + 1]["RAZAO_SOCIAL"].ToString())
                            {
                                j++;
                                x++;


                            }
                            else
                            {





                                //ADICIONA CNPJ MECLANDO CELULAS
                                cell.Rowspan = x;
                                cell.Phrase = new Phrase(dt.Rows[i]["CNPJ"].ToString(), f2);
                                cell.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                                cell.HorizontalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;

                                tab.AddCell(cell);


                                ///ADICIONAR RAZAO MECLANDO SUAS CELULAS

                                cell.Rowspan = x;
                                cell.Phrase = new Phrase(dt.Rows[i]["RAZAO_SOCIAL"].ToString(), f2);
                                cell.VerticalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                                cell.HorizontalAlignment = iTextSharp.text.Element.ALIGN_MIDDLE;

                                tab.AddCell(cell);



                                x++;
                                break;
                            }

                        }
                    }
                    x--;




                    //ADICONA DATA APRESENTAXAO
                    cell.Rowspan = 1;
                    cell.Phrase = new Phrase(dt.Rows[i]["DATA_APRESENTACAO"].ToString(), d);
                    cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                    cell.VerticalAlignment = Element.ALIGN_MIDDLE;

                    tab.AddCell(cell);


                    ///ADICIONA DATA DE AQUISICAO
                    cell.Rowspan = 1;
                    cell.Phrase = new Phrase(dt.Rows[i]["DATA_AQUISICAO"].ToString(), f2);
                    cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                    cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                    tab.AddCell(cell);


                    //ADICIONA DATA INICIO DA OBRA
                    cell.Rowspan = 1;
                    cell.Phrase = new Phrase(dt.Rows[i]["DATA_INICIO_OBRA"].ToString(), f2);
                    cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                    cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                    tab.AddCell(cell);

                    //ADICIONA DATA DO FIM DA OBRA

                    cell.Rowspan = 1;
                    cell.Phrase = new Phrase(dt.Rows[i]["DATA_FIM_OBRA"].ToString(), f2);
                    cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                    cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                    tab.AddCell(cell);


                    //ADICIONA DATA INICIO DA OPERAÇÃO
                    cell.Rowspan = 1;
                    cell.Phrase = new Phrase(dt.Rows[i]["DATA_INICIO_OPERACAO"].ToString(), f2);
                    cell.HorizontalAlignment = Element.ALIGN_RIGHT;
                    cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                    tab.AddCell(cell);









                }



                //ADICIONA TABELA AO DOCUMENTO
                document.Add(tab);













                //FECHA DOCUMENTO
                document.Close();



                //LIBERA O OBJETO DA MEMORIA
                document.Dispose();

                return 1;
            }
            else
            {

                return 0;
            }
        }

        

        /*
         * Ativa manutenção
         */
        protected void bntManutencao_Click1(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Clear();
            classes.limpaData(dt);
            dt = conexao.SELECT("SELECT SISTEMA FROM USUARIO WHERE SISTEMA<>1");

            if (dt.Rows.Count > 0)
                conexao.commandExec("UPDATE USUARIO SET SISTEMA=1 WHERE USERNAME<>'root'");
            else
                conexao.commandExec("UPDATE USUARIO SET SISTEMA=0 WHERE USERNAME<>'root'");

            Response.Redirect("~/paineldecontrole.aspx");
        }

        /*
         * Gerar relatório de processo em .xls
         */
        protected void Button1_Processo(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Clear();
            classes.limpaData(dt);
            dt = conexao.SELECT("SELECT DISTINCT NOME_DISTRITO, COD_DI, PROCESSO.COD_CLI, CEP, NOME, NUMERO, TIPO, "+
                "CNPJ, EMAIL, FATURAMENTO_ANUAL, RAZAO_SOCIAL, TELEFONE, TIPO_MONETARIO, COD_EMPRESA_PK, "+
                "NUM_FUNC, NUM_EMPREG_GERADOS, COMPLEMENTO, MUN, UF, BAIRRO FROM DISTRITO "+
                "INNER JOIN QUADRA ON COD_DISTRITO_PK = QUADRA.COD_DISTRITO_FK "+
                "INNER JOIN LOTE ON COD_QUADRA_PK = LOTE.COD_QUADRA_FK "+
                "INNER JOIN PROCESSO_LOTE ON COD_LOTE_PK = PROCESSO_LOTE.COD_LOTE_FK "+
                "INNER JOIN PROCESSO ON COD_PROCESSO_PK = PROCESSO_LOTE.COD_PROCESSO_FK "+
                "INNER JOIN EMPRESA ON COD_EMPRESA_PK = PROCESSO.COD_EMPRESA_FK "+
                "LEFT OUTER JOIN ENDERECO_EMPRESA ON COD_EMPRESA_PK = ENDERECO_EMPRESA.COD_EMPRESA_FK "+
                "WHERE COD_DI='"+ddlDistritos.SelectedValue+"'"
            );

            string attachment = "attachment; filename=processo.xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/vnd.ms-excel";
            Response.ContentEncoding = System.Text.Encoding.Unicode;
            Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());
            string tab = "";
            foreach (DataColumn dc in dt.Columns)
            {
                Response.Write(tab + dc.ColumnName.Trim());
                tab = "\t";
            }
            Response.Write("\n");
            int i;
            foreach (DataRow dr in dt.Rows)
            {
                tab = "";
                for (i = 0; i < dt.Columns.Count; i++)
                {
                    Response.Write(tab + dr[i].ToString().Trim());
                    tab = "\t";
                }
                Response.Write("\n");
            }
            Response.End();
        }

        /*
         * Gerar relatório de histórico em .xls
         */



        
        protected void Button1_Historico(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Clear();
            classes.limpaData(dt);
            dt = conexao.SELECT("select  DISTRITO.COD_DI, PROCESSO.COD_CLI, VOLUME.COD_VOLUME_CODEMIG, HISTORICO.DE, HISTORICO.PARA, HISTORICO.OBSERVECAO, HISTORICO.TIPO_OCORRENCIA, HISTORICO.PAGINA FROM PROCESSO " +
				"INNER JOIN VOLUME ON COD_PROCESSO_PK = VOLUME.COD_PROCESSO_FK "+
				"INNER JOIN HISTORICO_LOTE ON HISTORICO_LOTE.COD_VOLUME_FK = COD_VOLUME_PK "+
				"INNER JOIN HISTORICO ON HISTORICO.COD_HISTORICO_PK = HISTORICO_LOTE.COD_HISTORICO_FK "+
				"INNER JOIN LOTE ON COD_LOTE_PK = HISTORICO_LOTE.COD_LOTE_FK "+
				"INNER JOIN QUADRA ON COD_QUADRA_PK = LOTE.COD_QUADRA_FK "+
				"INNER JOIN DISTRITO ON COD_DISTRITO_PK = QUADRA.COD_DISTRITO_FK "+
                "WHERE COD_DI = '" + ddlDistritos.SelectedValue + "'"
            );

            string attachment = "attachment; filename=historico.xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/vnd.ms-excel";
            Response.ContentEncoding = System.Text.Encoding.Unicode;
            Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());
            string tab = "";
            foreach (DataColumn dc in dt.Columns)
            {
                Response.Write(tab + dc.ColumnName.Trim());
                tab = "\t";
            }
            Response.Write("\n");
            int i;
            foreach (DataRow dr in dt.Rows)
            {
                tab = "";
                for (i = 0; i < dt.Columns.Count; i++)
                {
                    Response.Write(tab + dr[i].ToString().Trim());
                    tab = "\t";
                }
                Response.Write("\n");
            }
            
            Response.End();

        }
       

       
       

        /*
         * Gerar relatório de contrato em .xls
         */
        protected void Button1_Contrato(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Clear();
            classes.limpaData(dt);
            dt = conexao.SELECT("SELECT DISTINCT NOME_DISTRITO, RAZAO_SOCIAL, CNPJ, CONTRATO_VT.DATA_APRESENTACAO, CONTRATO_VT.DATA_AQUISICAO," +
                " CONTRATO_VT.DATA_FIM_OBRA, CONTRATO_VT.DATA_INICIO_OBRA, CONTRATO_VT.DATA_INICIO_OPERACAO FROM EMPRESA"+
                " INNER JOIN PROCESSO ON COD_EMPRESA_PK = PROCESSO.COD_EMPRESA_FK"+
                " INNER JOIN PROCESSO_LOTE ON PROCESSO_LOTE.COD_PROCESSO_FK = COD_PROCESSO_PK"+
                " INNER JOIN LOTE ON COD_LOTE_PK = PROCESSO_LOTE.COD_LOTE_FK"+
                " INNER JOIN QUADRA ON COD_QUADRA_PK = LOTE.COD_QUADRA_FK"+
                " INNER JOIN DISTRITO ON COD_DISTRITO_PK = QUADRA.COD_DISTRITO_FK"+
                " LEFT OUTER JOIN CONTRATO_LOTE ON CONTRATO_LOTE.COD_LOTE_FK = COD_LOTE_PK"+
                " LEFT OUTER JOIN CONTRATO_VT ON COD_CONTRATO_VT_PK = CONTRATO_LOTE.COD_CONTRATO_FK"+
                " WHERE DISTRITO.COD_DI = '" + ddlDistritos.SelectedValue + "'"
            );

            string attachment = "attachment; filename=contrato.xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/vnd.ms-excel";
            Response.ContentEncoding = System.Text.Encoding.Unicode;
            Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());
            string tab = "";
            foreach (DataColumn dc in dt.Columns)
            {
                Response.Write(tab + dc.ColumnName.Trim());
                tab = "\t";
            }
            Response.Write("\n");
            int i;
            foreach (DataRow dr in dt.Rows)
            {
                tab = "";
                for (i = 0; i < dt.Columns.Count; i++)
                {
                    Response.Write(tab + dr[i].ToString().Trim());
                    tab = "\t";
                }
                Response.Write("\n");
            }

            Response.End();

        }

        /*
         * Botão update usuário
         */
        protected void bntUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                int userPK = Convert.ToInt32(hfUserPk.Value);
                String user = txtUsuario.Text;
                String password = txtSenha.Text;
                String name = txtNome.Text;
                String email = txtEmail.Text;
                String nivel = ddlNivel.SelectedValue;
                String proc = "btn disabled";
                String hist = "btn disabled";
                String cont = "btn disabled";
                String cada = "btn disabled";
                String imov = "btn disabled";
                String empr = "btn disabled";

                int recebeEmail = 0;
                if (rdoButtonRecebe.Checked)
                    recebeEmail = 1;
                else if (rdoButtonNRecebe.Checked)
                    recebeEmail = 0;

                if(hfPermissao.Value=="2")
                {
                    if (nivel == "1")
                    {
                        foreach (System.Web.UI.WebControls.ListItem item in cblPaginas.Items)
                        {
                            if (item.Selected)
                            {
                                if (item.Value == "PROCESSO")
                                {
                                    proc = "btn";
                                }
                                else if (item.Value == "HISTORICO")
                                {
                                    hist = "btn";
                                }
                                else if (item.Value == "CONTRATO")
                                {
                                    cont = "btn";
                                }
                                else if (item.Value == "IMOVEL")
                                {
                                    imov = "btn";
                                }
                                else if (item.Value == "EMPRESAS")
                                {
                                    empr = "btn";
                                }
                                // If the item is selected, add the value to the list.

                            }
                            else
                            {
                                // Item is not selected, do something else.
                            }
                        }
                    }
                    else if (nivel == "0")
                    {
                        proc = "btn";
                        hist = "btn";
                        cont = "btn";
                        cada = "btn";
                        imov = "btn disabled";
                        empr = "btn";
                    }
                    else if (nivel == "3")
                    {
                        proc = "btn disabled";
                        hist = "btn disabled";
                        cont = "btn disabled";
                        cada = "btn disabled";
                        imov = "btn";
                        empr = "btn disabled";
                    }
                    else
                    {
                        proc = "btn";
                        hist = "btn";
                        cont = "btn";
                        cada = "btn";
                        imov = "btn";
                        empr = "btn";
                    }


                    if (txtSenha.Text == "")
                    {
                        conexao.commandExec("UPDATE USUARIO SET RECEBE_EMAIL =" + recebeEmail + ", USERNAME ='" + user + "', NOME_COMPLETO ='" + name + "' , EMAIL ='" + email + "' where COD_LOGIN_PK = " + userPK);
                    }
                    else
                    {
                        conexao.commandExec("UPDATE USUARIO SET RECEBE_EMAIL =" + recebeEmail + ", PASSWORD =SUBSTRING(sys.fn_sqlvarbasetostr(HASHBYTES('MD5', '" + password + "')),3,999), USERNAME ='" + user + "', NOME_COMPLETO ='" + name + "' , EMAIL ='" + email + "' where COD_LOGIN_PK = " + userPK);
                    }


                    conexao.commandExec("DELETE FROM PERMISSAO WHERE COD_LOGIN_FK = " + userPK);


                    int codPermissao = 0;

                    codPermissao = conexao.insertReturn(
                        "Declare @count int " +
                        "SELECT @count = COUNT(*) FROM PERMISSAO " +
                        "IF(@count > 0) " +
                        "BEGIN " +
                        "INSERT INTO PERMISSAO([Id], [COD_LOGIN_FK],[PROCESSO],[HISTORICO],[CONTRATO],[CADASTROUSUARIO], [IMOVEL],[TIPOPERMISSAO],[EMPRESAS])OUTPUT Inserted.Id VALUES(((SELECT TOP 1 Id FROM PERMISSAO ORDER BY Id DESC) + 1)," + userPK + ",'" + proc + "','" + hist + "','" + cont + "','" + cada + "','" + imov + "','" + nivel + "', '" + empr + "') " +
                        "END " +
                        "ELSE " +
                        "BEGIN " +
                        "INSERT INTO PERMISSAO([Id], [COD_LOGIN_FK],[PROCESSO],[HISTORICO],[CONTRATO],[CADASTROUSUARIO], [IMOVEL],[TIPOPERMISSAO],[EMPRESAS]) OUTPUT Inserted.Id VALUES(1," + userPK + ",'" + proc + "','" + hist + "','" + cont + "','" + cada + "','" + imov + "','" + nivel + "', '" + empr + "') " +
                        "END", "Id"
                    );

                    if (codPermissao == 0)
                    {
                        conexao.Message("Erro ao tentar cadastrar as permissões");
                        return;
                    }
              


                }
                else if (hfPermissao.Value == "3" || hfPermissao.Value == "0")
                {
                
                      if (nivel == "1")
                         {
                            foreach (System.Web.UI.WebControls.ListItem item in cblPaginas.Items)
                             {
                                if (item.Selected)
                                {
                                    if (item.Value == "PROCESSO")
                                    {
                                        proc = "btn";
                                    }
                                    else if (item.Value == "HISTORICO")
                                    {
                                        hist = "btn";
                                    }
                                    else if (item.Value == "CONTRATO")
                                    {
                                        cont = "btn";
                                    }
                                    else if (item.Value == "IMOVEL")
                                    {
                                        imov = "btn";
                                    }
                                    else if (item.Value == "EMPRESAS")
                                    {
                                        empr = "btn";
                                    }
                                    // If the item is selected, add the value to the list.

                                }
                                else
                                {
                                    // Item is not selected, do something else.
                                }
                            }

                    
                            if (txtSenha.Text == "")
                            {
                                conexao.commandExec("UPDATE USUARIO SET RECEBE_EMAIL =" + recebeEmail + ", USERNAME ='" + user + "', NOME_COMPLETO ='" + name + "' , EMAIL ='" + email + "' where COD_LOGIN_PK = " + userPK);
                            }
                            else
                            {
                                conexao.commandExec("UPDATE USUARIO SET RECEBE_EMAIL =" + recebeEmail + ", PASSWORD =SUBSTRING(sys.fn_sqlvarbasetostr(HASHBYTES('MD5', '" + password + "')),3,999), USERNAME ='" + user + "', NOME_COMPLETO ='" + name + "' , EMAIL ='" + email + "' where COD_LOGIN_PK = " + userPK);
                            }


                            conexao.commandExec("DELETE FROM PERMISSAO WHERE COD_LOGIN_FK = " + userPK);


                            int codPermissao = 0;

                            codPermissao = conexao.insertReturn(
                                "Declare @count int " +
                                "SELECT @count = COUNT(*) FROM PERMISSAO " +
                                "IF(@count > 0) " +
                                "BEGIN " +
                                "INSERT INTO PERMISSAO([Id], [COD_LOGIN_FK],[PROCESSO],[HISTORICO],[CONTRATO],[CADASTROUSUARIO], [IMOVEL],[TIPOPERMISSAO],[EMPRESAS])OUTPUT Inserted.Id VALUES(((SELECT TOP 1 Id FROM PERMISSAO ORDER BY Id DESC) + 1)," + userPK + ",'" + proc + "','" + hist + "','" + cont + "','" + cada + "','" + imov + "','" + nivel + "', '" + empr + "') " +
                                "END " +
                                "ELSE " +
                                "BEGIN " +
                                "INSERT INTO PERMISSAO([Id], [COD_LOGIN_FK],[PROCESSO],[HISTORICO],[CONTRATO],[CADASTROUSUARIO], [IMOVEL],[TIPOPERMISSAO],[EMPRESAS]) OUTPUT Inserted.Id VALUES(1," + userPK + ",'" + proc + "','" + hist + "','" + cont + "','" + cada + "','" + imov + "','" + nivel + "', '" + empr + "') " +
                                "END", "Id"
                            );

                            if (codPermissao == 0)
                            {
                                conexao.Message("Erro ao tentar cadastrar as permissões");
                                return;
                            }

                   
                   
                        }
                        else
                        {
                            if (txtSenha.Text == "")
                            {
                                conexao.commandExec("UPDATE USUARIO SET RECEBE_EMAIL =" + recebeEmail + ", USERNAME ='" + user + "', NOME_COMPLETO ='" + name + "' , EMAIL ='" + email + "' where COD_LOGIN_PK = " + userPK);
                            }
                            else
                            {
                                conexao.commandExec("UPDATE USUARIO SET RECEBE_EMAIL =" + recebeEmail + ", PASSWORD =SUBSTRING(sys.fn_sqlvarbasetostr(HASHBYTES('MD5', '" + password + "')),3,999), USERNAME ='" + user + "', NOME_COMPLETO ='" + name + "' , EMAIL ='" + email + "' where COD_LOGIN_PK = " + userPK);
                            }
                        }
               

                }
                else
                {
                    if (txtSenha.Text == "")
                    {
                        conexao.commandExec("UPDATE USUARIO SET RECEBE_EMAIL =" + recebeEmail + ", USERNAME ='" + user + "', NOME_COMPLETO ='" + name + "' , EMAIL ='" + email + "' where COD_LOGIN_PK = " + userPK);
                    }
                    else
                    {
                        conexao.commandExec("UPDATE USUARIO SET RECEBE_EMAIL =" + recebeEmail + ", PASSWORD =SUBSTRING(sys.fn_sqlvarbasetostr(HASHBYTES('MD5', '" + password + "')),3,999), USERNAME ='" + user + "', NOME_COMPLETO ='" + name + "' , EMAIL ='" + email + "' where COD_LOGIN_PK = " + userPK);
                    }

                }


        }
        catch(Exception ex)
        {
          conexao.Message("Erro ao tentar atualizar usuario. Menssagem original:"+ex.Message);
          return;

        }

           
            
            
            
            conexao.Message("ATUALIZADO COM SUCESSO!");
            txtEmail.Text = "";
            txtNome.Text = "";
            txtSenha.Text = "";
            txtUsuario.Text = "";
            ddlNivel.SelectedIndex = -1;
        }

        /*
         * Botão cadastrar usuário
         */
        protected void bntCadastrar_Click1(object sender, EventArgs e)
        {
            String user = txtUsuario.Text;
            String password = txtSenha.Text;
            String name = txtNome.Text;
            String email = txtEmail.Text;
            String nivel = ddlNivel.SelectedValue;
            String proc = "btn disabled";
            String hist = "btn disabled";
            String cont = "btn disabled";
            String cada = "btn disabled";
            String imov = "btn disabled";
            String empr = "btn disabled";
            int recebeEmail = 0;
            if (rdoButtonRecebe.Checked)
                recebeEmail = 1;
            else if (rdoButtonNRecebe.Checked)
                recebeEmail = 0;

            //
            List<String> Lista = new List<string>();
            // Loop
            if(nivel == "1"){
                foreach (System.Web.UI.WebControls.ListItem item in cblPaginas.Items)
                {
                    if (item.Selected)
                    {
                        if(item.Value == "PROCESSO"){
                            proc = "btn";
                        } else if (item.Value == "HISTORICO"){
                            hist = "btn";
                        } else if (item.Value == "CONTRATO"){
                            cont = "btn";
                        } else if (item.Value == "IMOVEL"){
                            imov = "btn";
                        }else if (item.Value == "EMPRESAS"){
                            empr = "btn";
                        }

                        // If the item is selected, add the value to the list.
                        Lista.Add(item.Value);
                    }
                    else
                    {
                        // Item is not selected, do something else.
                    }
                }
            }
            else if (nivel == "0")
            {
                proc = "btn";
                hist = "btn";
                cont = "btn";
                cada = "btn";
                imov = "btn disabled";
                empr = "btn";
            }
            else if (nivel == "3")
            {
                proc = "btn disabled";
                hist = "btn disabled";
                cont = "btn disabled";
                cada = "btn disabled";
                imov = "btn";
                empr = "btn disabled";
            }
            else
            {
                proc = "btn";
                hist = "btn";
                cont = "btn";
                cada = "btn";
                imov = "btn";
                empr = "btn";
            }

            DataTable dt = new DataTable();
            string comando = "SELECT MAX(COD_LOGIN_PK) AS LastUser FROM USUARIO ORDER BY LastUser";
            int userPK = 0;
            dt.Clear();
            classes.limpaData(dt);
            dt = conexao.SELECT(comando);
            int registros = dt.Rows.Count;
            if (registros > 0)
            {
                for (int i = 0; i < registros; i++)
                {
                    userPK = (int)dt.Rows[i]["LastUser"];
                }
            }
            else
            {
                userPK = 0;
            }

            comando = "SELECT MAX(Id) AS LastPer FROM PERMISSAO ORDER BY LastPer";
            int permissaoPK = 0;
            dt.Clear();
            classes.limpaData(dt);
            dt = conexao.SELECT(comando);
            registros = dt.Rows.Count;
            if (registros > 0)
            {
                    permissaoPK = (int)dt.Rows[dt.Rows.Count-1]["LastPer"];
                
            }
            else
            {
                permissaoPK = 0;
            }

            int VERIFICA = 0;
            permissaoPK++;
            userPK++;
            
            conexao.commandExec("INSERT INTO USUARIO([COD_LOGIN_PK],[USERNAME],[PASSWORD],[NOME_COMPLETO],[EMAIL],[SISTEMA], [RECEBE_EMAIL]) VALUES(" + userPK + ",'" + user + "', SUBSTRING(sys.fn_sqlvarbasetostr(HASHBYTES('MD5', '"+password+"')),3,999),'" + name + "','" + email + "', 1, "+ recebeEmail +")");
            conexao.commandExec("INSERT INTO PERMISSAO([Id], [COD_LOGIN_FK],[PROCESSO],[HISTORICO],[CONTRATO],[CADASTROUSUARIO], [IMOVEL],[EMPRESAS],[TIPOPERMISSAO]) VALUES(" + permissaoPK + "," + userPK + ",'" + proc + "','" + hist + "','" + cont + "','" + cada + "','" + imov + "','"+empr+"','" + nivel + "')");
            VERIFICA++;

            if (VERIFICA >= 1)
            {
                cblPaginas.ClearSelection();
                conexao.Message("CADASTRADO COM SUCESSO!");
                txtEmail.Text = "";
                txtNome.Text = "";
                txtSenha.Text = "";
                txtUsuario.Text = "";
                ddlNivel.SelectedIndex = -1;
            }
        }
    }
}