using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CODEMIG.Classes;
using System.Data;
using System.Collections;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Script.Services;

public partial class Index : System.Web.UI.Page
{

    CODEMIG.Classes.DbUtils.DbConn conexao = new CODEMIG.Classes.DbUtils.DbConn();


    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            this.PopulateDistritos();
        }
        StringData webUserStringData = (StringData)Session["webuser"];
        if (Session["webuser"] != null)
        {

            if (webUserStringData.userProcesso != "btn")
            {
                Response.Write("<script>alert('Você não tem permissão para acessar esta página');</script>");
                Response.Redirect("~/home.aspx?per=1");
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

    protected void Submit(object sender, EventArgs e)
    {
        string customerName = Request.Form[txtProcesso.UniqueID];
    }
    public DataTable limpaData(DataTable dt)
    {
        for (int counter = dt.Columns.Count - 1; counter >= 0; counter--)
        {
            dt.Columns.RemoveAt(counter);
        }
        return dt;
    }
  
    protected void bntCadastrarEndereco_Click(object sender, EventArgs e)
    {

        string numero = "NULL";
        if(numeroTxt.Text=="" || numeroTxt.Text == "0")
        {
            numero = "NULL";

        }
        else
        {
            numero = numeroTxt.Text;
        }
        string dataagora;
        dataagora = "'" + DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day + "'";

        int codEmpresaPK = Convert.ToInt32(hfCodEmpresaPK.Value);

        int codEndEmpresaPK = conexao.insertReturn("SELECT COD_ENDERECO_EMPRESA_PK FROM ENDERECO_EMPRESA WHERE COD_EMPRESA_FK=" + codEmpresaPK, "COD_ENDERECO_EMPRESA_PK");

        if (codEndEmpresaPK == 0)
        {
            codEndEmpresaPK = conexao.insertReturn("INSERT INTO ENDERECO_EMPRESA([COD_ENDERECO_EMPRESA_PK],[NOME],[CEP],[NUMERO],[TIPO],[COMPLEMENTO],[BAIRRO],[MUN],[UF],[COD_EMPRESA_FK],[DATA_CADASTRO_ENDERECO],[CONTROLE_USUARIO_ENDERECO]) OUTPUT Inserted.COD_ENDERECO_EMPRESA_PK VALUES( ((SELECT TOP 1 COD_ENDERECO_EMPRESA_PK FROM ENDERECO_EMPRESA ORDER BY COD_ENDERECO_EMPRESA_PK DESC) + 1),'" + nomeTxt.Text + "','" + cepTxt.Text + "'," + numero + ",'" + DropDownList1.SelectedValue + "','" + complementoTxt.Text + "','" + bairroTxt.Text + "','" + SearchCidade.Text + "','" + ddlUF.SelectedValue.ToString() + " '," + codEmpresaPK + "," + dataagora + "," + hfLoginPK.Value + ")", "COD_ENDERECO_EMPRESA_PK");
            if (codEndEmpresaPK == 0)
            {
                conexao.Message("Erro ao cadastrar endereço");
                return;
            }
        }
        else if (codEndEmpresaPK > 0)
        {
            conexao.commandExec("UPDATE ENDERECO_EMPRESA SET [NOME]='" + nomeTxt.Text + "',[CEP]='" + cepTxt.Text + "',[NUMERO]=" + numero + ",[TIPO]='" + DropDownList1.SelectedValue + "',[COMPLEMENTO]='" + complementoTxt.Text + "',[BAIRRO]='" + bairroTxt.Text + "',[MUN]='" + SearchCidade.Text + "',[UF]='" + ddlUF.SelectedValue.ToString() + "',[COD_EMPRESA_FK]=" + codEmpresaPK + " WHERE COD_EMPRESA_FK=" + codEmpresaPK);
           
            
        }
        else
        {
            conexao.Message("Erro ao atualizar endereço");
            return;
        }

        lbl3.Visible = true;
        
    }


    protected void bntCadastrarProps_Click(object sender, EventArgs e)
    {
        string dataagora;
        dataagora = "'" + DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day + "'";

        if (txtNomeProp.Text != "" && txtCPFProp.Text != "")
        {

            int codPropPK = 0;
            int codEmpresaPK = Convert.ToInt32(hfCodEmpresaPK.Value);
            String nome = txtNomeProp.Text;
            String CPF = txtCPFProp.Text;
            int codProcessoPK = Convert.ToInt32(hfCodProcessoPK.Value);
            DataTable dt = new DataTable();

            limpaData(dt);
            dt.Clear();
            dt = conexao.SELECT("SELECT COD_PROPRIETARIO_PK, NOME, CPF, COD_EMPRESA_PK FROM PROPRIETARIO " +
                            "INNER JOIN EMPRESA_PROPRIETARIO ON PROPRIETARIO.COD_PROPRIETARIO_PK=EMPRESA_PROPRIETARIO.COD_PROPRIETARIO_FK  " +
                            "INNER JOIN EMPRESA ON EMPRESA.COD_EMPRESA_PK=EMPRESA_PROPRIETARIO.COD_EMPRESA_FK  " +
                            "WHERE CPF='" + CPF + "' AND COD_EMPRESA_PK=" + codEmpresaPK + "");

            if (dt.Rows.Count > 0)
            {
                lbl4.ForeColor = System.Drawing.Color.Red;
                lbl4.Text = "Proprietário já cadastrado";
                lbl4.Visible = true;
                return;
            }
            
            limpaData(dt);
            dt.Clear();
            dt = conexao.SELECT("SELECT COD_PROPRIETARIO_PK, NOME, CPF FROM PROPRIETARIO WHERE CPF='" + CPF + "'");

            if (dt.Rows.Count > 0)
            {
                codPropPK = (int)dt.Rows[0]["COD_PROPRIETARIO_PK"];
                codPropPK = conexao.insertReturn("INSERT INTO EMPRESA_PROPRIETARIO([COD_EMPRESA_PROPRIETARIO_PK],[COD_EMPRESA_FK],[COD_PROPRIETARIO_FK]) OUTPUT Inserted.COD_EMPRESA_PROPRIETARIO_PK VALUES ( ((SELECT TOP 1 COD_EMPRESA_PROPRIETARIO_PK FROM EMPRESA_PROPRIETARIO ORDER BY COD_EMPRESA_PROPRIETARIO_PK DESC) + 1)," + codEmpresaPK + "," + codPropPK + ")",
                "COD_EMPRESA_PROPRIETARIO_PK");
                if (codPropPK == 0)
                {
                    conexao.Message("Erro");
                    return;
                }

            }
            else
            {
                codPropPK = conexao.insertReturn(
                    "Declare @count int " +
                    "SELECT @count = COUNT(*) FROM PROPRIETARIO " +
                    "IF(@count > 0) " +
                    "BEGIN " +
                    "INSERT INTO PROPRIETARIO([COD_PROPRIETARIO_PK],[CPF],[NOME],[DATA_CADASTRO_PROPRIETARIO],[CONTROLE_USUARIO_PROPRIETARIO]) OUTPUT Inserted.COD_PROPRIETARIO_PK VALUES( ((SELECT TOP 1 COD_PROPRIETARIO_PK FROM PROPRIETARIO ORDER BY COD_PROPRIETARIO_PK DESC) + 1),'" + CPF + "', '" + nome + "'," + dataagora + "," + hfLoginPK.Value + ") " +
                    "END " +
                    "ELSE " +
                    "BEGIN " +
                    "INSERT INTO PROPRIETARIO([COD_PROPRIETARIO_PK],[CPF],[NOME],[DATA_CADASTRO_PROPRIETARIO],[CONTROLE_USUARIO_PROPRIETARIO]) OUTPUT Inserted.COD_PROPRIETARIO_PK VALUES( 1,'" + CPF + "', '" + nome + "'," + dataagora + "," + hfLoginPK.Value + ") " +
                    "END", "COD_PROPRIETARIO_PK"
                );
                if (codPropPK == 0)
                {
                    conexao.Message("Erro");
                    return;
                }
                codPropPK = conexao.insertReturn("INSERT INTO EMPRESA_PROPRIETARIO([COD_EMPRESA_PROPRIETARIO_PK],[COD_EMPRESA_FK],[COD_PROPRIETARIO_FK]) OUTPUT Inserted.COD_EMPRESA_PROPRIETARIO_PK VALUES ( ((SELECT TOP 1 COD_EMPRESA_PROPRIETARIO_PK FROM EMPRESA_PROPRIETARIO ORDER BY COD_EMPRESA_PROPRIETARIO_PK DESC) + 1)," + codEmpresaPK + "," + codPropPK + ")",
                "COD_EMPRESA_PROPRIETARIO_PK");
                if (codPropPK == 0)
                {
                    conexao.Message("Erro Empresa_Proprietário");
                    conexao.commandExec("DELETE FROM PROPRIETARIO WHERE COD_PROPRIETARIO_PK = " + codPropPK);
                    return;
                }


            }
            
            

            
            

            

           /* string comando = "SELECT COD_PROCESSO_PK, COD_CLI FROM PROCESSO WHERE COD_CLI='" + txtProcesso.Text + "'";
            int IDPROCESSO = 0;
            dt.Clear();
            dt = conexao.SELECT(comando);
            int registros = dt.Rows.Count;
            for (int i = 0; i < registros; i++)
            {
                IDPROCESSO = (int)dt.Rows[i]["COD_PROCESSO_PK"];
            }*/

            lbl4.ForeColor = System.Drawing.Color.Green;
            lbl4.Text = "Cadastrado";

            lbl4.Visible = true;

        }
        else
        {
            lbl4.ForeColor = System.Drawing.Color.Red;
            lbl4.Text = "Preencha os dois campos";

            lbl4.Visible = true;
        }

        
    }


    protected void bntCadastrarInfo_Click(object sender, EventArgs e)
    {
        string valfaturamento = "";
        string numerofuc = "";
        string numeroempr = "";
        if(faturamento.Text=="0,01" || faturamento.Text=="")
        {
            valfaturamento = "NULL";
        }
        else
        {
            valfaturamento = faturamento.Text;
        }
        if(numempregogeradostxt.Text== "0" || numempregogeradostxt.Text=="")
        {
            numeroempr = "NULL";
        }
        else
        {
            numeroempr = numempregogeradostxt.Text;
        }
        if(numfuctxt.Text=="0" || numfuctxt.Text=="" )
        {
            numerofuc = "NULL";
        }
        else
        {
            numerofuc = numfuctxt.Text;
        }
        string dataagora;
        dataagora = "'" + DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day + "'";
        string atividade = "";
        if(txtAtividade.Text=="")
        {
            atividade = "NULL";
        }
        else
        {
            atividade="'"+txtAtividade.Text+"'";

        }
        string tipomonetario = "NULL";
        if(ddlTipoMonetario.SelectedValue != "0")
        {
            tipomonetario = "'" + ddlTipoMonetario.SelectedValue + "'";
        }

        int codProcessoPK = Convert.ToInt32(hfCodProcessoPK.Value);

        conexao.commandExec("UPDATE EMPRESA SET EMAIL='" + EmailAddress.Text + "', TELEFONE='" + phone.Text + "', TIPO_MONETARIO="+tipomonetario+", FATURAMENTO_ANUAL=" + valfaturamento.Replace(".", "").Replace(",", ".") + ", NUM_FUNC=" + numerofuc + ", NUM_EMPREG_GERADOS = " + numeroempr+ ", ATIVIDADE="+atividade+" WHERE COD_EMPRESA_PK= (SELECT DISTINCT COD_EMPRESA_PK FROM EMPRESA INNER JOIN PROCESSO ON EMPRESA.COD_EMPRESA_PK=PROCESSO.COD_EMPRESA_FK WHERE COD_PROCESSO_PK= " + codProcessoPK + ")");
        
        lbl2.Visible = true;
        
    }



    protected void bntCadastrarVolume_Click(object sender, EventArgs e)
    {
        string dataagora;
        dataagora = "'" + DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day + "'";

        int codVolumePK = 0;
        String volume = volume1.Text;
        int codProcessoPK = Convert.ToInt32(hfCodProcessoPK.Value);
        DataTable dt = new DataTable();


        limpaData(dt);
        dt.Clear();
        dt = conexao.SELECT("SELECT COD_VOLUME_PK, COD_VOLUME_CODEMIG FROM VOLUME WHERE COD_VOLUME_CODEMIG='" + volume + "' AND COD_PROCESSO_FK=" + codProcessoPK + " ORDER BY COD_VOLUME_PK");

        if (dt.Rows.Count > 0)
        {
            lbl1.ForeColor = System.Drawing.Color.Red;
            lbl1.Text = "Volume já cadastrado";
            lbl1.Visible = true;
            return;
        }

        codVolumePK = conexao.insertReturn(
            "Declare @count int " +
            "SELECT @count = COUNT(*) FROM VOLUME " +
            "IF(@count > 0) " +
            "BEGIN " +
            "INSERT INTO VOLUME([COD_VOLUME_PK],[COD_VOLUME_CODEMIG],[COD_PROCESSO_FK],[DATA_CADASTRO_VOLUME],[CONTROLE_USUARIO_VOLUME]) OUTPUT Inserted.COD_VOLUME_PK VALUES( ((SELECT TOP 1 COD_VOLUME_PK FROM VOLUME ORDER BY COD_VOLUME_PK DESC) + 1) ,'" + volume + "', " + codProcessoPK + ","+dataagora+","+hfLoginPK.Value+ ") " +
            "END " +
            "ELSE " +
            "BEGIN " +
            "INSERT INTO VOLUME([COD_VOLUME_PK],[COD_VOLUME_CODEMIG],[COD_PROCESSO_FK],[DATA_CADASTRO_VOLUME],[CONTROLE_USUARIO_VOLUME]) OUTPUT Inserted.COD_VOLUME_PK VALUES( 1 ,'" + volume + "', " + codProcessoPK + "," + dataagora + "," + hfLoginPK.Value + ") " +
            "END", "COD_VOLUME_PK"
        );
        if (codVolumePK == 0)
        {
            conexao.Message("Erro");
            return;
        }
        
        
        volume1.Text = "";
        
        //função para mostra alert, parametro e a messagem exibida
        //conexao.Message("VOLUMES CADASTRADOS COM SUCESSO.");
        lbl1.ForeColor = System.Drawing.Color.Green;
        lbl1.Text = "Cadastrado";
        lbl1.Visible = true;
        


    }

    public bool Verificarnumero(int num)
    {
        num = num / num;
        if (num == 1)
        {
            return true;
        }
        else
        {
            return false;
        }
    }



    [System.Web.Services.WebMethod]
    public static ArrayList PopulateCities(int estado)
    {
        ArrayList list = new ArrayList();
        String strConnString = ConfigurationManager
            .ConnectionStrings["MyConnString"].ConnectionString;
        String strQuery = "select id, NOME from MUNICIPIO_IBEGE_BR where ESTADO=@Estado";
        using (SqlConnection con = new SqlConnection(strConnString))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@Estado", estado);
                cmd.CommandText = strQuery;
                cmd.Connection = con;
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    list.Add(new ListItem(
                   sdr["NOME"].ToString(),
                   sdr["id"].ToString()
                    ));
                }
                con.Close();
                return list;
            }
        }
    }
}
