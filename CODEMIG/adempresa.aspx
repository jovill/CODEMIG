<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/site.master" CodeBehind="adempresa.aspx.cs" Inherits="CODEMIG.adempresa" %>

 <asp:Content runat="server" ContentPlaceHolderID="head">
        
    </asp:Content>

    <asp:Content runat="server" ContentPlaceHolderID="body">

    <div class="content">

        <form autocomplete="off" runat="server" class="form-inline" style="width: 100%;" name="myForm" novalidate>
            <asp:HiddenField ID="hfLoginPK" runat="server" Value="" />
            <asp:HiddenField ID="hfPermissao" runat="server" Value="" />
            <asp:HiddenField ID="hfCodProcessoPK" runat="server" Value="" />
            <asp:HiddenField ID="hfCodEmpresaPK" runat="server" Value="" />
            <asp:ScriptManager ID="ScriptManager1" runat="server"/>
            

<%-- DISTRITO ---------------------------------------------------------------------------------------------%>
            <div class="row" style="margin-bottom:5px;">
                     
                <div class="col-md-4"></div>

                <div class="col-md-4 form-group">
                    <asp:DropDownList   Style=" display:none; width: 100%" ID="ddlDistritos" class=" form-control input-sm " runat="server" AppendDataBoundItems="true" >
                        <asp:ListItem Text = "Distrito" Value = "0"></asp:ListItem>                 
                    </asp:DropDownList>
                </div>

                <div class="col-md-4"></div>

            </div>
<%--------------------------------------------------------------------------------------------- DISTRITO --%>
<%-- PROCESSO ---------------------------------------------------------------------------------------------%>
            <div class="row" style="margin-bottom:5px;"> 

                <div class="col-md-4"></div>

                <div class="col-md-4 form-group">
                    <div class="icon-addon addon-sm">
                        <asp:TextBox Style="width: 100%" type="text" placeholder="Processo" class="form-control input-sm" ID="txtProcesso" runat="server" name="processo" autofocus="true"></asp:TextBox>
                        <label for="processo" class="glyphicon glyphicon-folder-close" rel="tooltip" title="processo" id="folder"></label>
                    </div>
                </div>

                <div class="col-md-4"></div>

            </div>
<%--------------------------------------------------------------------------------------------- PROCESSO --%>
<%-- EXIBIR VOLUMES ---------------------------------------------------------------------------------------%>

            <div class="row" style="margin-bottom:5px;">

                <div class="col-md-4"></div>
                <div class="col-md-4" id="rowVolumes" style="display: none;">
                    <div class=" form-group" style="width:100%;">
                        <div style="max-height: 100px; height: 42px; overflow-y: auto; border: 1px solid #cccccc; border-radius: 3px; padding: 10px;" id="volumes">
                        </div>
                    </div>
                </div>
                <div class="col-md-4"></div>


            </div>
<%-- VOLUME -----------------------------------------------------------------------------------------------%>
                
            <div class="controls  row5">

                <div id="teste" class="entry row " style="display: none; margin-bottom:5px;"">
                        
                    <div class="col-md-4"></div>
                    <div class="col-md-4 form-group">
                        <div class="input-group input-group-sm addon-sm " style="width: 100%">

                            <div>
                                <asp:TextBox Style="width: 100%" runat="server" class="form-control input-sm volumes" name="fields[]" ID="volume1" type="text" placeholder="Volume"></asp:TextBox>
                            </div>
                            <span class="input-group-btn" style="width: 10px;">

                                <asp:LinkButton ID="btnAtualizarParcial" runat="server" OnClick="bntCadastrarVolume_Click" type="button" class="btn btn-primary btn-sm pull-right cadastroVolume">
                                    
                                    <span class="glyphicon glyphicon-folder-close" aria-hidden="true"></span>
                                    
                                </asp:LinkButton>



                                
                            </span>

                        </div>
                    </div>
                    <div class="col-md-4"></div>

                </div>

            </div>
<%----------------------------------------------------------------------------------------------- VOLUME --%>

                
<%-- BOTÃO VOLUME -----------------------------------------------------------------------------------------%>
            <div id="displaybutton" class="row" style="display: none;">

                <div class="col-md-4"></div>
                    <div class="col-md-2 form-group">

                        <asp:UpdatePanel ID="UpdatePanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Label ID="lbl1" runat="server" ForeColor="Green" Visible="false">
                                        Cadastrado
                                </asp:Label>
                                <%-- =DateTime.Now.ToString() --%>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnAtualizarParcial"  EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>

                    <div class="col-md-2 form-group">
                                
                            <%--&nbsp;&nbsp;&nbsp;
                             %><asp:LinkButton ID="btnAtualizarParcial" runat="server" OnClick="bntCadastrarVolume_Click" type="button" class="btn btn-primary btn-sm pull-right cadastroVolume">
                                    
                                <span class="glyphicon glyphicon-folder-close" aria-hidden="true"></span>
                                    
                            </asp:LinkButton>--%>
                    </div>

                <div class="col-md-4"></div>

            </div>
<%----------------------------------------------------------------------------------------- BOTÃO VOLUME --%>
            <center>
<%-- EXIBIR RAZÃO E CNPJ ----------------------------------------------------------------------------------%>
                <h5><span id="empresa" style="color:#333333;"></span><br />
                <span id="CNPJ" style="color:#333333;"></span></h5>
                
<%---------------------------------------------------------------------------------- EXIBIR RAZÃO E CNPJ --%>
                <label style="position:relative; top:-5px; margin-bottom:10px; display: none;" class  ="glyphicon glyphicon-triangle-top"  rel="tooltip" title="email" id="hidr"></label>
            </center>

            <div id="teste2" style="display:none;" class="row2">

<%-- INFORMAÇÕES ------------------------------------------------------------------------------------------%>
                <center>
                    <h4>
                        <label style="font-size: 1.4em; " class = "glyphicon glyphicon-info-sign" rel="tooltip" title=""></label>
                        <span style="color:#333333; position:relative; top:-5px;">
                            INFORMAÇÕES
                        </span>
                    </h4>
                </center>
<%------------------------------------------------------------------------------------------ INFORMAÇÕES --%>
<%-- EMAIL ------------------------------------------------------------------------------------------------%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4"></div>
                    <div class="col-md-4 form-group">
                        <div>
                            <asp:TextBox type="email" name="email" Style="width: 100%" placeholder="Email" class="form-control input-sm" ID="EmailAddress" runat="server"></asp:TextBox>
                            <%--<asp:RegularExpressionValidator Style="color: #D9534F;" ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="EmailAddress" ErrorMessage="Email inválido"></asp:RegularExpressionValidator>
                            --%>
                        </div>
                    </div>
                    <div class="col-md-4"></div>

                </div>
<%------------------------------------------------------------------------------------------------ EMAIL --%>
<%-- TELEFONE ---------------------------------------------------------------------------------------------%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4"></div>
                    <div class="col-md-4 form-group">
                        <div class="">
                            <asp:TextBox Style="width: 100%" type="text" ID="phone" placeholder="Telefone" class="form-control input-sm phone" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-4"></div>

                </div>
<%--------------------------------------------------------------------------------------------- TELEFONE --%>
<%-- MOEDA / FATURAMENTO ----------------------------------------------------------------------------------%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4"></div>
                    <div class=" col-md-2 form-group ">
                        <asp:DropDownList Style="width:100%;" class=" form-control input-sm " ID="ddlTipoMonetario" runat="server">
                            <asp:ListItem Value="0">Moeda</asp:ListItem>
                            <asp:ListItem Value="Real">Real</asp:ListItem>
                            <asp:ListItem Value="Cruzeiro">Cruzeiro</asp:ListItem>
                            <asp:ListItem Value="Cruzeiro Novo">Cruzeiro Novo</asp:ListItem>
                            <asp:ListItem Value="Cruzado">Cruzado</asp:ListItem>
                            <asp:ListItem Value="Cruzado Novo">Cruzado Novo</asp:ListItem>
                            <asp:ListItem Value="Cruzeiro Real">Cruzeiro Real</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class=" col-md-2 form-group">
                        <div class="form-group input-group-sm " style="width: 100%">
                            <div class="">
                                <asp:TextBox Style="width: 100%" type="text" placeholder="Faturamento" class="form-control input-sm faturamento" ID="faturamento" runat="server"></asp:TextBox>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-4"></div>
                       
                </div>
<%---------------------------------------------------------------------------------- MOEDA / FATURAMENTO --%>
<%-- ATIVIDADES -----------------------------------------------------------------------------------------%>
                <div class="row" style="margin-bottom:5px;">      
                        <div class="col-md-4"></div>
                         <div class=" col-md-4 form-group">
                            <div class="form-group input-group-sm " style="width: 100%">
                                <div class="">
                                    <asp:TextBox Style="width: 100%" type="text" placeholder="Atividade" class="form-control input-sm atividade" ID="txtAtividade"  runat="server"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                        <div class="col-md-4"></div>         

                 </div>

 <%----------------------------------------------------------------------------------------- ATIVIDADES --%>


<%-- FUNCIONÁRIOS -----------------------------------------------------------------------------------------%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4"></div>
                    <div class="col-md-2 form-group">
                        <div class="">
                            <asp:TextBox Style="width: 100%" type="text" placeholder="Número de Funcionários" name="" ID="numfuctxt"  class="form-control input-sm  numeroTxt"  runat="server"></asp:TextBox>
                        </div>
                    </div>
                    





                    <div class="col-md-2 form-group">
                        <div class="input-group " style="width: 100%">
                            <div>
                                <asp:TextBox Style="width: 100%" runat="server" class="form-control input-sm numeroTxt" ID="numempregogeradostxt"  type="text" placeholder="Número de Empregos Gerados"></asp:TextBox>
                        </div>
                            <span class="input-group-btn" style="width: 10px;">
                                <asp:LinkButton ID="btnAtualizarParcial2" runat="server" OnClick="bntCadastrarInfo_Click" type="button" class="btn btn-primary btn-sm pull-right cadastroInfo">
                                    
                                    <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
                                    
                                </asp:LinkButton>
                            </span>
                        </div>
                    </div>




                    <div runat="server" class="col-md-4" id="cadastrado"></div>

                </div>
<%----------------------------------------------------------------------------------------- FUNCIONÁRIOS --%>
<%-- BOTÃO INFORMAÇÕES ------------------------------------------------------------------------------------%>
                <div class="row" ">

                    <div class="col-md-4 icon-addon addon-sm" style=""></div>
                    <div class="col-md-2 form-group">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                               <asp:Label ID="caracteres" runat="server" Visible="true"></asp:Label>

                                <asp:Label ID="lbl2" runat="server" ForeColor="Green" Visible="false">
                                        Cadastrado
                                </asp:Label>
                                <%-- =DateTime.Now.ToString() --%>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnAtualizarParcial2" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <div class="col-md-2 form-group">
                        <div>
                                <%-- %><asp:LinkButton ID="btnAtualizarParcial2" runat="server" OnClick="bntCadastrarInfo_Click" type="button" class="btn btn-primary btn-sm pull-right cadastroInfo">
                                    
                                    <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
                                    
                                </asp:LinkButton>--%>
                        </div>
                    </div>
                    <div class="col-md-4"></div>

                </div>
<%------------------------------------------------------------------------------------ BOTÃO INFORMAÇÕES --%>
        
<%-- ENDEREÇO ---------------------------------------------------------------------------------------------%>
                <center>
                    <h4>
                        <label style="font-size: 1.4em; " class  ="glyphicon glyphicon-map-marker" rel="tooltip" title="email"></label>
                        <span style="color:#333333; position:relative; top:-5px;">
                            ENDEREÇO
                        </span>
                    </h4>
                </center>
<%--------------------------------------------------------------------------------------------- ENDEREÇO --%>
<%-- TIPO / NOME RUA --------------------------------------------------------------------------------------%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4"></div>
                    <div class=" col-md-2 form-group ">
                        <asp:DropDownList Style="width:100%;" class=" form-control input-sm " ID="DropDownList1" runat="server">
                            <asp:ListItem Value="0">Tipo</asp:ListItem>
                            <asp:ListItem Value="Rua">Rua</asp:ListItem>
                            <asp:ListItem Value="Alameda">Alameda</asp:ListItem>
                            <asp:ListItem Value="Avenida">Avenida</asp:ListItem>
                            <asp:ListItem Value="Balneário">Balneário</asp:ListItem>
                            <asp:ListItem Value="Bloco">Bloco</asp:ListItem>
                            <asp:ListItem Value="Chácara">Chácara</asp:ListItem>
                            <asp:ListItem Value="Condomínio">Condomínio</asp:ListItem>
                            <asp:ListItem Value="Estrada">Estrada</asp:ListItem>
                            <asp:ListItem Value="Fazenda">Fazenda</asp:ListItem>
                            <asp:ListItem Value="Galeria">Galeria</asp:ListItem>
                            <asp:ListItem Value="Granja">Granja</asp:ListItem>
                            <asp:ListItem Value="Jardim">Jardim</asp:ListItem>
                            <asp:ListItem Value="Largo">Largo</asp:ListItem>
                            <asp:ListItem Value="Loteamento">Loteamento</asp:ListItem>
                            <asp:ListItem Value="Praça">Praça</asp:ListItem>
                            <asp:ListItem Value="Praia">Praia</asp:ListItem>
                            <asp:ListItem Value="Parque">Parque</asp:ListItem>
                            <asp:ListItem Value="Quadra">Quadra</asp:ListItem>
                            <asp:ListItem Value="Setor">Setor</asp:ListItem>
                            <asp:ListItem Value="Travessa">Travessa</asp:ListItem>
                            <asp:ListItem Value="Vila">Vila</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2 form-group">
                        <div class="">
                            <asp:TextBox Style="width: 100%" type="text"  placeholder="Nome" class="form-control input-sm" ID="nomeTxt" runat="server" Text=""></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-4"></div>

                </div>
<%-------------------------------------------------------------------------------------- TIPO / NOME RUA --%>
<%-- NÚMERO / COMPLEMENTO --------------------------------------------------------------------------------------%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4"></div>
                    <div class="col-md-1 form-group">
                        <div class="">
                            <asp:TextBox Style="width: 100%" type="text" placeholder="Número" class="form-control input-sm numeroTxt" ID="numeroTxt" runat="server" Text=""></asp:TextBox>
                            <%-- <asp:RegularExpressionValidator Style="color: red;" ID="RegularExpressionValidator2" runat="server" ValidationExpression="^\d+$" ControlToValidate="numeroTxt" ErrorMessage="Nº inválido"></asp:RegularExpressionValidator>
                                --%>

                        </div>
                    </div>
                    <div class="col-md-3 form-group">
                        <div class="">
                            <asp:TextBox Style="width: 100%" type="text" placeholder="Complemento" class="form-control input-sm" ID="complementoTxt" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-4"></div>

                </div>
<%-------------------------------------------------------------------------------------- NÚMERO / COMPLEMENTO --%>

<%-- BAIRRO / CEP ----------------------------------------------------------------------------------------------%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4"></div>
                    <div class="col-md-2 form-group">
                        <div class="">
                            <asp:TextBox Style="width: 100%" type="text" placeholder="Bairro" class="form-control input-sm" ID="bairroTxt" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-2 form-group">
                        <div class="">
                            <asp:TextBox Style="width: 100%" type="text" placeholder="CEP" class="form-control input-sm cepTxt" ID="cepTxt" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-4"></div>

                </div>
<%---------------------------------------------------------------------------------------------- BAIRRO / CEP --%>
<%-- ESTADO / CIDADE -------------------------------------------------------------------------------------------%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4"></div>
                    <div class=" col-md-2 form-group ">
                        <asp:DropDownList Style="width:100%;" class=" form-control input-sm " name="estados"  ID="ddlUF" runat="server" onchange="PopulateCidades()" >
                        <asp:ListItem Value="0">Estado</asp:ListItem>
                        <asp:ListItem Value="AC">Acre</asp:ListItem>
                        <asp:ListItem Value="AL" >Alagoas</asp:ListItem>
                        <asp:ListItem Value="AM">Amazonas</asp:ListItem>
                        <asp:ListItem Value="AP">Amapá</asp:ListItem>
                        <asp:ListItem Value="BA" >Bahia</asp:ListItem>
                        <asp:ListItem Value="CE">Ceará</asp:ListItem>
                        <asp:ListItem Value="DF">Distrito Federal</asp:ListItem>
                        <asp:ListItem Value="ES">Espírito Santo</asp:ListItem>
                        <asp:ListItem Value="GO">Goiás</asp:ListItem>
                        <asp:ListItem Value="MA">Maranhão</asp:ListItem>
                        <asp:ListItem Value="MS">Mato Grosso do Sul</asp:ListItem>
                        <asp:ListItem Value="MT">Mato Grosso</asp:ListItem>
                        <asp:ListItem Value="MG">Minas Gerais</asp:ListItem>
                        <asp:ListItem Value="PA">Pará</asp:ListItem>
                        <asp:ListItem Value="PB">Paraíba</asp:ListItem>
                        <asp:ListItem Value="PE">Pernambuco</asp:ListItem>
                        <asp:ListItem Value="PI">Piauí</asp:ListItem>
                        <asp:ListItem Value="PR">Paraná</asp:ListItem>
                        <asp:ListItem Value="RJ">Rio de Janeiro</asp:ListItem>
                        <asp:ListItem Value="RN">Rio Grande do Norte</asp:ListItem>
                        <asp:ListItem Value="RO">Rondônia</asp:ListItem>
                        <asp:ListItem Value="RR">Roraima</asp:ListItem>
                        <asp:ListItem Value="RS">Rio Grande do Sul</asp:ListItem>
                        <asp:ListItem Value="SC">Santa Catarina</asp:ListItem>
                        <asp:ListItem Value="SE">Sergipe</asp:ListItem>
                        <asp:ListItem Value="SP">São Paulo</asp:ListItem>
                        <asp:ListItem Value="TO">Tocantins</asp:ListItem>
                        </asp:DropDownList>

                    </div>


                    

                    <div class="col-md-2 form-group">
                            <div class="input-group " style="width: 100%">
                                <div>
                                    <asp:TextBox Style="width: 100%" type="text" placeholder="Cidade" class="form-control input-sm" ID="SearchCidade" runat="server" name="processo"></asp:TextBox>
                            </div>
                                <span class="input-group-btn" style="width: 10px;">
                                    <asp:LinkButton ID="btnAtualizarParcial3" runat="server" OnClick="bntCadastrarEndereco_Click" type="button" class="btn btn-primary btn-sm pull-right cadastroEndereco">
                                    
                                    <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
                                    
                                </asp:LinkButton>
                                </span>
                            </div>
                        </div>







                    <div class="col-md-4"></div>

                </div>
<%------------------------------------------------------------------------------------------- ESTADO / CIDADE --%>
<%-- BOTÃO ENDEREÇO --------------------------------------------------------------------------------------------%>
                <div class="row" >

                    <div class="col-md-4 icon-addon addon-sm" style=""></div>

                    <div class="col-md-2 form-group">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Label ID="lbl3" runat="server" ForeColor="Green" Visible="false">
                                        Cadastrado
                                </asp:Label>
                                <%-- =DateTime.Now.ToString() --%>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnAtualizarParcial3" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>

                    <div class="col-md-2 form-group">
                        <div>
                                <%-- %><asp:LinkButton ID="btnAtualizarParcial3" runat="server" OnClick="bntCadastrarEndereco_Click" type="button" class="btn btn-primary btn-sm pull-right cadastroEndereco">
                                    
                                    <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
                                    
                                </asp:LinkButton>--%>
                        </div>
                    </div>

                    <div class="col-md-4"></div>

                </div>
<%-------------------------------------------------------------------------------------------- BOTÃO ENDEREÇO --%>

<%-- PROPRIETÁRIOS ---------------------------------------------------------------------------------------------%>
                <center>
                    <h4>
                        <i style="font-size: 1.4em; margin:10px;" class  ="fa fa-users" rel="tooltip" title=""></i>
                        <span style="color:#333333; position:relative; top:-5px;">
                            PROPRIETÁRIOS
                        </span>
                    </h4>
                </center>
<%--------------------------------------------------------------------------------------------- PROPRIETÁRIOS --%>
                    
<%-- EXIBIR PROPRIETÁRIOS --------------------------------------------------------------------------------------%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4"></div>

                    <div class="col-md-4 form-group"  >
                        <div style=" overflow-y: auto; border: 1px solid #cccccc; border-radius: 3px; " id="divProps">
                            <table style="min-width: 100%;" id="proprietarios" >
                                
                            </table>
                        </div>
                    </div>

                    <div class="col-md-4"></div>

                </div>
<%-------------------------------------------------------------------------------------- EXIBIR PROPRIETÁRIOS --%>
<%-- PROPRIETÁRIOS ---------------------------------------------------------------------------------------------%>
                <div class="controls2">
                    <div class="entry2 row" >

                        <div class="col-md-4"></div>
                        <div class="col-md-2 form-group">
                            <div class="">
                                <asp:TextBox Style="width: 100%" type="text" placeholder="Nome" name="nomeProprietario[]" ID="txtNomeProp" class="form-control input-sm propnome" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-2 form-group">
                            <div class="input-group " style="width: 100%">
                                <div>
                                    <asp:TextBox Style="width: 100%" runat="server" class="form-control input-sm CPF propcpf" ID="txtCPFProp" name="cpf[]" type="text" placeholder="CPF"></asp:TextBox>
                                </div>
                                <span class="input-group-btn" style="width: 10px;">
                                    <asp:LinkButton ID="btnAtualizarParcial4" OnClick="bntCadastrarProps_Click" runat="server" type="button" class="btn btn-primary pull-right btn-sm cadastroProp">
                                        <i class="fa fa-users" aria-hidden="true"></i>
                                    </asp:LinkButton>
                                </span>
                            </div>
                        </div>
                        <div class="col-md-4"></div>

                    </div>
                </div>
<%----------------------------------------------------------------------------------------- PROPRIETÁRIOS --%>
<%-- BOTÃO PROPRIETÁRIOS -----------------------------------------------------------------------------------%>
                <div  class="row">

                    <div class="col-md-4"></div>

                    <%--<div class="col-md-2 form-group">
                        <asp:LinkButton  style="display:none;" runat="server" OnClick="bntCadastrar_Click" type="button" class="btn btn-primary btn-sm pull-left">
                            &nbsp;&nbsp;&nbsp;
                            Cadastrar Tudo
                            &nbsp;&nbsp;&nbsp;
                        </asp:LinkButton>
                    </div>---%>
                    <div class="col-md-2 form-group">
                                
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                            
                                        <asp:Label runat="server" ID="lbl4"  ForeColor="Green" Visible="false">
                                            Cadastrado
                                        </asp:Label>
                                        <%-- =DateTime.Now.ToString() --%>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnAtualizarParcial4" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                    </div>
                    <div class="col-md-2 form-group">
                        <div class="pull-right">
                                
                            <%-- %><asp:LinkButton ID="btnAtualizarParcial4" OnClick="bntCadastrarProps_Click" runat="server"  type="button" class="btn btn-primary pull-right btn-sm cadastroProp">
                                    
                                <i class="fa fa-users" aria-hidden="true"></i>
                                    
                            </asp:LinkButton>--%>

                        </div>
                    </div>
                    <div class="col-md-4"></div>

                </div>
<%----------------------------------------------------------------------------------- BOTÃO PROPRIETÁRIOS --%>

            </div>

            <br />
            <br />
            <br />

        </form>

    </div>

    <script>


        /**
        *
        * CONTROLE DE USUÁRIO
        *
        */
        var activePage = true;
        // session["tempo"] = 0;
        //var tempo =  session.getAttribute("datahora");

        // var tempo = localStorage.getItem('Tempo');
        if (localStorage.getItem('Tempo') == null) {
            var tempo = '<% = Session["Tempo"]%>'

        }
        else {
            var tempo = localStorage.getItem('Tempo');

        }
        //contador de tempo
        function showInformation() {

            tempo = parseInt(tempo.toString());


            if (activePage) {

                tempo = tempo + 1;
                localStorage.setItem('Tempo', tempo);

            } else {

                localStorage.setItem('teste', 't');
            }

            setTimeout("showInformation();", 1000);
        }
        //verifica se pagina esta em focu
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
                        //alert('Deslogar');
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
        /**
        *
        * CONTROLE DE USUÁRIO  -------------  FIM
        *
        */


        function limpar() {
            //RESETA CAMPOS DADOS EMPRESA
            $('#<%=EmailAddress.ClientID %>').prop('disabled', false)
            $('#<%=phone.ClientID %>').prop('disabled', false)
            $('#<%=faturamento.ClientID %>').prop('disabled', false)
            $('#<%=txtAtividade.ClientID %>').prop('disabled', false)
            $('#<%=numfuctxt.ClientID %>').prop('disabled', false)
            $('#<%=numempregogeradostxt.ClientID %>').prop('disabled', false)
            $('#<%=ddlTipoMonetario.ClientID %>').prop('disabled', false)
            //
            $('#<%=txtAtividade.ClientID %>').val('')
            $('#<%=EmailAddress.ClientID %>').val('')
            $('#<%=phone.ClientID %>').val('')
            $('#<%=faturamento.ClientID %>').val('')
            $('#<%=numfuctxt.ClientID %>').val('')
            $('#<%=numempregogeradostxt.ClientID %>').val('')
            $('#<%=ddlTipoMonetario.ClientID %>').val('0')
            //RESETA CAMPOS DADOS ENDEREÇO EMPRESA
            $('#<%=DropDownList1.ClientID %>').prop('disabled', false)
            $('#<%=nomeTxt.ClientID %>').prop('disabled', false)
            $('#<%=numeroTxt.ClientID %>').prop('disabled', false)
            $('#<%=complementoTxt.ClientID %>').prop('disabled', false)
            $('#<%=bairroTxt.ClientID %>').prop('disabled', false)
            $('#<%=cepTxt.ClientID %>').prop('disabled', false)
            $('#<%=ddlUF.ClientID %>').prop('disabled', false)
            $('#<%=SearchCidade.ClientID %>').prop('disabled', false)
            //
            $('#<%=DropDownList1.ClientID %>').val('0')
            $('#<%=nomeTxt.ClientID %>').val('')
            $('#<%=numeroTxt.ClientID %>').val('')
            $('#<%=complementoTxt.ClientID %>').val('')
            $('#<%=bairroTxt.ClientID %>').val('')
            $('#<%=cepTxt.ClientID %>').val('')
            $('#<%=ddlUF.ClientID %>').val('0')
            $('#<%=SearchCidade.ClientID %>').val('')
        }

        /**
         * Popular ddl Cidade de acordo com Estado
         *
         *
         */
        function PopulateCidades() {

            if ($('#<%=ddlUF.ClientID%>').val() == "0") {
                document.getElementById('<%=SearchCidade.ClientID %>').disabled = true;
            } else {
                document.getElementById('<%=SearchCidade.ClientID %>').disabled = false;
            }

            $("#<%=SearchCidade.ClientID %>").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: '<%=ResolveUrl("~/Service.asmx/GetCidades") %>',
                        data: "{ 'prefix': '" + request.term + "', 'UF': '" + $('#<%=ddlUF.ClientID%>').val() + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            var parsed = $.parseJSON(data.d);
                            var cidades = [];
                            $.each(parsed, function (i, jsondata) {
                                cidades.push(
                                    jsondata.nome
                                )
                            })

                            response($.map(cidades, function (item) {
                                return {
                                    label: item.toString()
                                }
                            }))

                        },
                        error: function (response) {
                            alert(response.responseText);
                        },
                        failure: function (response) {
                            alert(response.responseText);
                        }
                    });

                },
                select: function (e, i) {


                },
                minLength: 1
            });
        }
        
        /**
         * Exibir volumes cadastrados para o processo
         *
         * @param COD_CLI do processo para exibir seus volumes
         */
        function getVolumes(COD_CLI) {

            $.ajax({

                url: '<%=ResolveUrl("~/Service.asmx/GetVolumes") %>',
                data: "{ 'codProcessoCLI': '" + COD_CLI + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var parsed = $.parseJSON(data.d);
                    var spanVolume = "";
                    document.getElementById('rowVolumes').style.display = 'none';
                    $.each(parsed, function (i, jsondata) {
                        document.getElementById('rowVolumes').style.display = 'block';
                        spanVolume += '<span style="padding-right:2px; padding-left:2px; margin-right: 5px; border: 1px solid #cccccc; border-radius: 2px;">' + jsondata.COD_VOLUME_CODEMIG + ' &nbsp;<span style="cursor: pointer; padding-bottom:1px;" class="glyphicon glyphicon-remove"  onclick="removeVolume(' + jsondata.COD_VOLUME_PK + ',\'' + jsondata.COD_VOLUME_CODEMIG + '\')"></span></span>';
                    });
                    document.getElementById('volumes').innerHTML = spanVolume;
                },
                error: function (XHR, errStatus, errorThrown) {
                    var err = JSON.parse(XHR.responseText);
                    errorMessage = err.Message;
                    alert(errorMessage);
                }

            });
        };

        /**
         * Remover volumes de determinado processo
         *
         * @param volumePK PK do próprio volume para exclusão
         * @param volumeCODEMIG para confirmar exclusão
         */
        function removeVolume(volumePK, volumeCODEMIG) {

            if (confirm("Deseja excluir Volume-" + volumeCODEMIG + "?")) {

                $.ajax({
                    type: "POST",
                    url: '<%=ResolveUrl("~/Service.asmx/removeVolume") %>',
                    data: "{ 'volumePK':'" + volumePK + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (parseInt(data.d) == 1) {
                            getVolumes($('#<%=txtProcesso.ClientID%>').val())
                        };
                    },
                    error: function (XHR, errStatus, errorThrown) {
                        var err = JSON.parse(XHR.responseText);
                        errorMessage = err.Message;
                        alert(errorMessage);
                    }
                });

            }
        }

        /**
         * Criar tabela para exibição dos proprietários cadastrados para
         * a empresa no determinado processo
         *
         * @param CNPJ da empresa para exibir seus proprietários
         */
        function getProps(CNPJ) {
            $.ajax({
                type: "POST",
                url: '<%=ResolveUrl("~/Service.asmx/GetProps") %>',
                data: "{ 'prefix': '" + CNPJ + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var parsed = $.parseJSON(data.d);
                    var tableProp = "";
                    document.getElementById('divProps').style.display = 'none';
                    $.each(parsed, function (i, jsondata) {
                        document.getElementById('divProps').style.display = 'block';
                        
                        tableProp += '<tr><td style="white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;">' + jsondata.NOME + '</td ><td style="white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; ">' + jsondata.CPF + '</td ><td style="white-space: nowrap;"><center><span style="cursor: pointer;" onClick="removeProp(' + jsondata.COD_PROPRIETARIO_PK + ',' + jsondata.COD_EMPRESA_PK + ',\'' + jsondata.CPF + '\')" class="glyphicon glyphicon-remove "></span></center></td></tr>';
                    });
                    document.getElementById('proprietarios').innerHTML = tableProp;
                },
                error: function (XHR, errStatus, errorThrown) {
                    var err = JSON.parse(XHR.responseText);
                    errorMessage = err.Message;
                    alert(errorMessage);
                }
            });
        };

        /**
         * Remover proprietário de determinada empresa
         *
         * @param propPK PK do proprietário
         * @param empresaPK PK da empresa
         * @param cpf CPF do proprietário para confirmar exclusão
         */
        function removeProp(propPK, empresaPK, cpf) {
            if (confirm("Deseja excluir proprietário de CPF " + cpf + "?")) {
                $.ajax({
                    type: "POST",
                    url: '<%=ResolveUrl("~/Service.asmx/removeProp") %>',
                    data: "{ 'propPK': '" + propPK + "', 'empresaPK': '" + empresaPK + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (parseInt(data.d) == 1) {
                            getProps(document.getElementById('CNPJ').innerHTML)
                        };
                    },
                    error: function (XHR, errStatus, errorThrown) {
                        var err = JSON.parse(XHR.responseText);
                        errorMessage = err.Message;
                        alert(errorMessage);
                    }
                });
            }

        }

        /**
         * Document ready
         */
        $(document).ready(function () {

            $(".date").mask("00/00/0000", { clearIfNotMatch: true });
            $(".phone").mask("(00) 0000-0000", { clearIfNotMatch: true });
            $(".cepTxt").mask("00000-000", { clearIfNotMatch: true });
            $(".CPF").mask("000.000.000-00", { clearIfNotMatch: true });
            $(".numeroTxt").mask("000000");
            $(".faturamento").maskMoney({ prefix: 'R$ ', allowNegative: false, thousands: '.', decimal: ',', affixesStay: false });

            /** AUTOCOMPLETE PROCESSO **************************************************************************************/
            $("#<%=txtProcesso.ClientID %>").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: '<%=ResolveUrl("~/Service.asmx/GetProcessosAD") %>',
                        data: "{ 'texto': '" + request.term + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",

                        success: function (data) {
                            var parsed = $.parseJSON(data.d);
                            var processos = [];
                            $.each(parsed, function (i, jsondata) {

                                processos.push([
                                    jsondata.COD_CLI,
                                    jsondata.COD_PROCESSO_PK,
                                    jsondata.COD_EMPRESA_PK
                                ])
                            })

                            response($.map(processos, function (item) {
                                return {
                                    label: item[0].toString(),
                                    processoPK: item[1].toString(),
                                    empresaPK: item[2].toString()
                                }
                            }))

                        },
                        error: function (response) {
                            alert(response.responseText);
                        },
                        failure: function (response) {
                            alert(response.responseText);
                        }
                    });
                },

                select: function (e, i) {

                    limpar();

                    document.getElementById('rowVolumes').style.display = 'none';
                    document.getElementById('volumes').innerHTML = "";

                    PROCESSOPK = i.item.processoPK
                    EMPRESAPK = i.item.empresaPK


                    document.getElementById('<%=hfCodProcessoPK.ClientID %>').value = PROCESSOPK
                    document.getElementById('<%=hfCodEmpresaPK.ClientID %>').value = EMPRESAPK

                    $.ajax({
                        url: '<%=ResolveUrl("~/Service.asmx/GetDadosEmpresa") %>',
                        data: "{ 'empresaPK': '" + EMPRESAPK + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            var parsed = $.parseJSON(data.d);
                            $.each(parsed, function (i, jsondata) {
                                //DADOS EMPRESA
                                RAZAO_SOCIAL = jsondata.RAZAO_SOCIAL.trim()//trim
                                CNPJ = jsondata.CNPJ//trim

                                EMAIL = null
                                TELEFONE = null
                                TIPO_MONETARIO = '0'
                                ATIVIDADE = null
                                if (jsondata.EMAIL != null) EMAIL = jsondata.EMAIL.trim()//trim
                                if (jsondata.TELEFONE != null) TELEFONE = jsondata.TELEFONE.trim()//trim
                                if (jsondata.TIPO_MONETARIO != null) TIPO_MONETARIO = jsondata.TIPO_MONETARIO.trim()//trim
                                FATURAMENTO_ANUAL = jsondata.FATURAMENTO_ANUAL
                                if (jsondata.ATIVIDADE != null) ATIVIDADE = jsondata.ATIVIDADE.trim()//trim
                                NUM_FUNC = jsondata.NUM_FUNC
                                NUM_EMPREG_GERADOS = jsondata.NUM_EMPREG_GERADOS
                                
                                document.getElementById('empresa').innerHTML = RAZAO_SOCIAL;
                                document.getElementById('CNPJ').innerHTML = CNPJ;
                                
                                getProps(CNPJ);
                                document.getElementById('hidr').style.display = 'block';
                                
                                if ($('#<%=hfPermissao.ClientID%>').val() == 1) {
                                    PERMISSAO = false
                                } else {
                                    PERMISSAO = true
                                }
                                if (EMAIL != null)
                                    if (EMAIL != '') {
                                        $('#<%=EmailAddress.ClientID %>').val(EMAIL)
                                        if (!PERMISSAO) $('#<%=EmailAddress.ClientID %>').prop('disabled', true)
                                    }
                                if (TELEFONE != null)
                                    if (TELEFONE != '') {
                                        $('#<%=phone.ClientID %>').val(TELEFONE)
                                        if (!PERMISSAO) $('#<%=phone.ClientID %>').prop('disabled', true)
                                    }

                                if (TIPO_MONETARIO != null)
                                    if (TIPO_MONETARIO != '0') {
                                        $("#<%=ddlTipoMonetario.ClientID %>").val(TIPO_MONETARIO)
                                        if (!PERMISSAO) $('#<%=ddlTipoMonetario.ClientID %>').prop('disabled', true)
                                    }

                                if (FATURAMENTO_ANUAL != null) {
                                    $('#<%=faturamento.ClientID %>').val(FATURAMENTO_ANUAL)
                                    if (!PERMISSAO) $('#<%=faturamento.ClientID %>').prop('disabled', true)
                                }
                                    
                                if (ATIVIDADE != null) 
                                    if (ATIVIDADE != '') {
                                        $('#<%=txtAtividade.ClientID %>').val(ATIVIDADE)
                                        if (!PERMISSAO) $('#<%=txtAtividade.ClientID %>').prop('disabled', true)
                                    }
                                        
                                if (NUM_FUNC != null) {
                                    $('#<%=numfuctxt.ClientID %>').val(NUM_FUNC)
                                    if (!PERMISSAO) $('#<%=numfuctxt.ClientID %>').prop('disabled', true)
                                }
                                    
                                if (NUM_EMPREG_GERADOS != null) {
                                    $('#<%=numempregogeradostxt.ClientID %>').val(NUM_EMPREG_GERADOS) 
                                    if (!PERMISSAO) $('#<%=numempregogeradostxt.ClientID %>').prop('disabled', true)
                                }
                                //ENDEREÇO
                                TIPO = '0'
                                NOME = null
                                COMPLEMENTO = null
                                BAIRRO = null
                                CEP = null
                                UF = '0'
                                MUN = null
                                if (jsondata.TIPO != null) TIPO = jsondata.TIPO.trim()//trim
                                if (jsondata.NOME != null) NOME = jsondata.NOME.trim()//trim
                                NUMERO = jsondata.NUMERO
                                if (jsondata.COMPLEMENTO != null) COMPLEMENTO = jsondata.COMPLEMENTO.trim()//trim
                                if (jsondata.BAIRRO != null) BAIRRO = jsondata.BAIRRO.trim()//trim
                                if (jsondata.CEP != null) CEP = jsondata.CEP.trim()//trim
                                if (jsondata.UF != null) UF = jsondata.UF.trim()//trim
                                if (jsondata.MUN != null) MUN = jsondata.MUN.trim()//trim
                                
                                if (TIPO != null)
                                    if (TIPO != '0') {
                                        $("#<%= DropDownList1.ClientID %>").val(TIPO)
                                        if (!PERMISSAO) $('#<%=DropDownList1.ClientID %>').prop('disabled', true)
                                    }

                                if (NOME != null)
                                    if (NOME != '') {
                                        $('#<%=nomeTxt.ClientID %>').val(NOME)
                                        if (!PERMISSAO) $('#<%=nomeTxt.ClientID %>').prop('disabled', true)
                                    }

                                if (NUMERO != null) {
                                    $('#<%=numeroTxt.ClientID %>').val(NUMERO)
                                    if (!PERMISSAO) $('#<%=numeroTxt.ClientID %>').prop('disabled', true)
                                }

                                if (COMPLEMENTO != null)
                                    if (COMPLEMENTO != '') {
                                        $('#<%=complementoTxt.ClientID %>').val(COMPLEMENTO)
                                        if (!PERMISSAO) $('#<%=complementoTxt.ClientID %>').prop('disabled', true)
                                    }

                                if (BAIRRO != null)
                                    if (BAIRRO != '') {
                                        $('#<%=bairroTxt.ClientID %>').val(BAIRRO)
                                        if (!PERMISSAO) $('#<%=bairroTxt.ClientID %>').prop('disabled', true)
                                    }

                                if (CEP != null)
                                    if (CEP != '') {
                                        $('#<%=cepTxt.ClientID %>').val(CEP)
                                        if (!PERMISSAO) $('#<%=hfPermissao.ClientID %>').prop('disabled', true)
                                    }
                                
                                if (UF != null)
                                    if (UF != '0') {
                                        $("#<%= ddlUF.ClientID %>").val(UF)
                                        if (!PERMISSAO) $('#<%=ddlUF.ClientID %>').prop('disabled', true)
                                    }
                                
                                if (MUN != null)
                                    if (MUN != '0') {
                                        $("#<%= SearchCidade.ClientID %>").val(MUN)
                                        if (!PERMISSAO) $('#<%=SearchCidade.ClientID %>').prop('disabled', true)
                                    }

                            });
                            
                        },
                        error: function (XHR, errStatus, errorThrown) {
                            var err = JSON.parse(XHR.responseText);
                            errorMessage = err.Message;
                            alert(errorMessage);
                        }
                    });

                    $("#<%=ddlDistritos.ClientID %>").change(function () {
                   
                        document.getElementById('teste').style.display = 'none';
                        document.getElementById('teste2').style.display = 'none';
                        document.getElementById('hidr').style.display = 'none';
                        document.getElementById('CNPJ').innerHTML = '';
                        document.getElementById('empresa').innerHTML = '';
                        document.getElementById('rowVolumes').style.display = 'none';
                        document.getElementById('<%=txtProcesso.ClientID %>').value = '';

                    });

                    getVolumes(i.item.label);

                    document.getElementById('displaybutton').style.display = 'block';
                    document.getElementById('teste').style.display = 'block';
                    document.getElementById('teste2').style.display = 'block';
                    document.getElementById('folder').className = 'glyphicon glyphicon-folder-open';

                },
                minLength: 1

                });

        });

        $(function () {

            /**
            *Exibe/Esconde formulário, muda o ícone triangular
            */
            $("#hidr").click(function () {
                if (document.getElementById('hidr').className == 'glyphicon glyphicon-triangle-bottom') {
                    $(".row2").show(1000)
                    document.getElementById('hidr').className = 'glyphicon glyphicon-triangle-top';
                } else {
                    $(".row2").hide(1000)
                    document.getElementById('hidr').className = 'glyphicon glyphicon-triangle-bottom';

                };
            });

            /**
            * Executa ao ser digitado no campo atividade para contagem de caracteres
            * máximo: 255
            * Seta todos os caaracteres para maiúsculo
            */
            $('#<%=txtAtividade.ClientID%>').keyup(function () {
                $(this).val(function (_, val) {
                    return val.toUpperCase();
                });
                var tamanho = parseInt($('#<%=txtAtividade.ClientID%>').val().length);
                tamanho = 255 - tamanho;
                if (tamanho >= 0)
                    $('#<%=txtAtividade.ClientID%>').css('border', '');
                else
                    $('#<%=txtAtividade.ClientID%>').css('border', '1px solid red');
            });

            /**
            * Executa ao clicar em cadastro de informação
            */
            $(document).on('click', '.cadastroInfo', function (e) {

                setTimeout(function () {

                    $('#<%=lbl2.ClientID %>').fadeOut();

                }, 2000);
            });

            /**
            * Executa ao clicar em cadastro de endereço
            */
            $(document).on('click', '.cadastroEndereco', function (e) {

                setTimeout(function () {

                    $('#<%=lbl3.ClientID %>').fadeOut();

                }, 2000);
            });

            /**
            * Executa ao clicar em cadastro de volume
            */
            $(document).on('click', '.cadastroVolume', function (e) {

                setTimeout(function () {
                    $('#<%=volume1.ClientID %>').val('');
                    $('#<%=lbl1.ClientID %>').fadeOut();

                    getVolumes($('#<%=txtProcesso.ClientID%>').val())

                }, 1000);

            });

            /**
            * Executa ao clicar em cadastro de proprietário
            */
            $(document).on('click', '.cadastroProp', function (e) {

                setTimeout(function () {
                    $('#<%=lbl4.ClientID %>').fadeOut();
                    document.getElementById('<%=txtCPFProp.ClientID %>').value = ''
                    document.getElementById('<%=txtNomeProp.ClientID %>').value = ''

                    getProps(document.getElementById('CNPJ').innerHTML)

                }, 1000);

            });

        });

    </script>
        
    </asp:Content>
