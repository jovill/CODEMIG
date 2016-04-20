using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


    public partial class home : System.Web.UI.Page
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {
            CODEMIG.Classes.StringData webUserStringData = (CODEMIG.Classes.StringData)Session["webuser"];

            if (Session["webuser"] != null)
            {
                if (Convert.ToInt32(Request.QueryString["per"]) == 2)
                {
                    permissao.Visible = true;
                    permissao.InnerHtml = "<center > <strong>Atenção!</strong> Você não tem permissão para acessar à pagina Historico .</center>";

                }
                if (Convert.ToInt32(Request.QueryString["per"]) == 1)
                {
                    permissao.Visible = true;
                    permissao.InnerHtml = "<center > <strong>Atenção!</strong> Você não tem permissão para acessar à pagina Processo .</center>";

                }
                if (Convert.ToInt32(Request.QueryString["per"]) == 3)
                {
                    permissao.Visible = true;
                    permissao.InnerHtml = "<center > <strong>Atenção!</strong> Você não tem permissão para acessar à pagina Contrato .</center>";

                }
                if (Convert.ToInt32(Request.QueryString["per"]) == 4)
                {
                    permissao.Visible = true;
                    permissao.InnerHtml = "<center > <strong>Atenção!</strong> Você não tem permissão para acessar à pagina Empresa .</center>";

                }
                if (Convert.ToInt32(Request.QueryString["per"]) == 5)
                {
                    permissao.Visible = true;
                    permissao.InnerHtml = "<center > <strong>Atenção!</strong> Você não tem permissão para acessar à pagina Painel de Controle .</center>";

                }
                if (Convert.ToInt32(Request.QueryString["per"]) == 6)
                {
                    permissao.Visible = true;
                    permissao.InnerHtml = "<center > <strong>Atenção!</strong> Você não tem permissão para acessar à pagina Consulta .</center>";

                }
                if (Convert.ToInt32(Request.QueryString["per"]) == 7)
                {
                    permissao.Visible = true;
                    permissao.InnerHtml = "<center > <strong>Atenção!</strong> Você não tem permissão para acessar à pagina Imovel .</center>";

                }
                    // +webUserStringData.webUserId;

                    /*var role = webUserStringData.userRole;
                    if (role.Equals("0"))
                    {
                        this.lblTableUser.Text = "<td id='td-nav' class='users'><a href='usersAdmin.aspx'>&nbsp;&nbsp;&nbsp;Users - Admin</a></td>";
                    }*/
                
               
               
            }
            else
            {
                Response.Write("<script>alert('Faça login para ter acesso ao sistema');</script>");

                Response.Redirect("~/login.aspx");
            }

        }
        protected void bntCadastrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("http://aryagis.com/consulta/consulta/?consulta=" + "!#47295924031de8604#abd495347545c58");
        }
    }
