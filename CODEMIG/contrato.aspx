<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" MasterPageFile="~/site.master" CodeBehind="contrato.aspx.cs" Inherits="CODEMIG.contrato" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="body">
    
    <div class="content">
        <form autocomplete="off" runat="server" class="form-inline" style="width: 100%;" ng-app="myApp" ng-controller="validateCtrl" name="myForm">

            <asp:HiddenField ID="hfPermissao" runat="server" Value="" />
              <asp:HiddenField ID="hfLoginPK" runat="server" Value="" />

            <asp:ScriptManager ID="ScriptManager1" runat="server" />

            <div class="row" style="margin-bottom:5px;">
                <div class="col-md-4"></div>
                <div class="col-md-4 form-group">
                    <asp:DropDownList Style="width: 100%" ID="ddlDistritos" class=" form-control input-sm " runat="server" AppendDataBoundItems="true" autofocus="true" onchange="Dirstrito();">
                        <asp:ListItem Text="Distrito" Value="0"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-4"></div>

            </div>

            <div class="row" style="margin-bottom:5px;">

                <div class="col-md-4"></div>
                <div class="col-md-4 form-group">
                    <div class="icon-addon addon-sm">
                        <asp:TextBox Style="width: 100%" type="text" placeholder="Razão Social" class="form-control input-sm" ID="txtRazao" runat="server" name="contrato"></asp:TextBox>
                        <i for="contrato" class="fa fa-building" rel="tooltip" title="contrato" id="folder"></i>
                    </div>
                </div>
                <div class="col-md-4"></div>

            </div>
           

            <div class="row2" id="teste2" style="display: none;">

                <div class="row" >

                    <div class="col-md-4"></div>
                    <div class="col-md-4 form-group" style="">
                        <div style="max-height: 200px;   overflow-y: auto; border: 1px solid #cccccc; border-radius: 3px;  display: none;" id="divHists">

                            <table style="min-width: 100%;" id="contrato">
                            </table>

                        </div>

                    </div>
                    <div class="col-md-4"></div>
                </div>

                <%-- Linha EXIBIR EMPRESA E CNPJ--%>
                <center >
                    <h5><span id="empresa" style="color:#333333;"></span><br />
                    <span id="CNPJ" style="color:#333333;"></span></h5>
                <%-- Ícone exibir e ocultar formulário--%>
                    <label style="position:relative; top:-5px; margin-bottom:10px; display: none;" class  ="glyphicon glyphicon-triangle-bottom"  rel="tooltip" title="email" id="hidr"></label>
                </center>



                <center >
                    <h4>   
                        <i style="font-size: 1.4em; " class  ="fa fa-object-ungroup" rel="tooltip" title=""></i>
                        <span style="color:#333333; position:relative; top:-5px;">
                            LOTES
                        </span>
                    </h4>
                </center>
                <div class="row" style="margin-bottom:5px;">
                    <div class="col-md-4"></div>
                    <div class="col-md-4 form-group" style="">
                        <div  style="width: 100%; height: 190px; overflow-y: auto; border: 1px solid #cccccc; border-radius: 3px; padding: 10px;">
                            <asp:CheckBoxList Style="width: 100%; padding-bottom:0px; " ID="cblTeste" class="  input-sm cblTeste" runat="server" AppendDataBoundItems="true">

                                <asp:ListItem Text="Lote" Value="0"></asp:ListItem>

                            </asp:CheckBoxList>
                        </div>
                    </div>
                    <div class="col-md-4"></div>
                </div>
                <asp:HiddenField ID="hfLotes" runat="server" Value="" />
                
                <asp:HiddenField ID="hfContratoPK" runat="server" Value="" />
                
                <div class="row">
                    <center>
                        <h4>
                            <label style="font-size: 1.4em; " class = "glyphicon glyphicon-info-sign" rel="tooltip" title=""></label>
                            <span style="color:#333333; position:relative; top:-5px;">
                                INFORMAÇÕES DO CONTRATO
                            </span>
                        </h4>
                    </center>
                </div>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4"></div>

                    <div class=" col-md-2 form-group ">

                        <asp:TextBox Style="width: 100%" type="text" placeholder="Data de Apresentação do Projeto" class=" date form-control input-sm data" ID="txtDataApre" runat="server" name="Data"></asp:TextBox>

                    </div>
                    <div class="col-md-2 form-group">
                        <div class="">
                            <asp:TextBox Style="width: 100%" type="text" placeholder="Data de Aquisição do Terreno" class="date form-control input-sm " ID="txtAquis" runat="server"></asp:TextBox>
                        </div>
                    </div>


                    <div class="col-md-4"></div>

                </div>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4"></div>

                    <div class=" col-md-2 form-group ">

                        <asp:TextBox Style="width: 100%" type="text" placeholder="Data Inicio Operação" class=" date form-control input-sm " ID="txtDataIniOp" runat="server" name="Data"></asp:TextBox>

                    </div>
                    <div class="col-md-2 form-group">
                        <div class="">
                            <asp:TextBox Style="width: 100%" type="text" placeholder="Data Inicio da Obra" class="date form-control input-sm" ID="txtDataInicioOb" runat="server"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-md-4"></div>
                </div>









                <%-- BOTÃO CADASTRAR  --%>
                <div class="row" style="margin-bottom:5px;">

                    <div class="col-md-4"></div>
                    <div class="col-md-2 form-group">
                        <div class="">
                            <asp:TextBox Style="width: 100%" type="text" placeholder="Data Fim de Obra" class="date form-control input-sm" ID="txtDataFimOb" runat="server"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-md-2 form-group">
                        <asp:LinkButton Style="display: block; width: 100%;" runat="server" OnClick="bntCadastrar_Click1" type="button" class="btn btn-primary btn-sm pull-right cadastrar" disabled>
                            &nbsp;&nbsp;&nbsp;
                            Cadastrar
                            &nbsp;&nbsp;&nbsp;
                        </asp:LinkButton>
                        <asp:LinkButton runat="server" OnClick="bntUpdate_Click" type="button" class="btn btn-primary btn-sm pull-right update" Style="display: none; width: 100%;">
                                &nbsp;&nbsp;&nbsp;
                                Atualizar
                                &nbsp;&nbsp;&nbsp;
                        </asp:LinkButton>
                    </div>

                    <div class="col-md-4"></div>

                </div>
            </div>

            <br />
            <br />
            <br />
        </form>
    </div>



    <script type="text/javascript">
        /** GET VALORES CHECKBOX LIST LOTES ****************************************************************************/
        $(".cblTeste").change(function () {

            var lotesPK = "";
            var cont = 0;

            $(".check").each(function () {
                if ($(this).prop("checked")) {
                    //alert($(this).val());
                    if (cont == 0) {
                        lotesPK += $(this).val();
                    } else {
                        lotesPK += ',' + $(this).val();
                    }


                    cont++;
                }

            });

            if (cont != 0) {
                $('.cadastrar').removeAttr("disabled");
                $('.update').removeAttr("disabled");
            } else {
                $('.cadastrar').attr("disabled", "disabled");
                $('.update').attr("disabled", "disabled");
            }

            document.getElementById('<%=hfLotes.ClientID %>').value = lotesPK;

        });
        /**************************************************************************** GET VALORES CHECKBOX LIST LOTES **/


        $(document).ready(function () {
            $(".date").mask("00/00/0000", { clearIfNotMatch: true });
            /*
            *Populate Autocomplete RAZAO de acordo com o DISTRITO selecionado
            */
            $("#<%=txtRazao.ClientID %>").autocomplete({

                source: function (request, response) {
                    var razao;
                    $.ajax({
                        url: '<%=ResolveUrl("~/Service.asmx/PopulateEmpresaCNPJ") %>',
                            data: "{ 'prefix': '" + request.term + "$" + $('#<%=ddlDistritos.ClientID%>').val() + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                response($.map(data.d, function (item) {
                                    var razao = item.split('$')[0].replace(" ", "");
                                    var cnpj = item.split('$')[1].replace(" ", "");
                                    razao = razao.trim();
                                    cnpj = cnpj.trim();

                                    return {

                                        label: (razao + '||' + cnpj),



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


                    PopulateContrato(i.item.label);

                },
                minLength: 1
            });

        });















            jQuery(function ($) {
                /*
                *Máscaras Validação
                */
               








            });
            //**ONCHANGE DE DISTRITO PARA LIMPAR
            function Dirstrito() {
                if ($('#<%=ddlDistritos.ClientID%>').val() == "0") {

                document.getElementById('teste2').style.display = 'none';
                document.getElementById('empresa').innerHTML = "";

                document.getElementById('CNPJ').innerHTML = "";
                document.getElementById('hidr').style.display = 'none';
                document.getElementById('<%=txtRazao.ClientID%>').value = '';
            }
            else {
                document.getElementById('teste2').style.display = 'none';
                document.getElementById('empresa').innerHTML = "";

                document.getElementById('CNPJ').innerHTML = "";
                document.getElementById('hidr').style.display = 'none';
                document.getElementById('<%=txtRazao.ClientID%>').value = '';
                //document.getElementById('teste2').style.display = 'block';

            }
        }

        //POVPA TABELA DE CONTRATO POR EMPRESA 
        function PopulateContrato(empresa) {

            var razao = empresa.split('||')[0];
            var cnpj = empresa.split('||')[1];
            document.getElementById('empresa').innerHTML = razao;

            document.getElementById('CNPJ').innerHTML = cnpj;
            document.getElementById('hidr').style.display = 'block';
            document.getElementById('teste2').style.display = 'block';
            document.getElementById('<%=txtRazao.ClientID %>').value = '';
            document.getElementById('<%=txtAquis.ClientID %>').value = '';
            document.getElementById('<%=txtDataApre.ClientID %>').value = '';
            document.getElementById('<%=txtDataFimOb.ClientID %>').value = '';
            document.getElementById('<%=txtDataInicioOb.ClientID %>').value = '';
            document.getElementById('<%=txtDataIniOp.ClientID %>').value = '';


            if ($('#<%=ddlDistritos.ClientID%>').val() == "0") {

                document.getElementById('teste2').style.display = 'none';
            }
            else {

                document.getElementById('teste2').style.display = 'block';

                $('#<%=cblTeste.ClientID%>').children("tr").remove();
                $.ajax({
                    type: "POST",
                    url: '<%=ResolveUrl("~/Service.asmx/PopulateLotesCont") %>',
                        data: "{'prefix': '" + cnpj + "$" + $('#<%=ddlDistritos.ClientID%>').val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnLotesPopulated,
                        failure: function (response) {
                            alert(response.d);
                        },
                        error: function (response) {
                            alert(response.d);
                        }
                    });

                    $.ajax({


                        url: '<%=ResolveUrl("~/Service.asmx/GetContrato") %>',
                    data: "{'prefix': '" + cnpj + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data5) {


                        var DADOS = data5.d.toString().split('()');
                        var hists = DADOS[0].split(',');
                        var lotes = DADOS[1].split(',');
                        //alert(props);

                        var txt2 = "";

                        if ($('#<%=hfPermissao.ClientID%>').val() == "0" || $('#<%=hfPermissao.ClientID%>').val() == "2") {
                            txt2 += "<tr><td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>Apresentação</td>"+
                                "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>Aquisição</td>" +
                                "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>Início de Operação</td>"+
                                "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '> Início de Obra</td> "+
                                "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>Fim de Obra</td>"+
                                "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '><div >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></td></tr>";
                        } else {
                            txt2 += "<tr><td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>Apresentação</td><td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>Aquisição</td><td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>Início de Operação</td><td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>Início de Obra</td><td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>Fim de Obra</td></tr>";

                        }


                        if (hists[0] != "Zero") {

                            document.getElementById('divHists').style.display = 'block';

                            var historico = "";

                            for (var x = 0; x < hists.length; x++) {

                                historico = hists[x].split('&&');
                                var lote2 = "";

                                var cont = 0;
                                for (var y = 0; y < lotes.length; y++) {


                                    var lote = lotes[y].split('&&');

                                    if (lote[2] == historico[5]) {
                                        if (cont == 0) {
                                            lote2 += lote[1];

                                        } else {
                                            lote2 += "," + lote[1];
                                        }
                                        cont++;

                                    }
                                }

                                y = 0;
                                if ($('#<%=hfPermissao.ClientID%>').val() == "0" || $('#<%=hfPermissao.ClientID%>').val() == "2") {
                                    txt2 += "<tr><td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[0].split(' ')[0] + "</td ><td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[1].split(' ')[0] +
                                         "</td ><td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[2].split(' ')[0] + "</td><td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[3].split(' ')[0] + "</td ><td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[4].split(' ')[0] +
                                         "</td ><td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '><div sytle='width:50px'><i title='editar' id='" + historico[0].split(' ')[0] + "#" + historico[1].split(' ')[0] + "#" + historico[2].split(' ')[0] + "#" + historico[3].split(' ')[0] + "#" + historico[4].split(' ')[0] + "#" + historico[5] + "#" + lote2 + "' style='margin-right:4px; cursor:pointer;' onclick='javascript:editContrato(this);' value='' class='fa fa-pencil-square-o'></i><span style='cursor:pointer;' title='deletar' id='" + historico[5] + "' onclick='javascript:removeContrato(this);' value='' class='glyphicon glyphicon-remove '></span></div></td></tr>";
                                } else {
                                    txt2 += "<tr><td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[0].split(' ')[0] + "</td ><td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[1].split(' ')[0] +
                                         "</td ><td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[2].split(' ')[0] + "</td><td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[3].split(' ')[0] + "</td ><td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" + historico[4].split(' ')[0] +
                                         "</td >";

                                }

                            }
                        }


                        else {
                            document.getElementById('divHists').style.display = 'none';
                        }
                        // alert(lote2);
                        // alert(txt2);
                        document.getElementById('contrato').innerHTML = txt2;

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

        /** EXCLUI CONTRATO *******************************************************************************************/
        function removeContrato(id) {
            //alert(id.id);
            if (confirm("Deseja excluir Contrato?")) {


                $.ajax({
                    url: '<%=ResolveUrl("~/Service.asmx/removeContrato") %>',
                    data: "{ 'prefix':'" + id.id + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data7) {

                        if (data7.d.toString() == "1") {
                            location.reload();
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
            else {

            }
        }
        /******************************************************************************************* EXCLUI CONTRATO **/
        /** LIMPAR CAMPOS  *******************************************************************************************/
        function LimpaCampos() {
            document.getElementById('<%=hfContratoPK.ClientID%>').value = '';
            document.getElementById('<%=txtDataApre.ClientID%>').value = '';
            document.getElementById('<%=txtAquis.ClientID%>').value = '';
            document.getElementById('<%=txtDataIniOp.ClientID%>').value = '';
            document.getElementById('<%=txtDataInicioOb.ClientID%>').value = '';
            document.getElementById('<%=txtDataFimOb.ClientID%>').value = '';





            $(".check").each(function () {

                $(this).prop("checked", false)

            });


            $('.update').fadeOut();
            $('#limpartudo').fadeOut();
            $('.cadastrar').fadeIn(3000);
        }
        /********************************************************************************************LIMPAR CAMPOS*/

        /**EDITAR CONTRATO***************************************************************************************/
        function editContrato(id) {

            $('.cadastrar').fadeOut();
            $('#limpartudo').fadeIn(3000);
            $('.update').fadeIn(3000);

            // var contrato = id.id.split('#');
            var dataapre = id.id.split('#')[0];
            var dataaqui = id.id.split('#')[1];
            var datainiop = id.id.split('#')[2];
            var datainicioob = id.id.split('#')[3];
            var datafimob = id.id.split('#')[4];
            var contratoPk = id.id.split('#')[5];
            var lotesPkarray = id.id.split('#')[6];
            var lotesPk = lotesPkarray.split(',');




            $(".check").each(function () {

                $(this).prop("checked", false)

            });

            counter = 0;
            while (counter < lotesPk.length) {

                $("#" + lotesPk[counter]).prop('checked', true);
                counter++;

            }

            document.getElementById('<%=hfContratoPK.ClientID%>').value = contratoPk;
                document.getElementById('<%=txtDataApre.ClientID%>').value = dataapre;
                document.getElementById('<%=txtAquis.ClientID%>').value = dataaqui;
                document.getElementById('<%=txtDataIniOp.ClientID%>').value = datainiop;
                document.getElementById('<%=txtDataInicioOb.ClientID%>').value = datainicioob;
            document.getElementById('<%=txtDataFimOb.ClientID%>').value = datafimob;
            document.getElementById('<%=hfLotes.ClientID%>').value = lotesPkarray;
            }

            /*************************************************************************************EDITAR CONTRATO********/


            /**CHAMAR FUNÇÃO PARA POVOA LOTES PASSANDO ID*********************************************/
            function OnLotesPopulated(response) {
                //PopulateControl(response.d,  "Lote");

                PopulateControl2(response.d, $(".<%=cblTeste.ClientID %>"));

            }
            /******************************************************************************CHAMAR FUNÇÃO PARA POVOA LOTES PASSANDO ID*/
            /**POVOA LOTES********************************************************************************************/
            function PopulateControl2(list, control) {


                if (list.length > 0) {
                    var cont = 0;
                    $.each(list, function (index, value) {
                        cont++;
                        var table = "";
                        if (cont == 1) {
                            $('#<%=cblTeste.ClientID %>').empty().append("<input class='check' type='checkbox' id=" + this['Value'] + " value=" + this['Value'] + " name=" + this['Text'] + ">" + "&nbsp;&nbsp;<label style ='position: relative; top: -3px;' for=" + this['Value'] + ">" + this['Text'] + "</label><br/>");
                        } else {
                            table = table + "<input class='check' type='checkbox' id=" + this['Value'] + " value=" + this['Value'] + " name=" + this['Text'] + ">" + "&nbsp;&nbsp;<label style ='position: relative; top: -3px;' for=" + this['Value'] + ">" + this['Text'] + "</label><br/>";
                        }

                        //var data = document.getElementById('cblTeste');
                        //var tr = document.createElement("tr");


                        table = table + "";

                        //data.appendChild(tr);
                        $(".cblTeste").append(table);
                        //$(".cblTeste").insertRow();

                    });

                }
                else {

                }



            }

            /***********************************************************************************************POVOA LOTES***/
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

    </script>
</asp:Content>




