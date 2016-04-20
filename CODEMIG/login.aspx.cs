using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CODEMIG.Classes;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void btnLogOn_Click(object sender, EventArgs e)
        {
            //DbConn dbc = new DbConn();
            //String msg = dbc.getErrorMsg();
            //if (msg.Length == 0)
            //{

                //if (Session["user"] == null)
               // { // database connection is good/open
                    //WebUserMods webUserMods = new WebUserMods(dbc);
            StringData webUserStringData = find(this.inputUser.Text, this.inputPassword.Text);
                    if (webUserStringData == null)
                    {
                        //msg = "Username and password not found.";
                        //this.lblMsg.CssClass = "negative";
                        Label1.Text = "Senha Incorreta";
                        Label1.ForeColor = System.Drawing.Color.Red;
                       
                    }
                    else
                    {
                        if (webUserStringData.userSistema == 0)
                        {
                            //Response.Write("<script>alert('Sistema em manutenção');</script>");
                            this.sistema.Text = "Sistema em manutenção";
                            this.sistema.ForeColor = System.Drawing.Color.Red;
                            Session.Abandon();
                            return;
                            //Response.Redirect("~/login.aspx");
                        }
                        /*if (webUserStringData.recordStatus.Length != 0)
                        {
                            msg = webUserStringData.recordStatus; // this would indicate programmer error
                        }
                        else
                        {*/
                        //this.lblMsg.CssClass = "positive";
                        //msg = "Welcome " + webUserStringData.userEmail + ". Your id is " + webUserStringData.userRole;// +
                        // webUserStringData.webUserId;
                        Session.Add("webuser", webUserStringData);
                        Session["Permissao"] = webUserStringData.userPermission.ToString();
                        Session["Entrada"] = DateTime.Now.ToString();
                        Session["Tempo"] = Convert.ToInt32(0);
                        Label1.Text = "";
                        Response.Redirect("~/home.aspx");
                        //}
                    }
                /*}
                else
                {
                    StringData webUserStringData = (StringData)Session["webuser"];
                    this.lblMsg.CssClass = "positive";
                    msg = "You are already signed in with " + webUserStringData.userEmail;
                }*/
            //}



            //this.lblMsg.Text = msg;
        }

        public StringData find(String user, String pwd)
        {
            StringData foundWebUser = new StringData();

            using (SqlConnection conn = new SqlConnection())
            {

                conn.ConnectionString = ConfigurationManager.ConnectionStrings["MyConnString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand())
                {

                    String strQuery = "select USERNAME, USUARIO.SISTEMA, COD_LOGIN_PK, PASSWORD, NOME_COMPLETO, TIPOPERMISSAO,PROCESSO,HISTORICO,CONTRATO, IMOVEL,EMPRESAS from USUARIO INNER JOIN PERMISSAO ON USUARIO.COD_LOGIN_PK=PERMISSAO.COD_LOGIN_FK where " +
                    "USERNAME = @user AND PASSWORD = SUBSTRING(sys.fn_sqlvarbasetostr(HASHBYTES('MD5', '" + pwd + "')),3,999)";
                    //"select COD_CLI, COD_EMPRESA_PK, COD_ENDERECO_EMPRESA_PK, CEP, NOME, NUMERO, TIPO, COMPLEMENTO, MUN, UF, BAIRRO from ENDERECO_EMPRESA END, EMPRESA EMP, PROCESSO PRO where END.COD_EMPRESA_FK = COD_EMPRESA_PK AND COD_CLI LIKE @SearchText + '%' ;";
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@user", user);
                    cmd.Parameters.AddWithValue("@pwd", pwd); //nao aceita substring
                    cmd.CommandText = strQuery;
                    cmd.Connection = conn;
                    conn.Open();
                    SqlDataReader sdr = cmd.ExecuteReader();

                    if (sdr.Read())
                    {
                        //foundWebUser.userRole = (sdr["USERNAME"]).ToString();
                        foundWebUser.userID = (sdr["COD_LOGIN_PK"]).ToString();
                        foundWebUser.user = (sdr["USERNAME"]).ToString();
                        foundWebUser.userPw = (sdr["PASSWORD"]).ToString();
                        foundWebUser.userName = (sdr["NOME_COMPLETO"]).ToString();
                        foundWebUser.userPermission = (sdr["TIPOPERMISSAO"]).ToString();
                        foundWebUser.userProcesso = (sdr["PROCESSO"]).ToString();
                        foundWebUser.userHistorico = (sdr["HISTORICO"]).ToString();
                        foundWebUser.userContrato = (sdr["CONTRATO"]).ToString();
                        foundWebUser.userEmpresas = (sdr["EMPRESAS"]).ToString();
                        foundWebUser.userImovel = (sdr["IMOVEL"]).ToString();
                        foundWebUser.userSistema = Convert.ToInt32(sdr["SISTEMA"].ToString());
                        conn.Close();

                        return foundWebUser;
                    }
                    else
                    {
                        conn.Close();
                        return null; // this is our way of saying we did not find a web_user record
                    }

                }
                
            }

        }





    }
