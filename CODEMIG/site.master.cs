using CODEMIG.Classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CODEMIG
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        CODEMIG.Classes.DbUtils.DbConn conexao = new CODEMIG.Classes.DbUtils.DbConn();


        protected void Page_Load(object sender, EventArgs e)
        {

            DataTable dt = new DataTable();

            dt = conexao.SELECT("SELECT SISTEMA FROM USUARIO WHERE SISTEMA<>1");


            if (dt.Rows.Count > 0)
            {
                //this.lblSistema.ForeColor = System.Drawing.Color.Red;
                this.lblSistema.Text = "<i class='fa fa-thumbs-down' title='Sistema em manutenção' style='color: red'></i>";


            }
            else
            {

                //this.lblSistema.ForeColor = System.Drawing.Color.Green;
                this.lblSistema.Text = "<i class='fa fa-thumbs-up' title='Sistema em funcionamento' style='color: green'></i>";



            }

            if (Session["webuser"] == null)
            {
                this.lblStatusUser.Text = "<i class='fa fa-lock'></i>";

            }
            else
            {

                StringData webUserStringData = (StringData)Session["webuser"];

                this.lblStatusUser.Text = webUserStringData.user + "&nbsp;&nbsp;&nbsp;<i class='fa fa-unlock'></i>";
                this.linkHome.Attributes["Class"] = "btn";
                this.linkProcesso.Attributes["Class"] = webUserStringData.userProcesso.ToString();
                this.linkHistorico.Attributes["Class"] = webUserStringData.userHistorico.ToString();
                this.linkContrato.Attributes["Class"] = webUserStringData.userContrato.ToString();
                this.linkImovel.Attributes["Class"] = webUserStringData.userImovel.ToString();
                this.linkEmpresa.Attributes["Class"] = webUserStringData.userEmpresas.ToString();
                this.linkADEmpresa.Attributes["Class"] = webUserStringData.userProcesso.ToString();
                if (webUserStringData.userPermission.ToString() == "0" || webUserStringData.userPermission.ToString() == "2" || webUserStringData.userPermission.ToString() == "3")
                {
                    this.linkConsulta.Attributes["Class"] = "btn";
                    this.linkCadastro.Attributes["Class"] = "btn";

                }

                this.linkSair.Attributes["Class"] = "btn";
                Session["IDUSER"] = webUserStringData.userID;
                // +webUserStringData.webUserId;

                /*var role = webUserStringData.userRole;
                if (role.Equals("0"))
                {
                    this.lblTableUser.Text = "<td id='td-nav' class='users'><a href='usersAdmin.aspx'>&nbsp;&nbsp;&nbsp;Users - Admin</a></td>";
                }*/
            }

        }
    }
}