using CODEMIG.Classes;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CODEMIG
{
    public partial class historico : System.Web.UI.Page
    {
        CODEMIG.Classes.DbUtils.DbConn conexao = new Classes.DbUtils.DbConn();
        
        protected void Page_Load(object sender, EventArgs e)
        {


            StringData webUserStringData = (StringData)Session["webuser"];
            if (!IsPostBack)
            {
                this.PopulateDistritos();
                
            }
            if (Session["webuser"] != null)
            {
                

                if (webUserStringData.userHistorico != "btn")
                {
                    Response.Write("<script>alert('Você não tem permissão para acessar esta página');</script>");
                    Response.Redirect("~/home.aspx?per=2");
                }

                hfPermissao.Value = webUserStringData.userPermission;
                hfLoginPK.Value = webUserStringData.userID;

                if (Convert.ToInt32(Session["Tempo"]) == 0)
                {


                }
                else
                {

                }

                


            }
            
            else
            {
                Response.Write("<script>alert('Faça login para ter acesso ao sistema');</script>");
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Você não tem permissão para acessar esta página')", true);
                //Response.Redirect("~/login.aspx");
                Response.Redirect("~/login.aspx");
            }

        }
        protected void ddlVolume_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable data = new DataTable();
            data.Clear();
            data = conexao.SELECT("SELECT COD_LOTE_CODEMIG, COD_LOTE_PK FROM PROCESSO INNER JOIN PROCESSO_LOTE " +
                "ON PROCESSO.COD_PROCESSO_PK=PROCESSO_LOTE.COD_PROCESSO_FK " +
                "INNER JOIN LOTE " +
                "ON LOTE.COD_LOTE_PK=PROCESSO_LOTE.COD_LOTE_FK " +
                "INNER JOIN QUADRA " +
                "ON QUADRA.COD_QUADRA_PK=LOTE.COD_QUADRA_FK " +
                "INNER JOIN DISTRITO " +
                "ON DISTRITO.COD_DISTRITO_PK=QUADRA.COD_DISTRITO_FK " +
                "WHERE COD_DI = '" + ddlDistritos.Text + "' AND COD_CLI ='" + txtProcesso.Text + "'");

            int registros = 0;
            registros = data.Rows.Count;
            if (registros > 0)
            {
                cblLotes.Items.Clear();
                for (int i = 0; i < registros; i++)
                {
                    cblLotes.Items.Add(data.Rows[i]["COD_LOTE_CODEMIG"].ToString());
                    cblLotes.Items[i].Value = data.Rows[i]["COD_LOTE_PK"].ToString();

                }

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

        public DataTable limpaData(DataTable dt)
        {
            for (int counter = dt.Columns.Count - 1; counter >= 0; counter--)
            {
                dt.Columns.RemoveAt(counter);
            }
            return dt;
        }

        protected void bntCadastrar_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            
            int idVolume = Convert.ToInt32(hfSelectedVolume.Value);
            string dataagora;
            dataagora = "'" + DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day + "'";

            String[] lotes = hfLotes.Value.ToString().Split(new Char[] { ',' });
            int numlinha = lotes.Length;

            /*
             * TRATAR PAGINA NULA
             */
            string pagina;
             if(txtPagina.Text=="")
             {
                 pagina = "NULL";
             }
             else
             {
                 pagina = txtPagina.Text;
             }
            
            /*
             * Coverter Data para padrão SQL 
             */
            String novaData = "";
            String[] dataConvert;
            if (txtData.Text == "")
                novaData = "NULL";
            else
            {
                dataConvert = txtData.Text.Split('/');
                novaData = "'" + dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0] + "'";
            }
            /*
             * Tratar Ocorrência quando for 'Outro(?)'
             */
            String ocorrencia;
            if (ddlOcorrencia.SelectedItem.Value == "Outro")
                ocorrencia = "Outro(" + txtOcorrencia.Text + ")";
            else
                ocorrencia = ddlOcorrencia.SelectedItem.Value;
            /*
            *Cadastrar Histórico e retornar PK 
            */
            int codHistPK = 0;
            codHistPK = conexao.insertReturn(
               "Declare @count int " +
               "SELECT @count = COUNT(*) FROM HISTORICO " +
               "IF(@count > 0) " +
               "BEGIN " +
               "INSERT INTO HISTORICO([COD_HISTORICO_PK],[DATA],[DE],[PARA],[TIPO_OCORRENCIA],[OBSERVECAO], [PAGINA],[COD_CLI],[DATA_CADASTRO_HISTORICO],[CONTROLE_USUARIO_HISTORICO]) OUTPUT Inserted.COD_HISTORICO_PK VALUES( ((SELECT TOP 1 COD_HISTORICO_PK FROM HISTORICO ORDER BY COD_HISTORICO_PK DESC) + 1) ," + novaData + ",'" + txtDe.Text.Replace(",", "") + "','" + txtPara.Text.Replace(",", "") + "','" + ocorrencia + "','" + txtObs.Text.Replace(",", "") + "'," + pagina + ",'" + txtProcesso.Text + "'," + dataagora + "," + hfLoginPK.Value + ") " +
               "END " +
               "ELSE " +
               "BEGIN " +
               "INSERT INTO HISTORICO([COD_HISTORICO_PK],[DATA],[DE],[PARA],[TIPO_OCORRENCIA],[OBSERVECAO], [PAGINA],[COD_CLI],[DATA_CADASTRO_HISTORICO],[CONTROLE_USUARIO_HISTORICO]) OUTPUT Inserted.COD_HISTORICO_PK VALUES( 1 ," + novaData + ",'" + txtDe.Text.Replace(",", "") + "','" + txtPara.Text.Replace(",", "") + "','" + ocorrencia + "','" + txtObs.Text.Replace(",", "") + "'," + pagina + ",'" + txtProcesso.Text + "'," + dataagora + "," + hfLoginPK.Value + ") " +
               "END", "COD_HISTORICO_PK"
           );
            if (codHistPK == 0)
            {
                conexao.Message("Erro ao tentar cadastrar historico!");
                return;
            }
            /*
            *Cadastrar Histórico_Lote e retornar PK 
            */
            int codHistLotePK = 0;
            for (int i = 0; i < numlinha; ++i)
            {
                codHistLotePK = conexao.insertReturn(
                    "Declare @count int " +
                    "SELECT @count = COUNT(*) FROM HISTORICO_LOTE " +
                    "IF(@count > 0) " +
                    "BEGIN " +
                    "INSERT INTO HISTORICO_LOTE([COD_HISTORICO_LOTE_PK],[COD_LOTE_FK],[COD_HISTORICO_FK],[COD_VOLUME_FK] ) OUTPUT Inserted.COD_HISTORICO_LOTE_PK VALUES( ((SELECT TOP 1 COD_HISTORICO_LOTE_PK FROM HISTORICO_LOTE ORDER BY COD_HISTORICO_LOTE_PK DESC) + 1) ," + lotes[i] + "," + codHistPK + "," + idVolume + ") " +
                    "END " +
                    "ELSE " +
                    "BEGIN " +
                    "INSERT INTO HISTORICO_LOTE([COD_HISTORICO_LOTE_PK],[COD_LOTE_FK],[COD_HISTORICO_FK],[COD_VOLUME_FK] ) OUTPUT Inserted.COD_HISTORICO_LOTE_PK VALUES( 1 ," + lotes[i] + "," + codHistPK + "," + idVolume + ") " +
                    "END", "COD_HISTORICO_LOTE_PK"
                    //////////ERRO
                );
            }
            if (codHistLotePK == 0)
            {
                conexao.commandExec("DELETE FROM HISTORICO WHERE COD_HISTORICO_PK = " + codHistPK);
                conexao.Message("Erro ao cadastrar lotes para historico");
                
                return;
            }
            else
            {
                conexao.Message("Cadastrado");
                
            }
            
            
        }


        protected void bntUpdate_Click(object sender, EventArgs e)
        {
            
            int codHistPK = Convert.ToInt32(hfHistoricoPK.Value);

            int idVolume = Convert.ToInt32(hfSelectedVolume.Value);

            String[]  lotes = hfLotes.Value.ToString().Split(new Char[] { ',' });
            int numlinha = lotes.Length;
            /*
             * TRATAR PAGINA NULA
             */
            string pagina;
            if (txtPagina.Text == "")
            {
                pagina = "NULL";
            }
            else
            {
                pagina = txtPagina.Text;
            }

            /*
             * Tratar Ocorrência quando for 'Outro(?)'
             */
            String ocorrencia;
            if (ddlOcorrencia.SelectedItem.Value == "Outro")
            {
                ocorrencia = "Outro(" + txtOcorrencia.Text + ")";
            }
            else
            {
                ocorrencia = ddlOcorrencia.SelectedItem.Value;
            }

            /*
             * Coverter Data para padrão SQL 
             */
            String novaData = "";
            String[] dataConvert = txtData.Text.Split(' ');
            if (txtData.Text == "")
                novaData = "NULL";
            else
            {
                dataConvert = dataConvert[0].Split('/');
                novaData = dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0];
            }
            /*
            *Update HISTORICO
            */
            conexao.commandExec("UPDATE HISTORICO SET DATA ='" + novaData + "', PAGINA =" + pagina + ", DE ='" + txtDe.Text.Replace(",", "") + "' , PARA ='" + txtPara.Text.Replace(",", "") + "' , TIPO_OCORRENCIA ='" + ocorrencia + "' , OBSERVECAO =  '" + txtObs.Text + "' where COD_HISTORICO_PK = " + codHistPK);
            /*
            *Deletar todos Histórico_Lote
            */
            conexao.commandExec("DELETE FROM HISTORICO_LOTE WHERE COD_HISTORICO_FK = " + codHistPK);
            /*
            *Cadastrar Histórico_Lote e retornar PK 
            */
            int codHistLotePK = 0;
            for (int i = 0; i < numlinha; ++i)
            {
                codHistLotePK = conexao.insertReturn(
                    "Declare @count int " +
                    "SELECT @count = COUNT(*) FROM HISTORICO_LOTE " +
                    "IF(@count > 0) " +
                    "BEGIN " +
                    "INSERT INTO HISTORICO_LOTE([COD_HISTORICO_LOTE_PK],[COD_LOTE_FK],[COD_HISTORICO_FK],[COD_VOLUME_FK] ) OUTPUT Inserted.COD_HISTORICO_LOTE_PK VALUES( ((SELECT TOP 1 COD_HISTORICO_LOTE_PK FROM HISTORICO_LOTE ORDER BY COD_HISTORICO_LOTE_PK DESC) + 1) ," + lotes[i] + "," + codHistPK + "," + idVolume + ") " +
                    "END " +
                    "ELSE " +
                    "BEGIN " +
                    "INSERT INTO HISTORICO_LOTE([COD_HISTORICO_LOTE_PK],[COD_LOTE_FK],[COD_HISTORICO_FK],[COD_VOLUME_FK] ) OUTPUT Inserted.COD_HISTORICO_LOTE_PK VALUES( 1 ," + lotes[i] + "," + codHistPK + "," + idVolume + ") " +
                    "END", "COD_HISTORICO_LOTE_PK"
                );
            }
            if (codHistLotePK == 0)
            {
                conexao.Message("Erro ao alterar lotes para historico");
                return;
            }

            conexao.Message("Alterado");
            txtData.Text = "";
            txtDe.Text = "";
            txtPara.Text = "";
            txtOcorrencia.Text = "";
            txtObs.Text = "";
            txtPagina.Text = "";
            //teste2.Style.Add("display", "block");
            //ddlOcorrencia.SelectedIndex = -1;
            //ddlDistritos.SelectedIndex = -1;
            //hfLotes.Value = "";
            //hfHistoricoPK.Value = "";
            //hfVolumePK.Value = "";
            //txtProcesso.Text = "";
            
        }

    }
}