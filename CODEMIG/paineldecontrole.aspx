<%@ Page EnableEventValidation= "false" Language="C#" AutoEventWireup="true" MasterPageFile="~/site.master" CodeBehind="paineldecontrole.aspx.cs" Inherits="CODEMIG.usuarios" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
    <script type="text/javascript">
        window.onload = function () {

            GridUser();

            setTimeout(function () {
                if ($('#<%=hfPermissao.ClientID%>').val() == "2") {
                    document.getElementById('manu').style.display = 'block';
                    //manutencao();
                } else if ($('#<%=hfPermissao.ClientID%>').val() == "0" || $('#<%=hfPermissao.ClientID%>').val() == "3") {
                    $('#<%=ddlNivel.ClientID%>').val("1");
                    $('#<%=ddlNivel.ClientID%>').attr("disabled", "disabled");
                    document.getElementById('paginas').style.display = 'block';
                    document.getElementById('manu').style.display = 'none';

                }
                else {
                    $('.cadastrar').attr("disabled", "disabled");
                }



            }, 2000);



        }
</script> 

            <script src="js/bootstrap.file-input.js" type="text/javascript"></script>   
   <script src="Scripts/jquery-1.9.1.min.js"></script>
<script src="Scripts/bootstrap.min.js"></script>
<link href="Content/bootstrap.min.css" rel="stylesheet" />
<link href="Content/bootstrap-theme.css" rel="stylesheet" />


   
<style>
        .btn-file {
        position: relative;
        overflow: hidden;
    }
    .btn-file input[type=file] {
        position: absolute;
        top: 0;
        right: 0;
        min-width: 100%;
        min-height: 100%;
        font-size: 100px;
        text-align: right;
        filter: alpha(opacity=0);
        opacity: 0;
        outline: none;
        background: white;
        cursor: inherit;
        display: block;
    }
 </style>
   
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="body">

    

    <div class="content">
        
                        
                        
        <form autocomplete="off" runat="server" class="form-inline" style="width: 100%;" ng-app="myApp" ng-controller="validateCtrl" name="myForm">
            
            <asp:ScriptManager ID="ScriptManager1" runat="server"/>
           <asp:HiddenField ID="hfPermissao" runat="server" Value="" />
            <asp:HiddenField ID="hfTdoc" runat="server" Value="" />
                        <asp:HiddenField ID="hfLat" runat="server" Value="" />
                        <asp:HiddenField ID="hfLng" runat="server" Value="" />
                        <asp:HiddenField ID="hfPrecisao" runat="server" Value="" />
                        <asp:HiddenField ID="hfTypes" runat="server" Value="" />
                        <asp:HiddenField ID="hfLogradouro" runat="server" Value="" />
                        <asp:HiddenField ID="hfNumero" runat="server" Value="" />
                        <asp:HiddenField ID="hfComplemento" runat="server" Value="" />
                        <asp:HiddenField ID="hfBairro" runat="server" Value="" />
                         <asp:HiddenField ID="hfMunicipio" runat="server" Value="" />
                        <asp:HiddenField ID="hfEstado" runat="server" Value="" />
           
             <div class="row" style="display:none;">     
                        
                    <center>
                       

                        <h4>
                            <label style="font-size: 1.4em; " class = "glyphicon glyphicon-download-alt" rel="tooltip" title=""></label>
                            <span style="color:#333333; position:relative; top:-5px;">
                                Geocode<h6>O arquivo deve conter as seguintes colunas:(Logradouro,Número,Bairro,Múncipio,UF)</h6>
                            </span>
                        </h4>
                    </center>

                </div>

            
            <div class="row" style="display:none; margin-bottom:5px;">
                     
                <div class="col-md-4"></div>

                <div class="col-md-4">
   
                     
                        
                            <span class="btn btn-default btn-file" style="width:100%; text-align:left; margin-bottom:5px;"> Selecione(.xlsx) <input type="file"  id="File1" name="File1"  runat="server" />
                            </span>

                        
                        
                     
                    
                    
                </div>

                <div class="col-md-4"></div>

            </div>
              <div class="row" style=" display:none; margin-bottom:5px;">
                     
                <div class="col-md-4"></div>

                <div class="col-md-4">
   
                     
                      
                         
                              <asp:LinkButton   runat="server" OnClick="FindEndereco_Click1"   ID="LinkButton4"   class="btn btn-primary btn-sm pull-right">Geocode</asp:LinkButton>
                     

                      
                     
                    
                    
                </div>

                <div class="col-md-4"></div>

            </div>
             
            <%-- DISTRITO ---------------------------------------------------------------------------------------------%>
            <div class="row">     
           
                    <center>
                        <h4>
                            <label style="font-size: 1.4em; " class = "glyphicon glyphicon-list-alt" rel="tooltip" title=""></label>
                            <span style="color:#333333; position:relative; top:-5px;">
                                RELATÓRIO
                            </span>
                        </h4>
                    </center>

                </div>
            <div class="row" style="margin-bottom:5px;">
                     
                <div class="col-md-4"></div>

                <div class="col-md-4 form-group">
                    <asp:DropDownList  Style="width: 100%" ID="ddlDistritos" class=" form-control input-sm " runat="server" AppendDataBoundItems="true" onchange="onchangeOcorrencia()" >
                        <asp:ListItem Text = "Distrito" Value = "0"></asp:ListItem>                 
                    </asp:DropDownList>
                </div>

                <div class="col-md-4"></div>

            </div>
            <div class="row" style="margin-bottom:5px;">
                     
                <div class="col-md-4"></div>

                <div class="col-md-4 ">
                        <div style=" margin-bottom:5px; width: 100%; " class=" btn-group btn-group-sm btn-group-justified btn-group-fill-height">
                            <asp:LinkButton Style="margin-right:2px;" runat="server" OnClick="Button1_Processo" ID="LinkButton1" class="btn btn-primary btn-sm  processo" disabled><i class='fa fa-file-excel-o'></i> Processo</asp:LinkButton>

                            <asp:LinkButton Style="margin-right:2px;" runat="server" OnClick="Button1_Historico" ID="LinkButton2" class="btn btn-primary btn-sm historico" disabled><i class='fa fa-file-excel-o'></i> Histórico</asp:LinkButton>

                            <asp:LinkButton  runat="server" OnClick="Button1_Contrato" ID="LinkButton3" class="btn btn-primary btn-sm contrato" disabled><i class='fa fa-file-excel-o'></i> Contrato</asp:LinkButton>

                        </div>


                        <div style=" margin-bottom:5px; width: 100%;" id="empIrre">
                            <asp:LinkButton Style="width: 100%;" runat="server" OnClick="bntIrregular_Click1" ID="bntIrregular" class="btn btn-primary btn-sm empresas">Empresas Irregulares</asp:LinkButton>
                
                        </div>

                </div>
              

    
                   
                <div class="col-md-4"></div>
                
                
                
                </div>
                <div id="manu" class="row" style=" display:none; margin-bottom:5px;">
                        <div class="col-md-4"></div>

                        <div class="col-md-4">

                            <h4>
                                    <label style="font-size: 1.4em; " class = "glyphicon glyphicon-time"  title=""></label>
                                    <span style="color:#333333; position:relative; top:-5px;"> MANUTENÇÃO</span>
                                </h4>
                            <div>

                            <asp:LinkButton Style="width: 100%;" runat="server" OnClick="bntManutencao_Click1" ID="bntManutencao" class="btn btn-danger btn-sm manutencao">Ativar Manutenção</asp:LinkButton>

                            </div>
                        </div>


                        <div class="col-md-4"></div>

                </div>           
<%--------------------------------------------------------------------------------------------- DISTRITO --%>

            <div class="row">     
           
                    <center>
                        <h4>
                            <label style="font-size: 1.4em; " class = "glyphicon glyphicon-user" rel="tooltip" title=""></label>
                            <span style="color:#333333; position:relative; top:-5px;">
                                USUÁRIO
                            </span>
                        </h4>
                    </center>

                </div>

<%-- GRID HISTÓRICOS ------------------------------------------------------------------------------------------%>
                 <asp:HiddenField ID="hfLoginPk" runat="server" Value="" />
                <asp:HiddenField ID="hfUserPk" runat="server" Value="" />
                <div class="row" >
                     
                    <div class="col-md-4"></div>

                    <div class="col-md-4 form-group" style="">
                        <div style="max-height:200px; overflow-y:auto; border:1px solid #cccccc;	border-radius: 3px;  display:block;" id="divHists">
                       
                          <table   style="width: 100%;"  id="tblUsuarios">
                         
                          </table>

                        </div>
                    </div>

                    <div class="col-md-4"></div>

                </div>
<%------------------------------------------------------------------------------------------ GRID HISTÓRICOS --%>

<%-- INFORMAÇÕES ----------------------------------------------------------------------------------------------%>
                

                
                <div class="row">     
           
                    <center>
                        <h4>
                            <label style="font-size: 1.4em; " class = "glyphicon glyphicon-user" rel="tooltip" title=""></label>
                            <span style="color:#333333; position:relative; top:-5px;">
                                CADASTRO
                            </span>
                        </h4>
                    </center>

                </div>
                
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4"></div>
                        
                    <div class=" col-md-4 form-group " >
                            
                        <asp:TextBox Style="width: 100%" type="text" placeholder="Usuario" class=" form-control input-sm" ID="txtUsuario" runat="server" name="" ></asp:TextBox>
                            
                    </div>

                    <div class="col-md-4"></div>

                </div>

                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4"></div>
                        
                    <div class=" col-md-4 form-group " >
                            
                        <asp:TextBox Style="width: 100%" type="password" placeholder="Senha" class=" form-control input-sm" autocomplete="off" ID="txtSenha" runat="server" name=""></asp:TextBox>
                            
                    </div>

                    <div class="col-md-4"></div>

                </div>

                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4"></div>
                        
                    <div class=" col-md-4 form-group " >
                            
                        <asp:TextBox Style="width: 100%" type="text" placeholder="Nome Completo" class=" date form-control input-sm" ID="txtNome" runat="server" name="Data" ></asp:TextBox>
                            
                    </div>

                    <div class="col-md-4"></div>

                </div>

                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4"></div>
                        
                    <div class=" col-md-4 form-group " >
                            
                        <asp:TextBox Style="width: 100%" type="email" placeholder="Email" class=" date form-control input-sm" ID="txtEmail" runat="server" name="Data" ></asp:TextBox>
                            
                    </div>

                    <div class="col-md-4"></div>

                </div>

                <div id="nivel" class="row" >

                    <div class="col-md-4"></div>
                        
                    <div class=" col-md-4 form-group " >
                        <asp:DropDownList Style="width: 100%"  class="form-control input-sm" ID="ddlNivel" runat="server" onchange="onchangeNivel()">
                            <asp:ListItem Value="0">Admin Distrito</asp:ListItem>
                            <asp:ListItem Value="3">Admin Imovel</asp:ListItem>
                            <asp:ListItem Value="1">Usuário</asp:ListItem>
                        </asp:DropDownList>

                    </div>

                    <div class="col-md-4"></div>

                </div>


                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4"></div>
                        
                    <div class=" col-md-4 form-group " >
                        
                        <div id="paginas" class="cblAbas" style="width:100%; height:135px; overflow-y:auto; border:1px solid #cccccc; 	border-radius: 3px; padding:10px; display: none;">
                            <asp:CheckBoxList ID="cblPaginas" runat="server">
                                <asp:ListItem Value="PROCESSO" class="check">Processo</asp:ListItem>
                                <asp:ListItem Value="HISTORICO" class="check">Histórico</asp:ListItem>
                                <asp:ListItem Value="CONTRATO" class="check">Contrato</asp:ListItem>
                                <asp:ListItem Value="IMOVEL" class="check">Imovel</asp:ListItem>
                                 <asp:ListItem Value="EMPRESAS" class="check">Empresa</asp:ListItem>
                            </asp:CheckBoxList>
                        </div>

                    </div>

                    <div class="col-md-4"></div>

                </div>
                <div class="row">

                    <div class="col-md-4"></div>
                        
                    <div class=" col-md-4 form-group " >
                        
                        <div style="overflow-y: auto; height: 30px; border: 1px solid #cccccc; border-radius: 3px; padding-top: 4px; padding-left: 10px;">
                            <span style="position: relative; top: -2px;">
                                Recebe Email: &nbsp;&nbsp;
                            </span>
                            <asp:RadioButton ID="rdoButtonRecebe" runat="server" Value="1" GroupName="tipo"></asp:RadioButton><span style="position: relative; top: -2px;"> Sim</span>&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:RadioButton ID="rdoButtonNRecebe" runat="server" Value="0" GroupName="tipo" Checked></asp:RadioButton><span style="position: relative; top: -2px;"> Não</span>

                        </div>

                        

                    </div>
                    

                    <div class="col-md-4"></div>

                </div>
<%---------------------------------------------------------------------------------------------- INFORMAÇÕES --%>
                <br />
<%-- BOTÕES CADASTRAR / ATUALIZAR -----------------------------------------------------------------------------%>
                                
                <div class="row">

                    <div class="col-md-4"></div>
                    <div class="col-md-3 col-sm-4  form-group">
                        <span title='Apagar campos' id="limpartudo" onclick='javascript:LimpaCampos();' class='glyphicon glyphicon-erase' style="cursor:pointer; font-size: 1.4em; display: none;"></span>
                    </div>
                    <div class="col-md-1 form-group">
                        <asp:LinkButton  runat="server" onclick="bntCadastrar_Click1"  type="button" class="btn btn-primary btn-sm pull-right cadastrar">
                            &nbsp;&nbsp;&nbsp;
                            Cadastrar
                            &nbsp;&nbsp;&nbsp;
                        </asp:LinkButton>
                        <asp:LinkButton runat="server" onclick="bntUpdate_Click" type="button" class="btn btn-primary btn-sm pull-right update" Style=" display: none">
                            <center>
                                &nbsp;&nbsp;&nbsp;
                                Update
                                &nbsp;&nbsp;&nbsp;
                            </center>
                        </asp:LinkButton>
                        
                    </div>

                    <div class="col-md-4"></div>

                </div>

<%------------------------------------------------------------------------------ BOTÕES CADASTRAR / ATUALIZAR --%> 
                               
              
             
        </form>

    </div>

    <br />
    <br />
    <br />

    <script type = "text/javascript">


        $(document).on('click', '.update', function (e) {// FUNÇÃO PARA LIMPAR CAMPOS E FAZER UM NOVO CADASTRO

            $('#<%=ddlNivel.ClientID%>').removeAttr("disabled");


        });

        $(document).on('click', '.cadastrar', function (e) {// FUNÇÃO PARA LIMPAR CAMPOS E FAZER UM NOVO CADASTRO

            $('#<%=ddlNivel.ClientID%>').removeAttr("disabled");


        });
        $('input[type=file]').bootstrapFileInput();



        function manutencao() {

            // document.getElementById('manu').style.display = 'block';
        }

        function onchangeNivel() {

            if ($('#<%=ddlNivel.ClientID%>').val() == "1") {
                    document.getElementById('nivel').style.marginBottom = "5px"
                    document.getElementById('paginas').style.display = 'block';

                } else {
                    document.getElementById('paginas').style.display = 'none';
                    document.getElementById('nivel').style.marginBottom = "0px"
                }

            }
            /** FUNÇÕES CONTROLE USUÁRIO **********************************************************************************/
            var activePage = true;

            if (localStorage.getItem('Tempo') == null) {
                var tempo = '<% = Session["Tempo"]%>'

        }
        else {
            var tempo = localStorage.getItem('Tempo');

        }

        function showInformation() {

            tempo = parseInt(tempo.toString());


            if (activePage) {

                tempo = tempo + 1;
                localStorage.setItem('Tempo', tempo);

            } else {


            }

            setTimeout("showInformation();", 1000);
        }

        $(function () {
            $(window)
                .focus(function () { activePage = true; })
                .blur(function () { activePage = false; });

            showInformation();
        });

        function DataHora() {

            var session = '<% = Session["Entrada"]%>'
            var IDUSER = '<%=Session["IDUSER"].ToString()%>'
            localStorage.setItem('Tempo', null);
            localStorage.removeItem('Tempo');
            $.ajax({
                url: '<%=ResolveUrl("~/Service.asmx/SetHora") %>',
                data: "{ 'prefix':'" + tempo + "$" + session + "$" + IDUSER + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data7) {

                    if (data7.d.toString() == "1") {

                    }

                },
                error: function (response) {
                    alert(response.responseText);

                },
                failure: function (response) {
                    alert(response.responseText);

                }
            });

        }
        /********************************************************************************** FUNÇÕES CONTROLE USUÁRIO **/
        function editUser(id) {
            $('.cadastrar').fadeOut();
            $('.update').fadeIn(3000);
            $('#limpartudo').fadeIn(3000);

            var usuario = id.id.split('#');
            var userid = usuario[0];

            document.getElementById('<%=hfUserPk.ClientID %>').value = userid;
            var username = usuario[1];

            var nome = usuario[2];
            var email = usuario[3]
            var permissao = usuario[4];
            var abas = usuario[6];
            var recebeEmail = usuario[5];

            var processo = abas.split('&&')[0];
            var historico = abas.split('&&')[1];
            var imovel = abas.split('&&')[2];
            var contrato = abas.split('&&')[3];
            var empresas = abas.split('&&')[4];
            $('#<%=txtUsuario.ClientID%>').val(username);
            $('#<%=txtNome.ClientID%>').val(nome);
            $('#<%=txtEmail.ClientID%>').val(email);


            if (recebeEmail == 1 || recebeEmail == '1') {
                $('#<%=rdoButtonRecebe.ClientID%>').attr("checked", "checked");
            } else {
                $('#<%=rdoButtonNRecebe.ClientID%>').attr("checked", "checked");
            }

            if ($('#<%=hfPermissao.ClientID%>').val() == "2") {
                $('#<%=ddlNivel.ClientID%>').removeAttr("disabled");
                if (permissao == "Usuario") {
                    $('#<%=ddlNivel.ClientID%>').val("1");


                    document.getElementById('paginas').style.display = 'block';
                    if (processo.trim() == "btn") {

                        $('input[value="PROCESSO"]').prop('checked', true);
                    }
                    else {
                        $('input[value="PROCESSO"]').prop('checked', false);
                    }
                    if (historico.trim() == "btn") {
                        $('input[value="HISTORICO"]').prop('checked', true);
                    }
                    else {
                        $('input[value="HISTORICO"]').prop('checked', false);
                    }

                    if (imovel.trim() == "btn") {

                        $('input[value="IMOVEL"]').prop("checked", true);
                    }
                    else {

                        $('input[value="IMOVEL"]').prop("checked", false);
                    }
                    if (contrato.trim() == "btn") {

                        $('input[value="CONTRATO"]').prop('checked', true);

                    }
                    else {

                        $('input[value="CONTRATO"]').prop("checked", false);
                    }
                    if (empresas.trim() == "btn") {

                        $('input[value="EMPRESAS"]').prop('checked', true);

                    }
                    else {

                        $('input[value="EMPRESAS"]').prop("checked", false);
                    }


                }
                else if (permissao == "Administrador Imóvel") {

                    $('#<%=ddlNivel.ClientID%>').val("3");

                    document.getElementById('paginas').style.display = 'none';

                }
                else if (permissao == "Administrador Distrito") {
                    $('#<%=ddlNivel.ClientID%>').val("0");

                    document.getElementById('paginas').style.display = 'none';
                }
                else {
                    $('#<%=ddlNivel.ClientID%>').attr("disabled", "disabled");
                    if ($('#<%=ddlNivel.ClientID%>').val("2").val() != null) {
                        $('#<%=ddlNivel.ClientID%>').val("2");
                           document.getElementById('paginas').style.display = 'none';
                       }
                       else {
                           $('#<%=ddlNivel.ClientID%>').append("<option value='2'>Master</option>")
                           $('#<%=ddlNivel.ClientID%>').val("2")
                           document.getElementById('paginas').style.display = 'none';
                       }
                   }

       }
       else if ($('#<%=hfPermissao.ClientID%>').val() == "0") {

                if (permissao == "Usuario") {

                    $('#<%=ddlNivel.ClientID%>').val("1");
                    $('#<%=ddlNivel.ClientID%>').attr("disabled", "disabled");
                    document.getElementById('paginas').style.display = 'block';
                    if (processo.trim() == "btn") {

                        $('input[value="PROCESSO"]').prop('checked', true);
                    }
                    else {
                        $('input[value="PROCESSO"]').prop('checked', false);
                    }
                    if (historico.trim() == "btn") {
                        $('input[value="HISTORICO"]').prop('checked', true);
                    }
                    else {
                        $('input[value="HISTORICO"]').prop('checked', false);
                    }

                    if (imovel.trim() == "btn") {

                        $('input[value="IMOVEL"]').prop("checked", true);
                    }
                    else {

                        $('input[value="IMOVEL"]').prop("checked", false);
                    }
                    if (contrato.trim() == "btn") {

                        $('input[value="CONTRATO"]').prop('checked', true);

                    }
                    else {

                        $('input[value="CONTRATO"]').prop("checked", false);
                    }
                    if (empresas.trim() == "btn") {

                        $('input[value="EMPRESAS"]').prop('checked', true);

                    }
                    else {

                        $('input[value="EMPRESAS"]').prop("checked", false);
                    }
                }
                else {
                    $('#<%=ddlNivel.ClientID%>').attr("disabled", "disabled");
                    $('#<%=ddlNivel.ClientID%>').val("0");
                    document.getElementById('paginas').style.display = 'none';
                }

            }
            else if ($('#<%=hfPermissao.ClientID%>').val() == "3") {

                if (permissao == "Usuario") {
                    $('#<%=ddlNivel.ClientID%>').attr("disabled", "disabled");
                    $('#<%=ddlNivel.ClientID%>').val("1");
                    document.getElementById('paginas').style.display = 'block';
                    if (processo.trim() == "btn") {

                        $('input[value="PROCESSO"]').prop('checked', true);
                    }
                    else {
                        $('input[value="PROCESSO"]').prop('checked', false);
                    }
                    if (historico.trim() == "btn") {
                        $('input[value="HISTORICO"]').prop('checked', true);
                    }
                    else {
                        $('input[value="HISTORICO"]').prop('checked', false);
                    }

                    if (imovel.trim() == "btn") {

                        $('input[value="IMOVEL"]').prop("checked", true);
                    }
                    else {

                        $('input[value="IMOVEL"]').prop("checked", false);
                    }
                    if (contrato.trim() == "btn") {

                        $('input[value="CONTRATO"]').prop('checked', true);

                    }
                    else {

                        $('input[value="CONTRATO"]').prop("checked", false);
                    }
                    if (empresas.trim() == "btn") {

                        $('input[value="EMPRESAS"]').prop('checked', true);

                    }
                    else {

                        $('input[value="EMPRESAS"]').prop("checked", false);
                    }
                }
                else {
                    $('#<%=ddlNivel.ClientID%>').attr("disabled", "disabled");
                    $('#<%=ddlNivel.ClientID%>').val("3");
                    document.getElementById('paginas').style.display = 'none';
                }
            }
            else {
                $('#<%=ddlNivel.ClientID%>').attr("disabled", "disabled");
                $('#<%=ddlNivel.ClientID%>').val("1");
            }








}
function removeUser(id) {

    var usuario = id.id.split('#');
    var userid = usuario[0];

    if (confirm("Deseja excluir usuario: " + usuario[1] + " ?")) {
        $.ajax({

            url: '<%=ResolveUrl("~/Service.asmx/removeUser") %>',
                    data: "{'usuarioPK': '" + userid + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data5) {
                        if (parseInt(data5.d) > 0) {
                            alert('usuario excluido!');
                            GridUser();
                        }
                        else {
                            alert('Usuario não encontrado, tente novamente.')
                        }


                    },
                    error: function (response) {
                        alert(response.responseText);
                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }

                });
            }


        }

        function LimpaCampos() {

            $('#<%=ddlNivel.ClientID%>').removeAttr("disabled");

            document.getElementById('<%=txtUsuario.ClientID%>').value = '';
            document.getElementById('<%=txtNome.ClientID%>').value = '';
            document.getElementById('<%=txtSenha.ClientID%>').value = '';

            document.getElementById('<%=ddlDistritos.ClientID %>').value = '0';
            onchangeOcorrencia()
            $('#<%=rdoButtonNRecebe.ClientID%>').attr("checked", "checked");
            document.getElementById('<%=txtEmail.ClientID%>').value = '';
            document.getElementById('<%=ddlNivel.ClientID%>').value = '0';
            onchangeNivel()


            $(".check").each(function () {
                $(this).prop("checked", false)
            });

            $('.update').fadeOut();
            $('#limpartudo').fadeOut();
            $('.cadastrar').fadeIn(3000);

        }


        function onchangeOcorrencia() {
            if ($('#<%=ddlDistritos.ClientID%>').val() == "0") {
                $('.processo').attr("disabled", "disabled");
                $('.historico').attr("disabled", "disabled");
                $('.contrato').attr("disabled", "disabled");
            } else {
                $('.processo').removeAttr("disabled");
                $('.historico').removeAttr("disabled");
                $('.contrato').removeAttr("disabled");

            }
        }


        function GridUser() {

            $.ajax({

                url: '<%=ResolveUrl("~/Service.asmx/GetUsuario") %>',
                data: "{'prefix': '1'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data5) {
                    var DADOS = data5.d.toString().split('()');
                    var hists = DADOS[0].split(',');
                    var lotes = DADOS[1].split(',');


                    //var lotes2 = lotes.toString();
                    //alert(props);
                    var txt2 = "";
                    if (hists[0] != "Zero") {

                        //document.getElementById('divHists').style.display = 'block';

                        var historico = "";
                        var lotes2 = "";

                        if ($('#<%=hfPermissao.ClientID%>').val() == "0" || $('#<%=hfPermissao.ClientID%>').val() == "2" || $('#<%=hfPermissao.ClientID%>').val() == "3") {
                            //txt2 += "<tr><th>DE</th><th>PARA</th><th>DATA</th><th>TIPO</th><th>PÁGINA</th><th><i class='fa fa-cogs'></i></th></tr>";

                            txt2 += "<tr>" +
                            "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" +
                            "Nome de Usuario" +
                            "</td>" +
                            "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" +
                            "Nome Completo" +
                            "</td>" +
                            "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" +
                            "Email" +
                            "</td>" +
                            "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" +
                            "Permissao" +
                            "</td>" +
                            "<td style='padding-left: 10px; padding-right: 10px;  border-bottom: 1px solid #cccccc;'>" +
                            "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
                            "</td>" +
                        "</tr>";


                        } else {
                            //txt2 += "<tr><th>DE</th><th>PARA</th><th>DATA</th><th>TIPO</th><th>PÁGINA</th></tr>";
                            txt2 += "<tr>" +
                            "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" +
                            "Nome de Usuario" +
                            "</td>" +
                            "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" +
                            "Nome Completo" +
                            "</td>" +
                            "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" +
                            "Email" +
                            "</td>" +
                            "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" +
                            "Permissao" +
                            "</td>" +
                            "</tr>";
                        }





                        for (var x = 0; x < hists.length; x++) {

                            historico = hists[x].split('&&');


                            if (historico[4] == "0") {
                                historico[4] = "Administrador Distrito";

                            }
                            else if (historico[4] == "2") {
                                historico[4] = "Master";
                            }
                            else if (historico[4] == "3") {
                                historico[4] = "Administrador Imóvel";
                            }
                            else {
                                historico[4] = "Usuario";
                            }


                            if ($('#<%=hfPermissao.ClientID%>').val() == "2") {
                                txt2 += "<tr><td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[1] + "</td ><td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[2] +
                                    "</td ><td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[3] + "</td ><td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[4] +
                                    "</td >" +
                                    "<td style=' padding-left: 10px; padding-right: 10px;  border-bottom: 1px solid #cccccc;'><div style='width:40px;'><i title='editar' id='" + historico[0] + "#" + historico[1] + "#" + historico[2] + "#" + historico[3] + "#" + historico[4] + "#" + historico[5] + "#" + lotes[x] + "' style='cursor:pointer;margin-right:4px;' onclick='javascript:editUser(this);' value='' class='fa fa-pencil-square-o'></i><span style='cursor:pointer;' title='deletar' id='" + historico[0] + "#" + historico[1] + "' onclick='javascript:removeUser(this);' value='' class='glyphicon glyphicon-remove '></span></di></td></tr>";

                            } else {

                                if ($('#<%=hfPermissao.ClientID%>').val() == "3" && historico[4] == "Usuario" || $('#<%=hfPermissao.ClientID%>').val() == "0" && historico[4] == "Usuario" || historico[0] == $('#<%=hfLoginPk.ClientID%>').val()) {
                                    txt2 += "<tr><td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[1] + "</td ><td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[2] +
                                    "</td ><td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[3] + "</td ><td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[4] +
                                    "</td >" +
                                    "<td style=' padding-left: 10px; padding-right: 10px;  border-bottom: 1px solid #cccccc;'><div style='width:40px;'><i title='editar' id='" + historico[0] + "#" + historico[1] + "#" + historico[2] + "#" + historico[3] + "#" + historico[4] + "#" + historico[5] + "#" + lotes[x] + "' style='cursor:pointer;margin-right:4px;' onclick='javascript:editUser(this);' value='' class='fa fa-pencil-square-o'></i><span style='cursor:pointer;' title='deletar' id='" + historico[0] + "#" + historico[1] + "' onclick='javascript:removeUser(this);' value='' class='glyphicon glyphicon-remove '></span></di></td></tr>";

                                } else {
                                    txt2 += "<tr><td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[1] + "</td ><td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[2] +
                                    "</td ><td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[3] + "</td ><td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[4] +
                                    "</td ><td style=' padding-left: 10px; padding-right: 10px;  border-bottom: 1px solid #cccccc;'></td></tr>";
                                }

                            }




                        }

                        document.getElementById('tblUsuarios').innerHTML = txt2;
                    } else {
                        document.getElementById('tblUsuarios').innerHTML = '';
                    }


                },
                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }

            });

        }


    </script>
     
    
   
    
   
</asp:Content>



