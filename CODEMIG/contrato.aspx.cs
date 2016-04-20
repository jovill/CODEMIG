using CODEMIG.Classes;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CODEMIG
{
    public partial class contrato : System.Web.UI.Page
    {
        CODEMIG.Classes.DbUtils.DbConn conexao = new Classes.DbUtils.DbConn();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                this.PopulateDistritos();

            StringData webUserStringData = (StringData)Session["webuser"];

            if (Session["webuser"] != null)
            {
                if (webUserStringData.userContrato != "btn")
                {
                    Response.Write("<script>alert('Você não tem permissão para acessar esta página');</script>");
                    Response.Redirect("~/home.aspx?per=3");
                }

                hfPermissao.Value = webUserStringData.userPermission;
                hfLoginPK.Value = webUserStringData.userID;
            }
            else
            {
                Response.Write("<script>alert('Faça login para ter acesso ao sistema');</script>");
                Response.Redirect("~/login.aspx");
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
        protected void bntCadastrar_Click1(object sender, EventArgs e)
        {
            string dataagora;
            dataagora = "'" + DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day + "'";
            /*
             * Coverter Datas para padrão SQL 
             */
            String[] novaData = new String[5];
            String[] dataConvert;
            if (txtDataApre.Text == "")
                novaData[0] = "NULL";
            else
            {
                dataConvert = txtDataApre.Text.Split('/');
                novaData[0] = "'" + dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0] + "'";
            }
            if (txtAquis.Text == "")
                novaData[1] = "NULL";
            else
            {
                dataConvert = txtAquis.Text.Split('/');
                novaData[1] = "'" + dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0] + "'";
            }
            if (txtDataIniOp.Text == "")
                novaData[2] = "NULL";
            else
            {
                dataConvert = txtDataIniOp.Text.Split('/');
                novaData[2] = "'" + dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0] + "'";
            }
            if (txtDataInicioOb.Text == "")
                novaData[3] = "NULL";
            else
            {
                dataConvert = txtDataInicioOb.Text.Split('/');
                novaData[3] = "'" + dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0] + "'";
            }
            if (txtDataFimOb.Text == "")
                novaData[4] = "NULL";
            else
            {
                dataConvert = txtDataFimOb.Text.Split('/');
                novaData[4] = "'" + dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0] + "'";
            }
            /*
            *Cadastrar Contrato e retornar PK 
            */
            int codContratoPK = 0;
            codContratoPK = conexao.insertReturn(
                "Declare @count int " +
                "SELECT @count = COUNT(*) FROM CONTRATO_VT " +
                "IF(@count > 0) " +
                "BEGIN " +
                "INSERT INTO CONTRATO_VT([COD_CONTRATO_VT_PK],[DATA_APRESENTACAO],[DATA_AQUISICAO],[DATA_INICIO_OPERACAO],[DATA_INICIO_OBRA],[DATA_FIM_OBRA],[DATA_CADASTRO_CONTRATO_VT],[CONTROLE_USUARIO_CONTRATO_VT]) OUTPUT Inserted.COD_CONTRATO_VT_PK VALUES( ((SELECT TOP 1 COD_CONTRATO_VT_PK FROM CONTRATO_VT ORDER BY COD_CONTRATO_VT_PK DESC) + 1) ," + novaData[0] + "," + novaData[1] + "," + novaData[2] + "," + novaData[3] + "," + novaData[4] + "," + dataagora + "," + hfLoginPK.Value + ") " +
                "END " +
                "ELSE " +
                "BEGIN " +
                "INSERT INTO CONTRATO_VT([COD_CONTRATO_VT_PK],[DATA_APRESENTACAO],[DATA_AQUISICAO],[DATA_INICIO_OPERACAO],[DATA_INICIO_OBRA],[DATA_FIM_OBRA],[DATA_CADASTRO_CONTRATO_VT],[CONTROLE_USUARIO_CONTRATO_VT]) OUTPUT Inserted.COD_CONTRATO_VT_PK VALUES( 1 ," + novaData[0] + "," + novaData[1] + "," + novaData[2] + "," + novaData[3] + "," + novaData[4] + "," + dataagora + "," + hfLoginPK.Value + ") " +
                "END", "COD_CONTRATO_VT_PK"
            );
            if (codContratoPK == 0)
            {
                conexao.Message("Erro");
                return;
            };
            /*
            *Cadastrar Contrato_Lote e retornar PK 
            */
            String[] lotes = hfLotes.Value.ToString().Split(new Char[] { ',' });
            int numlinha = lotes.Length;
            int codContratoLotePK = 0;
            for (int i = 0; i < numlinha; ++i)
            {
                codContratoLotePK = conexao.insertReturn(
                    "Declare @count int " +
                    "SELECT @count = COUNT(*) FROM CONTRATO_VT " +
                    "IF(@count > 0) " +
                    "BEGIN " +
                    "INSERT INTO CONTRATO_LOTE([COD_CONTRATO_LOTE_PK],[COD_LOTE_FK],[COD_CONTRATO_FK] ) OUTPUT Inserted.COD_CONTRATO_LOTE_PK VALUES( ((SELECT TOP 1 COD_CONTRATO_LOTE_PK FROM CONTRATO_LOTE ORDER BY COD_CONTRATO_LOTE_PK DESC) + 1) ," + lotes[i] + "," + codContratoPK + ") " +
                    "END " +
                    "ELSE " +
                    "BEGIN " +
                    "INSERT INTO CONTRATO_LOTE([COD_CONTRATO_LOTE_PK],[COD_LOTE_FK],[COD_CONTRATO_FK] ) OUTPUT Inserted.COD_CONTRATO_LOTE_PK VALUES( 1," + lotes[i] + "," + codContratoPK + ") " +
                    "END", "COD_CONTRATO_LOTE_PK"
                );
            }
            if (codContratoLotePK == 0)
            {
                conexao.Message("Erro");
                return;
            };

            txtRazao.Text = "";
            conexao.Message("Cadastrado");

        }


        protected void bntUpdate_Click(object sender, EventArgs e)
        {
            /*
             * Coverter Datas para padrão SQL 
             */
            String[] novaData = new String[5];
            String[] dataConvert;
            if (txtDataApre.Text == "")
                novaData[0] = "NULL";
            else
            {
                dataConvert = txtDataApre.Text.Split('/');
                novaData[0] = "'" + dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0] + "'";
            }
            if (txtAquis.Text == "")
                novaData[1] = "NULL";
            else
            {
                dataConvert = txtAquis.Text.Split('/');
                novaData[1] = "'" + dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0] + "'";
            }
            if (txtDataIniOp.Text == "")
                novaData[2] = "NULL";
            else
            {
                dataConvert = txtDataIniOp.Text.Split('/');
                novaData[2] = "'" + dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0] + "'";
            }
            if (txtDataInicioOb.Text == "")
                novaData[3] = "NULL";
            else
            {
                dataConvert = txtDataInicioOb.Text.Split('/');
                novaData[3] = "'" + dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0] + "'";
            }
            if (txtDataFimOb.Text == "")
                novaData[4] = "NULL";
            else
            {
                dataConvert = txtDataFimOb.Text.Split('/');
                novaData[4] = "'" + dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0] + "'";
            }
            /*
            *Update CONTRATO
            */
            int codContratoPK = Convert.ToInt32(hfContratoPK.Value);
            conexao.commandExec("UPDATE CONTRATO_VT SET DATA_APRESENTACAO =" + novaData[0] + ", DATA_AQUISICAO =" + novaData[1] + " , DATA_INICIO_OPERACAO =" + novaData[2] + " , DATA_INICIO_OBRA =" + novaData[3] + " , DATA_FIM_OBRA =  " + novaData[4] + " where COD_CONTRATO_VT_PK = " + codContratoPK);
            /*
            *Deletar Contrato_Lote
            */
            conexao.commandExec("DELETE FROM CONTRATO_LOTE WHERE COD_CONTRATO_FK = " + codContratoPK);
            /*
            *Cadastrar Contrato_Lote e retornar PK
            */
            String[] lotes = hfLotes.Value.ToString().Split(new Char[] { ',' });
            int numlinha = lotes.Length;
            int codContratoLotePK = 0;
            for (int i = 0; i < numlinha; ++i)
            {
                codContratoLotePK = conexao.insertReturn(
                    "Declare @count int " +
                    "SELECT @count = COUNT(*) FROM CONTRATO_VT " +
                    "IF(@count > 0) " +
                    "BEGIN " +
                    "INSERT INTO CONTRATO_LOTE([COD_CONTRATO_LOTE_PK],[COD_LOTE_FK],[COD_CONTRATO_FK] ) OUTPUT Inserted.COD_CONTRATO_LOTE_PK VALUES( ((SELECT TOP 1 COD_CONTRATO_LOTE_PK FROM CONTRATO_LOTE ORDER BY COD_CONTRATO_LOTE_PK DESC) + 1) ," + lotes[i] + "," + codContratoPK + ") " +
                    "END " +
                    "ELSE " +
                    "BEGIN " +
                    "INSERT INTO CONTRATO_LOTE([COD_CONTRATO_LOTE_PK],[COD_LOTE_FK],[COD_CONTRATO_FK] ) OUTPUT Inserted.COD_CONTRATO_LOTE_PK VALUES( 1," + lotes[i] + "," + codContratoPK + ") " +
                    "END", "COD_CONTRATO_LOTE_PK"
                );
            }
            if (codContratoLotePK == 0)
            {
                conexao.Message("Erro");
                return;
            };
            
            conexao.Message("Atualizado");
            txtAquis.Text = "";
            txtDataApre.Text = "";
            txtDataFimOb.Text = "";
            txtDataInicioOb.Text = "";
            txtDataIniOp.Text = "";
            txtRazao.Text = "";

        }

    }
}