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
    public partial class empresas : System.Web.UI.Page
    {


        CODEMIG.Classes.DbUtils.DbConn conexao = new CODEMIG.Classes.DbUtils.DbConn();
        protected void Page_Load(object sender, EventArgs e)
        {
            StringData webUserStringData = (StringData)Session["webuser"];
            if (!IsPostBack)
            {
                this.PopulateDistritos();

            }
            if (Session["webuser"] != null)
            {


                if (webUserStringData.userEmpresas != "btn")
                {
                    Response.Write("<script>alert('Você não tem permissão para acessar esta página');</script>");
                    Response.Redirect("~/home.aspx?per=4");
                    
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
        protected void bntCadastrarProcesso_Click(object sender, EventArgs e)
        {



            int codProcessoPK = 0;
            String processo = txtProcesso.Text;
            // int codEmpresaPK = Convert.ToInt32(hfEmpresa.Value);
            DataTable dt = new DataTable();

            try
            {
                if (hfProcessoPK.Value != "")
                {
                    if (hfEmpresa.Value == null && hfEmpresa.Value == "-1" && hfEmpresa.Value == "")
                    {

                        lblCadastradoPasta.ForeColor = System.Drawing.Color.White;
                        lblCadastradoPasta.Text = "Não Cadastrado. Selecione uma empresa por favor!";
                        lblCadastradoPasta.Visible = true;
                        lblCadastradoPasta.CssClass = "naoCadastrado";
                        return;
                    }
                    if (hfEmpresaProcesso.Value != null && hfEmpresaProcesso.Value != "-1" && hfEmpresaProcesso.Value != "")
                    {
                       
                        lblCadastradoPasta.ForeColor = System.Drawing.Color.White;
                        lblCadastradoPasta.Text = "Não Cadastrado. Processo pertence á uma empresa!";
                        lblCadastradoPasta.Visible = true;
                        lblCadastradoPasta.CssClass = "naoCadastrado";
                        return;
                    }
                   

                    codProcessoPK = conexao.insertReturn(
                        "Declare @count int " +
                        "Declare @existe int " +
                        "SELECT @count = COUNT(*) FROM PROCESSO " +
                        "SELECT @existe = COUNT(*) FROM PROCESSO WHERE COD_CLI = '" + txtProcesso.Text + "' " +
                        "IF(@existe = 0) " +
                        "BEGIN " +
                            "IF(@count > 0) " +
                            "BEGIN " +
                            "INSERT INTO PROCESSO([COD_PROCESSO_PK],[COD_CLI],[COD_EMPRESA_FK]) OUTPUT Inserted.COD_PROCESSO_PK VALUES( ((SELECT TOP 1 COD_PROCESSO_PK FROM PROCESSO ORDER BY COD_PROCESSO_PK DESC) + 1) ,'" + txtProcesso.Text + "'," + hfEmpresa.Value + ") " +
                            "END " +
                            "ELSE " +
                            "BEGIN " +
                            "INSERT INTO PROCESSO([COD_PROCESSO_PK],[COD_CLI],[COD_EMPRESA_FK]) OUTPUT Inserted.COD_PROCESSO_PK VALUES(1,'" + txtProcesso.Text + "'," + hfEmpresa.Value + ") " +
                            "END " +
                        "END", "COD_PROCESSO_PK"
                    );
                    if (codProcessoPK == 0)
                    {
                        lblCadastradoPasta.ForeColor = System.Drawing.Color.White;
                        lblCadastradoPasta.Text = "Não Cadastrado. Processo existente!";
                        lblCadastradoPasta.Visible = true;
                        lblCadastradoPasta.CssClass = "naoCadastrado";
                        return;
                    }


                }
                else
                {
                    lblCadastradoPasta.ForeColor = System.Drawing.Color.White;
                    lblCadastradoPasta.Text = "Informe o processo.";
                    lblCadastradoPasta.Visible = true;
                    lblCadastradoPasta.CssClass = "naoCadastrado";
                    return;
                }





            }
            catch (Exception exception)
            {
                //e.Message;
                lblCadastradoPasta.ForeColor = System.Drawing.Color.White;
                
                lblCadastradoPasta.Text = conexao.Translate(exception.Message);
                lblCadastradoPasta.Visible = true;
                lblCadastradoPasta.CssClass = "naoCadastrado";
                return;
            }




            txtProcesso.Text = "";

            //função para mostra alert, parametro e a messagem exibida
            //conexao.Message("VOLUMES CADASTRADOS COM SUCESSO.");
            lblCadastradoPasta.ForeColor = System.Drawing.Color.White;
            lblCadastradoPasta.Text = "Cadastrado";
            lblCadastradoPasta.Visible = true;
            lblCadastradoPasta.CssClass = "cadastrado";






        }
        protected void bntUpdateEmpresa_Click(object sender, EventArgs e)
        {
            string faturamento="";
            string numfunc="";
            string numempgera="";
            string numero="";


            ////////////////
            if (txtFaturamento.Text != "" && txtFaturamento.Text != "NULL" && txtFaturamento.Text != null)
            {
                faturamento = txtFaturamento.Text;
            }
            else
            {
                faturamento = "NULL";
            }
            /////////////////////

            if (txtNumFunc.Text != "" && txtNumFunc.Text != "NULL" && txtNumFunc.Text != null)
            {
                numfunc = txtNumFunc.Text;
            }
            else
            {
                numfunc = "NULL";
            }
            ///////////////////

            if (txtNumEmpregosGerados.Text != "" && txtNumEmpregosGerados.Text != "NULL" && txtNumEmpregosGerados.Text != null)
            {
                 numempgera= txtNumEmpregosGerados.Text;
            }
            else
            {
                numempgera = "NULL";
            }

            ///////////////////////

            if (txtNumero.Text != "" && txtNumero.Text != "NULL" && txtNumero.Text != null)
            {
                numero = txtNumero.Text;
            }
            else
            {
                numero = "NULL";
            }
            string tipomonetario = "NULL";
            if (ddlTipoMonetario.SelectedValue != "0")
            {
                tipomonetario = "'" + ddlTipoMonetario.SelectedValue + "'";
            }

            if(txtRazaoSocial.Text!="" && txtCNPJ.Text!="")
            {
                conexao.commandExec("UPDATE EMPRESA SET RAZAO_SOCIAL='" + txtRazaoSocial.Text + "',CNPJ='" + txtCNPJ.Text + "',EMAIL='" + txtEmail.Text + "',FATURAMENTO_ANUAL=" + faturamento.Replace(".", "").Replace(",", ".") + ",TELEFONE='" + txtTelefone.Text + "',TIPO_MONETARIO=" + tipomonetario + ",NUM_FUNC=" + numfunc + ",NUM_EMPREG_GERADOS=" + numempgera + ",ATIVIDADE='" + txtAtividades.Text + "' WHERE COD_EMPRESA_PK=" + hfEmpresa.Value);
                conexao.commandExec("UPDATE ENDERECO_EMPRESA SET CEP='" + txtCEP.Text + "',NOME='" + txtNomeRua.Text + "',NUMERO=" + numero + ",TIPO='" + ddlTipoRua.Text + "',COMPLEMENTO='" + txtComplemento.Text + "',MUN='" + txtCidade.Text + "',UF='" + ddlUF.Text + "',BAIRRO='" + txtBairro.Text + "' WHERE COD_EMPRESA_FK=" + hfEmpresa.Value);
            }
           

        }
        protected void bntUpdate_Click(object sender, EventArgs e)
        {
            string empresaprocesso = hfEmpresaProcesso.Value;
            string empresapk = "";
            string processoPk;
            string[] lotepk;
            lotepk = hfLotes.Value.Split(',');
            empresapk = hfEmpresa.Value;
            processoPk = hfProcessoPK.Value;
            int numlinha = lotepk.Length;


            string dataagora;
            dataagora = "'" + DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day + "'";

            if ( hfProcessoPK.Value != "")
            {
                if(lotepk.Length>0)
                {
                    if (empresaprocesso == "-1" || empresaprocesso == "" || empresaprocesso == null)
                    {
                        conexao.commandExec("UPDATE PROCESSO SET COD_EMPRESA_FK=" + empresapk + " WHERE COD_PROCESSO_PK=" + processoPk);
                        empresaprocesso = empresapk;
                    }



                    if (empresaprocesso == empresapk)
                    {


                        conexao.commandExec("DELETE FROM PROCESSO_LOTE WHERE COD_PROCESSO_FK=" + processoPk);

                        int codProcessoLote = 0;
                        for (int i = 0; i < numlinha; ++i)
                        {
                            codProcessoLote = conexao.insertReturn(
                                "Declare @count int " +
                                "SELECT @count = COUNT(*) FROM PROCESSO_LOTE " +
                                "IF(@count > 0) " +
                                "BEGIN " +
                                "INSERT INTO PROCESSO_LOTE([COD_PROCESSO_LOTE_PK],[COD_LOTE_FK],[COD_PROCESSO_FK] ) OUTPUT Inserted.COD_PROCESSO_LOTE_PK VALUES( ((SELECT TOP 1 COD_PROCESSO_LOTE_PK FROM PROCESSO_LOTE ORDER BY COD_PROCESSO_LOTE_PK DESC) + 1) ," + lotepk[i] + "," + processoPk + ") " +
                                "END " +
                                "ELSE " +
                                "BEGIN " +
                                "INSERT INTO PROCESSO_LOTE([COD_PROCESSO_LOTE_PK],[COD_LOTE_FK],[COD_PROCESSO_FK] ) OUTPUT Inserted.COD_PROCESSO_LOTE_PK VALUES( 1 ," + lotepk[i] + "," + processoPk + ") " +
                                "END", "COD_PROCESSO_LOTE_PK"
                            );

                            if (codProcessoLote == 0)
                            {
                                conexao.commandExec("DELETE FROM PROCESSO_LOTE WHERE COD_PROCESSO_FK=" + processoPk);
                                conexao.Message("Erro ao cadastrar lotes para processo");
                                return;
                            }
                        }
                    }
                    else
                    {
                        conexao.Message("Processo pertence a outra empresa!");
                        return;

                    }

                }
                else
                {

                    conexao.Message("Selecione no minímo um lote!");
                    return;

                }

                

               




                
               
            }else
            {
                conexao.Message("Selecione um processo!");
                return;
            }


            conexao.Message("Cadastrado");


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
        public void limparCampos()
        {

        }
        protected void bntCadastrar_Click(object sender, EventArgs e)
        {


            if (txtCNPJ.Text != "")
            {
                string cnpj = txtCNPJ.Text;
                DataTable dt = new DataTable();
                int codEmpresaPK = 0;
                int codEndEmpresaPK = 0;


                dt.Clear();
                dt = conexao.SELECT("SELECT COD_EMPRESA_PK FROM EMPRESA WHERE CNPJ='" + cnpj + "' ORDER BY COD_EMPRESA_PK");
                if (dt.Rows.Count > 0)
                {
                    conexao.Message("Empresa ja Cadastrada!");
                    return;
                }
                else
                {
                    string valfaturamento = "";
                    string numerofuc = "";
                    string numeroempr = "";
                    if (txtFaturamento.Text == "")
                    {
                        valfaturamento = "NULL";
                    }
                    else
                    {
                        valfaturamento = txtFaturamento.Text;
                    }
                    if (txtNumEmpregosGerados.Text == "0" || txtNumEmpregosGerados.Text == "")
                    {
                        numeroempr = "NULL";
                    }
                    else
                    {
                        numeroempr = txtNumEmpregosGerados.Text;
                    }
                    if (txtNumFunc.Text == "0" || txtNumFunc.Text == "")
                    {
                        numerofuc = "NULL";
                    }
                    else
                    {
                        numerofuc = txtNumFunc.Text;
                    }
                    string dataagora;
                    dataagora = "'" + DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day + "'";
                    string atividade = "";
                    if (txtAtividades.Text == "")
                    {
                        atividade = "NULL";
                    }
                    else
                    {
                        atividade = "'" + txtAtividades.Text + "'";

                    }
                    string tipomonetario = "NULL";
                    if (ddlTipoMonetario.SelectedValue != "0")
                    {
                        tipomonetario = "'" + ddlTipoMonetario.SelectedValue + "'";
                    }


                    codEmpresaPK = conexao.insertReturn(
                   "Declare @count int " +
                   "SELECT @count = COUNT(*) FROM EMPRESA " +
                   "IF(@count > 0) " +
                   "BEGIN " +
                   "INSERT INTO EMPRESA([COD_EMPRESA_PK],[CNPJ],[RAZAO_SOCIAL],[EMAIL],[TELEFONE],[TIPO_MONETARIO],[FATURAMENTO_ANUAL],[ATIVIDADE],[NUM_FUNC],[NUM_EMPREG_GERADOS],[DATA_CADASTRO_EMPRESA],[CONTROLE_USUARIO_EMPRESA]) OUTPUT Inserted.COD_EMPRESA_PK VALUES( ((SELECT TOP 1 COD_EMPRESA_PK FROM EMPRESA ORDER BY COD_EMPRESA_PK DESC) + 1) ,'" + cnpj + "','" + txtRazaoSocial.Text + "', '" + txtEmail.Text + "','" + txtTelefone.Text + "'," + tipomonetario + "," + valfaturamento.Replace(".", "").Replace(",", ".") + "," + atividade + "," + numerofuc + "," + numeroempr + "," + dataagora + "," + hfLoginPK.Value + ") " +
                   "END " +
                   "ELSE " +
                   "BEGIN " +
                   "INSERT INTO EMPRESA([COD_EMPRESA_PK],[CNPJ],[RAZAO_SOCIAL],[EMAIL],[TELEFONE],[TIPO_MONETARIO],[FATURAMENTO_ANUAL],[ATIVIDADE],[NUM_FUNC],[NUM_EMPREG_GERADOS],[DATA_CADASTRO_EMPRESA],[CONTROLE_USUARIO_EMPRESA]) OUTPUT Inserted.COD_EMPRESA_PK VALUES( 1 ,'" + cnpj + "','" + txtRazaoSocial.Text + "', '" + txtEmail.Text + "','" + txtTelefone.Text + "','" + ddlTipoMonetario.SelectedValue + "'," + valfaturamento.Replace(".", "").Replace(",", ".") + "," + atividade + "," + numerofuc + "," + numeroempr + "," + dataagora + "," + hfLoginPK.Value + ") " +
                   "END", "COD_EMPRESA_PK");

                    if (codEmpresaPK > 0)
                    {


                        string numero = "NULL";
                        if (txtNumero.Text == "" || txtNumero.Text == "0")
                        {
                            numero = "NULL";

                        }
                        else
                        {
                            numero = txtNumero.Text;
                        }

                        dataagora = "'" + DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day + "'";


                        codEndEmpresaPK = conexao.insertReturn("SELECT COD_ENDERECO_EMPRESA_PK FROM ENDERECO_EMPRESA WHERE COD_EMPRESA_FK=" + codEmpresaPK, "COD_ENDERECO_EMPRESA_PK");

                        if (codEndEmpresaPK == 0)
                        {
                            codEndEmpresaPK = conexao.insertReturn("INSERT INTO ENDERECO_EMPRESA([COD_ENDERECO_EMPRESA_PK],[NOME],[CEP],[NUMERO],[TIPO],[COMPLEMENTO],[BAIRRO],[MUN],[UF],[COD_EMPRESA_FK],[DATA_CADASTRO_ENDERECO],[CONTROLE_USUARIO_ENDERECO]) OUTPUT Inserted.COD_ENDERECO_EMPRESA_PK VALUES( ((SELECT TOP 1 COD_ENDERECO_EMPRESA_PK FROM ENDERECO_EMPRESA ORDER BY COD_ENDERECO_EMPRESA_PK DESC) + 1),'" + txtNomeRua.Text + "','" + txtCEP.Text + "'," + numero + ",'" + ddlTipoRua.SelectedValue + "','" + txtComplemento.Text + "','" + txtBairro.Text + "','" + txtCidade.Text + "','" + ddlUF.SelectedValue.ToString() + " '," + codEmpresaPK + "," + dataagora + "," + hfLoginPK.Value + ")", "COD_ENDERECO_EMPRESA_PK");
                            if (codEndEmpresaPK == 0)
                            {
                                conexao.Message("Erro ao cadastrar endereço da empresa. Verifique os valores informados.");
                                return;
                            }
                            else
                            {

                                conexao.Message("Cadastrato com sucesso!");

                            }
                        }

                    }
                    else
                    {
                        conexao.Message("Erro ao cadastrar empresa. Verifique os valores informados.");
                        return;
                    }



                    //lbl2.Visible = true;

                }


            }




        }







    }
}