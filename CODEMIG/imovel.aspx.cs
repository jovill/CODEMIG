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
    public partial class imovel : System.Web.UI.Page
    {
        CODEMIG.Classes.DbUtils.DbConn conexao = new Classes.DbUtils.DbConn();
        protected void Page_Load(object sender, EventArgs e)
        {

            StringData webUserStringData = (StringData)Session["webuser"];
            if (!IsPostBack)
            {
                

            }
            else
            {
               
            }
            if (Session["webuser"] != null)
            {


                if (webUserStringData.userImovel != "btn")
                {
                    Response.Write("<script>alert('Você não tem permissão para acessar esta página');</script>");
                    Response.Redirect("~/home.aspx?per=7");
                }
                PopulateMunicipio();

                /*if (webUserStringData.userHistorico != "btn")
                {
                    Response.Write("<script>alert('Você não tem permissão para acessar esta página');</script>");
                    Server.Transfer("~/home.aspx", true);
                }*/

                hfPermissao.Value = webUserStringData.userPermission;
                hfLoginPK.Value = webUserStringData.userID;

               




            }

            else
            {
                Response.Write("<script>alert('Faça login para ter acesso ao sistema');</script>");
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Você não tem permissão para acessar esta página')", true);
                //Response.Redirect("~/login.aspx");
                Response.Redirect("~/login.aspx");
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

        private void PopulateMunicipio()
        {
            String strConnString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;
            String strQuery = "select DISTINCT CIDADE from ENDERECO_IMOVEL";
            using (SqlConnection con = new SqlConnection(strConnString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strQuery;
                    cmd.Connection = con;
                    con.Open();
                    ddlMuni.DataSource = cmd.ExecuteReader();
                    ddlMuni.DataTextField = "CIDADE";
                    ddlMuni.DataValueField = "CIDADE";
                    ddlMuni.DataBind();
                    con.Close();

                }
            }
        }
        private void PopulateMunicipio( string cidade)
        {
            String strConnString = ConfigurationManager
                .ConnectionStrings["MyConnString"].ConnectionString;
            String strQuery = "select DISTINCT CIDADE from ENDERECO_IMOVEL";
            using (SqlConnection con = new SqlConnection(strConnString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strQuery;
                    cmd.Connection = con;
                    con.Open();
                    
                    ddlMuni.Items.Clear();
                    ddlMuni.DataSource = cmd.ExecuteReader();
                    //ddlMuni.Items.Add(new ListItem(cidade, cidade));
                    ddlMuni.SelectedValue = cidade;
                   
                    ddlMuni.DataBind();
                    con.Close();

                }
            }
        }

        protected void bntUpdateInfo_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtDenominacao.Text) || string.IsNullOrEmpty(txtNPatrimonio.Text))
                return;

            string numPatrimonio = "NULL";
            if (!string.IsNullOrEmpty(txtNPatrimonio.Text))
                numPatrimonio = txtNPatrimonio.Text;

            string area = "NULL";
            if (!string.IsNullOrEmpty(txtArea.Text))
                area = txtArea.Text.Replace(".", "").Replace(",", ".");

            string valorTerreno = "NULL";
            if (!string.IsNullOrEmpty(txtValorTerreno.Text))
                valorTerreno = txtValorTerreno.Text.Replace(".", "").Replace(",", ".");

            string valorAreaConstruida = "NULL";
            if (!string.IsNullOrEmpty(txtVAConstruida.Text))
                valorAreaConstruida = txtVAConstruida.Text.Replace(".", "").Replace(",", ".");

            string valorAvaliado = "NULL";
            if (!string.IsNullOrEmpty(txtVAvaliado.Text))
                valorAvaliado = txtVAvaliado.Text.Replace(".", "").Replace(",", ".");

            string dataAvaliacao = "NULL";
            string[] dataConvert;
            if (!string.IsNullOrEmpty(txtDAvaliacao.Text))
            {
                dataConvert = txtDAvaliacao.Text.Split('/');
                dataAvaliacao = dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0];
            }

            int codImovelPK = Convert.ToInt32(hfImovelPK.Value);
            int codEndImovelPK = Convert.ToInt32(hfEnderecoPK.Value);


            String tipoImovel = "";
            if (rdoButtonRural.Checked)
                tipoImovel = "Rural";
            else if (rdoButtonUrbano.Checked)
                tipoImovel = "Urbano";



            string numeroEndImovel = "NULL";
            if (!string.IsNullOrEmpty(numeroTxt.Text))
                numeroEndImovel = numeroTxt.Text;

            string shapeEndereco = "NULL";
            if (!string.IsNullOrEmpty(hfLat.Value) && !string.IsNullOrEmpty(hfLng.Value))
                shapeEndereco = "geometry::STGeomFromText('POINT('+convert(varchar(20),'" + hfLng.Value + "')+' '+convert(varchar(20),'" + hfLat.Value + "')+')',4674)";
            string link = "NULL";
            if (txtLink.Text.Length > 0)
            {
                link = "'" + txtLink.Text + "'";
            }

            try
            {
                 
                conexao.commandExec("UPDATE IMOVEL SET TIPO_IMOVEL = '" + tipoImovel + "', DENOMINACAO = '" + txtDenominacao.Text + "', NUM_PATRIMONIO = " + numPatrimonio + ", SITUACAO_IMOVEL = '" + txtSituacao.Text + "', VALOR_TERRENO = " + valorTerreno + ", VALOR_AREA_CONSTRUIDA = " + valorAreaConstruida + ", VALOR_AVALIACAO = " + valorAvaliado + ", AREA_IMOVEL = " + area + ", OBSERVACAO = '" + txtObservacao.Text + "', UNIDADE_AREA = '" + ddlTipoMedida.SelectedValue + "', LINK_DOC_IMOVEL="+link+" where COD_IMOVEL_PK = " + codImovelPK);

                conexao.commandExec("UPDATE ENDERECO_IMOVEL SET [NOME_LOGRADOURO]='" + txtNRua.Text + "',[CEP]='" + txtCEP.Text + "',[SHAPE] = "+shapeEndereco+", [NUMERO]=" + numeroEndImovel + ", [PRECISAO] = '" + hfPrecisao.Value + "', [TYPES] = '" + hfTypes.Value + "' ,[TIPO_LOGRADOURO]='" + ddlTipo.SelectedValue + "',[COMPLEMENTO]='" + txtComplemento.Text + "',[BAIRRO]='" + txtBairro.Text + "',[CIDADE]='" + SearchCidade.Text + "',[ESTADO]='" + ddlEstados.SelectedValue.ToString() + "' WHERE COD_IMOVEL_FK =" + codImovelPK);
                           
            }

            catch (Exception exception)
            {
                //e.Message;
                lblCadastradoInfo.ForeColor = System.Drawing.Color.Red;
                lblCadastradoInfo.Text = exception.Message;
                lblCadastradoInfo.Visible = true;

                return;
            }

            if (codImovelPK == 0 || codEndImovelPK == 0)
            {
                lblCadastradoInfo.ForeColor = System.Drawing.Color.Red;
                lblCadastradoInfo.Text = "Erro";
                lblCadastradoInfo.Visible = true;

                return;
            }

            lblCadastradoInfo.ForeColor = System.Drawing.Color.Green;
            lblCadastradoInfo.Text = "Atualizado";
            lblCadastradoInfo.Visible = true;


        }

        protected void Atualizar_Click(object sender, EventArgs e)

        {

        lblCadastradoPasta.Text = "Botão quem atualizou";

        }


        protected void bntCadastrarInfo_Click(object sender, EventArgs e)
        {

            if (string.IsNullOrEmpty(txtDenominacao.Text) || string.IsNullOrEmpty(txtNPatrimonio.Text))
                return;

            string numPatrimonio = "NULL";
            if (!string.IsNullOrEmpty(txtNPatrimonio.Text))
                numPatrimonio = txtNPatrimonio.Text;

            string area = "NULL";
            if(!string.IsNullOrEmpty(txtArea.Text))
                area = txtArea.Text.Replace(".", "").Replace(",", ".");

            string valorTerreno = "NULL";
            if (!string.IsNullOrEmpty(txtValorTerreno.Text))
                valorTerreno = txtValorTerreno.Text.Replace(".", "").Replace(",", ".");

            string valorAreaConstruida = "NULL";
            if (!string.IsNullOrEmpty(txtVAConstruida.Text))
                valorAreaConstruida = txtVAConstruida.Text.Replace(".", "").Replace(",", ".");

            string valorAvaliado = "NULL";
            if (!string.IsNullOrEmpty(txtVAvaliado.Text))
                valorAvaliado = txtVAvaliado.Text.Replace(".", "").Replace(",", ".");

            string dataAvaliacao = "NULL";
            string[] dataConvert;
            if (!string.IsNullOrEmpty(txtDAvaliacao.Text))
            {
                dataConvert = txtDAvaliacao.Text.Split('/');
                dataAvaliacao =  "'"+dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0]+"'";
            }
            string link = "NULL";
            if(txtLink.Text.Length>0)
            {
                link = "'"+txtLink.Text+"'";
            }
            

            int codImovelPK = 0;
            int codEndImovelPK = 0;

            String tipoImovel = "";
            if (rdoButtonRural.Checked)
                tipoImovel = "Rural";
            else if (rdoButtonUrbano.Checked)
                tipoImovel = "Urbano";

            try
            {
                codImovelPK = conexao.insertReturn(
                    "Declare @count int " +
                    "SELECT @count = COUNT(*) FROM IMOVEL " +
                    "IF(@count > 0) " +
                    "BEGIN " +
                    "INSERT INTO [dbo].[IMOVEL] ([TIPO_IMOVEL], [DENOMINACAO], [NUM_PATRIMONIO], [SITUACAO_IMOVEL], [VALOR_TERRENO], [VALOR_AREA_CONSTRUIDA], [VALOR_AVALIACAO], [AREA_IMOVEL], [OBSERVACAO], [UNIDADE_AREA], [DATA_AVALIACAO], [COD_IMOVEL_PK],[LINK_DOC_IMOVEL]) OUTPUT Inserted.COD_IMOVEL_PK " +
                    "VALUES ('" + tipoImovel + "', '" + txtDenominacao.Text + "', " + numPatrimonio + ", '" + txtSituacao.Text + "', " + valorTerreno + "," + valorAreaConstruida + ", " + valorAvaliado + ", " + area + ", '" + txtObservacao.Text + "', '" + ddlTipoMedida.SelectedValue + "',"+dataAvaliacao+", ((SELECT TOP 1 COD_IMOVEL_PK FROM IMOVEL ORDER BY COD_IMOVEL_PK DESC) + 1),"+link+") " +
                    "END " +
                    "ELSE " +
                    "BEGIN " +
                    "INSERT INTO [dbo].[IMOVEL] ([TIPO_IMOVEL], [DENOMINACAO], [NUM_PATRIMONIO], [SITUACAO_IMOVEL], [VALOR_TERRENO], [VALOR_AREA_CONSTRUIDA], [VALOR_AVALIACAO], [AREA_IMOVEL], [OBSERVACAO], [UNIDADE_AREA],[DATA_AVALIACAO], [COD_IMOVEL_PK],[LINK_DOC_IMOVEL]) OUTPUT Inserted.COD_IMOVEL_PK " +
                    "VALUES ('" + tipoImovel + "', '" + txtDenominacao.Text + "', " + numPatrimonio + ", '" + txtSituacao.Text + "', " + valorTerreno + "," + valorAreaConstruida + ", " + valorAvaliado + ", " + area + ", '" + txtObservacao.Text + "','" + ddlTipoMedida.SelectedValue + "'," + dataAvaliacao + ", 1," + link + ") " +
                    "END", "COD_IMOVEL_PK"
                );

                if (codImovelPK == 0)
                {
                    //e.Message;
                    lblCadastradoInfo.ForeColor = System.Drawing.Color.Red;
                    lblCadastradoInfo.Text ="Erro inesperado ao tentar cadastrar imovel, tente novamente.";
                    lblCadastradoInfo.Visible = true;

                    return;
                }
               

                string numeroEndImovel = "NULL";
                if (!string.IsNullOrEmpty(numeroTxt.Text))
                    numeroEndImovel = numeroTxt.Text;

                string shapeEndereco = "NULL";
                if (!string.IsNullOrEmpty(hfLat.Value) && !string.IsNullOrEmpty(hfLng.Value))
                    shapeEndereco = "geometry::STGeomFromText('POINT('+convert(varchar(20),'" + hfLng.Value + "')+' '+convert(varchar(20),'" + hfLat.Value + "')+')',4674)";

                codEndImovelPK = conexao.insertReturn(
                    "Declare @count int " +
                    "SELECT @count = COUNT(*) FROM ENDERECO_IMOVEL " +
                    "IF(@count > 0) " +
                    "BEGIN " +
                    "INSERT INTO ENDERECO_IMOVEL([COD_END_IMOVEL_PK],[COD_IMOVEL_FK],[TIPO_LOGRADOURO],[NOME_LOGRADOURO],[CEP],[SHAPE],[BAIRRO],[CIDADE],[ESTADO],[COMPLEMENTO],[NUMERO],[PRECISAO],[TYPES]) OUTPUT Inserted.COD_END_IMOVEL_PK " +
                    "VALUES(((SELECT TOP 1 COD_END_IMOVEL_PK FROM ENDERECO_IMOVEL ORDER BY COD_END_IMOVEL_PK DESC) + 1)," + codImovelPK + ",'" + ddlTipo.SelectedValue + "','" + txtNRua.Text + "','" + txtCEP.Text + "', "+ shapeEndereco +" ,'" + txtBairro.Text + "','" + SearchCidade.Text + "','" + ddlEstados.SelectedValue + "','" + txtComplemento.Text + "'," + numeroEndImovel + ",'" + hfPrecisao.Value + "','" + hfTypes.Value + "')" +
                    "END " +
                    "ELSE " +
                    "BEGIN " +
                    "INSERT INTO ENDERECO_IMOVEL([COD_END_IMOVEL_PK],[COD_IMOVEL_FK],[TIPO_LOGRADOURO],[NOME_LOGRADOURO],[CEP],[SHAPE],[BAIRRO],[CIDADE],[ESTADO],[COMPLEMENTO],[NUMERO],[PRECISAO],[TYPES]) OUTPUT Inserted.COD_END_IMOVEL_PK " +
                    "VALUES(1," + codImovelPK + ",'" + ddlTipo.SelectedValue + "','" + txtNRua.Text + "','" + txtCEP.Text + "', " + shapeEndereco + " ,'" + txtBairro.Text + "','" + SearchCidade.Text + "','" + ddlEstados.SelectedValue + "','" + txtComplemento.Text + "'," + numeroEndImovel + ",'" + hfPrecisao.Value + "','" + hfTypes.Value + "')" +
                    "END", "COD_END_IMOVEL_PK"
                );
                if (codEndImovelPK == 0)
                {
                    //e.Message;
                    conexao.commandExec("DELETE FROM IMOVEL WHERE COD_IMOVEL_PK=" + codImovelPK);
                    lblCadastradoInfo.ForeColor = System.Drawing.Color.Red;
                    lblCadastradoInfo.Text = "Erro inesperado ao tentar cadastrar endereço, tente novamente.";
                    lblCadastradoInfo.Visible = true;

                    return;
                }
               
                
                
            }

            catch (Exception exception)
            {
                //e.Message;
                lblCadastradoInfo.ForeColor = System.Drawing.Color.Red;
                lblCadastradoInfo.Text = exception.Message;
                lblCadastradoInfo.Visible = true;

                return;
            }
            
            if (codImovelPK == 0 || codEndImovelPK == 0)
            {
                lblCadastradoInfo.ForeColor = System.Drawing.Color.Red;
                lblCadastradoInfo.Text = "Erro ao cadastrar imovel";
                lblCadastradoInfo.Visible = true;

                return;
            }
            else
            {
                

               
                hfEnderecoPK.Value = codEndImovelPK.ToString();
                hfImovelPK.Value = codImovelPK.ToString();
                lblCadastradoInfo.ForeColor = System.Drawing.Color.Green;
                lblCadastradoInfo.Text = "Cadastrado";
                lblCadastradoInfo.Visible = true;
                PopulateMunicipio(SearchCidade.Text);
                //ddlMuni.Items.FindByValue(SearchCidade.Text).Selected = true;
               
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "alert", "alerta(" + codImovelPK + ");", true);

            }
           
        }

        protected void bntCadastrarPasta_Click(object sender, EventArgs e)
        {
            int codPastaImovelPK = 0;
            int codPastaPK = 0;
            String pasta = txtPasta.Text;
            int codImovelPK = Convert.ToInt32(hfImovelPK.Value);
            DataTable dt = new DataTable();

            try
            {
                codPastaPK = conexao.insertReturn(
                    "Declare @count int " +
                    "Declare @existe int " +
                    "SELECT @count = COUNT(*) FROM PASTA " +
                    "SELECT @existe = COUNT(*) FROM PASTA WHERE COD_PASTA_CODEMIG = '" + txtPasta.Text + "' " +
                    "IF(@existe = 0) " +
                    "BEGIN " +
                        "IF(@count > 0) " +
                        "BEGIN " +
                        "INSERT INTO PASTA([COD_PASTA_PK],[COD_PASTA_CODEMIG]) OUTPUT Inserted.COD_PASTA_PK VALUES( ((SELECT TOP 1 COD_PASTA_PK FROM PASTA ORDER BY COD_PASTA_PK DESC) + 1) ,'" + txtPasta.Text + "') " +
                        "END " +
                        "ELSE " +
                        "BEGIN " +
                        "INSERT INTO PASTA([COD_PASTA_PK],[COD_PASTA_CODEMIG]) OUTPUT Inserted.COD_PASTA_PK VALUES(1,'" + txtPasta.Text + "') " +
                        "END " +
                    "END", "COD_PASTA_PK"
                );
                if (codPastaPK == 0)
                {
                    lblCadastradoPasta.ForeColor = System.Drawing.Color.White;
                    lblCadastradoPasta.Text = "Não Cadastrado";
                    lblCadastradoPasta.Visible = true;
                    lblCadastradoPasta.CssClass = "naoCadastrado";
                    return;
                }
                
                codPastaImovelPK = conexao.insertReturn(
                    "Declare @count int " +
                    "SELECT @count = COUNT(*) FROM PASTA_IMOVEL " +
                    "IF(@count > 0) " +
                    "BEGIN " +
                    "INSERT INTO PASTA_IMOVEL([COD_PASTA_IMOVEL_PK],[COD_PASTA_FK], [COD_IMOVEL_FK]) OUTPUT Inserted.COD_PASTA_IMOVEL_PK VALUES( ((SELECT TOP 1 COD_PASTA_IMOVEL_PK FROM PASTA_IMOVEL ORDER BY COD_PASTA_IMOVEL_PK DESC) + 1) ," + codPastaPK + ", " + codImovelPK + ") " +
                    "END " +
                    "ELSE " +
                    "BEGIN " +
                    "INSERT INTO PASTA_IMOVEL([COD_PASTA_IMOVEL_PK],[COD_PASTA_FK], [COD_IMOVEL_FK]) OUTPUT Inserted.COD_PASTA_IMOVEL_PK VALUES(1," + codPastaPK + ", " + codImovelPK + ") " +
                    "END", "COD_PASTA_IMOVEL_PK"
                    );
                
                
            }
            catch (Exception exception)
            {
                //e.Message;
                lblCadastradoPasta.ForeColor = System.Drawing.Color.White;
                lblCadastradoPasta.Text = exception.Message;
                lblCadastradoPasta.Visible = true;
                lblCadastradoPasta.CssClass = "naoCadastrado";
                return;
            }
            
            


            txtPasta.Text = "";

            //função para mostra alert, parametro e a messagem exibida
            //conexao.Message("VOLUMES CADASTRADOS COM SUCESSO.");
            lblCadastradoPasta.ForeColor = System.Drawing.Color.White;
            lblCadastradoPasta.Text = "Cadastrado";
            lblCadastradoPasta.Visible = true;
            lblCadastradoPasta.CssClass = "cadastrado";


        }

        protected void bntCadastrarDCartoriais_Click(object sender, EventArgs e)
        {
            int codDCartoriaisPK = 0;
            int codImovelPK = Convert.ToInt32(hfImovelPK.Value);

            try
            {
                codDCartoriaisPK = conexao.insertReturn(
                    "Declare @count int " +
                    "SELECT @count = COUNT(*) FROM MATRICULA " +
                    "IF(@count > 0) " +
                    "BEGIN " +
                    "INSERT INTO MATRICULA([COD_IMOVEL_FK],[COMARCA],[COD_MATRICULA_PK],[NUM_MATRICULA]) OUTPUT Inserted.COD_MATRICULA_PK VALUES(" + codImovelPK + ",'" + txtComarca.Text + "',((SELECT TOP 1 COD_MATRICULA_PK FROM MATRICULA ORDER BY COD_MATRICULA_PK DESC) + 1),'" + txtMatricula.Text + "') " +
                    "END " +
                    "ELSE " +
                    "BEGIN " +
                    "INSERT INTO MATRICULA([COD_IMOVEL_FK], [COMARCA],[COD_MATRICULA_PK],[NUM_MATRICULA]) OUTPUT Inserted.COD_MATRICULA_PK VALUES(" + codImovelPK + ",'" + txtComarca.Text + "', 1,'" + txtMatricula.Text + "') " +
                    "END ", "COD_MATRICULA_PK"
                );
                if (codDCartoriaisPK == 0)
                {
                    lblCadastradoDCartoriais.ForeColor = System.Drawing.Color.Red;
                    lblCadastradoDCartoriais.Text = "&nbsp;&nbsp;Não Cadastrado&nbsp;&nbsp;";
                    lblCadastradoDCartoriais.Visible = true;
                    return;
                }

            }
            catch (Exception exception)
            {
                //e.Message;
                lblCadastradoDCartoriais.ForeColor = System.Drawing.Color.Red;
                lblCadastradoDCartoriais.Text = exception.Message;
                lblCadastradoDCartoriais.Visible = true;
                return;
            }

            lblCadastradoDCartoriais.ForeColor = System.Drawing.Color.Green;
            lblCadastradoDCartoriais.Text = "&nbsp;&nbsp;Cadastrado&nbsp;&nbsp;";
            lblCadastradoDCartoriais.Visible = true;

        }

        protected void bntAtualizarDCartoriais_Click(object sender, EventArgs e)
        {

            String pasta = txtPasta.Text;
            int codDCartoriaisPK = Convert.ToInt32(HiddenFieldDCartoriais.Value);
            
            try
            {
                conexao.commandExec("UPDATE MATRICULA SET COMARCA = '" + txtComarca.Text + "', NUM_MATRICULA = '" + txtMatricula.Text + "' WHERE COD_MATRICULA_PK = " + codDCartoriaisPK);
            }

            catch (Exception exception)
            {
                lblCadastradoDCartoriais.ForeColor = System.Drawing.Color.White;
                lblCadastradoDCartoriais.Text = exception.Message;
                lblCadastradoDCartoriais.Visible = true;
                lblCadastradoDCartoriais.CssClass = "naoCadastrado";
                return;
            }

            lblCadastradoDCartoriais.ForeColor = System.Drawing.Color.White;
            lblCadastradoDCartoriais.Text = "&nbsp;&nbsp;Atualizado&nbsp;&nbsp;";
            lblCadastradoDCartoriais.Visible = true;
            lblCadastradoDCartoriais.CssClass = "cadastrado";

        }

        protected void bntCadastrarTributos_Click(object sender, EventArgs e)
        {
            int codTributoPK = 0;
            int codImovelPK = Convert.ToInt32(hfImovelPK.Value);
            string tipo = "";

            if (ddlTTributo.SelectedItem.Value == "OUTRO")
                tipo = "OUTRO(" + txtTTributo.Text + ")";
            else
                tipo = ddlTTributo.SelectedItem.Value;

            string negativa = "NULL";
            if(ddlCNegativa.SelectedValue=="0")
            {
                negativa = "NULL";
            }
            else
            {
                negativa = "'" + ddlCNegativa.SelectedValue + "'";
            }

            try
            {
                codTributoPK = conexao.insertReturn(
                    "Declare @count int " +
                    "SELECT @count = COUNT(*) FROM TRIBUTO " +
                    "IF(@count > 0) " +
                    "BEGIN " +
                    "INSERT INTO TRIBUTO([COD_IMOVEL_FK],[TIPO_TRIBUTO],[VALOR_PAGO],[COD_TRIBUTO],[ANO_PAGAMENTO],[COD_TRIBUTO_PK],[CERTIDAO_NEGATIVA], [NUM_TRIBUTO]) OUTPUT Inserted.COD_TRIBUTO_PK VALUES(" + codImovelPK + ",'" + tipo + "'," + txtValor.Text.Replace(".", "").Replace(",", ".") + ",'" + txtCodigo.Text + "'," + txtAno.Text + ",((SELECT TOP 1 COD_TRIBUTO_PK FROM TRIBUTO ORDER BY COD_TRIBUTO_PK DESC) + 1),'" + ddlCNegativa.SelectedValue + "','" + txtCodigo.Text + "') " +
                    "END " +
                    "ELSE " +
                    "BEGIN " +
                    "INSERT INTO TRIBUTO([COD_IMOVEL_FK],[TIPO_TRIBUTO],[VALOR_PAGO],[COD_TRIBUTO],[ANO_PAGAMENTO],[COD_TRIBUTO_PK],[CERTIDAO_NEGATIVA], [NUM_TRIBUTO]) OUTPUT Inserted.COD_TRIBUTO_PK VALUES(" + codImovelPK + ",'" + tipo + "'," + txtValor.Text.Replace(".", "").Replace(",", ".") + ",'" + txtCodigo.Text + "'," + txtAno.Text + ", 1," + negativa + ",'" + txtCodigo.Text + "') " +
                    "END ", "COD_TRIBUTO_PK"
                );
                if (codTributoPK == 0)
                {
                    lblCadastradoTributos.ForeColor = System.Drawing.Color.Red;
                    lblCadastradoTributos.Text = "&nbsp;&nbsp;Não Cadastrado&nbsp;&nbsp;";
                    lblCadastradoTributos.Visible = true;
                    return;
                }

            }
            catch (Exception exception)
            {
                //e.Message;
                lblCadastradoTributos.ForeColor = System.Drawing.Color.Red;
                lblCadastradoTributos.Text = exception.Message;
                lblCadastradoTributos.Visible = true;
                return;
            }

            lblCadastradoTributos.ForeColor = System.Drawing.Color.Green;
            lblCadastradoTributos.Text = "&nbsp;&nbsp;Cadastrado&nbsp;&nbsp;";
            lblCadastradoTributos.Visible = true;

        }

        protected void bntAtualizarTributos_Click(object sender, EventArgs e)
        {

            int codTributoPK = Convert.ToInt32(HiddenFieldTributos.Value);
            string tipo = "";

            if (ddlTTributo.SelectedItem.Value == "OUTRO")
                tipo = "OUTRO(" + txtTTributo.Text + ")";
            else
                tipo = ddlTTributo.SelectedItem.Value;

            string negativa = "NULL";
            if (ddlCNegativa.SelectedValue == "0")
            {
                negativa = "NULL";
            }
            else
            {
                negativa = "'" + ddlCNegativa.SelectedValue + "'";
            }

            try
            {
                
                conexao.commandExec("UPDATE TRIBUTO SET TIPO_TRIBUTO = '" + tipo + "', VALOR_PAGO = " + txtValor.Text.Replace(".", "").Replace(",", ".") + ", COD_TRIBUTO = '" + txtCodigo.Text + "', ANO_PAGAMENTO = " + txtAno.Text + ", CERTIDAO_NEGATIVA = " + negativa + ", NUM_TRIBUTO = '" + txtCodigo.Text + "' WHERE COD_TRIBUTO_PK = " + codTributoPK);
            
            }
            catch (Exception exception)
            {
                //e.Message;
                lblCadastradoTributos.ForeColor = System.Drawing.Color.Red;
                lblCadastradoTributos.Text = exception.Message;
                lblCadastradoTributos.Visible = true;
                return;
            }

            lblCadastradoTributos.ForeColor = System.Drawing.Color.Green;
            lblCadastradoTributos.Text = "&nbsp;&nbsp;Atualizado&nbsp;&nbsp;";
            lblCadastradoTributos.Visible = true;

        }

        protected void bntCadastrarContratos_Click(object sender, EventArgs e)
        {
            int codContratoImovelPK = 0;
            int codContratoPK = 0;
            int codImovelPK = Convert.ToInt32(hfImovelPK.Value);

            string novaDataAssinatura = "";
            string novaDataVencimento = "";
            String[] dataConvert;

            if (string.IsNullOrEmpty(txtDAssinatura.Text))
                novaDataAssinatura = "NULL";
            else
            {
                dataConvert = txtDAssinatura.Text.Split('/');
                novaDataAssinatura = dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0];
            }

            if (string.IsNullOrEmpty(txtDVencimento.Text))
                novaDataVencimento = "NULL";
            else
            {
                dataConvert = txtDVencimento.Text.Split('/');
                novaDataVencimento =  dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0] ;
            }
            string numContrato = "NULL";
            if (!string.IsNullOrEmpty(txtNumero.Text))
                numContrato = txtNumero.Text;
            else
                return;


            try
            {
                codContratoPK = conexao.insertReturn(
                    "Declare @count int " +
                    "Declare @existe int " +
                    "SELECT @count = COUNT(*) FROM CONTRATO " +
                    "SELECT @existe = COUNT(*) FROM CONTRATO WHERE NUM_CONTRATO = " + numContrato + " " +
                    "IF(@existe = 0) " +
                    "BEGIN " +
                        "IF(@count > 0) " +
                        "BEGIN " +
                        "INSERT INTO CONTRATO ([PROMISSARIO], [NUM_CONTRATO], [DATA_VENCIMENTO], [DATA_ASSINATURA], [COD_CONTRATO_PK], [DATA_CADASTRO_CONTRATO], [CONTROLE_USUARIO_CONTRATO]) " +
                        "OUTPUT Inserted.COD_CONTRATO_PK VALUES  ('" + txtPromissario.Text + "', " + numContrato + ", '" + novaDataVencimento + "', '" + novaDataAssinatura + "', ((SELECT TOP 1 COD_CONTRATO_PK FROM CONTRATO ORDER BY COD_CONTRATO_PK DESC) + 1), GETDATE(), " + hfLoginPK.Value + ")" +
                        "END " +
                        "ELSE " +
                        "BEGIN " +
                        "INSERT INTO CONTRATO ([PROMISSARIO], [NUM_CONTRATO], [DATA_VENCIMENTO], [DATA_ASSINATURA], [COD_CONTRATO_PK], [DATA_CADASTRO_CONTRATO], [CONTROLE_USUARIO_CONTRATO]) " +
                        "OUTPUT Inserted.COD_CONTRATO_PK VALUES  ('" + txtPromissario.Text + "', " + numContrato + ", '" + novaDataVencimento + "', '" + novaDataAssinatura + "', 1, GETDATE(), " + hfLoginPK.Value + ")" +
                        "END " +
                    "END", "COD_CONTRATO_PK"
                );
                
                if (codContratoPK == 0)
                {
                    lblCadastradoContratos.ForeColor = System.Drawing.Color.Red;
                    lblCadastradoContratos.Text = "&nbsp;&nbsp;Não Cadastrado&nbsp;&nbsp;";
                    lblCadastradoContratos.Visible = true;
                    return;
                }

                codContratoImovelPK = conexao.insertReturn(
                        "Declare @count int " +
                        "Declare @existe int " +
                        "SELECT @count = COUNT(*) FROM CONTRATO_IMOVEL " +
                        "SELECT @existe = COUNT(*) FROM CONTRATO_IMOVEL WHERE COD_CONTRATO_FK = " + codContratoPK + " AND COD_IMOVEL_FK = " + codImovelPK + " " +
                        "IF(@existe = 0) " +
                        "BEGIN " +
                            "IF(@count > 0) " +
                            "BEGIN " +
                            "INSERT INTO CONTRATO_IMOVEL([COD_CONTRATO_IMOVEL],[COD_CONTRATO_FK], [COD_IMOVEL_FK]) OUTPUT Inserted.COD_CONTRATO_IMOVEL VALUES( ((SELECT TOP 1 COD_CONTRATO_IMOVEL FROM CONTRATO_IMOVEL ORDER BY COD_CONTRATO_IMOVEL DESC) + 1) ," + codContratoPK + ", " + codImovelPK + ") " +
                            "END " +
                            "ELSE " +
                            "BEGIN " +
                            "INSERT INTO CONTRATO_IMOVEL([COD_CONTRATO_IMOVEL],[COD_CONTRATO_FK], [COD_IMOVEL_FK]) OUTPUT Inserted.COD_CONTRATO_IMOVEL VALUES( 1, " + codContratoPK + ", " + codImovelPK + ") " +
                            "END " +
                        "END", "COD_CONTRATO_IMOVEL"
                        );


            }

            catch (Exception exception)
            {
                lblCadastradoContratos.ForeColor = System.Drawing.Color.Red;
                lblCadastradoContratos.Text = exception.Message;
                lblCadastradoContratos.Visible = true;
                return;
            }



            lblCadastradoContratos.ForeColor = System.Drawing.Color.Green;
            lblCadastradoContratos.Text = "&nbsp;&nbsp;Cadastrado&nbsp;&nbsp;";
            lblCadastradoContratos.Visible = true;


        }

        protected void bntAtualizarContratos_Click(object sender, EventArgs e)
        {
            
            int codContratoPK = Convert.ToInt32(HiddenFieldContratos.Value);

            string novaDataAssinatura = "";
            string novaDataVencimento = "";
            String[] dataConvert;

            if (string.IsNullOrEmpty(txtDAssinatura.Text))
                novaDataAssinatura = "NULL";
            else
            {
                dataConvert = txtDAssinatura.Text.Split('/');
                novaDataAssinatura = "'" + dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0] + "'";
            }

            if (string.IsNullOrEmpty(txtDVencimento.Text))
                novaDataVencimento = "NULL";
            else
            {
                dataConvert = txtDVencimento.Text.Split('/');
                novaDataVencimento = "'" + dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0] + "'";
            }
            
            try
            {
                conexao.commandExec("UPDATE CONTRATO SET PROMISSARIO = '" + txtPromissario.Text + "', NUM_CONTRATO = " + txtNumero.Text + ", DATA_VENCIMENTO = " + novaDataVencimento + ", DATA_ASSINATURA = " + novaDataAssinatura + ", DATA_CADASTRO_CONTRATO = GETDATE(), CONTROLE_USUARIO_CONTRATO = " + hfLoginPK.Value + "  WHERE COD_CONTRATO_PK = " + codContratoPK);
            }
            catch (Exception exception)
            {
                lblCadastradoContratos.ForeColor = System.Drawing.Color.Red;
                lblCadastradoContratos.Text = exception.Message;
                lblCadastradoContratos.Visible = true;
                return;
            }

            lblCadastradoContratos.ForeColor = System.Drawing.Color.Green;
            lblCadastradoContratos.Text = "&nbsp;&nbsp;Atualizado&nbsp;&nbsp;";
            lblCadastradoContratos.Visible = true;

        }

        

    }
}