<%@ Page  EnableEventValidation="false" Language="C#" AutoEventWireup="true" MasterPageFile="~/site.master" CodeBehind="historico.aspx.cs" Inherits="CODEMIG.historico" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="body">

    <div class="content">
        <%--<a href="linkdoc/JTB1/16-02/JTB1_16-02_DA-01.pdf" download>
            <button type="button" class="btn btn-primary btn-sm ">
                Download    
                            
            </button>
        </a>--%>

        <form autocomplete="off" runat="server" class="form-inline" style="width: 100%;" >
            
            <%-- DISTRITO --%>
            <div class="row" style="margin-bottom: 5px;">
                <div class="col-md-4 col-sm-3"></div>
                <div class="col-md-4 col-sm-6 form-group">
                    <asp:DropDownList Style="width: 100%" ID="ddlDistritos" class=" form-control input-sm " runat="server" AppendDataBoundItems="true" autofocus="true" onchange="onChangeDistrito();">
                        <asp:ListItem Text="Distrito" Value="0"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-4 col-sm-3"></div>
            </div>

            <%-- PROCESSO --%>
            <div class="row" style="margin-bottom: 5px;">
                <div class="col-md-4 col-sm-3 "></div>
                <div class="col-md-4 col-sm-6  form-group">
                    <asp:TextBox  Style="width: 100%" type="text" placeholder="Processo" class="form-control input-sm txtProcesso" ID="txtProcesso" runat="server" name="processo" disabled></asp:TextBox>
                </div>
                <div class="col-md-4 col-sm-3 "></div>
            </div>

            <%-- VOLUME --%>
            <div class="row" style="margin-bottom: 5px;">

                <div class="col-md-4 col-sm-3 "></div>
                <div class="col-md-4  col-sm-6  form-group">
                    <asp:DropDownList disabled Style="width: 100%" ID="ddlVolume" class=" form-control input-sm " runat="server" AppendDataBoundItems="true" onchange="PopulateLotes();">
                        <asp:ListItem Text="Volume" Value="0"></asp:ListItem>
                    </asp:DropDownList>

                </div>
                <div class="col-md-4 col-sm-3 "></div>

            </div>
            
            <div id="divDisplay" style="display: none;">

                <%-- GRID HISTÓRICOS --%>
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-4 col-sm-3 "></div>
                    <div class="col-md-4 col-sm-6  form-group" style="">
                        <div id="divHists" style="max-height: 200px; overflow-y: auto; display:none; border: 1px solid #cccccc; border-radius: 3px;">
                            <table style="min-width: 100%; " id="historicos">
                                <%-- TABELA GERADA JS ----%>
                            </table>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-3 "></div>
                </div>
                <%-- GRID HISTÓRICOS --%>

                <center>
                    <h4> 
                        <i style="font-size: 1.4em; margin:10px;" class  ="fa fa-object-ungroup" ></i>
                        <span style="color:#333333; position:relative; top:-5px;">
                            LOTES
                        </span>
                    </h4>
                </center>

                <%-- LOTES --%>
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-4 col-sm-3 "></div>
                    <div class="col-md-4 col-sm-6  form-group" style="">
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

                <div class="row" style="margin-bottom: 5px;">
                    <center>
                        <h4>
                            <label style="font-size: 1.4em;" class = "glyphicon glyphicon-info-sign"></label>
                            <span style="color:#333333; position:relative; top:-5px;">
                                INFORMAÇÕES
                            </span>
                        </h4>
                    </center>
                </div>

                <%-- DATA/OCORRÊNCIA--%>
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-4 col-sm-3 "></div>
                    <div class=" col-md-2  col-sm-3 form-group ">
                        <asp:TextBox Style="width: 100%" type="text" placeholder="Data" class=" date form-control input-sm" ID="txtData" runat="server" name="Data"></asp:TextBox>
                    </div>
                    <div class="col-md-2 col-sm-3  form-group">
                        <asp:DropDownList Style="width: 100%" class="form-control input-sm" ID="ddlOcorrencia" runat="server" onchange="onchangeOcorrencia()">
                            <asp:ListItem Value="0">Ocorrência</asp:ListItem>
                            <asp:ListItem Value="Contrato Particular de Promessa de Compra e Venda">Contrato Particular de Promessa de Compra e Venda</asp:ListItem>
                            <asp:ListItem Value="Termo de Anuência">Termo de Anuência</asp:ListItem>
                            <asp:ListItem Value="Escritura">Escritura</asp:ListItem>
                            <asp:ListItem Value="Registro">Registro</asp:ListItem>
                            <asp:ListItem Value="Termo de Cessão e Transferência">Termo de Cessão e Transferência</asp:ListItem>
                            <asp:ListItem Value="Notificação">Notificação</asp:ListItem>
                            <asp:ListItem Value="Alvará de Construção">Alvará de Construção</asp:ListItem>
                            <asp:ListItem Value="Ação de Rescisão">Ação de Rescisão</asp:ListItem>
                            <asp:ListItem Value="Decisão da Ação de Rescisão">Decisão da Ação de Rescisão</asp:ListItem>
                            <asp:ListItem Value="Laudo de Vistoria Técnica">Laudo de Vistoria Técnica</asp:ListItem>
                            <asp:ListItem Value="Outro">Outro</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox Style="width: 100%; display: none; margin-top: 2px;" type="text" placeholder="Ocorrência" class="form-control input-sm txtOcorrencia" ID="txtOcorrencia" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-4 col-sm-3 "></div>
                </div>

                <%-- DE/PARA --%>
                <div class="row" style="margin-bottom: 5px;">
                    <div class="col-md-4 col-sm-3 "></div>
                    <div class="col-md-2 col-sm-3  form-group">
                        <asp:TextBox Style="width: 100%" type="text" placeholder="De" class="form-control input-sm" ID="txtDe" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-2 col-sm-3  form-group">
                        <asp:TextBox Style="width: 100%" type="text" placeholder="Para" class="form-control input-sm" ID="txtPara" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-4 col-sm-3 "></div>
                </div>

                <%-- OBS/PAGINA --%>
                <div class="row" style="margin-bottom: 10px;">
                    <div class="col-md-4 col-sm-3 "></div>
                    <div class=" col-md-3 col-sm-4  form-group ">
                        <asp:TextBox ID="txtObs" Rows="5" Width="100%" placeholder="Observação" class="form-control input-sm" runat="server" />
                    </div>
                    <div class=" col-md-1 col-sm-2  form-group ">
                        <asp:TextBox ID="txtPagina" Rows="5" Width="100%" placeholder="Página" class="form-control input-sm pagina" runat="server" />
                    </div>
                    <div class="col-md-4 col-sm-3 "></div>
                </div>

                <%-- LIMPAR/ATUALIZAR/CADASTRAR --%>
                <div class="row">
                    <div class="col-md-4 col-sm-3 "></div>
                    <div class="col-md-3 col-sm-4  form-group">
                        <span title='Apagar campos' id="limpartudo" onclick='javascript:LimpaCampos();' class='glyphicon glyphicon-erase' style="cursor:pointer; font-size: 1.4em; display: none;"></span>
                    </div>
                    <div class="col-md-1 col-sm-2  form-group">
                        <asp:LinkButton runat="server" OnClick="bntCadastrar_Click" type="button" class="btn btn-primary btn-sm pull-right cadastrar" Style="width:100%;" disabled>
                            <center>
                                Cadastrar
                            </center>
                        </asp:LinkButton>
                        <asp:LinkButton runat="server" OnClick="bntUpdate_Click" type="button" class="btn btn-primary btn-sm pull-right update" Style="width:100%; display: none">
                            <center>
                                Atualizar
                            </center>
                        </asp:LinkButton>
                    </div>
                    <div class="col-md-4 col-sm-3 "></div>
                </div>

            </div>
             <asp:HiddenField ID="hfLoginPK" runat="server" Value="" />
            <asp:HiddenField ID="hfHistoricoPK" runat="server" Value="" />
            <asp:HiddenField ID="hfPermissao" runat="server" Value="" />
            <asp:HiddenField ID="hfVolumePK" runat="server" Value="" />
            <asp:HiddenField ID="hfLotes" runat="server" Value="" />
            <asp:HiddenField ID="hfSelectedVolume" runat="server" Value="" />
           
            <input type="hidden" id="_ispostback" value="<%=Page.IsPostBack.ToString()%>" />

        </form>

    </div>

    <br />
    <br />
    <br />

    <script type="text/javascript">

        function isPostBack() { //function to check if page is a postback-ed one
            return document.getElementById('_ispostback').value;
        }

        $(document).ready(function () {

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

                if (cont != 0 && document.getElementById('<%=ddlOcorrencia.ClientID %>').value != '0') {
                    $('.cadastrar').removeAttr("disabled");
                    $('.update').removeAttr("disabled");
                } else {
                    $('.cadastrar').attr("disabled", "disabled");
                    $('.update').attr("disabled", "disabled");
                }

                document.getElementById('<%=hfLotes.ClientID %>').value = lotesPK;





            });

            

            $(".date").mask("00/00/0000", { clearIfNotMatch: true });
            $(".pagina").mask("00000000000000");

            if (isPostBack() == 'True') {

                

                if ($('#<%=ddlDistritos.ClientID%>').val() != "0") {
                    $('.txtProcesso').removeAttr("disabled", "disabled");
                } else {
                    $('.txtProcesso').attr("disabled", "disabled");
                }
                
                populateVolumes($('#<%=txtProcesso.ClientID%>').val());
                
                setTimeout(function () {
                    PopulateLotes();
                    
                }, 250);

            }


            /** POPULATE PROCESSO *****************************************************************************************/
            $("#<%=txtProcesso.ClientID %>").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: '<%=ResolveUrl("~/Service.asmx/GetDistritos") %>',
                        data: "{ 'prefix': '" + request.term + "', 'distrito': '" + $('#<%=ddlDistritos.ClientID%>').val() + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",

                        success: function (data) {
                            var parsed = $.parseJSON(data.d);
                            var processos = [];
                            $.each(parsed, function (i, jsondata) {

                                processos.push(
                                    jsondata.COD_CLI
                                )
                            })

                            response($.map(processos, function (item) {
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
                    
                    document.getElementById('divDisplay').style.display = 'none';
                    $('.update').fadeOut();
                    $('#limpartudo').fadeOut();
                    $('.cadastrar').fadeIn();

                    if ($('#<%=ddlDistritos.ClientID%>').val() == "0") {

                        $('#<%=ddlVolume.ClientID %>').empty().append('<option value="0">Volume</option>');
                        document.getElementById('divDisplay').style.display = 'none';

                    }
                    else {

                        populateVolumes(i.item.label)

                        

                    }

                },
                minLength: 1
            });
        });

        $.ajax({
            type: "POST",
            url: '<%=ResolveUrl("~/Service.asmx/PopulateVolumes") %>',
                            data: "{'prefix': '" + i.item.label + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data2) {
                                var parsed2 = $.parseJSON(data2.d);
                                $("#<%=ddlVolume.ClientID %>").attr("disabled", "disabled");
                                $("#<%=ddlVolume.ClientID %>").empty().append('<option selected="selected" value="0">Não disponível<option>');
                                var cont = 0;
                                $.each(parsed2, function (i, jsondata) {
                                    if (cont == 0) {
                                        $("#<%=ddlVolume.ClientID %>").removeAttr("disabled")
                                        $("#<%=ddlVolume.ClientID %>").empty().append('<option  value="0">Volume</option>')
                                    }
                                    $("#<%=ddlVolume.ClientID %>").append($("<option></option>").val(jsondata.COD_VOLUME_PK).html(jsondata.COD_VOLUME_CODEMIG).attr("id", jsondata.COD_VOLUME_PK));
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

        function populateVolumes(processo) {

            $.ajax({
                type: "POST",
                url: '<%=ResolveUrl("~/Service.asmx/PopulateVolumes") %>',
                data: "{'prefix': '" + processo + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data2) {
                    var parsed2 = $.parseJSON(data2.d);
                    $("#<%=ddlVolume.ClientID %>").attr("disabled", "disabled");
                    $("#<%=ddlVolume.ClientID %>").empty().append('<option selected="selected" value="0">Não disponível<option>');
                    var cont = 0;
                    $.each(parsed2, function (i, jsondata) {
                        if (cont == 0) {
                            $("#<%=ddlVolume.ClientID %>").removeAttr("disabled")
                            $("#<%=ddlVolume.ClientID %>").empty().append('<option  value="0">Volume</option>')
                        }
                        $("#<%=ddlVolume.ClientID %>").append($("<option></option>").val(jsondata.COD_VOLUME_PK).html(jsondata.COD_VOLUME_CODEMIG).attr("id", jsondata.COD_VOLUME_PK));
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

        function onChangeDistrito() {
            document.getElementById('divDisplay').style.display = 'none';

            $('.update').fadeOut();
            $('#limpartudo').fadeOut();
            $('.cadastrar').fadeIn();

            if ($('#<%=ddlDistritos.ClientID%>').val() != "0") {
                $('.txtProcesso').removeAttr("disabled", "disabled");
            } else {
                $('.txtProcesso').attr("disabled", "disabled");
            }
        }

        $("#<%=ddlVolume.ClientID %>").change(function () {
            volume = $(this).val();
            document.getElementById('<%=hfVolumePK.ClientID %>').value = volume;
        });

        function onchangeOcorrencia() {
            
            $('.cadastrar').attr("disabled", "disabled");
            $('.update').attr("disabled", "disabled");

            if ($('#<%=ddlOcorrencia.ClientID%>').val() != "0") {
                $(".check").each(function () {

                    if ($(this).prop("checked")) {

                        $('.cadastrar').removeAttr("disabled");
                        $('.update').removeAttr("disabled");
                        
                        return;
                    }
                });
            }


            if ($('#<%=ddlOcorrencia.ClientID%>').val() == "Outro") {
                document.getElementById('<%=txtOcorrencia.ClientID %>').style.display = 'block';
            } else {
                document.getElementById('<%=txtOcorrencia.ClientID %>').style.display = 'none';
            }
        }

        
        /******************************************************************************************* POPULATE VOLUMES **/
        jQuery(function ($) {
            

            
            /** LOTES **/

        });


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

            if (cont != 0 && document.getElementById('<%=ddlOcorrencia.ClientID %>').value != '0') {
                $('.cadastrar').removeAttr("disabled");
                $('.update').removeAttr("disabled");
            } else {
                $('.cadastrar').attr("disabled", "disabled");
                $('.update').attr("disabled", "disabled");
            }

            document.getElementById('<%=hfLotes.ClientID %>').value = lotesPK;

        }

        /** POPULATE LOTES **/
        function PopulateLotes() {
           
            document.getElementById('<%=hfSelectedVolume.ClientID%>').value = document.getElementById('<%=ddlVolume.ClientID%>').value;
            
            document.getElementById('<%=txtDe.ClientID %>').value = '';
            document.getElementById('<%=txtPara.ClientID %>').value = '';
            document.getElementById('<%=txtData.ClientID %>').value = '';
            document.getElementById('<%=ddlOcorrencia.ClientID %>').value = '0';
            document.getElementById('<%=txtOcorrencia.ClientID %>').value = '';
            document.getElementById('<%=txtObs.ClientID %>').value = '';
            document.getElementById('<%=txtPagina.ClientID %>').value = '';

            if ($('#<%=ddlVolume.ClientID%>').val() == "0") {
                document.getElementById('divDisplay').style.display = 'none';
            }
            else {

                document.getElementById('divDisplay').style.display = 'block';

                $('#<%=cblLotes.ClientID%>').children("tr").remove();
                
                $.ajax({
                    type: "POST",
                    url: '<%=ResolveUrl("~/Service.asmx/PopulateLotes") %>',
                    data: "{ 'processo': '" + $('#<%=txtProcesso.ClientID%>').val() + "', 'distrito': '" + $('#<%=ddlDistritos.ClientID%>').val() + "'}",
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

                $.ajax({

                    url: '<%=ResolveUrl("~/Service.asmx/GetHistorico") %>',
                    data: "{'prefix': '" + $('#<%=ddlVolume.ClientID%>').val() + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data5) {
                        document.getElementById('divHists').style.display = 'none';
                        document.getElementById('historicos').innerHTML = '';
                        var parsed2 = $.parseJSON(data5.d);
                        var cont = 0;
                        var txt2 = "";
                        var date = "";
                        $.each(parsed2, function (i, jsondata) {

                            if (jsondata.DATA != null && jsondata.DATA != "") {
                                date = new Date(parseInt(jsondata.DATA.substr(6)))
                                var json = JSON.stringify(date).split("T")[0].split("-")

                                dataHist = json[2] + "/" + json[1] + "/" + json[0].replace('"', '')

                            }
                            else {
                                dataHist = "";
                            }

                            

                            if (jsondata.PAGINA == null)
                                pagina = ''
                            else
                                pagina = jsondata.PAGINA

                            if (cont == 0) {

                                txt2 += "<tr>" +
                                    "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" +
                                    "De" +
                                    "</td>" +
                                    "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" +
                                    "Para" +
                                    "</td>" +
                                    "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" +
                                    "Data" +
                                    "</td>" +
                                    "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" +
                                    "Tipo" +
                                    "</td>" +
                                    "<td style='white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>" +
                                    "Página" +
                                    "</td>" +
                                    "<td style='padding-left: 10px; padding-right: 10px;  border-bottom: 1px solid #cccccc;'>" +
                                    "<i class='fa fa-gear'></i>" +
                                    "</td>" +
                                    "</tr>";
                                

                                txt2 += '<tr><td style="white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; ">' + jsondata.DE + '</td ><td style="white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; ">' + jsondata.PARA +
                                   '</td ><td style="white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; ">' + dataHist + '</td ><td style="white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; ">' + jsondata.TIPO_OCORRENCIA +
                                   '</td ><td style="white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; ">' + pagina + '</td >' +
                                   '<td style="padding-left: 10px; padding-right: 10px;  border-bottom: 1px solid #cccccc;"><div style="width:40px;"><i title="editar"  style="cursor:pointer;margin-right:4px;" onclick="javascript:editHist(' + jsondata.COD_HISTORICO_PK + ',\'' + jsondata.DE + '\'' + ',\'' + jsondata.PARA + '\'' + ',\'' + jsondata.DATA + '\'' + ',\'' + jsondata.TIPO_OCORRENCIA + '\'' + ',' + jsondata.PAGINA + ',\'' + jsondata.OBSERVECAO + '\');" class="fa fa-pencil-square-o"></i><span style="cursor:pointer;" title="deletar" onclick="javascript:removeHistorico(' + jsondata.COD_HISTORICO_PK + ');" class="glyphicon glyphicon-remove "></span></di></td></tr>';

                            } else 
                                txt2 += '<tr><td style="white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; ">' + jsondata.DE + '</td ><td style="white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; ">' + jsondata.PARA +
                                    '</td ><td style="white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; ">' + dataHist + '</td ><td style="white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; ">' + jsondata.TIPO_OCORRENCIA +
                                    '</td ><td style="white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; ">' + pagina + '</td >' +
                                    '<td style="padding-left: 10px; padding-right: 10px;  border-bottom: 1px solid #cccccc;"><div style="width:40px;"><i title="editar"  style="cursor:pointer;margin-right:4px;" onclick="javascript:editHist(' + jsondata.COD_HISTORICO_PK + ',\'' + jsondata.DE + '\'' + ',\'' + jsondata.PARA + '\'' + ',\'' + jsondata.DATA + '\'' + ',\'' + jsondata.TIPO_OCORRENCIA + '\'' + ',' + jsondata.PAGINA + ',\'' + jsondata.OBSERVECAO + '\');" class="fa fa-pencil-square-o"></i><span style="cursor:pointer;" title="deletar" onclick="javascript:removeHistorico(' + jsondata.COD_HISTORICO_PK + ');" class="glyphicon glyphicon-remove "></span></di></td></tr>';

                            cont++;
                        
                        });
                        document.getElementById('divHists').style.display = 'block';
                        document.getElementById('historicos').innerHTML = txt2;
                        
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

        /** EXCLUI HISTÓRICO **/
        function removeHistorico(historicoPK) {

            if (confirm("Deseja excluir Historico?")) {

                $.ajax({
                    url: '<%=ResolveUrl("~/Service.asmx/removeHistorico") %>',
                    data: "{ 'prefix':'" + historicoPK + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data7) {

                        if (data7.d.toString() == "1") {
                            //location.reload();
                            PopulateLotes();
                            $('.update').fadeOut();
                            $('#limpartudo').fadeOut();
                            $('.cadastrar').fadeIn();
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
        /** EXCLUI HISTÓRICO **/

        /** LIMPAR CAMPOS  ********************************************************************************************/
        function LimpaCampos() {

            document.getElementById('<%=txtData.ClientID%>').value = '';
                document.getElementById('<%=txtDe.ClientID%>').value = '';
                document.getElementById('<%=txtPara.ClientID%>').value = '';
                document.getElementById('<%=ddlOcorrencia.ClientID %>').value = '0';
                document.getElementById('<%=txtObs.ClientID%>').value = '';
                document.getElementById('<%=txtPagina.ClientID%>').value = '';

                $(".check").each(function () {

                    $(this).prop("checked", false)

                });

                $('.update').fadeOut();
                $('#limpartudo').fadeOut();
                $('.cadastrar').fadeIn(3000);
                document.getElementById('<%=txtOcorrencia.ClientID %>').style.display = 'none';
        }
        /** LIMPAR CAMPOS **/

        /** EDITA HISTÓRICO **/
        function editHist(historicoPK, de, para, data, tipo, pag, obs) {
            
            $.ajax({
                type: "POST",
                url: '<%=ResolveUrl("~/Service.asmx/GetLotesHistorico") %>',
                data: "{ 'prefix': '" + historicoPK + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var parsed = $.parseJSON(data.d);
                    var lotesPK = [];
                    $.each(parsed, function (i, jsondata) {
                        lotesPK.push(jsondata.COD_LOTE_FK)
                    });
                    $('.cadastrar').fadeOut();
                    $('.update').fadeIn(3000);
                    $('#limpartudo').fadeIn(3000);


                    

                    counter = 0;
                    while (counter < lotesPK.length) {
                        $("#" + lotesPK[counter]).prop('checked', true);
                        counter++;

                    }

                    document.getElementById('<%=txtDe.ClientID %>').value = de;
                    document.getElementById('<%=txtPara.ClientID %>').value = para;
                    document.getElementById('<%=txtData.ClientID %>').value = dataHist;

                    if (tipo.indexOf("Outro") > -1) {
                        $("#<%= ddlOcorrencia.ClientID %>").val("Outro");
                        document.getElementById('<%=txtOcorrencia.ClientID %>').style.display = 'block';
                        tipo = tipo.substr(6);
                        tipo = tipo.slice(0, -1);
                        document.getElementById('<%=txtOcorrencia.ClientID %>').value = tipo;
                        //alert(tipo);
                    } else {
                        document.getElementById('<%=txtOcorrencia.ClientID %>').style.display = 'none';
                        $("#<%= ddlOcorrencia.ClientID %>").val(tipo);
                    }


                    document.getElementById('<%=txtObs.ClientID %>').value = obs;
                    document.getElementById('<%=hfHistoricoPK.ClientID %>').value = historicoPK;

                    if (pag == null) 
                        document.getElementById('<%=txtPagina.ClientID %>').value = '';
                    else
                        document.getElementById('<%=txtPagina.ClientID %>').value = pag;

                    document.getElementById('<%=hfLotes.ClientID %>').value = lotesPK;

                },
                error: function (XHR, errStatus, errorThrown) {
                    var err = JSON.parse(XHR.responseText);
                    errorMessage = err.Message;
                    alert(errorMessage);
                }
            });


            
        }
        /******************************************************************************************* EDITA HISTÓRICO **/

        /** FUNÇÕES CONTROLE USUÁRIO **********************************************************************************/
        var activePage = true;

        if (localStorage.getItem('Tempo') == null) {
            var tempo = '<% = Session["Tempo"]%>';

        }
        else {
            var tempo = localStorage.getItem('Tempo');
        }

        function showInformation() {

            tempo = parseInt(tempo.toString());


            if (activePage) {

                tempo = tempo + 1;
                localStorage.setItem('Tempo', tempo);


                if ('<%=Session["webuser"]%>' != 'CODEMIG.Classes.StringData') {

                    window.location.href = "login.aspx";
                }


            } else {

                localStorage.setItem('teste', 't');
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
        /** FUNÇÕES CONTROLE USUÁRIO **/

    </script>

</asp:Content>



