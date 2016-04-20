 <%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/site.master" CodeBehind="empresas.aspx.cs" Inherits="CODEMIG.empresas" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
   
<style>
    .btn-circle.btn-xl {
  width: 35px;
  height: 30px;
  
  font-size: 15px;
  
  
  
  
}

  
  
  


 .naoSelecionado{
    background-color:rgb(217, 83, 79);
    border-radius: 2px;
    color: white;
    font-size: 0.7em;
}
.naoCadastrado{
    background-color:rgb(217, 83, 79);
    border-radius: 2px;
    color: white;
    font-size: 0.7em;
}

.cadastrado{
    background-color:rgb(92, 184, 92);
    border-radius: 2px;
    color: white;
    font-size: 0.7em;
}
</style>
    <script src="scripts/scrip_search.js"></script> 
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="body">

    <div class="content">

        <form replete="off" runat="server" >

            <asp:HiddenField ID="hfLoginPK" runat="server" Value="" />
            <asp:HiddenField ID="hfPermissao" runat="server" Value="" />
            <asp:HiddenField ID="hfProcessoPK" runat="server" Value="" />
            <asp:HiddenField ID="hfCodCli" runat="server" Value="" />
            <asp:HiddenField ID="hfEmpresaProcesso" runat="server" Value="" />
             <asp:HiddenField ID="hfEmpresa" runat="server" Value="" />
             <asp:HiddenField ID="hfLotes" runat="server" Value="" />
            <asp:HiddenField ID="hfNumLotes" runat="server" Value="" />
            <asp:HiddenField ID="hfValida" runat="server" Value="0" />
            <asp:ScriptManager ID="ScriptManager2" runat="server"/>

           
            <asp:HiddenField ID="hfDistritoPK" runat="server" Value="" />

            
            <div class="escondeTudo" style="display:block">
<%-- ------------------------------------------------------------------------------------------------empresa --%>
                <%-- INFORMAÇÕES --%>
                <div class="row" style="margin-bottom: 5px;">

                  

                    <div class="col-md-4 col-sm-3"></div>
                    <div class=" col-md-4 form-group">
                        <label style="font-size: 1.4em; vertical-align:bottom; " class = "glyphicon glyphicon-search" rel="tooltip" title=""></label>
                        <span style="font-size:1.4em; vertical-align:bottom; color:#333333; position:relative; ">
                            BUSCAR / CADASTRAR
                        </span>
                    <%--</div>--%>
                    <%--<div class=" col-md-2 col-sm-6 form-group">--%>
                        
                    </div>
                    <div class="col-md-4 col-sm-3"></div>

                </div>

                <%-- RAZÃO / CNPJ --%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4 col-sm-3"></div>
                    <div class="col-md-4 col-sm-6" >
                        <div class="form-group" style=" border: 1px solid #cccccc; border-radius: 3px; padding: 10px; width:100%;">
                        
                            <asp:TextBox Style="width: 100%" ID="txtRazaoSocial" runat="server" class="form-control input-sm" type="text" placeholder="Razão Social"></asp:TextBox>
                            <br />
                            <asp:TextBox Style="width: 100%" ID="txtCNPJ" runat="server" class="form-control input-sm CNPJ" type="text" placeholder="CNPJ"></asp:TextBox>

                        </div>
                    </div>
                    <div class="col-md-4 col-sm-3"></div>

                </div>
                
                  <div class="row" style="margin-bottom: 5px;">
                
                    <div class="col-md-4"></div>
                    <div class=" col-md-4 ">
                        <label style="font-size: 1.4em; vertical-align:bottom;" class="glyphicon glyphicon-info-sign" rel="tooltip" title="email"></label>
                         <span style="font-size:1.4em; vertical-align:bottom; color:#333333; position:relative; ">
                            INFORMAÇÔES
                        </span>
                    </div>
                   
                    <div class="col-md-4 "></div>

                </div>

                <%-- EMAIL --%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4 col-sm-3"></div>
                    <div class="col-md-4 col-sm-6 form-group">
                        <asp:TextBox type="email" Style="width: 100%" placeholder="Email" class="form-control input-sm" ID="txtEmail" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-4 col-sm-3"></div>

                </div>

                <%-- TELEFONE --%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4 col-sm-3"></div>
                    <div class="col-md-4 col-sm-6 form-group">
                            <asp:TextBox Style="width: 100%" type="text" ID="txtTelefone" placeholder="Telefone" class="form-control input-sm phone" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-4 col-sm-3"></div>

                </div>
                <%-- MOEDA / FATURAMENTO --%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4 col-sm-3"></div>
                    <div class=" col-md-2 col-sm-3 form-group">
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
                    <div class=" col-md-2 col-sm-3 form-group">
                        <asp:TextBox Style="width: 100%" type="text" placeholder="Faturamento" class="form-control input-sm faturamento" ID="txtFaturamento" runat="server" ></asp:TextBox>
                    </div>
                    <div class="col-md-4 col-sm-3"></div>
                       
                </div>

                <%-- ATIVIDADES--%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4 col-sm-3"></div>
                    <div class="col-md-4 col-sm-6 form-group">
                            <asp:TextBox Style="width: 100%" type="text" ID="txtAtividades" placeholder="Atividades" class="form-control input-sm" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-4 col-sm-3"></div>

                </div>

                <%-- FUNCIONÁRIOS --%>

                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4 col-sm-3"></div>
                    <div class=" col-md-2 col-sm-3 form-group">
                        <asp:TextBox Style="width: 100%" type="text" placeholder="Número de Funcionários" ID="txtNumFunc"  class="form-control input-sm numerotxt"  runat="server"></asp:TextBox>
                    </div>
                    <div class=" col-md-2 col-sm-3 form-group">
                        <asp:TextBox Style="width: 100%" type="text" placeholder="Empregos Gerados" class="form-control input-sm numerotxt" ID="txtNumEmpregosGerados" runat="server" ></asp:TextBox>
                    </div>
                    <div class="col-md-4 col-sm-3"></div>
                       
                </div>
                
<%-- ------------------------------------------------------------------------------------------fim empresa --%>
 <%--__________________________________ ENDEREÇO ----------------------------------------------------------------------------------------------------%>
                <div class="row" style="margin-bottom: 5px;">

                    <div class="col-md-4 col-sm-3"></div>
                    <div class=" col-md-2 col-sm-6 form-group">
                        <label style="font-size: 1.4em;" class="glyphicon glyphicon-map-marker" rel="tooltip" title="Endereço"></label>
                        <span style="font-size:1.4em; vertical-align:bottom; color:#333333; position:relative; ">
                            LOCALIZAÇÃO
                        </span>
                    </div>
                   
                    <div class="col-md-4 col-sm-3"></div>

                </div>
                <%-- TIPO / NOME RUA --%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4 col-sm-3"></div>
                    <div class=" col-md-2 col-sm-3 form-group ">
                        <asp:DropDownList Style="width:100%;" class=" form-control input-sm " ID="ddlTipoRua" runat="server">
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
                    <div class="col-md-2 col-sm-3 form-group">
                        <asp:TextBox Style="width: 100%" type="text"  placeholder="Nome" class="form-control input-sm " ID="txtNomeRua" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-4 col-sm-3"></div>

                </div>

                <%-- NÚMERO / COMPLEMENTO --%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4 col-sm-3"></div>
                    <div class="col-md-1 col-sm-2 form-group">
                        <asp:TextBox Style="width: 100%" type="text" placeholder="Número" class="form-control input-sm numerotxt" ID="txtNumero" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-3 col-sm-4 form-group">
                        <asp:TextBox Style="width: 100%" type="text" placeholder="Complemento" class="form-control input-sm" ID="txtComplemento" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-4 col-sm-3"></div>

                </div>

                <%-- BAIRRO / CEP --%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4 col-sm-3"></div>
                    <div class="col-md-2 col-sm-3 form-group">
                        <asp:TextBox Style="width: 100%" type="text" placeholder="Bairro" class="form-control input-sm" ID="txtBairro" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-2 col-sm-3 form-group">
                        <asp:TextBox Style="width: 100%" type="text" placeholder="CEP" class="form-control input-sm cepTxt" ID="txtCEP" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-4 col-sm-3"></div>

                </div>
                <%-- ESTADO / CIDADE --%>
                <div class="row" style="margin-bottom: 5px;">

                    <div class="col-md-4 col-sm-3"></div>
                    <div class=" col-md-2 col-sm-3 form-group">
                        <asp:DropDownList Style="width: 100%;" class=" form-control input-sm " ID="ddlUF" runat="server" onchange="PopulateCidades()">
                            <asp:ListItem Value="0">Estado</asp:ListItem>
                            <asp:ListItem Value="AC">Acre</asp:ListItem>
                            <asp:ListItem Value="AL">Alagoas</asp:ListItem>
                            <asp:ListItem Value="AM">Amazonas</asp:ListItem>
                            <asp:ListItem Value="AP">Amapá</asp:ListItem>
                            <asp:ListItem Value="BA">Bahia</asp:ListItem>
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

                    <div class="col-md-2 col-sm-3 form-group">
                        <div class="input-group " style="width: 100%">
                            <asp:TextBox Style="width: 100%" placeholder="Cidade" class="form-control input-sm"   ID="txtCidade" runat="server" ></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-md-4 col-sm-3"></div>

                </div>





                <div class="row">
                    <div class="col-md-4 col-sm-3 "></div>
                    <div class="col-md-1 col-sm-3 form-group ">

                         
                        
                           <%-- <button title="Excluir empresa" style="float:left;display:none;" type="button" class="btn btn-danger btn-circle btn-xl"><i style="vertical-align:top;" class="glyphicon glyphicon-trash delete"></i></button>--%>
                            <button style="width:30%; display:none;" id="deletarempresa"   class="btn btn-danger btn-sm pull-left btn-xl" title="Excluir Empresa" type="button" >
                                    <span class="glyphicon glyphicon-trash delete" aria-hidden="true"></span>
                            </button>
                        
                     

                    </div>
                   <div class="col-md-2 col-sm-3 form-group ">  </div>
                    <div class="col-md-1 col-sm-3 form-group"   >
                          <asp:LinkButton Style="width: 100%;" ID="LinkButtonCadastrar" OnClick="bntCadastrar_Click" runat="server"  type="button" class="btn btn-primary btn-sm pull-right cadastrar">
                           <center> Cadastrar </center>
                        </asp:LinkButton>
                        <asp:LinkButton Style="width: 100%; display:none; " ID="btnEndereco" OnClick="bntUpdateEmpresa_Click" runat="server"  type="button" class="btn btn-primary btn-sm pull-right atualizar">
                           <span class="glyphicon glyphicon-refresh delete " aria-hidden="true"> </span> Empresa
                        </asp:LinkButton>
                         
                       
                    </div>
                    <div class="col-md-4 col-sm-3 "></div>
                </div>


                

<%--------------------------------------------------------------------------------------------------------------------fim endereço --%>




<%--************************************************************CADASTRAR PROCESSO***********--%>


                


                

            
            <div class="escondeProcesso" style="display:none;">

                <div class="row" style="margin-bottom: 5px;">

                  

                    <div class="col-md-4 col-sm-3"></div>
                    <div class=" col-md-2 col-sm-6 ">
                        <label style="font-size: 1.4em; " class = "glyphicon glyphicon-folder-open" rel="tooltip"  title="Processo"></label>
                        <span style="color:#333333; position:relative;  left:3px; top:-5px;">
                            PROCESSO
                        </span>
                    </div>
                    <div class="col-md-4 col-sm-3"></div>

                </div>
                 <div class="row">
                    <div class="col-md-4"></div>
                    
                        <div class="col-md-4">
                                                      
                            <asp:UpdatePanel ID="UpdatePanel1" RenderMode="Inline"  runat="server" UpdateMode="Conditional" >

                                <ContentTemplate>

                                    
                                    <asp:Label class="naoCadastrado" ID="lblCadastradoPasta"  runat="server" Visible="false">
                                        
                                    </asp:Label>
                                    

                                </ContentTemplate>
                                <Triggers>

                                    <asp:AsyncPostBackTrigger ControlID="btnAtualizarParcial" EventName="Click" />
                                   

                                </Triggers>

                            </asp:UpdatePanel>
                   

                          </div>
                        
                    <div class="col-md-4"></div>
                    </div>


                <%-- PROCESSO --%>
                <div  class="row" style="margin-bottom: 1px;">
                    <div class="col-md-4"></div>
                    <div class="col-md-3">
                        <%--<div class="input-group input-group-sm addon-sm " style="width: 100%">--%>

                            <div>
                                <asp:TextBox Style="width: 100%" runat="server" class="form-control input-sm txtProcesso" ID="txtProcesso"   type="text" placeholder="Processo"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-1">


                            <asp:LinkButton style=" width:100%"  ID="btnAtualizarParcial" OnClick="bntCadastrarProcesso_Click" runat="server" type="button" class="btn btn-primary btn-sm pull-right btnProcesso">
                                    
                                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                                    
                                </asp:LinkButton>

                            <button style="width:45%; display:none;" id="DeletaProcesso"  class="btn btn-danger btn-sm pull-right removeProcesso" title="Exluir processo" type="button" >
                                    <span class="glyphicon glyphicon-trash delete" aria-hidden="true"></span>
                            </button>
                                 <%--<button title="Excluir Processo" style="display:none; width:45%" type="button" class="btn btn-danger btn-circle removeProcesso"><i style="vertical-align:top;" class="glyphicon glyphicon-trash delete"></i></button>--%>

                             &nbsp;
                                <button style="width:45%; display:none;" id="limpaProcesso"   class="btn btn-default btn-sm pull-left limpaProcesso" title="Limpa processo" type="button" >
                                    <i class="fa fa-eraser"></i>
                             </button>
                            
                             
                                
                             
                          
                           
                        </div>
                    
                    <div class="col-md-4"></div>
                </div>
                <div class="row" style="margin-bottom:5px;">
                     <div class="col-md-4"></div>
                    <div class="col-md-4">
                         <asp:label runat="server" id="lblAlertProcesso" class="naoSelecionado" style="color: white; display: none;">Selecione uma empresa!</asp:label>
                     </div>
                      
                     <div class="col-md-4"></div>
                </div>

                <%-- GRID PASTAS ------------------------------------------------------------------------------------------%>
                <div id="divprocessos" class="row" style="display:none">

                    <div class="col-md-4"></div>

                    <div class="col-md-4 form-group" style="">
                        <div style="max-height: 100px; height: 42px; overflow-y: auto; border: 1px solid #cccccc; border-radius: 3px; padding: 10px;" id="divPastas">
                        </div>
                    </div>

                    <div class="col-md-4"></div>


                </div>
               
            </div>
<%------------------------------------------------------------------------------------------ GRID PASTAS --%>
<%----------------------------------------------------------------------distrito -------------------------------------------------------------%>
                 <%-- Distritos --%>
                <div class="escondedistrito" style="display:none;">

                      <div class="row" style="margin-bottom: 5px;">

                            <div class="col-md-4 col-sm-3"></div>
                                <div class=" col-md-2 col-sm-6 form-group">
                                    <i style="font-size: 1.4em;" class="fa fa-object-ungroup"></i>
                                    <span style="color:#333333; position:relative; top:-5px;">
                                        LOTES
                                    </span>
                                </div>
                            <div class="col-md-4 col-sm-3"></div>

                      </div>

                      <div class="row" style="margin-bottom: 5px;">
                        <div class="col-md-4 col-sm-3"></div>
                            <div class="col-md-4 col-sm-6 form-group">
                                <asp:DropDownList onchange="onChangeDistrito()" Style="width: 100%" ID="ddlDistritos" class="form-control input-sm " runat="server" AppendDataBoundItems="true" autofocus="true">
                                  <asp:ListItem Text="Distrito" Value="0"></asp:ListItem>
                                 </asp:DropDownList>
                            </div>
                        <div class="col-md-4 col-sm-3"></div>
                    </div>


                </div>
                
<%-- ---------------------------------------------------------------------------------- fim distrito --%>


<%--***LOTES*********************************************************************************************--%>



                <div class="escondelote" style="display:none;">

                     

                <%-- LOTES --%>
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-4 col-sm-3 "></div>
                    <div class="col-md-4 col-sm-6  form-group">
                         
                         <asp:TextBox Style="width: 100%" ID="txtSearchLote" runat="server" class="form-control input-sm" type="text" placeholder="Pesquisar Lote"></asp:TextBox>
                        <div style="width: 100%; height: 190px; overflow-y: auto; border: 1px solid #cccccc; border-radius: 3px; padding: 10px;">
                            <i id="marcarTodosLotes" onclick="javascript: marcarTodosLotes();"  class="fa fa-square-o"></i>
                            <span style="color:#333333; position:relative; top:-2px;">
                                marcar / desmarcar todos
                            </span>
                            <asp:CheckBoxList Style="width: 100%" ID="cblLotes" class="input-sm cblLotes" runat="server" AppendDataBoundItems="true">
                                <asp:ListItem Text="Lote" Value="0"></asp:ListItem>
                            </asp:CheckBoxList>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-3 "></div>
                </div>

                
                
            </div>

               <%-- <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-4 col-sm-3 "></div>
                    <div class="col-md-3 col-sm-3 "></div>
                    <div class="col-md-1 col-sm-3  form-group">
                       
                    </div>
                    <div class="col-md-4 col-sm-3 "></div>
                </div>--%>

                <div class="row">
                    <div class="col-md-4 col-sm-3 "></div>
                    <div class="col-md-3 col-sm-4  form-group">
                        <span title='Limpar campos' id="limpartudo" onclick='javascript:limpa();' class='glyphicon glyphicon-erase' style="cursor:pointer; font-size: 1.4em; display: none;"></span>
                    </div>
                    <div class="col-md-1 col-sm-2  form-group">
                        
                        <asp:LinkButton runat="server" OnClick="bntUpdate_Click" type="button" class="btn btn-primary btn-sm pull-right update disabled" Style="width:100%; display: none">
                           Cadastrar
                        </asp:LinkButton>
                    </div>
                    <div class="col-md-4 col-sm-3 "></div>
                </div>

                </div>

              

             <input type="hidden" id="_ispostback" value="<%=Page.IsPostBack.ToString()%>" />
        </form>
        
    </div>

    <br />
    <br />
    <br />

    <script>
        function isPostBack() { //function to check if page is a postback-ed one
            return document.getElementById('_ispostback').value;
        }

        var cadastrar = 0;
       


        $(document).ready(function () {
           
            var input = $('#<%=txtSearchLote.ClientID%>');
            input.onkeyup = function () {
                var filter = input.value.toUpperCase();
                var lis = document.getElementsByTagName('li');
                for (var i = 0; i < lis.length; i++) {
                    var name = lis[i].getElementsByClassName('name')[0].innerHTML;
                    if (name.toUpperCase().indexOf(filter) == 0)
                        lis[i].style.display = 'list-item';
                    else
                        lis[i].style.display = 'none';
                }
            }
                                   
            $(".date").mask("00/00/0000", { clearIfNotMatch: true });
            $(".phone").mask("(00) 0000-0000", { clearIfNotMatch: true });
            $(".cepTxt").mask("00000-000", { clearIfNotMatch: true });
            $(".CNPJ").mask("00.000.000/0000-00", { clearIfNotMatch: true });
            $(".numerotxt").mask("000000");
            $(".faturamento").maskMoney({ allowNegative: false, thousands: '.', decimal: ',', affixesStay: false });
            
           
            $(document).on('click', '.btn-xl', function (e) {
                <%--$('#<%=lblCadastradoPasta.ClientID%>').css("background-color", "rgb(92, 184, 92)");
                $('#<%=lblCadastradoPasta.ClientID%>').css("border-radius", "2px");
                $('#<%=lblCadastradoPasta.ClientID%>').css("color", "white");
                $('#<%=lblCadastradoPasta.ClientID%>').fadeIn();--%>
                if ($('#<%=hfPermissao.ClientID%>').val() == "0" || $('#<%=hfPermissao.ClientID%>').val() == "2")
                {
                    if (confirm("Deseja excluir essa empresa?")) {
                        $.ajax({
                            type: "POST",
                            url: '<%=ResolveUrl("~/Service.asmx/removeEmpresa") %>',
                            data: "{ 'empresaPK':'" + $('#<%=hfEmpresa.ClientID%>').val() + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                if (parseInt(data.d) > 0) {
                                    alert('Empresa Deletada!')
                                }
                                else {
                                    alert('Empresa não encontrada. Tente novamente!')
                                }

                            },
                            error: function (XHR, errStatus, errorThrown) {
                                var err = JSON.parse(XHR.responseText);
                                errorMessage = err.Message;
                                alert(errorMessage);
                            }
                        });

                        setTimeout(function () {
                            $('#<%=hfEmpresaProcesso.ClientID%>').val('-1')
                            limpa();

                        }, 3000);

                    }
                   

                }
                else
                {
                    alert('Procure o administrador do sistema, você não tem permissão!')

                }
                

                
               
                

            });
            $(document).on('click', '.removeProcesso', function (e) {///FUNÇÃO PARA DELETAR PROCESSO A CLICA NO X
               


                $.ajax({
                    type: "POST",
                    url: '<%=ResolveUrl("~/Service.asmx/deleteProcesso") %>',
                    data: "{ 'PROCESSOPK':'" + $('#<%=hfProcessoPK.ClientID%>').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (parseInt(data.d) > 0) {
                            alert('Processo Deletado!')
                        }
                        else {
                            alert('Processo não encontrado. Tente novamente!')
                        }

                    },
                    error: function (XHR, errStatus, errorThrown) {
                        var err = JSON.parse(XHR.responseText);
                        errorMessage = err.Message;
                        alert(errorMessage);
                    }
                });

                setTimeout(function () {
                    $('#<%=hfEmpresaProcesso.ClientID%>').val('-1')
                    limpa();

                }, 3000);



            });

            $(document).on('click', '.limpaProcesso', function (e) {// FUNÇÃO PARA LIMPAR CAMPOS E FAZER UM NOVO CADASTRO
                
                $('#<%=hfEmpresaProcesso.ClientID%>').val('-1')
               
                $('.txtProcesso').removeAttr("disabled", "disabled")
                $('#limpaProcesso').fadeOut();
                $(".removeProcesso").fadeOut();
                setTimeout(function () {
                    $('#<%=txtProcesso.ClientID %>').val('');
                    $('.escondelote').css('display', 'none')
                    $('.escondedistrito').css('display', 'none')
                    $(".btnProcesso").fadeIn(1000);


                    <%--getDivProcesso($('#<%=hfEmpresa.ClientID%>').val())--%>

                }, 3000);
            
            });
            $(document).on('click', '.atualizar', function (e) {// FUNÇÃO PARA LIMPAR CAMPOS E FAZER UM NOVO CADASTRO

                $('#<%=txtProcesso.ClientID %>').prop('disabled', false)
                $('#<%=txtRazaoSocial.ClientID %>').prop('disabled', false)
                $('#<%=txtCNPJ.ClientID %>').prop('disabled', false)
                $('#<%=txtEmail.ClientID %>').prop('disabled', false)
                $('#<%=txtTelefone.ClientID %>').prop('disabled', false)
                $('#<%=ddlTipoMonetario.ClientID %>').prop('disabled', false)
                $('#<%=txtFaturamento.ClientID %>').prop('disabled', false)
                $('#<%=txtAtividades.ClientID %>').prop('disabled', false)
                $('#<%=txtNumFunc.ClientID %>').prop('disabled', false)
                $('#<%=txtNumEmpregosGerados.ClientID %>').prop('disabled', false)
                $('#<%=ddlTipoRua.ClientID %>').prop('disabled', false)
                $('#<%=txtNomeRua.ClientID %>').prop('disabled', false)
                $('#<%=txtNumero.ClientID %>').prop('disabled', false)
                $('#<%=txtComplemento.ClientID %>').prop('disabled', false)
                $('#<%=txtBairro.ClientID %>').prop('disabled', false)
                $('#<%=txtCEP.ClientID %>').prop('disabled', false)
                $('#<%=ddlUF.ClientID %>').prop('disabled', false)
                $('#<%=txtCidade.ClientID %>').prop('disabled', false)

            });
            
            $(document).on('click', '.btnProcesso', function (e) {// FUNÇÃO ATUALIZAR TABELA PROCESSO,LIMPAR CAMPO E LIMPAR MENSSAGEM

                

               
                setTimeout(function () {
                    $('#<%=txtProcesso.ClientID %>').val('');//LIMPA CAMPO
                    $('#<%=lblCadastradoPasta.ClientID %>').fadeOut();///TIRAR MESSAGEM DA TELA
                    getDivProcesso($('#<%=hfEmpresa.ClientID %>').val())//ATUALIZA DIV PROCESSO
                    
                   

                }, 3000);



            });
            $(document).on('click', '.cadastrar', function (e) {
                cadastrar = 1;
               
                if ($('#<%=txtRazaoSocial.ClientID%>').val("") == "" || $('#<%=txtCNPJ.ClientID%>').val("") == "")
                {
                    alert('Favor preecher Razao social e CNPJ')
                } else
                {
                    $('#<%=txtProcesso.ClientID %>').val("");
                    $('#<%=txtRazaoSocial.ClientID %>').val("");
                    $('#<%=txtCNPJ.ClientID %>').val("");
                    $('#<%=txtEmail.ClientID %>').val("");
                    $('#<%=txtTelefone.ClientID %>').val("");
                    $('#<%=ddlTipoMonetario.ClientID %>').val("0");
                    $('#<%=txtFaturamento.ClientID %>').val("");
                    $('#<%=txtAtividades.ClientID %>').val("");
                    $('#<%=txtNumFunc.ClientID %>').val("");
                    $('#<%=txtNumEmpregosGerados.ClientID %>').val("");
                    $('#<%=ddlTipoRua.ClientID %>').val("0");
                    $('#<%=txtNomeRua.ClientID %>').val("");
                    $('#<%=txtNumero.ClientID %>').val("");
                    $('#<%=txtComplemento.ClientID %>').val("");
                    $('#<%=txtBairro.ClientID %>').val("");
                    $('#<%=txtCEP.ClientID %>').val("");
                    $('#<%=ddlUF.ClientID %>').val("0");
                    $('#<%=txtCidade.ClientID %>').val("");
                    $('.atualizar').fadeOut();
                    $('.btn-xl').fadeOut();
                    $('.removeProcesso').fadeOut();
                    document.getElementById('divPastas').innerHTML = "";
                    $('.escondelote').css('display', 'none')
                    $('.escondedistrito').css('display', 'none')
                    $('.update').fadeOut();
                    $('#limpartudo').fadeOut();
                    $('.cadastrar').fadeIn(3000);

                    $('#<%=hfEmpresaProcesso.ClientID%>').val('-1')
                    $('#<%=txtProcesso.ClientID %>').removeAttr('disabled');

                    $('#limpaProcesso').fadeOut();
                    $(".removeProcesso").fadeOut();
                    setTimeout(function () {
                        $('#<%=txtProcesso.ClientID %>').val('');

                        $(".btnProcesso").fadeIn(1000);


                        <%--getDivProcesso($('#<%=hfEmpresa.ClientID%>').val())--%>

                    }, 2000);


                    $(".check").each(function () {

                        $(this).prop("checked", false)

                    });
                }
                
                
              

            });

            
            


            if (isPostBack().toString() == "True") {///RELOAD DA PAGINA FAZER
              
                
                if (cadastrar == 0)//VERIFICA SE FOI CADASTRADO ALGUMA COISA
                {
                    if ($('#<%=ddlDistritos.ClientID%>').val() != "0") {// VERIFICA SE TEM DISTRITO SELECIONADO

                        $('.txtProcesso').attr("disabled", "disabled")

                        $('#<%=hfDistritoPK.ClientID %>').val($('#<%=ddlDistritos.ClientID %>').val())
                        $('.btnProcesso').fadeOut();



                        $('.escondedistrito').css('display', 'block')
                        $('.escondeTudo').css('display', 'block')
                        $('.escondeProcesso').css('display', 'block')
                        $('.escondelote').css('display', 'block')
                        $('#divprocessos').css('display', 'block')
                       
                        
                        getDivProcesso($('#<%=hfEmpresa.ClientID%>').val())
                        $('#<%=ddlDistritos.ClientID%>').val($('#<%=hfDistritoPK.ClientID %>').val());
                        <%--PopulateLotesDistrito($('#<%=ddlDistritos.ClientID%>').val());--%>
                        editProcesso($('#<%=hfProcessoPK.ClientID%>').val(), $('#<%=hfCodCli.ClientID%>').val(), $('#<%=hfEmpresa.ClientID%>').val())

                        setTimeout(function () {

                            $('.atualizar').fadeIn(1000);
                            $('.cadastrar').fadeOut();
                            $('.update').fadeIn(1000);
                            $('#limpartudo').fadeIn(1000);
                            $('#limpaProcesso').fadeIn(1000);

                            $(".removeProcesso").fadeIn(1000);

                            <%--getDivProcesso($('#<%=hfEmpresa.ClientID%>').val())--%>

                        }, 2300);
                    } else {
                        $('.txtProcesso').removeAttr("disabled", "disabled")
                        $('#<%=txtProcesso.ClientID%>').val("");
                        $('#<%=hfDistritoPK.ClientID %>').val("0");
                        $('.escondeTudo').css('display', 'block')
                        $('.escondelote').css('display', 'none')
                        $('.escondeProcesso').css('display', 'none')

                        $('#divprocessos').css('display', 'none')
                        $('.escondedistrito').css('display', 'none')
                    }

                }
                else
                {
                    
                    cadastrar = 0;
                }
                
                
               

               

            }


          


         


            $(".cblLotes").change(function () {
                var lotesPK = "";
                var cont = 0;

                $(".check").each(function () {

                    if ($(this).prop("checked")) {
                        if (cont == 0) {
                            lotesPK += $(this).val();

                        } else {
                            lotesPK += ',' + $(this).val();
                        }
                        cont++;
                    }
                });
                document.getElementById('<%=hfLotes.ClientID %>').value = lotesPK;
                if(lotesPK.split(',').length>0 && lotesPK!='')
                {
                    
                    $('#<%=hfValida.ClientID%>').val(1)
                    $('.update').removeClass("disabled")
                }
                else {
                   
                    $('#<%=hfValida.ClientID%>').val(0)
                    $('.update').addClass("disabled")
                }

            });

            /** AUTOCOMPLETE PROCESSO **************************************************************************************/
            
               
                $("#<%=txtProcesso.ClientID %>").autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            url: '<%=ResolveUrl("~/Service.asmx/GetProcessosGeral") %>',
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
                                        jsondata.COD_EMPRESA_FK,
                                        jsondata.COD_DI
                                    ])
                                })

                                response($.map(processos, function (item) {
                                    return {
                                        label: item[0].toString(),
                                        processoPK: item[1].toString(),
                                        empresaPK: item[2],
                                        distrito: item[3]

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
                        
                        selectprocesso(i.item.label, i.item.empresaPK, i.item.processoPK, i.item.distrito)
                       

                    },
                    minLength: 1
                });

            
        
            function selectprocesso(cod_cli,empresaPK,processoPK,distrito)
            {
                $('.txtProcesso').addClass('disabled')
                $('.escondedistrito').css('display', 'block')
                $('.escondelote').css('display', 'none')
                
                if ($('#<%=hfEmpresa.ClientID%>').val() != "" && $('#<%=hfEmpresa.ClientID%>').val() != "-1" && $('#<%=hfEmpresa.ClientID%>').val() != null) {
                    var counter;
                    $("#<%=hfProcessoPK.ClientID %>").val(processoPK);
                   
                    if (empresaPK != null) {
                        $("#<%=hfEmpresaProcesso.ClientID %>").val(empresaPK);

                    }
                    else {
                        $("#<%=hfEmpresaProcesso.ClientID %>").val("-1");
                    }
                    //$('.txtProcesso').attr("disabled", "disabled");
                    $('#<%=txtProcesso.ClientID %>').val(cod_cli)
                    $('#<%=hfCodCli.ClientID %>').val(cod_cli)
                  
                    $('#<%=hfProcessoPK.ClientID %>').val(processoPK)


                    $.ajax({
                        type: "POST",
                        url: '<%=ResolveUrl("~/Service.asmx/GetLotesProcesso") %>',
                        data: "{ 'prefix': '" + processoPK + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {



                            var distrito = [];
                            var parsed = $.parseJSON(data.d);
                            var lotesPK = [];
                            $.each(parsed, function (i, jsondata) {
                                lotesPK.push(jsondata.COD_LOTE_FK)
                                distrito.push(jsondata.COD_DI)
                            });

                            $(".check").each(function () {

                                $(this).prop("checked", false)

                            });
                            $('.btnProcesso').fadeOut();

                            setTimeout(function () {
                                $('.txtProcesso').attr("disabled", "disabled")

                                $('#limpaProcesso').fadeIn(1000);

                                $(".removeProcesso").fadeIn(1000);

                                    <%--getDivProcesso($('#<%=hfEmpresa.ClientID%>').val())--%>

                                }, 2300);


                            if (distrito[0] == $('#<%=ddlDistritos.ClientID%>').val()) {

                                $('.escondeProcesso').css('display', 'block')
                                $('.escondelote').css('display', 'block')


                                counter = 0;
                              
                                while (counter < lotesPK.length) {
                                    $("#" + lotesPK[counter]).prop('checked', true);
                                    
                                    
                                    counter++;
                                   
                                }

                                $('#<%=hfLotes.ClientID%>').val(lotesPK);



                                if (lotesPK.length > 0) {
                                    alert('' + lotesPK.length + ' selecionados')
                                }
                                else {

                                    alert('Esse processo não possui lote')
                                }

                               

                          






                            }
                            else if (distrito[0] != null && distrito[0] != '' && distrito[0] != undefined) {
                                if (confirm('Processo pertence a outro distrito, gostaria que selecionasse?')) {

                                    $('#<%=ddlDistritos.ClientID%>').val(distrito[0])
                                    $('.escondeProcesso').css('display', 'block')
                                    $('.escondelote').css('display', 'block')
                                    $('#<%=hfDistritoPK.ClientID %>').val($('#<%=ddlDistritos.ClientID %>').val());
                                    <%--$('#<%=cblLotes.ClientID %>').empty();--%>
                                    PopulateLotesDistrito(distrito[0])

                                    setTimeout(function () {

                                        $('#limpaProcesso').fadeIn(1000);
                                        //$('.btnAtualizar').fadeIn(1000);
                                        $(".removeProcesso").fadeIn(1000);

                                        <%--getDivProcesso($('#<%=hfEmpresa.ClientID%>').val())--%>

                                    }, 2300);

                                    $('.btnProcesso').fadeOut();

                                    //$(".check").each(function () {

                                    //    $(this).prop("checked", false)

                                    //});

                                    sleep(3000);
                                    selectprocesso(cod_cli, empresaPK, processoPK, distrito);


                            }
                            else {
                                alert('Esse processo não possui distrito, selecione porfavor.')
                                




                                }

                            }


                            lotesPK.length = 0;









                        },
                        error: function (XHR, errStatus, errorThrown) {
                            var err = JSON.parse(XHR.responseText);
                            errorMessage = err.Message;
                            alert(errorMessage);
                        }
                    });
                   

                }
                else {
                    

                    $('.naoSelecionado').fadeIn();
                    setTimeout(function () {
                        $('#<%=txtProcesso.ClientID %>').val('');
                        $('.naoSelecionado').fadeOut();

                        <%--getDivProcesso($('#<%=hfEmpresa.ClientID%>').val())--%>

                    }, 3000);
                }
            }

            $("#<%=txtCidade.ClientID %>").autocomplete({
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
        
            $("#<%=txtRazaoSocial.ClientID %>").autocomplete({

                source: function (request, response) {
                    

                    $.ajax({
                        url: '<%=ResolveUrl("~/Service.asmx/GetRazao") %>',
                        data: "{ 'prefix': '" + request.term + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                var razao = item.split('$')[0].replace(" ", "");
                                var cnpj = item.split('$')[1].replace(" ", "");
                                var empresaPK = item.split('$')[2].replace(" ", "");
                                razao = razao.trim();
                                cnpj = cnpj.trim();
                                codempresa = empresaPK.trim();
                               
                                return {

                                    label: (razao),
                                    codempresa: empresaPK,


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

                /*
                *Executa após o CONTRATO ser selecionado: 'select'
                */
                select: function (e, i) {

                    
                    PopulateEmpresa(i.item.codempresa);
                    
                },
                minLength: 1
            });

            $("#<%=txtCNPJ.ClientID %>").autocomplete({

                source: function (request, response) {


                    $.ajax({
                        url: '<%=ResolveUrl("~/Service.asmx/PopulateCNPJ") %>',
                        data: "{ 'prefix': '" + request.term +  "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                var razao = item.split('$')[0].replace(" ", "");
                                var cnpj = item.split('$')[1].replace(" ", "");
                                var empresaPK = item.split('$')[2].replace(" ", "");
                                razao = razao.trim();
                                cnpj = cnpj.trim();
                                codempresa = empresaPK.trim();

                                return {

                                    label: (cnpj),
                                    codempresa: empresaPK,


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

                /*
                *Executa após o CONTRATO ser selecionado: 'select'
                */
                select: function (e, i) {


                    PopulateEmpresa(i.item.codempresa);

                },
                minLength: 1
            });



            function lotesempresa(arraylotes)
            {
                var numlotes = 0;
                var counter = 0;
                
             
                while (counter < arraylotes.length) {

                    $("#" + arraylotes[counter]).prop('checked', true);
                    counter++;

                }
            }


            function PopulateEmpresa(empresaPK) {
                $('#<%=hfEmpresa.ClientID%>').val(empresaPK);
               
                $('.escondeProcesso').css('display', 'block')
                $('.btn-xl').css('display', 'block')
               
                $('.atualizar').fadeIn(3000);
                $('.cadastrar').fadeOut();
                $('.update').fadeIn(3000);
                $('#limpartudo').fadeIn(3000);

                $.ajax({
                    url: '<%=ResolveUrl("~/Service.asmx/GetDadosEmpresa") %>',
                    data: "{ 'empresaPK': '" + empresaPK + "'}",
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

                           // document.getElementById('empresa').innerHTML = RAZAO_SOCIAL;
                           // document.getElementById('CNPJ').innerHTML = CNPJ;

                           // getProps(CNPJ);
                           //document.getElementById('hidr').style.display = 'block';

                            if ($('#<%=hfPermissao.ClientID%>').val() == 1) {
                                PERMISSAO = false
                            } else {
                                PERMISSAO = true
                            }
                            if (CNPJ != null)
                                if (CNPJ != '') {
                                    $('#<%=txtCNPJ.ClientID %>').val(CNPJ)
                                    if (!PERMISSAO) $('#<%=txtCNPJ.ClientID %>').prop('disabled', true)
                                }
                            if (RAZAO_SOCIAL != null)
                                if (RAZAO_SOCIAL != '') {
                                    $('#<%=txtRazaoSocial.ClientID %>').val(RAZAO_SOCIAL)
                                    if (!PERMISSAO) $('#<%=txtRazaoSocial.ClientID %>').prop('disabled', true)
                                }
                            if (EMAIL != null)
                                if (EMAIL != '') {
                                    $('#<%=txtEmail.ClientID %>').val(EMAIL)
                                    if (!PERMISSAO) $('#<%=txtEmail.ClientID %>').prop('disabled', true)
                                }
                            if (TELEFONE != null)
                                if (TELEFONE != '') {
                                    $('#<%=txtTelefone.ClientID %>').val(TELEFONE)
                                    if (!PERMISSAO) $('#<%=txtTelefone.ClientID %>').prop('disabled', true)
                                }

                            if (TIPO_MONETARIO != null)
                                if (TIPO_MONETARIO != '0') {
                                    $("#<%=ddlTipoMonetario.ClientID %>").val(TIPO_MONETARIO)
                                    if (!PERMISSAO) $('#<%=ddlTipoMonetario.ClientID %>').prop('disabled', true)
                                }

                            if (FATURAMENTO_ANUAL != null) {
                                $('#<%=txtFaturamento.ClientID %>').val(FATURAMENTO_ANUAL)
                                if (!PERMISSAO) $('#<%=txtFaturamento.ClientID %>').prop('disabled', true)
                            }

                            if (ATIVIDADE != null)
                                if (ATIVIDADE != '') {
                                    $('#<%=txtAtividades.ClientID %>').val(ATIVIDADE)
                                    if (!PERMISSAO) $('#<%=txtAtividades.ClientID %>').prop('disabled', true)
                                }

                            if (NUM_FUNC != null) {
                                $('#<%=txtNumFunc.ClientID %>').val(NUM_FUNC)
                                if (!PERMISSAO) $('#<%=txtNumFunc.ClientID %>').prop('disabled', true)
                            }

                            if (NUM_EMPREG_GERADOS != null) {
                                $('#<%=txtNumEmpregosGerados.ClientID %>').val(NUM_EMPREG_GERADOS)
                                if (!PERMISSAO) $('#<%=txtNumEmpregosGerados.ClientID %>').prop('disabled', true)
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
                                    $("#<%= ddlTipoRua.ClientID %>").val(TIPO)
                                    if (!PERMISSAO) $('#<%=ddlTipoRua.ClientID %>').prop('disabled', true)
                                }

                            if (NOME != null)
                                if (NOME != '') {
                                    $('#<%=txtNomeRua.ClientID %>').val(NOME)
                                    if (!PERMISSAO) $('#<%=txtNomeRua.ClientID %>').prop('disabled', true)
                                }

                            if (NUMERO != null) {
                                $('#<%=txtNumero.ClientID %>').val(NUMERO)
                                if (!PERMISSAO) $('#<%=txtNumero.ClientID %>').prop('disabled', true)
                            }

                            if (COMPLEMENTO != null)
                                if (COMPLEMENTO != '') {
                                    $('#<%=txtComplemento.ClientID %>').val(COMPLEMENTO)
                                    if (!PERMISSAO) $('#<%=txtComplemento.ClientID %>').prop('disabled', true)
                                }

                            if (BAIRRO != null)
                                if (BAIRRO != '') {
                                    $('#<%=txtBairro.ClientID %>').val(BAIRRO)
                                    if (!PERMISSAO) $('#<%=txtBairro.ClientID %>').prop('disabled', true)
                                }

                            if (CEP != null)
                                if (CEP != '') {
                                    $('#<%=txtCEP.ClientID %>').val(CEP)
                                    if (!PERMISSAO) $('#<%=txtCEP.ClientID %>').prop('disabled', true)
                                }

                            if (UF != null)
                                if (UF != '0') {
                                    $("#<%= ddlUF.ClientID %>").val(UF)
                                    if (!PERMISSAO) $('#<%=ddlUF.ClientID %>').prop('disabled', true)
                                }

                            if (MUN != null)
                                if (MUN != '0') {
                                    $("#<%= txtCidade.ClientID %>").val(MUN)
                                    if (!PERMISSAO) $('#<%=txtCidade.ClientID %>').prop('disabled', true)
                                }

                        });
                        // PopulateLotesDistrito();
                        PopulateLotes(empresaPK);
                        //PROCESSO
                        getDivProcesso(empresaPK);
                        $('#divprocessos').css('display', 'block')
                        

                       

                    },
                    error: function (XHR, errStatus, errorThrown) {
                        var err = JSON.parse(XHR.responseText);
                        errorMessage = err.Message;
                        alert(errorMessage);
                    }
                });

                


            }
            $('#<%=txtAtividades.ClientID%>').keyup(function () {
                $(this).val(function (_, val) {
                    return val.toUpperCase();
                });
                var tamanho = parseInt($('#<%=txtAtividades.ClientID%>').val().length);
                tamanho = 255 - tamanho;
                if (tamanho >= 0)
                    $('#<%=txtAtividades.ClientID%>').css('border', '');
                else
                    $('#<%=txtAtividades.ClientID%>').css('border', '1px solid red');
            });
           
            function PopulateLotesDistrito(distrito) {


                $.ajax({
                    type: "POST",
                    url: '<%=ResolveUrl("~/Service.asmx/PopulateLotesDistrito") %>',
                    data: "{ 'distrito': '" + distrito + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        var parsed2 = $.parseJSON(response.d);
                        var cont = 0;
                        $.each(parsed2, function (i, jsondata) {
                            if (cont == 0) {
                                $('#<%=cblLotes.ClientID %>').empty().append("<input class='check' id='" + jsondata.COD_LOTE_PK + "' type='checkbox' value='" + jsondata.COD_LOTE_PK + "' name='" + jsondata.COD_LOTE_CODEMIG + "'>" + "&nbsp;&nbsp;<label style ='position: relative; top: -3px;' for='" + jsondata.COD_LOTE_PK + "'>" + jsondata.COD_LOTE_CODEMIG + "</label><br/>");
                            } else
                                $('#<%=cblLotes.ClientID %>').append("<input class='check' id='" + jsondata.COD_LOTE_PK + "' type='checkbox' value='" + jsondata.COD_LOTE_PK + "' name='" + jsondata.COD_LOTE_CODEMIG + "'>" + "&nbsp;&nbsp;<label style ='position: relative; top: -3px;' for='" + jsondata.COD_LOTE_PK + "'>" + jsondata.COD_LOTE_CODEMIG + "</label><br/>");
                            cont++;
                        });
                    },
                    failure: function (response) {
                        alert(response.d);
                    },
                    error: function (response) {
                        alert(response.d);
                    }
                });

            }

            function PopulateLotes(empresaPK)
            {
                
                var arraylotes;
                var lotes="";
                $.ajax({
                    type: "POST",
                    url: '<%=ResolveUrl("~/Service.asmx/PopulateLotesEmpresas") %>',
                    data: "{ 'codempresa': '" + empresaPK + "', 'distrito': '" + $('#<%=ddlDistritos.ClientID%>').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        var parsed2 = $.parseJSON(response.d);
                        var cont = 0;
                        $.each(parsed2, function (i, jsondata) {
                            if (cont == 0) {
                                lotes = jsondata.COD_LOTE_PK;
                                
                               
                            } else {
                                lotes = lotes+","+jsondata.COD_LOTE_PK;
                               


                            }

                            cont++;
                        });
                        arraylotes = lotes.split(',');
                       
                        $('#<%=hfLotes.ClientID%>').val(lotes);
                        lotesempresa(arraylotes);


                    },
                    failure: function (response) {
                        alert(response.d);
                    },
                    error: function (response) {
                        alert(response.d);
                    }
                });

            }
            function getDivProcesso(codempresa) {
                $.ajax({
                    url: '<%=ResolveUrl("~/Service.asmx/GetProcessoGrid") %>',
                    data: "{ 'codempresa': '" + codempresa + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        var parsed = $.parseJSON(data.d);
                        var txt = "";
                        $.each(parsed, function (i, jsondata) {
                            txt += '<span id="' + jsondata.COD_CLI.toString() + '" style="padding-right:2px; padding-left:2px; margin-right: 5px; border: 1px solid #cccccc; border-radius: 2px;">' + jsondata.COD_CLI + ' &nbsp;<span style=" padding-bottom:1px; " class="fa fa-pencil-square-o" title="Selecionar"  onclick="javascript:editProcesso(' + jsondata.COD_PROCESSO_PK + ',\''+ jsondata.COD_CLI +'\','+codempresa+')" id="' + jsondata.COD_PROCESSO_PK + '"></span><span style=" padding-bottom:1px; " class="glyphicon glyphicon-remove"  onclick="javascript:removeProcesso(' + jsondata.COD_PROCESSO_PK + ', ' + $('#<%=hfEmpresa.ClientID%>').val() + ')" id="' + jsondata.COD_PROCESSO_PK + '"></span></span>';
                        })
                        document.getElementById('divPastas').innerHTML = txt;

                    },
                    error: function (response) {
                        alert(response.responseText);
                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }
                });
            }


            function PopulateLotesDistrito(distrito) {


                $.ajax({
                    type: "POST",
                    url: '<%=ResolveUrl("~/Service.asmx/PopulateLotesDistrito") %>',
                    data: "{ 'distrito': '" + distrito + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        var parsed2 = $.parseJSON(response.d);
                        var cont = 0;
                        $.each(parsed2, function (i, jsondata) {
                            if (cont == 0) {
                                $('#<%=cblLotes.ClientID %>').empty().append("<input class='check' id='" + jsondata.COD_LOTE_PK + "' type='checkbox' value='" + jsondata.COD_LOTE_PK + "' name='" + jsondata.COD_LOTE_CODEMIG + "'>" + "&nbsp;&nbsp;<label style ='position: relative; top: -3px;' for='" + jsondata.COD_LOTE_PK + "'>" + jsondata.COD_LOTE_CODEMIG + "</label><br/>");
                            } else
                                $('#<%=cblLotes.ClientID %>').append("<input class='check' id='" + jsondata.COD_LOTE_PK + "' type='checkbox' value='" + jsondata.COD_LOTE_PK + "' name='" + jsondata.COD_LOTE_CODEMIG + "'>" + "&nbsp;&nbsp;<label style ='position: relative; top: -3px;' for='" + jsondata.COD_LOTE_PK + "'>" + jsondata.COD_LOTE_CODEMIG + "</label><br/>");
                            cont++;
                        });
                    },
                    failure: function (response) {
                        alert(response.d);
                    },
                    error: function (response) {
                        alert(response.d);
                    }
                });

            }
            function editProcesso(processo, cod_cli, empresa) {
                $('.txtProcesso').attr("disabled", "disabled")

                $('#<%=txtProcesso.ClientID %>').val(cod_cli)
                $('#<%=hfCodCli.ClientID %>').val(cod_cli)
                $('#<%=hfEmpresaProcesso.ClientID%>').val(empresa)
                $('#<%=hfProcessoPK.ClientID %>').val(processo)


                $.ajax({
                    type: "POST",
                    url: '<%=ResolveUrl("~/Service.asmx/GetLotesProcesso") %>',
                    data: "{ 'prefix': '" + processo + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {



                        var distrito = [];
                        var parsed = $.parseJSON(data.d);
                        var lotesPK = [];
                        $.each(parsed, function (i, jsondata) {
                            lotesPK.push(jsondata.COD_LOTE_FK)
                            distrito.push(jsondata.COD_DI)
                        });

                        $(".check").each(function () {

                            $(this).prop("checked", false)

                        });


                        if (distrito[0] == $('#<%=ddlDistritos.ClientID%>').val()) {





                            counter = 0;
                            while (counter < lotesPK.length) {
                                $("#" + lotesPK[counter]).prop('checked', true);

                                counter++;

                            }





                            if (lotesPK.length > 0) {
                                alert('' + lotesPK.length + ' selecionados')
                                $('.escondelote').css('display', 'block')
                            }
                            else {

                                alert('Esse processo não possui lote')
                            }

                            $('.btnProcesso').fadeOut();

                            setTimeout(function () {

                                $('#limpaProcesso').fadeIn(1000);

                                $(".removeProcesso").fadeIn(1000);

                                <%--getDivProcesso($('#<%=hfEmpresa.ClientID%>').val())--%>

                            }, 2300);







                        }
                        else if (distrito[0] == null || distrito[0] == '' || distrito[0] == undefined) {
                            alert('Esse processo não possui distrito, selecione porfavor.')
                            $('.escondedistrito').css('display', 'block')
                            $('.escondeProcesso').css('display', 'block')
                            $('.escondelote').css('display', 'none')
                        }
                        else {

                            if (confirm('Processo pertence a outro distrito, gostaria que selecionasse?')) {

                                $('#<%=ddlDistritos.ClientID%>').val(distrito[0])
                                $('.escondedistrito').css('display', 'block')
                                $('.escondeProcesso').css('display', 'block')
                                $('.escondelote').css('display', 'block')
                                $('#<%=hfDistritoPK.ClientID %>').val($('#<%=ddlDistritos.ClientID %>').val());
                                <%--$('#<%=cblLotes.ClientID %>').empty();--%>
                                PopulateLotesDistrito(distrito[0])



                                //$(".check").each(function () {

                                //    $(this).prop("checked", false)

                                //});

                                sleep(3000);
                                editProcesso(processo, cod_cli, empresa);






                            }

                        }


                        lotesPK.length = 0;









                    },
                    error: function (XHR, errStatus, errorThrown) {
                        var err = JSON.parse(XHR.responseText);
                        errorMessage = err.Message;
                        alert(errorMessage);
                    }
                });


            }
            function sleep(milliseconds) {
                var start = new Date().getTime();
                for (var i = 0; i < 1e7; i++) {
                    if ((new Date().getTime() - start) > milliseconds) {
                        break;
                    }
                }
            }
            


            function limpa() {
                $('#<%=txtProcesso.ClientID %>').prop('disabled', false)
                $('#<%=txtRazaoSocial.ClientID %>').prop('disabled', false)
                $('#<%=txtCNPJ.ClientID %>').prop('disabled', false)
                $('#<%=txtEmail.ClientID %>').prop('disabled', false)
                $('#<%=txtTelefone.ClientID %>').prop('disabled', false)
                $('#<%=ddlTipoMonetario.ClientID %>').prop('disabled', false)
                $('#<%=txtFaturamento.ClientID %>').prop('disabled', false)
                $('#<%=txtAtividades.ClientID %>').prop('disabled', false)
                $('#<%=txtNumFunc.ClientID %>').prop('disabled', false)
                $('#<%=txtNumEmpregosGerados.ClientID %>').prop('disabled', false)
                $('#<%=ddlTipoRua.ClientID %>').prop('disabled', false)
                $('#<%=txtNomeRua.ClientID %>').prop('disabled', false)
                $('#<%=txtNumero.ClientID %>').prop('disabled', false)
                $('#<%=txtComplemento.ClientID %>').prop('disabled', false)
                $('#<%=txtBairro.ClientID %>').prop('disabled', false)
                $('#<%=txtCEP.ClientID %>').prop('disabled', false)
                $('#<%=ddlUF.ClientID %>').prop('disabled', false)
                $('#<%=txtCidade.ClientID %>').prop('disabled', false)


                $('#<%=txtProcesso.ClientID %>').val("");
                $('#<%=txtRazaoSocial.ClientID %>').val("");
                $('#<%=txtCNPJ.ClientID %>').val("");
                $('#<%=txtEmail.ClientID %>').val("");
                $('#<%=txtTelefone.ClientID %>').val("");
                $('#<%=ddlTipoMonetario.ClientID %>').val("0");
                $('#<%=txtFaturamento.ClientID %>').val("");
                $('#<%=txtAtividades.ClientID %>').val("");
                $('#<%=txtNumFunc.ClientID %>').val("");
                $('#<%=txtNumEmpregosGerados.ClientID %>').val("");
                $('#<%=ddlTipoRua.ClientID %>').val("0");
                $('#<%=txtNomeRua.ClientID %>').val("");
                $('#<%=txtNumero.ClientID %>').val("");
                $('#<%=txtComplemento.ClientID %>').val("");
                $('#<%=txtBairro.ClientID %>').val("");
                $('#<%=txtCEP.ClientID %>').val("");
                $('#<%=ddlUF.ClientID %>').val("0");
                $('#<%=txtCidade.ClientID %>').val("");
                $('.atualizar').fadeOut();
                $('.btn-xl').fadeOut();
                $('.removeProcesso').fadeOut();
                document.getElementById('divPastas').innerHTML = "";
                $('.escondelote').css('display', 'none')
                $('.escondedistrito').css('display', 'none')
                $('.update').fadeOut();
                $('#limpartudo').fadeOut();
                $('.cadastrar').fadeIn(3000);
             
                $('.escondeProcesso').css('display', 'none')

              
               
                $('#<%=hfEmpresaProcesso.ClientID%>').val('-1')
                $('#<%=txtProcesso.ClientID %>').removeAttr('disabled');
                
                $('#limpaProcesso').fadeOut();
                $(".removeProcesso").fadeOut();
                setTimeout(function () {
                    $('#<%=txtProcesso.ClientID %>').val('');

                    $(".btnProcesso").fadeIn(1000);


                    <%--getDivProcesso($('#<%=hfEmpresa.ClientID%>').val())--%>

                }, 2000);


                $(".check").each(function () {

                    $(this).prop("checked", false)

                });

            }
           
            
            
        })


        



        

        function limpa()
        {
            $('#<%=txtProcesso.ClientID %>').prop('disabled', false)
            $('#<%=txtRazaoSocial.ClientID %>').prop('disabled', false)
            $('#<%=txtCNPJ.ClientID %>').prop('disabled', false)
            $('#<%=txtEmail.ClientID %>').prop('disabled', false)
            $('#<%=txtTelefone.ClientID %>').prop('disabled', false)
            $('#<%=ddlTipoMonetario.ClientID %>').prop('disabled', false)
            $('#<%=txtFaturamento.ClientID %>').prop('disabled', false)
            $('#<%=txtAtividades.ClientID %>').prop('disabled', false)
            $('#<%=txtNumFunc.ClientID %>').prop('disabled', false)
            $('#<%=txtNumEmpregosGerados.ClientID %>').prop('disabled', false)
            $('#<%=ddlTipoRua.ClientID %>').prop('disabled', false)
            $('#<%=txtNomeRua.ClientID %>').prop('disabled', false)
            $('#<%=txtNumero.ClientID %>').prop('disabled', false)
            $('#<%=txtComplemento.ClientID %>').prop('disabled', false)
            $('#<%=txtBairro.ClientID %>').prop('disabled', false)
            $('#<%=txtCEP.ClientID %>').prop('disabled', false)
            $('#<%=ddlUF.ClientID %>').prop('disabled', false)
            $('#<%=txtCidade.ClientID %>').prop('disabled', false)

            $('#<%=txtProcesso.ClientID %>').val("");
            $('#<%=txtRazaoSocial.ClientID %>').val("");
            $('#<%=txtCNPJ.ClientID %>').val("");
            $('#<%=txtEmail.ClientID %>').val("");
            $('#<%=txtTelefone.ClientID %>').val("");
            $('#<%=ddlTipoMonetario.ClientID %>').val("0");
            $('#<%=txtFaturamento.ClientID %>').val("");
            $('#<%=txtAtividades.ClientID %>').val("");
            $('#<%=txtNumFunc.ClientID %>').val("");
            $('#<%=txtNumEmpregosGerados.ClientID %>').val("");
            $('#<%=ddlTipoRua.ClientID %>').val("0");
            $('#<%=txtNomeRua.ClientID %>').val("");
            $('#<%=txtNumero.ClientID %>').val("");
            $('#<%=txtComplemento.ClientID %>').val("");
            $('#<%=txtBairro.ClientID %>').val("");
            $('#<%=txtCEP.ClientID %>').val("");
            $('#<%=ddlUF.ClientID %>').val("0");
            $('#<%=txtCidade.ClientID %>').val("");
            $('#divprocessos').css('display', 'none');
            document.getElementById('divPastas').innerHTML = "";
            $('.escondelote').css('display', 'none')
            $('.escondedistrito').css('display', 'none')
            $('.update').fadeOut();
            $('.btn-xl').fadeOut();
            $('.removeProcesso').fadeOut();
            $('.atualizar').fadeOut();
            $('#limpartudo').fadeOut();
            $('.cadastrar').fadeIn(3000);
            
            $('.escondeProcesso').css('display', 'none')

        


            $('#<%=hfEmpresaProcesso.ClientID%>').val('-1')
            $('#<%=txtProcesso.ClientID %>').removeAttr('disabled');
          
            $('#limpaProcesso').fadeOut();
            $(".removeProcesso").fadeOut();
            setTimeout(function () {
                $('#<%=txtProcesso.ClientID %>').val('');

                $(".btnProcesso").fadeIn(1000);


                <%--getDivProcesso($('#<%=hfEmpresa.ClientID%>').val())--%>

            }, 2000);


            $(".check").each(function () {

                $(this).prop("checked", false)

            });

        }

        function editProcesso(processo,cod_cli,empresa)
        {
            $('.txtProcesso').attr("disabled","disabled")
           
            $('#<%=txtProcesso.ClientID %>').val(cod_cli)
            $('#<%=hfCodCli.ClientID %>').val(cod_cli)
            $('#<%=hfEmpresaProcesso.ClientID%>').val(empresa)
            $('#<%=hfProcessoPK.ClientID %>').val(processo)
           

            $.ajax({
                type: "POST",
                url: '<%=ResolveUrl("~/Service.asmx/GetLotesProcesso") %>',
                data: "{ 'prefix': '" + processo + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                        
                   
                        var distrito = [];
                        var parsed = $.parseJSON(data.d);
                        var lotesPK = [];
                        $.each(parsed, function (i, jsondata) {
                            lotesPK.push(jsondata.COD_LOTE_FK)
                            distrito.push(jsondata.COD_DI)
                        });

                        $(".check").each(function () {

                            $(this).prop("checked", false)

                        });
                        
                       
                            if (distrito[0] == $('#<%=ddlDistritos.ClientID%>').val())
                            {
                               

                               
                                

                                counter = 0;
                                while (counter < lotesPK.length) {
                                    $("#" + lotesPK[counter]).prop('checked', true);
                                    
                                    counter++;

                                }


                               

                               
                                    if (lotesPK.length > 0) {
                                        alert('' + lotesPK.length + ' selecionados')
                                        $('.escondelote').css('display', 'block')
                                    }
                                    else {

                                        alert('Esse processo não possui lote')
                                    }

                                    $('.btnProcesso').fadeOut();

                                    setTimeout(function () {

                                        $('#limpaProcesso').fadeIn(1000);
                                        
                                        $(".removeProcesso").fadeIn(1000);

                                        <%--getDivProcesso($('#<%=hfEmpresa.ClientID%>').val())--%>

                                    }, 2300);
                                




                                
                                
                            }
                            else if (distrito[0] == null || distrito[0] == '' || distrito[0] == undefined)
                            {
                                alert('Esse processo não possui distrito, selecione porfavor.')
                                $('.escondedistrito').css('display', 'block')
                                $('.escondeProcesso').css('display', 'block')
                                $('.escondelote').css('display', 'none')
                            }
                            else {

                                if (confirm('Processo pertence a outro distrito, gostaria que selecionasse?')) {

                                    $('#<%=ddlDistritos.ClientID%>').val(distrito[0])
                                    $('.escondedistrito').css('display', 'block')
                                    $('.escondeProcesso').css('display', 'block')
                                    $('.escondelote').css('display', 'block')
                                    $('#<%=hfDistritoPK.ClientID %>').val($('#<%=ddlDistritos.ClientID %>').val());
                                    <%--$('#<%=cblLotes.ClientID %>').empty();--%>
                                    PopulateLotesDistrito(distrito[0])



                                    //$(".check").each(function () {

                                    //    $(this).prop("checked", false)

                                    //});

                                    sleep(3000);
                                    editProcesso(processo, cod_cli, empresa);






                                }

                            }
                             
                    
                            lotesPK.length = 0;
                            
                    
                    

                   

                   

                   
                },
                error: function (XHR, errStatus, errorThrown) {
                    var err = JSON.parse(XHR.responseText);
                    errorMessage = err.Message;
                    alert(errorMessage);
                }
            });
           

        }
        function sleep(milliseconds) {
            var start = new Date().getTime();
            for (var i = 0; i < 1e7; i++) {
                if ((new Date().getTime() - start) > milliseconds) {
                    break;
                }
            }
        }
        function removeProcesso(processo, empresa) {
            if ($('#<%=hfPermissao.ClientID%>').val() == "0" || $('#<%=hfPermissao.ClientID%>').val() == "2")
            {
                if (confirm("Deseja excluir esse processo?")) {
                    $.ajax({
                        type: "POST",
                        url: '<%=ResolveUrl("~/Service.asmx/removeProcesso") %>',
                        data: "{ 'PROCESSOPK': '" + processo + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (parseInt(data.d) > 0) {
                                $('#<%=hfEmpresaProcesso.ClientID%>').val("-1");
                                getDivProcesso(empresa)
                                $('#lblCadastradoPasta').css("background-color", "rgb(217, 83, 79)");
                                $('#lblCadastradoPasta').html('Deletado')
                                $('#lblCadastradoPasta').fadeIn();
                                setTimeout(function () {
                                    $('#lblCadastradoPasta').fadeOut();
                                    //$('.statusPasta').html('')
                                }, 3000);
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
            else
            {
                alert("Não tem permissão para excluir esse processo.")
            }
            
        }
        function getDivProcesso(codempresa) {
            $.ajax({
                url: '<%=ResolveUrl("~/Service.asmx/GetProcessoGrid") %>',
                data: "{ 'codempresa': '" + codempresa + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    var parsed = $.parseJSON(data.d);
                    var txt = "";
                    $.each(parsed, function (i, jsondata) {
                        txt += '<span id="' + jsondata.COD_CLI + '" style="padding-right:2px; padding-left:2px; margin-right: 5px; border: 1px solid #cccccc; border-radius: 2px;">' + jsondata.COD_CLI + ' &nbsp;<span style=" padding-bottom:1px; " class="fa fa-pencil-square-o" title="Selecionar"  onclick="javascript:editProcesso(' + jsondata.COD_PROCESSO_PK + ', ' + $('#<%=hfEmpresa.ClientID%>').val() + ',' + jsondata.COD_CLI + ')" id="' + jsondata.COD_PROCESSO_PK + '"></span><span style=" padding-bottom:1px; " class="glyphicon glyphicon-remove"  onclick="javascript:removeProcesso(' + jsondata.COD_PROCESSO_PK + ', ' + $('#<%=hfEmpresa.ClientID%>').val() + ')" id="' + jsondata.COD_PROCESSO_PK + '"></span></span>';
                    })
                    document.getElementById('divPastas').innerHTML = txt;

                },
                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });
        }
        function marcarTodosLotes() {

            var lotesPK = "";
            cont = 0;

            if (document.getElementById('marcarTodosLotes').className == 'fa fa-square-o') {
                document.getElementById('marcarTodosLotes').className = 'fa fa-check-square-o';
                $(".check").each(function () {
                    $(this).prop('checked', true);


                    if (cont == 0) {
                        lotesPK += $(this).val();

                    } else {
                        lotesPK += ',' + $(this).val();
                    }
                    cont++;

                })

            } else {
                $(".check").each(function () {
                    document.getElementById('marcarTodosLotes').className = 'fa fa-square-o';
                    $(this).prop('checked', false);

                    cont = 0;
                    lotesPK = "";
                })
            }

            


            document.getElementById('<%=hfLotes.ClientID %>').value = lotesPK;

        }
        

        function onChangeDistrito() {
            
            if ($('#<%=ddlDistritos.ClientID %>').val() != "0") {
                //limpa();
                $('.escondeTudo').css('display', 'block')
                $('.escondeProcesso').css('display', 'block')
                $('.escondelote').css('display', 'block')
                $('#<%=hfDistritoPK.ClientID %>').val($('#<%=ddlDistritos.ClientID %>').val());
                
                PopulateLotesDistrito($('#<%=ddlDistritos.ClientID%>').val());
                
            }
            else {
                limpa();
                //$('.escondeTudo').css('display', 'none')
                //$('.escondeProcesso').css('display', 'none')
                $('.escondelote').css('display', 'none')
            }
        }


        function PopulateLotesDistrito(distrito) {

           
            $.ajax({
                type: "POST",
                url: '<%=ResolveUrl("~/Service.asmx/PopulateLotesDistrito") %>',
                data: "{ 'distrito': '" + distrito + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    var parsed2 = $.parseJSON(response.d);
                    var cont = 0;
                    $.each(parsed2, function (i, jsondata) {
                        if (cont == 0) {
                            $('#<%=cblLotes.ClientID %>').empty().append("<input class='check' id='" + jsondata.COD_LOTE_PK + "' type='checkbox' value='" + jsondata.COD_LOTE_PK + "' name='" + jsondata.COD_LOTE_CODEMIG + "'>" + "&nbsp;&nbsp;<label style ='position: relative; top: -3px;' for='" + jsondata.COD_LOTE_PK + "'>" + jsondata.COD_LOTE_CODEMIG + "</label><br/>");
                        } else
                            $('#<%=cblLotes.ClientID %>').append("<input class='check' id='" + jsondata.COD_LOTE_PK + "' type='checkbox' value='" + jsondata.COD_LOTE_PK + "' name='" + jsondata.COD_LOTE_CODEMIG + "'>" + "&nbsp;&nbsp;<label style ='position: relative; top: -3px;' for='" + jsondata.COD_LOTE_PK + "'>" + jsondata.COD_LOTE_CODEMIG + "</label><br/>");
                        cont++;
                    });
                },
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });

        }


        

       

    </script>

    

</asp:Content>