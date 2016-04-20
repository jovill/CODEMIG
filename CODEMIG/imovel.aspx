<%@ Page EnableEventValidation= "false" Language="C#" AutoEventWireup="true" MasterPageFile="~/site.master" CodeBehind="imovel.aspx.cs" Inherits="CODEMIG.imovel" %>



<asp:Content runat="server" ContentPlaceHolderID="head">
    <script type="text/javascript" src="bootstrap/js/bootstrap-filestyle.min.js"> </script>
    <script type="text/javascript">
        function alerta(codimovel) {
           
           
            $('#<%=ddlMuni.ClientID%>').val($('#<%=SearchCidade.ClientID%>').val())
            $('#<%=txtPatrimonio.ClientID%>').val($('#<%=txtNPatrimonio.ClientID%>').val())
            $('#<%=hfImovelPK.ClientID%>').val(codimovel)
           
                  
                   

            $('#showCadastroPastas').removeAttr("disabled");
            $('#showCadastroDCartoriais').removeAttr("disabled");
            $('#showCadastroTributos').removeAttr("disabled");
            $('#showCadastroContratos').removeAttr("disabled");


           

            $('.cadastroInfo').fadeOut();
            $('.updateInfo').fadeIn(1000);
            $('#limpartudo').fadeIn(1000);
            $('.deleteImovel').fadeIn(1000);
            //INFORMAÇÕES
            $.ajax({
                url: '<%=ResolveUrl("~/Service.asmx/GetDadosImovel") %>',
                data: "{ 'prefix': '" + $('#<%=txtNPatrimonio.ClientID%>').val() + "', 'municipio': '" + $('#<%=SearchCidade.ClientID%>').val() + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    var parsed = $.parseJSON(data.d);
                    var txt = "";
                    $.each(parsed, function (i, jsondata) {
                        var parsed = $.parseJSON(data.d);
                        var txt = "";
                        

                        document.getElementById('municipio').innerHTML = jsondata.CIDADE
                        document.getElementById('patrimonio').innerHTML = jsondata.NUM_PATRIMONIO
                        document.getElementById('info').style.display = 'block';
                        //////define qual permissao diferente de 1 é admin e master

                        if ($('#<%=hfPermissao.ClientID%>').val() == 1) {
                            PERMISSAO = false
                        } else {
                            PERMISSAO = true
                        }
                        ////setando valores e bloqueando campos para usuario caso o mesmo exista.

                        if (jsondata.NUM_PATRIMONIO != "" && jsondata.NUM_PATRIMONIO != null) {
                            $("#<%=txtNPatrimonio.ClientID %>").val(jsondata.NUM_PATRIMONIO);
                            if (!PERMISSAO) $('#<%=txtNPatrimonio.ClientID %>').prop('disabled', true)
                        }

                        if (jsondata.DENOMINACAO != "" && jsondata.DENOMINACAO != null) {
                            $("#<%=txtDenominacao.ClientID %>").val(jsondata.DENOMINACAO);
                            if (!PERMISSAO) $('#<%=txtDenominacao.ClientID %>').prop('disabled', true)

                        }

                        if (jsondata.UNIDADE_AREA != "" && jsondata.UNIDADE_AREA != null)
                            $("#<%=ddlTipoMedida.ClientID %>").val(jsondata.UNIDADE_AREA);
                        if (!PERMISSAO) $('#<%=ddlTipoMedida.ClientID %>').prop('disabled', true)

                        if (jsondata.AREA_IMOVEL != "" && jsondata.AREA_IMOVEL != null) {
                            $("#<%=txtArea.ClientID %>").val(jsondata.AREA_IMOVEL);
                            if (!PERMISSAO) $('#<%=txtArea.ClientID %>').prop('disabled', true)

                        }

                        if (jsondata.SITUACAO_IMOVEL != "" && jsondata.SITUACAO_IMOVEL != null) {
                            $("#<%=txtSituacao.ClientID %>").val(jsondata.SITUACAO_IMOVEL);
                            if (!PERMISSAO) $('#<%=txtSituacao.ClientID %>').prop('disabled', true)
                        }

                        if (jsondata.OBSERVACAO != "" && jsondata.OBSERVACAO != null) {
                            $("#<%=txtObservacao.ClientID %>").val(jsondata.OBSERVACAO);
                            if (!PERMISSAO) $('#<%=txtObservacao.ClientID %>').prop('disabled', true)

                        }


                        if (jsondata.VALOR_TERRENO != "" && jsondata.VALOR_TERRENO != null) {
                            $("#<%=txtValorTerreno.ClientID %>").val(jsondata.VALOR_TERRENO);
                            if (!PERMISSAO) $('#<%=txtValorTerreno.ClientID %>').prop('disabled', true)
                        }

                        if (jsondata.VALOR_AREA_CONSTRUIDA != "" && jsondata.VALOR_AREA_CONSTRUIDA != null) {
                            $("#<%=txtVAConstruida.ClientID %>").val(jsondata.VALOR_AREA_CONSTRUIDA);
                            if (!PERMISSAO) $('#<%=txtVAConstruida.ClientID %>').prop('disabled', true)

                        }

                        if (jsondata.VALOR_AVALIACAO != "" && jsondata.VALOR_AVALIACAO != null) {
                            $("#<%=txtVAvaliado.ClientID %>").val(jsondata.VALOR_AVALIACAO);
                            if (!PERMISSAO) $('#<%=txtVAvaliado.ClientID %>').prop('disabled', true)

                        }


                        if (jsondata.DATA_AVALIACAO != "" && jsondata.DATA_AVALIACAO != null) {
                            date = new Date(parseInt(jsondata.DATA_AVALIACAO.substr(6)))
                            var jsonDataAvaliacao = JSON.stringify(date).split("T")[0].split("-")
                            dataAvaliacao = jsonDataAvaliacao[2] + "/" + jsonDataAvaliacao[1] + "/" + jsonDataAvaliacao[0].replace('"', '')

                            $("#<%=txtDAvaliacao.ClientID %>").val(dataAvaliacao);
                            if (!PERMISSAO) $('#<%=txtDAvaliacao.ClientID %>').prop('disabled', true)

                        }

                        if (jsondata.TIPO_IMOVEL != "" && jsondata.TIPO_IMOVEL != null) {
                            if (jsondata.TIPO_IMOVEL == "Urbano") {
                                $("#<%=rdoButtonRural.ClientID %>").attr('checked', false);
                                $("#<%=rdoButtonUrbano.ClientID %>").attr('checked', true);
                            }
                            else {
                                $("#<%=rdoButtonUrbano.ClientID %>").attr('checked', false);
                                $("#<%=rdoButtonRural.ClientID %>").attr('checked', true);

                            }
                            if (!PERMISSAO) $('#<%=rdoButtonUrbano.ClientID %>').prop('disabled', true)
                            if (!PERMISSAO) $('#<%=rdoButtonRural.ClientID %>').prop('disabled', true)
                        }

                        ////setando valores de endereco

                        if (jsondata.SHAPE != "" && jsondata.SHAPE != null) {
                            $("#<%=hfLat.ClientID %>").val(jsondata.SHAPE.split('(')[1].split(' ')[0]);
                            $("#<%=hfLng.ClientID %>").val(jsondata.SHAPE.split('(')[1].split(' ')[1].split(')')[0]);
                            geocode2();

                        }

                        if (!PERMISSAO) $('#<%=numeroTxt.ClientID %>').prop('disabled', true)


                        if (jsondata.NUMERO != "" && jsondata.NUMERO != null)
                            $("#<%=numeroTxt.ClientID %>").val(jsondata.NUMERO);
                        if (!PERMISSAO) $('#<%=numeroTxt.ClientID %>').prop('disabled', true)


                        if (jsondata.NOME_LOGRADOURO != "" && jsondata.NOME_LOGRADOURO != null)
                            $("#<%=txtNRua.ClientID %>").val(jsondata.NOME_LOGRADOURO);
                        if (!PERMISSAO) $('#<%=txtNRua.ClientID %>').prop('disabled', true)

                        if (jsondata.BAIRRO != "" && jsondata.BAIRRO != null)
                            $("#<%=txtBairro.ClientID %>").val(jsondata.BAIRRO);
                        if (!PERMISSAO) $('#<%=txtBairro.ClientID %>').prop('disabled', true)

                        if (jsondata.CIDADE != "" && jsondata.CIDADE != null)
                            $("#<%=SearchCidade.ClientID %>").val(jsondata.CIDADE);
                        if (!PERMISSAO) $('#<%=SearchCidade.ClientID %>').prop('disabled', true)

                        if (jsondata.ESTADO != "" && jsondata.ESTADO != null)
                            $("#<%=ddlEstados.ClientID %>").val(jsondata.ESTADO);
                        if (!PERMISSAO) $('#<%=ddlEstados.ClientID %>').prop('disabled', true)

                        if (jsondata.TIPO_LOGRADOURO != "" && jsondata.TIPO_LOGRADOURO != null)
                            $("#<%=ddlTipo.ClientID %>").val(jsondata.TIPO_LOGRADOURO);
                        if (!PERMISSAO) $('#<%=ddlTipo.ClientID %>').prop('disabled', true)

                        if (jsondata.CEP != "" && jsondata.CEP != null)
                            $("#<%=txtCEP.ClientID %>").val(jsondata.CEP);
                        if (!PERMISSAO) $('#<%=txtCEP.ClientID %>').prop('disabled', true)

                        if (jsondata.COMPLEMENTO != "" && jsondata.COMPLEMENTO != null)
                            $("#<%=txtComplemento.ClientID %>").val(jsondata.COMPLEMENTO);
                        if (!PERMISSAO) $('#<%=txtComplemento.ClientID %>').prop('disabled', true)



                    })

                    initMap();

                },
                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });

            //PASTAS
           
             $.ajax({
                url: '<%=ResolveUrl("~/Service.asmx/GetPastasGrid") %>',
                data: "{ 'imovelPK': '" + codimovel + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    var parsed = $.parseJSON(data.d);
                    var txt = "";
                    $.each(parsed, function (i, jsondata) {
                        txt += '<span id="' + jsondata.COD_PASTA_CODEMIG + '" style="padding-right:2px; padding-left:2px; margin-right: 5px; border: 1px solid #cccccc; border-radius: 2px;">' + jsondata.COD_PASTA_CODEMIG + ' &nbsp;<span style=" padding-bottom:1px; " class="glyphicon glyphicon-remove"  onclick="javascript:removePasta(' + jsondata.COD_PASTA_PK + ', ' + $('#<%=hfImovelPK.ClientID%>').val() + ')" id="' + jsondata.COD_PASTA_PK + '"></span></span>';
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
          
            //DADOS CARTORIAIS
            
            $.ajax({
                url: '<%=ResolveUrl("~/Service.asmx/GetDadosCartoriais") %>',
                data: "{ 'imovelPK': '" + codimovel + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var parsed = $.parseJSON(data.d);
                    var cont = 0;
                    var txt = "";
                    $.each(parsed, function (i, jsondata) {
                        if (cont == 0) {
                            txt += "<tr> "
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Matrícula "
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Comarca "
                                + "</td>"
                                + "<td style='padding-left: 10px; padding-right: 10px; border-bottom: 1px solid #cccccc;'> "
                                + "   <center><i class='fa fa-gear'></i></center> "
                                + "</td> "
                                + "</tr> ";
                            txt += '<tr>'
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; '>"
                                + jsondata.NUM_MATRICULA
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;' >"
                                + jsondata.COMARCA
                                + "</td>"
                                + "<td style=''>"
                                + '<center><i title="editar"  style="cursor:pointer;margin-right:4px;" onclick="javascript:editDCartoriais(' + jsondata.COD_MATRICULA_PK + ',\'' + jsondata.NUM_MATRICULA + '\'' + ',\'' + jsondata.COMARCA + '\');" class="fa fa-pencil-square-o"></i><span style="cursor:pointer;" title="deletar" onclick="javascript:removeDCartoriais(' + jsondata.COD_MATRICULA_PK + ');" class="glyphicon glyphicon-remove "></span></center>'
                                + "</td>"
                                + "</tr>";

                        } else {
                            txt += '<tr>'
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; '>"
                                + jsondata.NUM_MATRICULA
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; ' >"
                                + jsondata.COMARCA
                                + "</td>"
                                + "<td style=''>"
                                + '<center><i title="editar"  style="cursor:pointer;margin-right:4px;" onclick="javascript:editDCartoriais(' + jsondata.COD_MATRICULA_PK + ',\'' + jsondata.NUM_MATRICULA + '\'' + ',\'' + jsondata.COMARCA + '\');" class="fa fa-pencil-square-o"></i><span style="cursor:pointer;" title="deletar" onclick="javascript:removeDCartoriais(' + jsondata.COD_MATRICULA_PK + ');" class="glyphicon glyphicon-remove "></span></center>'
                                + "</td>"
                                + "</tr>";
                        }
                        cont++;

                    })
                    document.getElementById('tableDCartoriais').innerHTML = txt;

                },
                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });

            //TRIBUTOS BANCO
            
            $.ajax({
                url: '<%=ResolveUrl("~/Service.asmx/GetTributos") %>',
                data: "{ 'imovelPK': '" + codimovel + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var parsed = $.parseJSON(data.d);
                    var cont = 0;
                    var txt = "";
                    $.each(parsed, function (i, jsondata) {
                        if (cont == 0) {
                            txt += "<tr> "
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Tipo "
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Certidão Negativa "
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Ano "
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Valor "
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Código "
                                + "</td>"
                                + "<td style='padding-left: 10px; padding-right: 10px; border-bottom: 1px solid #cccccc;'> "
                                + "   <center><i class='fa fa-gear'></i></center> "
                                + "</td> "
                                + "</tr> ";
                            txt += '<tr>'
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; '>"
                                + jsondata.TIPO_TRIBUTO
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; '>"
                                + jsondata.CERTIDAO_NEGATIVA
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;' >"
                                + jsondata.ANO_PAGAMENTO
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;' >"
                                + jsondata.VALOR_PAGO
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;' >"
                                + jsondata.COD_TRIBUTO
                                + "</td>"
                                + "<td style=''>"
                                + '<center><i title="editar"  style="cursor:pointer;margin-right:4px;" onclick="javascript:editTributo(' + jsondata.COD_TRIBUTO_PK + ',\'' + jsondata.TIPO_TRIBUTO + '\'' + ',\'' + jsondata.CERTIDAO_NEGATIVA + '\'' + ',' + jsondata.ANO_PAGAMENTO + ',' + jsondata.VALOR_PAGO + ',\'' + jsondata.COD_TRIBUTO + '\');" class="fa fa-pencil-square-o"></i><span style="cursor:pointer;" title="deletar" onclick="javascript:removeTributo(' + jsondata.COD_TRIBUTO_PK + ');" class="glyphicon glyphicon-remove "></span></center>'
                                + "</td>"
                                + "</tr>";

                        } else {
                            txt += '<tr>'
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; '>"
                                + jsondata.TIPO_TRIBUTO
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; '>"
                                + jsondata.CERTIDAO_NEGATIVA
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;' >"
                                + jsondata.ANO_PAGAMENTO
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;' >"
                                + jsondata.VALOR_PAGO
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;' >"
                                + jsondata.COD_TRIBUTO
                                + "</td>"
                                + "<td style=''>"
                                + '<center><i title="editar"  style="cursor:pointer;margin-right:4px;" onclick="javascript:editTributo(' + jsondata.COD_TRIBUTO_PK + ',\'' + jsondata.TIPO_TRIBUTO + '\'' + ',\'' + jsondata.CERTIDAO_NEGATIVA + '\'' + ',' + jsondata.ANO_PAGAMENTO + ',' + jsondata.VALOR_PAGO + ',\'' + jsondata.COD_TRIBUTO + '\');" class="fa fa-pencil-square-o"></i><span style="cursor:pointer;" title="deletar" onclick="javascript:removeTributo(' + jsondata.COD_TRIBUTO_PK + ');" class="glyphicon glyphicon-remove "></span></center>'
                                + "</td>"
                                + "</tr>";
                        }
                        cont++;

                    })
                    document.getElementById('tableTributos').innerHTML = txt;

                },
                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });

            //CONTRATO
           
            $.ajax({
                url: '<%=ResolveUrl("~/Service.asmx/GetContratosGrid") %>',
                data: "{ 'imovelPK': '" + codimovel + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    var parsed = $.parseJSON(data.d);
                    var txt = "";
                    var cont = 0;

                    $.each(parsed, function (i, jsondata) {

                        /*date = new Date(parseInt(jsondata.DATA_ASSINATURA.substr(6)))
                        var jsonAssinatura = JSON.stringify(date).split("T")[0].split("-")
                        dataAssinatura = jsonAssinatura[2] + "/" + jsonAssinatura[1] + "/" + jsonAssinatura[0].replace('"', '')
                        */
                        var toString = '\'' + jsondata.PROMISSARIO + '\',' + jsondata.NUM_CONTRATO + ', \'' + jsondata.DATA_ASSINATURA + '\', \'' + jsondata.DATA_VENCIMENTO + '\', ' + jsondata.COD_CONTRATO_PK;

                        //alert(toString)

                        if (cont == 0) {
                            txt += "<tr> "
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Número "
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Promissário "
                                + "</td>"
                                + "<td style='padding-left: 10px; padding-right: 10px; border-bottom: 1px solid #cccccc;'> "
                                + "   <center><i class='fa fa-gear'></i></center> "
                                + "</td> "
                                + "</tr> ";
                            txt += '<tr>'
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;'>"
                                + jsondata.NUM_CONTRATO
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;'>"
                                + jsondata.PROMISSARIO
                                + "</td>"
                                + "<td style=''>"
                                + '<center><i title="editar"  style="cursor:pointer;margin-right:4px;" onclick="javascript:editContrato(' + toString + ');" class="fa fa-pencil-square-o"></i><span style="cursor:pointer;" title="deletar" onclick="javascript:removeContrato(' + jsondata.COD_CONTRATO_PK + ', ' + $('#<%=hfImovelPK.ClientID%>').val() + ')" class="glyphicon glyphicon-remove "></span></center>'
                               + "</td>"
                               + "</tr>";

                        } else {
                            txt += '<tr>'
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;'>"
                                + jsondata.NUM_CONTRATO
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;'>"
                                + jsondata.PROMISSARIO
                                + "</td>"
                                + "<td style=''>"
                                + '<center><i title="editar"  style="cursor:pointer;margin-right:4px;" onclick="javascript:editContrato(' + toString + ');" class="fa fa-pencil-square-o"></i><span style="cursor:pointer;" title="deletar" onclick="javascript:removeContrato(' + jsondata.COD_CONTRATO_PK + ', ' + $('#<%=hfImovelPK.ClientID%>').val() + ')" class="glyphicon glyphicon-remove "></span></center>'
                                + "</td>"
                                + "</tr>";
                        }
                        cont++;

                    })

                    document.getElementById('tableContratos').innerHTML = txt;

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
        
    <style>
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        border: 1px solid #cccccc; 
        border-radius: 3px;
        height: 250px;
      }
#panel {
  position: relative;
  top: 10px;
  z-index: 5;
  background-color: #fff;
  padding: 5px;
  border: 1px solid #999;
  text-align: center;
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

/**
 * Provide the following styles for both ID and class, where ID represents an
 * actual existing "panel" with JS bound to its name, and the class is just
 * non-map content that may already have a different ID with JS bound to its
 * name.
 */

#panel, .panel {
  font-family: 'Roboto','sans-serif';
  line-height: 30px;
  padding-left: 10px;
}

#panel select, #panel input, .panel select, .panel input {
  font-size: 15px;
}

#panel select, .panel select {
  width: 100%;
}

#panel i, .panel i {
  font-size: 12px;
}

    </style>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="body">



    <div class="content">
      
        <form autocomplete="off" runat="server" class="form-inline" style="width: 100%;"  name="myForm">
            
            <asp:HiddenField ID="hfLoginPK" runat="server" Value="" />
            
            <asp:ScriptManager ID="ScriptManager2" runat="server"/>
             

            <asp:HiddenField ID="hfPermissao" runat="server" Value="" />



                                    
                     <div class="row" >
                                <div class="col-md-4"></div>
                                <div class="col-md-4">
                    
                                    <h4 style=" color: #555; width:98%; text-align:left; border-bottom: 1px solid #cccccc; line-height:0.1em; margin:10px 0 20px;">
                                        <span style="color: #555; background:#fff; padding-right:10px;">
                                            BUSCAR                                            
                                        </span>
                                         <label style="color: #555; background:#fff; float:right; top:-3px;  display: block;" class="glyphicon glyphicon-triangle-bottom"  rel="tooltip" title="Buscar" id="hidr""></label>
                                    </h4>
                                   

                                    <%--<h4 >
                                        <i style="font-size: 1.4em;" class="fa fa-search" rel="tooltip" title=""></i>
                                        <span style="color:#333333; position:relative; ">
                                            &nbsp;BUSCA
                                        </span>
                        
                                    </h4>--%>
                    
                       
                                    <div id="divBuscar" style="width:100%; padding-top:10px; padding-bottom:10px; border: 1px solid #cccccc; border-radius: 3px; display:none;" class="form-group">
                                        
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" >

                                            <ContentTemplate>
                                                <div class="col-md-6">
                                                    <asp:DropDownList Style="width: 100%;" class=" form-control input-sm " name="estados" ID="ddlMuni" runat="server" AppendDataBoundItems="true" onchange="LimpaTudo()">
                                                        <asp:ListItem Value="0">Município</asp:ListItem>
                               
                                                    </asp:DropDownList>
                                                </div>
                                            </ContentTemplate>
                                            <Triggers>

                                                 <asp:AsyncPostBackTrigger ControlID="LinkButtonCadastrar" EventName="Click" />

                                              </Triggers>

                                            </asp:UpdatePanel>
                                                <div class="col-md-6">
                                                    <asp:TextBox type="text" name="" Style="width: 100%" placeholder="Número Patrimônio" class="form-control input-sm" ID="txtPatrimonio" runat="server"></asp:TextBox>
                                                </div>
                            
                                    </div>
                                </div>
                                <div class="col-md-4 "></div>
                        </div>                                   


            

           
            <div id="info" class="row" style="display:none;">
<%-- EXIBIR RAZÃO E CNPJ ----------------------------------------------------------------------------------%>
             
                  <div class="col-md-4"></div>
                  <div class="col-md-4">
                       
                            <h4><span id="InfoMuni" style="color:#333333; ">Municipio:</span> <span id="municipio" style="color:#333333; "></span></h4>
                               
                           <h4> <span id="InfoPatr" style="color:#333333; ">N° Patrimonio</span>  <span id="patrimonio" style="color:#333333; "></span></h4>
                
<%---------------------------------------------------------------------------------- EXIBIR RAZÃO E CNPJ --%>
                            
                         
                 </div>

                
            <div class="col-md-4"></div>
            </div>
            <div class="row" >
                <div class="col-md-4"></div>
                <div class="col-md-4 ">

                    <h4 style= "color: #555; width:100%; text-align:left; border-bottom: 1px solid #cccccc; line-height:0.1em; margin:10px 0 20px;">
                        <span style="color: #555;background:#fff; padding-right:10px;">
                            CADASTRO
                        </span>
                    </h4>



                    <%--<h4 >
                        <i style="font-size: 1.4em;" class="fa fa-floppy-o" rel="tooltip" title=""></i>
                        <i style="font-size: 0.7em; position:relative; top:-4px;" class="fa fa-arrow-right" rel="tooltip" title=""></i>
                        <i style="font-size: 1.4em;" class="fa fa-database" rel="tooltip" title=""></i>
                        
                        <span style="color:#333333; position:relative; ">
                            &nbsp;CADASTRO
                        </span>
                    </h4>--%>

                    <div style="margin-bottom: 5px; margin-top:5px; width: 100%;" class=" btn-group btn-group-sm btn-group-justified btn-group-fill-height">
                        <a class="btn btn-primary btn-sm  processo" id="showCadastroInfo">Info</a>

                        <a class="btn btn-primary btn-sm" id="showCadastroPastas" disabled>Pastas</a>

                        <a class="btn btn-primary btn-sm" id="showCadastroDCartoriais" disabled>D. Cartoriais</a>

                        <a class="btn btn-primary btn-sm" id="showCadastroTributos" disabled>Tributos</a>

                        <a class="btn btn-primary btn-sm" id="showCadastroContratos" disabled>Contratos</a>

                    </div>
                </div>
                <div class="col-md-4"></div>
            </div>


            
<%-- PASTAS ------------------------------------------------------------------------------------------%>
            <div class="cadastroPastas" style="display:none">
                <div class="row">
                    <div class="col-md-4"></div>
                    
                        <div class="col-md-4">
                            <h4>
                            <i style="font-size: 1.4em;" class="fa fa-folder-open" rel="tooltip" title=""></i>
                        
                            <span class="statusPasta" style="color: white; border-radius:2px; position: relative; top: -2px; font-size: 0.7em; display:none;">
                                <%--PASTAS--%>
                                
                            </span>
                           

                            
                            <asp:UpdatePanel ID="UpdatePanel1" RenderMode="Inline" runat="server" UpdateMode="Conditional" >

                                <ContentTemplate>

                                    
                                    <asp:Label class="" ID="lblCadastradoPasta" runat="server" Visible="false">
                                        <!-- TEXTOOOOOOO -->
                                    </asp:Label>
                                    

                                </ContentTemplate>
                                <Triggers>

                                    <asp:AsyncPostBackTrigger ControlID="LinkButtonCadastrarPasta" EventName="Click" />

                                </Triggers>

                            </asp:UpdatePanel>
                            
                            

                                <%--<label class="glyphicon glyphicon-triangle-top pull-right" rel="tooltip" title="email" id="hideCadastro"></label>--%>

</h4>
                            </div>
                        
                    <div class="col-md-4"></div>
                    </div>
                    
                
                <%------------------------------------------------------------------------------------------ CADASTRO --%>

                <%-- DENOMINAÇÃO -------------------------------------------------------------------------------------------------%>




                
                <%------------------------------------------------------------------------------------------------- DENOMINAÇÃO --%>
                <%-- PASTA -------------------------------------------------------------------------------------------------%>
                <div class="row" style="margin-bottom: 5px;">

                    <div class="col-md-4"></div>

                    <div class="col-md-4 form-group">
                        <div class="input-group input-group-sm addon-sm " style="width: 100%">

                            <div>
                                <asp:TextBox Style="width: 100%" runat="server" class="form-control input-sm volumes" name="fields[]" ID="txtPasta" type="text" placeholder="Pasta"></asp:TextBox>
                            </div>
                            <span class="input-group-btn" style="width: 10px;">
                                <asp:LinkButton OnClick="bntCadastrarPasta_Click" runat="server" ID="LinkButtonCadastrarPasta" class="btn btn-primary btn-add btn-sm btnPastas" title="Cadastrar nova pasta" type="button">
                                    <span class="glyphicon glyphicon-plus"></span>
                                </asp:LinkButton>
                            </span>

                        </div>
                    </div>

                    <div class="col-md-4"></div>

                </div>
                <%------------------------------------------------------------------------------------------------- PASTA --%>

                <%-- GRID PASTAS ------------------------------------------------------------------------------------------%>
                <div class="row">

                    <div class="col-md-4"></div>

                    <div class="col-md-4 form-group" style="">
                        <div style="max-height: 100px; height: 42px; overflow-y: auto; border: 1px solid #cccccc; border-radius: 3px; padding: 10px;" id="divPastas">
                        </div>
                    </div>

                    <div class="col-md-4"></div>


                </div>
                <div class="row">

                    <div class="col-md-4"></div>
                    
                    <div class="col-md-4"></div>


                    <%--<asp:UpdatePanel ID="UpdatePanelPasta" runat="server" UpdateMode="Conditional" style="width: 100%;">

                        <ContentTemplate>

                            <div class="col-md-3 col-sm-1">
                                <asp:Label ID="S" runat="server" >
                                           dsadasd <!-- TEXTOOOOOOO -->
                                </asp:Label>
                            </div>

                        </ContentTemplate>
                        <triggers>

                            <asp:AsyncPostBackTrigger ControlID="LinkButtonCadastrarPasta" EventName="Click" />
                            <%--<asp:AsyncPostBackTrigger ControlID="LinkButtonUpdatePasta" EventName="Click" />--

                        </triggers>

                    </asp:UpdatePanel>--%>

                </div>
            </div>
<%------------------------------------------------------------------------------------------ GRID PASTAS --%>


<%-- INFORMAÇÕES ---------------------------------------------------------------------------------------------%>
            <div class="informacoes">
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <h4>
                        <label style="font-size: 1.4em;" class="glyphicon glyphicon-info-sign" rel="tooltip" title="email"></label>
                        <span style="color: #333333; position: relative; top: -5px;"><%--INFORMAÇÕES--%>
                        </span>
                        
                    </h4>
                    
                </div>
                <div class="col-md-4"></div>
            </div>
<%--------------------------------------------------------------------------------------------- INFORMAÇÕES --%>
            <%-- NÚMERO PATRIMÔNIO -------------------------------------------------------------------------------------------------%>
            <div class="row" style="margin-bottom:5px;">

                <div class="col-md-4"></div>
                <div class="col-md-4 form-group">
                    <div>
                        <asp:TextBox type="text" name="" Style="width: 100%" placeholder="Número Patrimônio" class="form-control input-sm" ID="txtNPatrimonio" runat="server" autofocus="true"></asp:TextBox>
                        
                    </div>
                </div>
                <div class="col-md-4"></div>

            </div>
<%------------------------------------------------------------------------------------------------- NÚMERO PATRIMÔNIO --%>
<%-- DENOMINAÇÃO -------------------------------------------------------------------------------------------------%>

            <div class="row" style="margin-bottom: 5px;">

                <div class="col-md-4"></div>
                <div class=" col-md-4 form-group">
                    <div class="">
                        <asp:TextBox Style="width: 100%" ID="txtDenominacao" placeholder="Denominação" class=" form-control input-sm " runat="server" ></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-4"></div>

            </div>

<%-- TIPO IMÓVEL ------------------------------------------------------------------------------------------%>
            
            <div class="row" style="margin-bottom: 5px;">

                <div class="col-md-4"></div>

                <div class="col-md-4 form-group" style="">
                    <div style=" overflow-y: auto; height:30px;  border: 1px solid #cccccc; border-radius: 3px; padding-top:4px; padding-left: 10px;">
                        <span style="position:relative; top: -2px;">
                            Tipo do Imóvel: &nbsp;&nbsp;
                        </span>
                        <asp:RadioButton id="rdoButtonRural" runat="server" Value="Rural" GroupName="tipo"></asp:RadioButton><span style="position:relative; top: -2px;"> Rural</span>&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:RadioButton id="rdoButtonUrbano" runat="server" Value="Urbano" GroupName="tipo"></asp:RadioButton><span style="position:relative; top: -2px;"> Urbano</span>

                    </div>
                </div>

                <div class="col-md-4"></div>

            </div>

<%------------------------------------------------------------------------------------------ TIPO IMÓVEL --%>



<%-- ÁREA -------------------------------------------------------------------------------------------------%>
            <div class="row" style="margin-bottom:5px;">
                     
                <div class="col-md-4"></div>
                <div  class=" col-md-2 form-group ">
                    <asp:DropDownList Style="width: 100%;" class=" form-control input-sm " name="estados" ID="ddlTipoMedida" runat="server" >
                        <asp:ListItem Value="0">Unidade de medida</asp:ListItem>
                        <asp:ListItem Value="m²">m²</asp:ListItem>
                        <asp:ListItem Value="Km²">Km²</asp:ListItem>
                        <asp:ListItem Value="Hectare">Hectare</asp:ListItem>
                    </asp:DropDownList>

                 </div>
                <div class=" col-md-2 form-group">
                    <div class="">
                        <asp:TextBox Style="width: 100%" type="text" placeholder="Área" class="form-control input-sm area" ID="txtArea" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-4"></div>

            </div>
<%------------------------------------------------------------------------------------------------- ÁREA --%>
<%-- SITUAÇÃO -------------------------------------------------------------------------------------------------%>
            <div class="row" style="margin-bottom:5px;">

                <div class="col-md-4"></div>
                <div class="col-md-4 form-group">
                    <div>
                        <asp:TextBox type="text" name="" Style="width: 100%" placeholder="Situação" class="form-control input-sm" ID="txtSituacao" runat="server"></asp:TextBox>
                        
                    </div>
                </div>
                <div class="col-md-4"></div>

            </div>
<%------------------------------------------------------------------------------------------------- SITUAÇÃO --%>

            <div class="row" style="margin-bottom:5px;">

                <div class="col-md-4"></div>
                <div class="col-md-4 form-group">
                    <div>
                        <asp:TextBox type="text" name="" Style="width: 100%" placeholder="Observação" class="form-control input-sm" ID="txtObservacao" runat="server"></asp:TextBox>
                        
                    </div>
                </div>
                <div class="col-md-4"></div>

            </div>
<%------------------------------------------------------------------------------------------------- OBSERVAÇÃO --%>
 <%-- VALOR DO TERRENO -------------------------------------------------------------------------------------------------%>
            <div class="row" style="margin-bottom:5px;">

                <div class="col-md-4"></div>
                <div class="col-md-4 form-group">
                    <div>
                        <asp:TextBox type="text" name="" Style="width: 100%" placeholder="Valor do Terreno " class="form-control input-sm dinheiro" ID="txtValorTerreno" runat="server"></asp:TextBox>
                        
                    </div>
                </div>
                <div class="col-md-4"></div>

            </div>
<%------------------------------------------------------------------------------------------------- SITUAÇÃO JURÍDICA --%>

<%-- VALOR ÁREA CONSTRUIDA -------------------------------------------------------------------------------------------------%>
            <div class="row" style="margin-bottom:5px;">

                <div class="col-md-4"></div>
                <div class="col-md-4 form-group">
                    <div>
                        <asp:TextBox type="text" name="" Style="width: 100%" placeholder="Valor Área Construida" class="form-control input-sm dinheiro" ID="txtVAConstruida" runat="server"></asp:TextBox>
                        
                    </div>
                </div>
                <div class="col-md-4"></div>

            </div>
<%------------------------------------------------------------------------------------------------- VALOR IMOBILIZADO --%>

<%-- VALOR AVALIADO -------------------------------------------------------------------------------------------------%>
            <div class="row" style="margin-bottom:5px;">

                <div class="col-md-4"></div>
                <div class="col-md-2 form-group">
                    <div>
                        <asp:TextBox type="text" name="" Style="width: 100%" placeholder="Valor Avaliado" class="form-control input-sm dinheiro" ID="txtVAvaliado" runat="server"></asp:TextBox>
                        
                    </div>

                </div>
                <div class="col-md-2 form-group">
                    <div>
                        <asp:TextBox type="text" name="" Style="width: 100%" placeholder="Data da Avaliação" class="form-control input-sm data" ID="txtDAvaliacao" runat="server"></asp:TextBox>
                        
                    </div>
                

                </div>
                <div class="col-md-4"></div>
             </div>

             <div class="row" style="margin-bottom:5px;">                             

                  

                    <div class="col-md-4"></div>
                    <div class="col-md-4">
                       
                          
                            <asp:TextBox Style="width: 100%" type="text" placeholder="Link documento"  class="form-control input-sm link" ID="txtLink"  runat="server"></asp:TextBox>
                           
                       
                   
                    </div>
                    
                   
                   

                <div class="col-md-4"></div>

            </div>
        
<%------------------------------------------------------------------------------------------------- VALOR AVALIADO --%>



<%-- ENDEREÇO ---------------------------------------------------------------------------------------------%>
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <h4>
                        <label style="font-size: 1.4em;" class="glyphicon glyphicon-map-marker" rel="tooltip" title="email"></label>
                        <span style="color: #333333; position: relative; top: -5px;"><%--ENDEREÇO--%>
                        </span>
                        
                    </h4>
                    
                </div>
                <div class="col-md-4"></div>

            </div>
<%--------------------------------------------------------------------------------------------- ENDEREÇO --%>
<%-- TIPO / NOME RUA --------------------------------------------------------------------------------------%>
            
            
                <div class="row" style="margin-bottom: 5px;">

                        <div class="col-md-4"></div>
                        <div class=" col-md-2 form-group ">
                            <asp:DropDownList Style="width: 100%;" class=" form-control input-sm " ID="ddlTipo" runat="server">
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
                                <asp:TextBox Style="width: 100%" type="text" placeholder="Nome" class="form-control input-sm" ID="txtNRua" runat="server" Text=""></asp:TextBox>
                            </div>
                        </div>
                        
                        <div class="col-md-4"></div>

                    </div>
                    <%-------------------------------------------------------------------------------------- TIPO / NOME RUA --%>
                    <%-- NÚMERO / COMPLEMENTO --------------------------------------------------------------------------------------%>
                    <div class="row" style="margin-bottom: 5px;">

                        <div class="col-md-4"></div>
                        <div class="col-md-1 form-group">
                            <div class="">
                                <asp:TextBox Style="width: 100%" type="text" placeholder="Número" class="form-control input-sm numeroTxt" ID="numeroTxt" runat="server" Text=""></asp:TextBox>


                            </div>
                        </div>
                        <div class="col-md-3 form-group">
                            <div class="">
                                <asp:TextBox Style="width: 100%" type="text" placeholder="Complemento" class="form-control input-sm" ID="txtComplemento" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4"></div>

                    </div>
                    <%-------------------------------------------------------------------------------------- NÚMERO / COMPLEMENTO --%>

                    <%-- BAIRRO / CEP ----------------------------------------------------------------------------------------------%>
                    <div class="row" style="margin-bottom: 5px;">

                        <div class="col-md-4"></div>
                        <div class="col-md-2 form-group">
                            <div class="">
                                <asp:TextBox Style="width: 100%" type="text" placeholder="Bairro" class="form-control input-sm" ID="txtBairro" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-2 form-group">
                            <div class="">
                                <asp:TextBox Style="width: 100%" type="text" placeholder="CEP" class="form-control input-sm cepTxt" ID="txtCEP" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4"></div>

                    </div>
                    <%---------------------------------------------------------------------------------------------- BAIRRO / CEP --%>
                    <%-- ESTADO / CIDADE -------------------------------------------------------------------------------------------%>
                    <div class="row" style="margin-bottom: 5px;">

                        <div class="col-md-4"></div>
                        <div class=" col-md-1 form-group ">
                            <asp:DropDownList Style="width: 100%;" class=" form-control input-sm " name="estados" ID="ddlEstados" runat="server" onchange="PopulateCidades()">
                                <asp:ListItem Value="0">Estado</asp:ListItem>
                                <asp:ListItem Value="AC">AC</asp:ListItem>
                                <asp:ListItem Value="AL">AL</asp:ListItem>
                                <asp:ListItem Value="AM">AM</asp:ListItem>
                                <asp:ListItem Value="AP">AP</asp:ListItem>
                                <asp:ListItem Value="BA">BA</asp:ListItem>
                                <asp:ListItem Value="CE">CE</asp:ListItem>
                                <asp:ListItem Value="DF">DF</asp:ListItem>
                                <asp:ListItem Value="ES">ES</asp:ListItem>
                                <asp:ListItem Value="GO">GO</asp:ListItem>
                                <asp:ListItem Value="MA">MA</asp:ListItem>
                                <asp:ListItem Value="MS">MS</asp:ListItem>
                                <asp:ListItem Value="MT">MT</asp:ListItem>
                                <asp:ListItem Value="MG">MG</asp:ListItem>
                                <asp:ListItem Value="PA">PA</asp:ListItem>
                                <asp:ListItem Value="PB">PB</asp:ListItem>
                                <asp:ListItem Value="PE">PE</asp:ListItem>
                                <asp:ListItem Value="PI">PI</asp:ListItem>
                                <asp:ListItem Value="PR">PR</asp:ListItem>
                                <asp:ListItem Value="RJ">RJ</asp:ListItem>
                                <asp:ListItem Value="RN">RN</asp:ListItem>
                                <asp:ListItem Value="RO">RO</asp:ListItem>
                                <asp:ListItem Value="RR">RR</asp:ListItem>
                                <asp:ListItem Value="RS">RS</asp:ListItem>
                                <asp:ListItem Value="SC">SC</asp:ListItem>
                                <asp:ListItem Value="SE">SE</asp:ListItem>
                                <asp:ListItem Value="SP">SP</asp:ListItem>
                                <asp:ListItem Value="TO">TO</asp:ListItem>
                            </asp:DropDownList>

                        </div>
                        <div class=" col-md-2 form-group ">

                            <asp:TextBox Style="width: 100%" type="text" placeholder="Cidade" class="form-control input-sm" ID="SearchCidade" autocomplete="false" runat="server" name="processo" ></asp:TextBox>

                        </div>
                        <div class="col-md-1 form-group">
                            <div class="">
                                
                               <button id="submitGeo" class="btn btn-sm btn-primary btn-block" onclick="initMap()"  type="button">
                        Geocode
                    </button>
                            </div>
                            
                        </div>
                        <div class="col-md-4"></div>

                    </div>
                

                    <div class="row" >
                    <div class="col-md-4"></div>
                    <div class=" col-md-4 form-group ">

                       <p id="latlng"></p>
                    </div>
                    <div class="col-md-4"></div>
                </div>

                <div class="row">
                    <div class="col-md-4"></div>
                    <div class=" col-md-4 form-group ">
                        <div id="map"></div>
                        <asp:HiddenField ID="hfLat" runat="server" Value="" />
                        <asp:HiddenField ID="hfLng" runat="server" Value="" />
                        <asp:HiddenField ID="hfPrecisao" runat="server" Value="" />
                        <asp:HiddenField ID="hfTypes" runat="server" Value="" />
                    </div>
                    <div class="col-md-4"></div>
                </div>
                <%------------------------------------------------------------------------------------------- ESTADO / CIDADE --%>
                <%-- BOTÕES CADASTRAR / ATUALIZAR -----------------------------------------------------------------------------%>
                <br />          
                <%-- LIMPAR/ATUALIZAR/CADASTRAR --%>

                <div class="row">
                    

                    <div class="col-md-4 col-sm-3 "></div>

                    <asp:UpdatePanel ID="updPainel2" runat="server" UpdateMode="Conditional" style="width: 100%;">

                        <ContentTemplate>
                            
                              <div class="col-md-1 ">
                                  <button style="width:30%; display:none;" id="deletarImovel"   class="btn btn-danger btn-sm pull-left deleteImovel" title="Excluir Imovel" type="button" >
                                    <span  class="glyphicon glyphicon-trash delete" aria-hidden="true"></span>
                                   </button>
                                 
                                <span title='Limpar campos' id="limpartudo" onclick='javascript:LimpaTudo();' class='glyphicon glyphicon-erase' style="height:30px;width:30%; cursor: pointer; font-size: 1.6em;float:right; display: none;"></span>
                            </div>
                            <div class="col-md-2 col-sm-1">
                                <asp:Label ID="lblCadastradoInfo" runat="server"  style="float:left;" Visible="false">
                                            <!-- TEXTOOOOOOO -->
                                </asp:Label>
                            </div>

                          

                        </ContentTemplate>
                        <triggers>

                            <asp:AsyncPostBackTrigger ControlID="LinkButtonCadastrar" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="LinkButtonUpdate" EventName="Click" />

                        </triggers>

                    </asp:UpdatePanel>
                    <div class="col-md-1 col-sm-1">
                        <asp:LinkButton Style="width: 100%;" ID="LinkButtonCadastrar" runat="server" OnClick="bntCadastrarInfo_Click" type="button" class="btn btn-primary btn-sm pull-right cadastroInfo">
                            Cadastrar
                        </asp:LinkButton>
                        <asp:LinkButton runat="server" ID="LinkButtonUpdate" OnClick="bntUpdateInfo_Click" type="button" class="btn btn-primary btn-sm pull-right updateInfo" Style="width: 100%; display: none">
                            Atualizar
                        </asp:LinkButton>
                    </div>

                    <div class="col-md-4 col-sm-3 "></div>

                </div>


            </div>
          
            <%-------------------------------------------------------------------------- LIMPAR/ATUALIZAR/CADASTRAR --%>
<%-- DADOS CARTORIAIS ----------------------------------------------------------------------------------------------%>
            
            <asp:HiddenField ID="HiddenFieldDCartoriais" runat="server" Value="" />
            <div class="dadoscartoriais" style="display: none">

                <div class="row">
                    <div class="col-md-4"></div>
                    <div class="col-md-4">

                        <h4>
                            <i style="font-size: 1.4em;" class="fa fa-inbox" rel="tooltip" title=""></i>
                            
                        </h4>

                    </div>

                    <div class="col-md-4"></div>
                </div>
               

                <div class="row" style="margin-bottom: 5px;">

                    <div class="col-md-4"></div>

                    <div class="col-md-1 form-group">
                        <div class="">
                            <asp:TextBox Style="width: 100%" type="text" placeholder="Matrícula" class="form-control input-sm" ID="txtMatricula" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-2 form-group">
                        <div class="">
                            <asp:TextBox Style="width: 100%" type="text" placeholder="Comarca" class="form-control input-sm" ID="txtComarca" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-1 form-group">

                        <asp:LinkButton  OnClick="bntCadastrarDCartoriais_Click" runat="server" ID="LinkButtonCadastrarDCartoriais"  style=" width:100%; " class="btn btn-primary btn-add btn-sm cadastrarDCartoriais" title="Cadastrar novo dado cartorial" type="button">
                            <span class="glyphicon glyphicon-plus"></span>
                        </asp:LinkButton>
                        <%--<span title='Apagar campos' id="limparDCartoriais" onclick='javascript:limparDCartoriais();' class='glyphicon glyphicon-erase pull-left' style="cursor:pointer; width:45%; display:none;"></span>
                        --%>
                        <button style="width:45%; display:none;" id="limparDCartoriais"  onclick='javascript:limpaDCartoriais();'  class="btn btn-default btn-add btn-sm pull-left" title="Apagar campos" type="button" >
                            <i class="fa fa-eraser"></i>
                        </button>
                        
                        <asp:LinkButton style="width:45%; display:none;" OnClick="bntAtualizarDCartoriais_Click" runat="server" ID="LinkButtonAtualizarDCartoriais" class="btn btn-primary btn-add btn-sm pull-right atualizarDCartoriais" title="Atualizar dados cartoriais" type="button" >
                            <i class="fa fa-pencil"></i>
                        </asp:LinkButton>

                    </div>
                    <div class="col-md-4"></div>

                </div>
                


                <div class="row" style="margin-bottom: 5px;">

                    <div class="col-md-4"></div>

                    <div class="col-md-4 form-group" style="">
                        <div style="max-height: 200px; overflow-y: auto; border: 1px solid #cccccc; border-radius: 3px;">

                            <table style="min-width: 100%;" id="tableDCartoriais">
                                

                            </table>

                        </div>
                    </div>

                    <div class="col-md-4"></div>


                </div>

                <div class="row">

                    <div class="col-md-4"></div>

                    <div class="col-md-4" style="">
                        <span class="statusDCartoriais" style="color: white; position: relative; top: -2px; display: none;">
                                
                        </span>
                        <asp:UpdatePanel ID="UpdatePanelDCartoriais" RenderMode="Inline" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Label class="" ID="lblCadastradoDCartoriais" runat="server" Visible="false">
                                        <!-- TEXTO STATUS DADOS CARTORIAIS -->
                                </asp:Label>
                            </ContentTemplate>

                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="LinkButtonCadastrarDCartoriais" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="LinkButtonAtualizarDCartoriais" EventName="Click" />

                            </Triggers>
                        </asp:UpdatePanel>
                    </div>

                    <div class="col-md-4"></div>


                </div>

            </div>
<%---------------------------------------------------------------------------------------------- DADOS CARTORIAIS --%>




<%-- TRIBUTOS ----------------------------------------------------------------------------------------------%>
            
            <asp:HiddenField ID="HiddenFieldTributos" runat="server" Value="" />

            <div class="tributos" style="display: none">
                <div class="row">
                    <div class="col-md-4"></div>
                    <div class="col-md-4">
                        <h4>
                            <i style="font-size: 1.4em;" class="fa fa-money" rel="tooltip" title=""></i>

                        </h4>
                    </div>
                    <div class="col-md-4"></div>
                </div>
                <div class="row" style="margin-bottom: 5px;">

                    <div class="col-md-4"></div>

                    <div class="col-md-1 form-group">
                        <div class="">

                            <asp:DropDownList Style="width: 100%" class="form-control input-sm" ID="ddlTTributo" runat="server" onchange="onchangeTributo()">
                                <asp:ListItem Value="0">Tipo</asp:ListItem>
                                <asp:ListItem Value="IPTU">IPTU</asp:ListItem>
                                <asp:ListItem Value="CCIR">CCIR</asp:ListItem>
                                <asp:ListItem Value="ITR">ITR</asp:ListItem>
                                <asp:ListItem Value="NIRF">NIRF</asp:ListItem>
                                <asp:ListItem Value="OUTRO">Outro</asp:ListItem>
                            </asp:DropDownList>


                        </div>
                    </div>

                    <div class="col-md-1 form-group">
                        <asp:TextBox Style="width: 100%; margin-top: 2px;" type="text" placeholder="Especificar" class="form-control input-sm txtTTributo" ID="txtTTributo" runat="server" disabled></asp:TextBox>
                    </div>

                    <div class="col-md-2 form-group">
                        <div class="">

                            <asp:DropDownList Style="width: 100%" class="form-control input-sm" ID="ddlCNegativa" runat="server">
                                <asp:ListItem Value="0">Situação do Tributo</asp:ListItem>
                                <asp:ListItem Value="PAGO">Pago</asp:ListItem>
                                <asp:ListItem Value="ABERTO">Em aberto</asp:ListItem>
                                <asp:ListItem Value="ISENTO">Isento</asp:ListItem>
                                <asp:ListItem Value="CONTRATANTE">À cargo do contratante</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="col-md-4"></div>

                </div>
                <div class="row" style="margin-bottom: 5px;">

                    <div class="col-md-4"></div>

                    <div class="col-md-1 form-group">
                        <div class="">
                            <asp:TextBox Style="width: 100%" type="text" placeholder="Ano" class="form-control input-sm ano" ID="txtAno" runat="server"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-md-1 form-group">
                        <div class="">
                            <asp:TextBox Style="width: 100%" type="text" placeholder="Valor" class="form-control input-sm dinheiro" ID="txtValor" runat="server"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-md-1 form-group">
                        <div class="">
                            <asp:TextBox Style="width: 100%" type="text" placeholder="Índice Cadastral" class="form-control input-sm" ID="txtCodigo" runat="server"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-md-1 form-group">
                        <%--<button class="btn btn-primary btn-add btn-sm pull-right btnTributos" style="width: 100%;" type="button">
                            <span class="glyphicon glyphicon-plus"></span>
                        </button>--%>

                        <asp:LinkButton style="width:100%" OnClick="bntCadastrarTributos_Click" runat="server" ID="LinkButtonCadastrarTributos" class="btn btn-primary btn-add btn-sm cadastrarTributos" title="Cadastrar novo tributo" type="button">
                            <span class="glyphicon glyphicon-plus"></span>
                        </asp:LinkButton>
                        <button style="width:45%; display:none;" id="limparTributos"  onclick='javascript:limpaTributos();'  class="btn btn-default btn-add btn-sm pull-left" title="Apagar campos" type="button" >
                            <i class="fa fa-eraser"></i>
                        </button>
                        
                        <asp:LinkButton style="width:45%; display:none;" OnClick="bntAtualizarTributos_Click" runat="server" ID="LinkButtonAtualizarTributos" class="btn btn-primary btn-add btn-sm pull-right atualizarTributos" title="Atualizar tributos" type="button" >
                            <i class="fa fa-pencil"></i>
                        </asp:LinkButton>


                    </div>


                    <div class="col-md-4"></div>

                </div>
                <div class="row" style="margin-bottom: 5px;">

                    <div class="col-md-4"></div>

                    <div class="col-md-4 form-group" style="">
                        <div style="max-height: 200px;overflow-y: auto; border: 1px solid #cccccc; border-radius: 3px;">

                            <table style="min-width: 100%;" id="tableTributos">
                                
                            </table>

                        </div>
                    </div>

                    <div class="col-md-4"></div>


                </div>
                <div class="row">

                    <div class="col-md-4"></div>

                    <div class="col-md-4" style="">
                        <span class="statusTributos" style="color: white; position: relative; top: -2px; display: none;">
                                
                        </span>
                        <asp:UpdatePanel ID="UpdatePanelTributos" RenderMode="Inline" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Label class="" ID="lblCadastradoTributos" runat="server" Visible="false">
                                        <!-- TEXTO STATUS DADOS CARTORIAIS -->
                                </asp:Label>
                            </ContentTemplate>

                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="LinkButtonCadastrarTributos" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="LinkButtonAtualizarTributos" EventName="Click" />

                            </Triggers>
                        </asp:UpdatePanel>
                    </div>

                    <div class="col-md-4"></div>


                </div>
            </div>
<%---------------------------------------------------------------------------------------------- TRIBUTOS --%>

            
<%-- CONTRATO ----------------------------------------------------------------------------------------------%>
            <asp:HiddenField ID="HiddenFieldContratos" runat="server" Value="" />
           

            <div class="contrato" style="display:none">
                 <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <h4>
                        <i style="font-size: 1.4em; " class  ="fa fa-file-text" rel="tooltip" title=""></i>
                        
                    </h4>
                    
                </div>
                <div class="col-md-4"></div>
            </div>
                <div class="row" style="margin-bottom:5px;">

                <div class="col-md-4"></div>
                <div class="col-md-4 form-group">
                    <p>Caso desejar adicionar um contrato já existente, digite apenas o NÚMERO, ao autocompletar selecione o número desejado e o contrato referente será cadastrado</p>
                </div>
                
                <div class="col-md-4"></div>

            </div>

            <div class="row" style="margin-bottom:5px;">

                <div class="col-md-4"></div>
                <div class="col-md-2 form-group">
                    <div class="">
                        <asp:TextBox Style="width: 100%" type="text" placeholder="Número" class="form-control input-sm txtNumero" ID="txtNumero" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-2 form-group">
                    <div class="">
                            <asp:TextBox Style="width: 100%" type="text" placeholder="Promissário" class="form-control input-sm" ID="txtPromissario" runat="server"></asp:TextBox>
                        </div>
                  
                </div>
                
                <div class="col-md-4"></div>

            </div>

            
            <div class="row" style="margin-bottom:5px;">

                <div class="col-md-4"></div>

                    
                    <div class="col-md-0 form-group">
                     
                    </div>
                    <div class="col-md-2 form-group">
                        <div id="divDAssinatura" class="form-group  has-feedback" style="width:100%;">
                          
                            <asp:TextBox Style="width: 100%" type="text" placeholder="Data Assinatura" onblur="ValidaData()" class="form-control input-sm data" ID="txtDAssinatura"  runat="server"></asp:TextBox>
                           
                        </div>
                   
                    </div>
                    
                    <div class="col-md-2 form-group">
                        <div class="">
                            <asp:TextBox Style="width: 100%" type="text" placeholder="Data Vencimento" class="form-control input-sm data" ID="txtDVencimento" runat="server" ></asp:TextBox>
                        </div>
                    </div>

                <div class="col-md-4"></div>

            </div>
            
           
            <div class="row" style="margin-bottom:5px;">

                <div class="col-md-4"></div>

                    <div class="col-md-1 form-group">
                        
                           
                    </div>
                    <div class="col-md-2 form-group">
                       
                    </div>
                <div class="col-md-1 form-group">
                    
                    <asp:LinkButton Style="width: 100%" OnClick="bntCadastrarContratos_Click" runat="server" ID="LinkButtonCadastrarContratos" class="btn btn-primary btn-add btn-sm cadastrarContratos" title="Cadastrar novo contrato" type="button">
                        <span class="glyphicon glyphicon-plus"></span>
                    </asp:LinkButton>
                     
                    <button style="width: 45%; display: none;" id="limparContratos" onclick='javascript:limpaContratos();' class="btn btn-default btn-add btn-sm pull-left" title="Apagar campos" type="button">
                        <i class="fa fa-eraser"></i>
                    </button>

                    <asp:LinkButton Style="width: 45%; display: none;" OnClick="bntAtualizarContratos_Click" runat="server" ID="LinkButtonAtualizarContratos" class="btn btn-primary btn-add btn-sm pull-right atualizarContratos" title="Atualizar contrato" type="button">
                        <i class="fa fa-pencil"></i>
                    </asp:LinkButton>



                </div>

                <div class="col-md-4"></div>

            </div>


                <asp:HiddenField ID="hfContratos" runat="server" Value="" />


                <div class="row" >

                <div class="col-md-4"></div>

                <div class="col-md-4 form-group" style="">
                    <div style="max-height: 200px; overflow-y: auto; border: 1px solid #cccccc; border-radius: 3px;" >

                        <table  style="min-width: 100%;" id="tableContratos">
                            
                            
                        </table>

                    </div>
                </div>

                <div class="col-md-4"></div>


            </div>

                <div class="row">

                    <div class="col-md-4"></div>

                    <div class="col-md-4" style="">
                        <span class="statusContrato" style="color: white; position: relative; top: -2px; display: none;">
                                
                        </span>
                        <asp:UpdatePanel ID="UpdatePanelContratos" RenderMode="Inline" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Label class="" ID="lblCadastradoContratos" runat="server" Visible="false">
                                        <!-- TEXTO STATUS DADOS CARTORIAIS -->
                                </asp:Label>
                            </ContentTemplate>

                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="LinkButtonCadastrarContratos" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="LinkButtonAtualizarContratos" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>

                    <div class="col-md-4"></div>


                </div>
                



</div>
            

<%------------------------------------------------------------------------------ BOTÕES CADASTRAR / ATUALIZAR --%> 
            <asp:HiddenField ID="hfPastas" runat="server" Value="" />
            <asp:HiddenField ID="hfTributos" runat="server" Value="" />
            <asp:HiddenField ID="hfDCartoriais" runat="server" Value="" />
            <asp:HiddenField runat="server" Value="" ID="hfImovelPK" />
            <asp:HiddenField runat="server" Value="" ID="hfEnderecoPK" />
        </form>

    </div>

    <br />
    <br />
    <br />

    
   
    <script type="text/javascript">
        
        $("#hidr").click(function () {
            if (document.getElementById('hidr').className == 'glyphicon glyphicon-triangle-bottom') {
                $("#divBuscar").show(1000)
                document.getElementById('hidr').className = 'glyphicon glyphicon-triangle-top';
            } else {
                $("#divBuscar").hide(1000)
                document.getElementById('hidr').className = 'glyphicon glyphicon-triangle-bottom';

            };
        });

        function onchangeTributo() {

            if ($('#<%=ddlTTributo.ClientID%>').val() == 'OUTRO') {
                document.getElementById('<%=txtTTributo.ClientID%>').disabled = false;
            } else {
                document.getElementById('<%=txtTTributo.ClientID%>').value = '';
                document.getElementById('<%=txtTTributo.ClientID%>').disabled = true;
            }

        }

      

        function PopulateCidades() {

            if ($('#<%=ddlEstados.ClientID%>').val() == "0") {
                document.getElementById('<%=SearchCidade.ClientID%>').value = '';
                document.getElementById('<%=SearchCidade.ClientID %>').disabled = true;
            } else {
                document.getElementById('<%=SearchCidade.ClientID %>').disabled = false;
            }


            $("#<%=SearchCidade.ClientID %>").autocomplete({// AUTOCOMPLETE DE CIDADES DE ACORDO COM SEU ESTADO
                source: function (request, response) {
                    $.ajax({
                        url: '<%=ResolveUrl("~/Service.asmx/GetCidades") %>',
                        data: "{ 'prefix': '" + request.term + "', 'UF': '" + $('#<%=ddlEstados.ClientID%>').val() + "'}",
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
        
       

        function LimpaCampos()//LIMPA TODOS OS CAMPOS
        {
           
            $('#<%=txtDenominacao.ClientID%>').val("");
            $('#<%=rdoButtonRural.ClientID%>').attr("checked",false)
            $('#<%=rdoButtonUrbano.ClientID%>').attr("checked",false);
            $('#<%=txtSituacao.ClientID%>').val("");
            $('#<%=txtObservacao.ClientID%>').val("");
            $('#<%=ddlTipoMedida%>').val("0");
            $('#<%=txtArea.ClientID%>').val("");           
            $('#<%=txtValorTerreno.ClientID%>').val("");
            $('#<%=txtVAvaliado.ClientID%>').val("");
            $('#<%=txtDAvaliacao.ClientID%>').val("");
            $('#<%=ddlTipo.ClientID%>').val("0");
            $('#<%=txtNRua.ClientID%>').val("");
            $('#<%=numeroTxt.ClientID%>').val("");
            $('#<%=txtComplemento.ClientID%>').val("");
            $('#<%=txtCEP.ClientID%>').val("");
            $('#<%=txtBairro.ClientID%>').val("");
            $('#<%=ddlEstados.ClientID%>').val("0");
            $('#<%=SearchCidade.ClientID%>').val("");
            $('#<%=hfLat.ClientID%>').val("");
            $('#<%=hfLng.ClientID%>').val("");
            $('#<%=hfImovelPK.ClientID%>').val("");
            $('#<%=hfEnderecoPK.ClientID%>').val("");
            $('#<%=hfContratos.ClientID%>').val("");
            $('#<%=hfDCartoriais.ClientID%>').val("");
            $('#<%=hfPastas.ClientID%>').val("");
            $('#<%=hfTributos.ClientID%>').val("");
            $('#<%=txtPasta.ClientID%>').val("");
            $('#<%=txtMatricula.ClientID%>').val("");
            $('#<%=txtComarca.ClientID%>').val("");
            $('#<%=txtTTributo.ClientID%>').val("");
            $('#<%=ddlCNegativa.ClientID%>').val("");
            $('#<%=txtAno.ClientID%>').val("");
            $('#<%=txtValor.ClientID%>').val("");
            $('#<%=txtCodigo.ClientID%>').val("");
            $('#<%=txtNumero.ClientID%>').val("");
            $('#<%=txtPromissario.ClientID%>').val("");
            $('#<%=txtDAssinatura.ClientID%>').val("");
            $('#<%=txtDVencimento.ClientID%>').val("");
            $('#<%=txtVAConstruida.ClientID%>').val("");
            $('#<%=txtNPatrimonio.ClientID%>').val("");
            $('#<%=txtPatrimonio.ClientID%>').val("");
            $('#<%=ddlTipoMedida.ClientID%>').val("0");
            $('#<%=lblCadastradoInfo.ClientID%>').fadeOut(2000);
            $('#<%=txtLink.ClientID%>').val("");
            document.getElementById('municipio').innerHTML = "";
            document.getElementById('patrimonio').innerHTML = "";
            document.getElementById('info').style.display = 'none';
            $('#<%=SearchCidade.ClientID%>').removeAttr("disabled");
            document.getElementById('tableContratos').innerHTML = "";
            document.getElementById('tableTributos').innerHTML = "";
            document.getElementById('tableDCartoriais').innerHTML = "";
            document.getElementById('divPastas').innerHTML = "";
           


        }
        function LimpaTudo() {// RESTAURA A PAGINA PARA SEU ESTADO INICIAL
            $('#<%=txtPatrimonio.ClientID%>').val("");
            $('#<%=lblCadastradoInfo.ClientID%>').fadeOut();
            $('#<%=txtNPatrimonio.ClientID%>').val("");
            $('#<%=txtDenominacao.ClientID%>').val("");
            $('#<%=rdoButtonRural.ClientID%>').attr("checked", false)
            $('#<%=rdoButtonUrbano.ClientID%>').attr("checked", false);
            $('#<%=txtSituacao.ClientID%>').val("");
            $('#<%=txtObservacao.ClientID%>').val("");
            $('#<%=ddlTipoMedida%>').val("0");
            $('#<%=txtArea.ClientID%>').val("");
            $('#<%=txtValorTerreno.ClientID%>').val("");
            $('#<%=txtVAvaliado.ClientID%>').val("");
            $('#<%=txtDAvaliacao.ClientID%>').val("");
            $('#<%=ddlTipo.ClientID%>').val("0");
            $('#<%=txtNRua.ClientID%>').val("");
            $('#<%=numeroTxt.ClientID%>').val("");
            $('#<%=txtComplemento.ClientID%>').val("");
            $('#<%=txtCEP.ClientID%>').val("");
            $('#<%=txtBairro.ClientID%>').val("");
            $('#<%=ddlEstados.ClientID%>').val("0");
            $('#<%=SearchCidade.ClientID%>').val("");
            $('#<%=hfLat.ClientID%>').val("");
            $('#<%=hfLng.ClientID%>').val("");
            $('#<%=hfImovelPK.ClientID%>').val("");
            $('#<%=hfEnderecoPK.ClientID%>').val("");
            $('#<%=hfContratos.ClientID%>').val("");
            $('#<%=hfDCartoriais.ClientID%>').val("");
            $('#<%=hfPastas.ClientID%>').val("");
            $('#<%=hfTributos.ClientID%>').val("");
            $('#<%=txtPasta.ClientID%>').val("");
            $('#<%=txtMatricula.ClientID%>').val("");
            $('#<%=txtComarca.ClientID%>').val("");
            $('#<%=txtTTributo.ClientID%>').val("");
            $('#<%=ddlCNegativa.ClientID%>').val("");
            $('#<%=txtAno.ClientID%>').val("");
            $('#<%=txtValor.ClientID%>').val("");
            $('#<%=txtCodigo.ClientID%>').val("");
            $('#<%=txtNumero.ClientID%>').val("");
            $('#<%=txtPromissario.ClientID%>').val("");
            $('#<%=txtDAssinatura.ClientID%>').val("");
            $('#<%=txtDVencimento.ClientID%>').val("");
            $('#<%=txtVAConstruida.ClientID%>').val("");
            $('#<%=txtLink.ClientID%>').val("");
            $('#<%=SearchCidade.ClientID%>').removeAttr("disabled");
            document.getElementById('municipio').innerHTML = "";
            document.getElementById('patrimonio').innerHTML = "";
            document.getElementById('tableContratos').innerHTML = "";
            document.getElementById('tableTributos').innerHTML = "";
            document.getElementById('tableDCartoriais').innerHTML = "";
            document.getElementById('divPastas').innerHTML = "";
            $('#showCadastroPastas').attr("disabled", "disabled");
            $('#showCadastroDCartoriais').attr("disabled", "disabled");
            $('#showCadastroTributos').attr("disabled", "disabled");
            $('#showCadastroContratos').attr("disabled", "disabled");
            document.getElementById('info').style.display = 'none';

            $('.updateInfo').fadeOut();
            $('#limpartudo').fadeOut();
            
            $('.deleteImovel').fadeOut();
            $('.cadastroInfo').fadeIn(1000);

        }

        $(document).ready(function () {
           
           

            $(document).on('click', '.cadastroInfo', function (e) {
               
               

            });

            $(":file").filestyle('buttonText', 'Procurar arquivo');

            $(document).on('click', '.deleteImovel', function (e) {

                $.ajax({
                    type: "POST",
                    url: '<%=ResolveUrl("~/Service.asmx/removeImovel") %>',
                    data: "{ 'imovelPK':'" + $('#<%=hfImovelPK.ClientID%>').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (parseInt(data.d) > 0) {
                            alert('Imovel Deletado!')
                            LimpaTudo();
                        }
                        else {
                            alert('Imovel não encontrado. Tente novamente!')
                        }

                    },
                    error: function (XHR, errStatus, errorThrown) {
                        var err = JSON.parse(XHR.responseText);
                        errorMessage = err.Message;
                        alert(errorMessage);
                    }
                });
                
            });

           
            function LimpaTudo() {// RESTAURA A PAGINA PARA SEU ESTADO INICIAL
                $('#<%=txtPatrimonio.ClientID%>').val("");
                $('#<%=ddlMuni.ClientID%>').val("0");
                $('#<%=txtNPatrimonio.ClientID%>').val("");
                $('#<%=txtDenominacao.ClientID%>').val("");
                $('#<%=rdoButtonRural.ClientID%>').attr("checked", false)
                $('#<%=rdoButtonUrbano.ClientID%>').attr("checked", false);
                $('#<%=txtSituacao.ClientID%>').val("");
                $('#<%=txtObservacao.ClientID%>').val("");
                $('#<%=ddlTipoMedida%>').val("0");
                $('#<%=txtArea.ClientID%>').val("");
                $('#<%=txtValorTerreno.ClientID%>').val("");
                $('#<%=txtVAvaliado.ClientID%>').val("");
                $('#<%=txtDAvaliacao.ClientID%>').val("");
                $('#<%=ddlTipo.ClientID%>').val("0");
                $('#<%=txtNRua.ClientID%>').val("");
                $('#<%=numeroTxt.ClientID%>').val("");
                $('#<%=txtComplemento.ClientID%>').val("");
                $('#<%=txtCEP.ClientID%>').val("");
                $('#<%=txtBairro.ClientID%>').val("");
                $('#<%=ddlEstados.ClientID%>').val("0");
                $('#<%=SearchCidade.ClientID%>').val("");
                $('#<%=hfLat.ClientID%>').val("");
                $('#<%=hfLng.ClientID%>').val("");
                $('#<%=hfImovelPK.ClientID%>').val("");
                $('#<%=hfEnderecoPK.ClientID%>').val("");
                $('#<%=hfContratos.ClientID%>').val("");
                $('#<%=hfDCartoriais.ClientID%>').val("");
                $('#<%=hfPastas.ClientID%>').val("");
                $('#<%=hfTributos.ClientID%>').val("");
                $('#<%=txtPasta.ClientID%>').val("");
                $('#<%=txtMatricula.ClientID%>').val("");
                $('#<%=txtComarca.ClientID%>').val("");
                $('#<%=txtTTributo.ClientID%>').val("");
                $('#<%=ddlCNegativa.ClientID%>').val("");
                $('#<%=txtAno.ClientID%>').val("");
                $('#<%=txtValor.ClientID%>').val("");
                $('#<%=txtCodigo.ClientID%>').val("");
                $('#<%=txtNumero.ClientID%>').val("");
                $('#<%=txtPromissario.ClientID%>').val("");
                $('#<%=txtDAssinatura.ClientID%>').val("");
                $('#<%=txtDVencimento.ClientID%>').val("");
                $('#<%=txtVAConstruida.ClientID%>').val("");
                $('#<%=txtLink.ClientID%>').val("");
                $('#<%=SearchCidade.ClientID%>').removeAttr("disabled");
                document.getElementById('tableContratos').innerHTML = "";
                document.getElementById('tableTributos').innerHTML = "";
                document.getElementById('tableDCartoriais').innerHTML = "";
                document.getElementById('divPastas').innerHTML = "";
                $('#showCadastroPastas').attr("disabled", "disabled");
                $('#showCadastroDCartoriais').attr("disabled", "disabled");
                $('#showCadastroTributos').attr("disabled", "disabled");
                $('#showCadastroContratos').attr("disabled", "disabled");


                $('.updateInfo').fadeOut();
                $('#limpartudo').fadeOut();

                $('.deleteImovel').fadeOut();
                $('.cadastroInfo').fadeIn(1000);

            }
            /** AUTOCOMPLETE NUM PATRIMONIO POR MUNICIPIO*****************************************************/






            $("#<%=txtPatrimonio.ClientID %>").autocomplete({//AUTOCOMPLETE NUMERO DO PARADRIMONIO RETORNA OS DADOS PRINCIPAIS PARA NAO SOBRECARREGAR O AUTOCOMPLETE
                
                source: function (request, response) {
                    
                    $.ajax({
                        url: '<%=ResolveUrl("~/Service.asmx/GetCodImovel") %>',
                        data: "{ 'prefix': '" + request.term + "', 'municipio': '" + $('#<%=ddlMuni.ClientID%>').val() + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            var parsed = $.parseJSON(data.d);
                            
                            
                            var imoveis = [];
                            $.each(parsed, function (i, jsondata) {
                                

                                imoveis.push([
                                    jsondata.NUM_PATRIMONIO,
                                    jsondata.COD_IMOVEL_PK,
                                    jsondata.COD_END_IMOVEL_PK
                                    
                                    
                                ])
                            })
                            
                            response($.map(imoveis, function (item) {
                                
                                return {
                                    label: item[0].toString(),
                                    IMOVELPK: item[1].toString(),
                                    ENDERECOPK: item[2].toString(),

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
                    dadosImoveis(i.item);// AO SELECIONAR O NUMERO DO PATRIMONIO SELECIONA DADOSiMOVEIS



                },
                minLength: 1
            });

            function dadosImoveis(codimovel)
            {
                
                LimpaCampos();//LIMPA CAMPOS ANTES DE BUSCA NOVOS DADOS

               


                /////////HABILITA TODOS OS BOTÕES
                $('#showCadastroPastas').removeAttr("disabled");
                $('#showCadastroDCartoriais').removeAttr("disabled");
                $('#showCadastroTributos').removeAttr("disabled");
                $('#showCadastroContratos').removeAttr("disabled");
                /////////

                ///////GUARDA OS CODIGOS EM UM HIDENFIELD PARA CADASTRAR  INFORMAÇÕES REFERENTES AO IMOVEL
                document.getElementById('<%=hfImovelPK.ClientID%>').value = codimovel.IMOVELPK;
                document.getElementById('<%=hfEnderecoPK.ClientID%>').value = codimovel.ENDERECOPK;
                //////

                
                $('.cadastroInfo').fadeOut();////ENCONDE BOTAO CADASTAR
                $('.updateInfo').fadeIn(1000);///HABILITA BOTAO DE UPDATE
                $('#limpartudo').fadeIn(1000);///HABILITA BOTAO RESTAURAR PAGINA
                $('.deleteImovel').fadeIn(1000);
                //INFORMAÇÕES
                $.ajax({////FUNÇÃO É CHAMADA NOVAMENTE PARA BUSCAR RESTATE DOS DADOS
                    url: '<%=ResolveUrl("~/Service.asmx/GetDadosImovel") %>',
                    data: "{ 'prefix': '" + codimovel.IMOVELPK + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        var parsed = $.parseJSON(data.d);
                        var txt = "";
                        $.each(parsed, function (i, jsondata) {
                            var parsed = $.parseJSON(data.d);
                            var txt = "";
                           
                            document.getElementById('municipio').innerHTML = jsondata.CIDADE
                            document.getElementById('patrimonio').innerHTML = jsondata.NUM_PATRIMONIO
                            document.getElementById('info').style.display = 'block';
                         

                            //////define qual permissao diferente de 1 é admin e master
                                
                            if ($('#<%=hfPermissao.ClientID%>').val() == 1) {
                                PERMISSAO = false
                            } else {
                                PERMISSAO = true
                            }
                            ////setando valores e bloqueando campos para usuario caso o mesmo exista.

                            if (jsondata.NUM_PATRIMONIO != "" && jsondata.NUM_PATRIMONIO != null) {
                                $("#<%=txtNPatrimonio.ClientID %>").val(jsondata.NUM_PATRIMONIO);
                                if (!PERMISSAO) $('#<%=txtNPatrimonio.ClientID %>').prop('disabled', true)
                            }
                            if (jsondata.LINK_DOC_IMOVEL != "" && jsondata.LINK_DOC_IMOVEL != null) {
                                $("#<%=txtLink.ClientID %>").val(jsondata.LINK_DOC_IMOVEL);
                                if (!PERMISSAO) $('#<%=txtLink.ClientID %>').prop('disabled', true)
                            }
                           
                            
                            if (jsondata.DENOMINACAO != "" && jsondata.DENOMINACAO != null)
                            {
                                $("#<%=txtDenominacao.ClientID %>").val(jsondata.DENOMINACAO);
                                if (!PERMISSAO) $('#<%=txtDenominacao.ClientID %>').prop('disabled', true)

                            }
                                   
                            if (jsondata.UNIDADE_AREA != "" && jsondata.UNIDADE_AREA != null)
                                $("#<%=ddlTipoMedida.ClientID %>").val(jsondata.UNIDADE_AREA);
                            if (!PERMISSAO) $('#<%=ddlTipoMedida.ClientID %>').prop('disabled', true)

                            if (jsondata.AREA_IMOVEL != "" && jsondata.AREA_IMOVEL != null) {
                                $("#<%=txtArea.ClientID %>").val(jsondata.AREA_IMOVEL);
                                if (!PERMISSAO) $('#<%=txtArea.ClientID %>').prop('disabled', true)

                            }
                           
                            if (jsondata.SITUACAO_IMOVEL != "" && jsondata.SITUACAO_IMOVEL != null)
                            {
                                $("#<%=txtSituacao.ClientID %>").val(jsondata.SITUACAO_IMOVEL);
                                if (!PERMISSAO) $('#<%=txtSituacao.ClientID %>').prop('disabled', true)
                            }
                                   
                            if (jsondata.OBSERVACAO != "" && jsondata.OBSERVACAO != null) {
                                $("#<%=txtObservacao.ClientID %>").val(jsondata.OBSERVACAO);
                                if (!PERMISSAO) $('#<%=txtObservacao.ClientID %>').prop('disabled', true)

                            }

                              
                            if (jsondata.VALOR_TERRENO != "" && jsondata.VALOR_TERRENO != null)
                            {
                                $("#<%=txtValorTerreno.ClientID %>").val(jsondata.VALOR_TERRENO);
                                if (!PERMISSAO) $('#<%=txtValorTerreno.ClientID %>').prop('disabled', true)
                            }

                            if (jsondata.VALOR_AREA_CONSTRUIDA != "" && jsondata.VALOR_AREA_CONSTRUIDA != null) {
                                $("#<%=txtVAConstruida.ClientID %>").val(jsondata.VALOR_AREA_CONSTRUIDA);
                                if (!PERMISSAO) $('#<%=txtVAConstruida.ClientID %>').prop('disabled', true)

                            }

                            if (jsondata.VALOR_AVALIACAO != "" && jsondata.VALOR_AVALIACAO != null) {
                                $("#<%=txtVAvaliado.ClientID %>").val(jsondata.VALOR_AVALIACAO);
                                if (!PERMISSAO) $('#<%=txtVAvaliado.ClientID %>').prop('disabled', true)

                            }


                            if (jsondata.DATA_AVALIACAO != "" && jsondata.DATA_AVALIACAO != null) {
                                date = new Date(parseInt(jsondata.DATA_AVALIACAO.substr(6)))
                                var jsonDataAvaliacao = JSON.stringify(date).split("T")[0].split("-")
                                dataAvaliacao = jsonDataAvaliacao[2] + "/" + jsonDataAvaliacao[1] + "/" + jsonDataAvaliacao[0].replace('"', '')

                                $("#<%=txtDAvaliacao.ClientID %>").val(dataAvaliacao);
                                if (!PERMISSAO) $('#<%=txtDAvaliacao.ClientID %>').prop('disabled', true)

                            }
                            
                            
                            
                               
                            ////setando valores de endereco
                            if (jsondata.SHAPE != "" && jsondata.SHAPE != null) {
                                $("#<%=hfLat.ClientID %>").val(jsondata.SHAPE.split('(')[1].split(' ')[0]);
                                $("#<%=hfLng.ClientID %>").val(jsondata.SHAPE.split('(')[1].split(' ')[1].split(')')[0]);
                                geocode2();

                            }
                            
                            
                            if (!PERMISSAO) $('#<%=numeroTxt.ClientID %>').prop('disabled', true)
                          
                           

                                if (jsondata.NUMERO != "" && jsondata.NUMERO != null)
                                    $("#<%=numeroTxt.ClientID %>").val(jsondata.NUMERO);
                                if (!PERMISSAO) $('#<%=numeroTxt.ClientID %>').prop('disabled', true)

                            
                                if (jsondata.NOME_LOGRADOURO != "" && jsondata.NOME_LOGRADOURO != null)
                                    $("#<%=txtNRua.ClientID %>").val(jsondata.NOME_LOGRADOURO);
                                if (!PERMISSAO) $('#<%=txtNRua.ClientID %>').prop('disabled', true)

                                if (jsondata.BAIRRO != "" && jsondata.BAIRRO != null)
                                    $("#<%=txtBairro.ClientID %>").val(jsondata.BAIRRO);
                                if (!PERMISSAO) $('#<%=txtBairro.ClientID %>').prop('disabled', true)

                                if (jsondata.CIDADE != "" && jsondata.CIDADE != null)
                                    $("#<%=SearchCidade.ClientID %>").val(jsondata.CIDADE);
                                if (!PERMISSAO) $('#<%=SearchCidade.ClientID %>').prop('disabled', true)

                                if (jsondata.ESTADO != "" && jsondata.ESTADO != null)
                                    $("#<%=ddlEstados.ClientID %>").val(jsondata.ESTADO);
                                if (!PERMISSAO) $('#<%=ddlEstados.ClientID %>').prop('disabled', true)

                                if (jsondata.TIPO_LOGRADOURO != "" && jsondata.TIPO_LOGRADOURO != null)
                                    $("#<%=ddlTipo.ClientID %>").val(jsondata.TIPO_LOGRADOURO);
                                if (!PERMISSAO) $('#<%=ddlTipo.ClientID %>').prop('disabled', true)

                                if (jsondata.CEP != "" && jsondata.CEP != null)
                                    $("#<%=txtCEP.ClientID %>").val(jsondata.CEP);
                                if (!PERMISSAO) $('#<%=txtCEP.ClientID %>').prop('disabled', true)

                                if (jsondata.COMPLEMENTO != "" && jsondata.COMPLEMENTO != null)
                                    $("#<%=txtComplemento.ClientID %>").val(jsondata.COMPLEMENTO);
                                    if (!PERMISSAO) $('#<%=txtComplemento.ClientID %>').prop('disabled', true)                            
                           
                            
                            if (jsondata.TIPO_IMOVEL != "" && jsondata.TIPO_IMOVEL != null) {
                                if (jsondata.TIPO_IMOVEL == "Urbano") {
                                    $("#<%=rdoButtonRural.ClientID %>").attr('checked', false);
                                    $("#<%=rdoButtonUrbano.ClientID %>").attr('checked', true);
                                }
                                else {
                                    $("#<%=rdoButtonUrbano.ClientID %>").attr('checked', false);
                                    $("#<%=rdoButtonRural.ClientID %>").attr('checked', true);

                                }
                                if (!PERMISSAO) $('#<%=rdoButtonUrbano.ClientID %>').prop('disabled', true)
                                if (!PERMISSAO) $('#<%=rdoButtonRural.ClientID %>').prop('disabled', true)
                            
                            }
                           
                        })
                        /////INICIALIZADO MAPA
                        initMap();

                    },
                    error: function (response) {
                        alert(response.responseText);
                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }
                });

                //PASTAS
                getDivPastas(codimovel.IMOVELPK)

                //DADOS CARTORIAIS
                getTableDCartoriais(codimovel.IMOVELPK)

                
                //TRIBUTOS BANCO
                getTableTributos(codimovel.IMOVELPK)
                
                //CONTRATO
                getTableContratos(codimovel.IMOVELPK)

                
                
               

             

            }
         

            //*********************************************************************FIM AUTOCOMPLETE PATRIMONIO POR MUNICIPIO


            /** AUTOCOMPLETE PASTA **************************************************************************************/
            $("#<%=txtPasta.ClientID %>").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: '<%=ResolveUrl("~/Service.asmx/GetPastas") %>',
                        data: "{ 'prefix': '" + request.term + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            
                            var parsed = $.parseJSON(data.d);
                            var pastas = [];
                            $.each(parsed, function (i, jsondata) {
                                pastas.push([
                                    jsondata.COD_PASTA_CODEMIG,
                                    jsondata.COD_PASTA_PK
                                ])
                            })

                            response($.map(pastas, function (item) {
                                return {
                                    label: item[0],
                                    pastaPK: item[1]
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

                    var PASTA = i.item.label;
                    var pastaPK = i.item.pastaPK;
                    
                    $.ajax({/// CADASTAR UMA PASTA EXISTENTE PEGA O CODIGO DA PASTA
                        type: "POST",
                        url: '<%=ResolveUrl("~/Service.asmx/cadastraPasta") %>',
                        data: "{ 'pastaPK':'" + pastaPK + "', 'imovelPK': '" + $('#<%=hfImovelPK.ClientID%>').val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (data.d > 0) {
                                $('#<%=txtPasta.ClientID %>').val('');
                                getDivPastas($('#<%=hfImovelPK.ClientID%>').val())
                                $('.statusPasta').css("background-color", "rgb(92, 184, 92)");
                                $('.statusPasta').html('&nbsp;&nbsp;Cadastrado&nbsp;&nbsp;')
                                $('.statusPasta').fadeIn();
                                setTimeout(function () {
                                    $('.statusPasta').fadeOut();
                                    //$('.statusPasta').html('')
                                }, 3000);


                            } else {
                                $('#<%=txtPasta.ClientID %>').val('');
                                $('.statusPasta').css("background-color", "rgb(217, 83, 79)");
                                $('.statusPasta').html('&nbsp;&nbsp;Não Cadastrado&nbsp;&nbsp;')
                                $('.statusPasta').fadeIn();
                                setTimeout(function () {
                                    $('.statusPasta').fadeOut();
                                    //$('.statusPasta').html('')
                                }, 3000);
                            }

                        },
                        error: function (XHR, errStatus, errorThrown) {
                            var err = JSON.parse(XHR.responseText);
                            errorMessage = err.Message;
                            alert(errorMessage);
                        }
                    });

                }, minLength: 1

            });
            /***************************************************************************************** AUTOCOMPLETE PASTA **/

            /** AUTOCOMPLETE CONTRATO **************************************************************************************/

            $("#<%=txtNumero.ClientID %>").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: '<%=ResolveUrl("~/Service.asmx/GetContratos") %>',
                        data: "{ 'prefix': '" + request.term + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            var parsed = $.parseJSON(data.d);

                            var contratos = [];
                            $.each(parsed, function (i, jsondata) {

                                contratos.push([
                                    jsondata.NUM_CONTRATO,
                                    jsondata.COD_CONTRATO_PK

                                ])
                            })

                            response($.map(contratos, function (item) {

                                return {

                                    label: item[0].toString(),
                                    contratoPK: item[1].toString()

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
                    
                    var contratoPK = i.item.contratoPK;

                    $.ajax({
                        type: "POST",
                        url: '<%=ResolveUrl("~/Service.asmx/cadastraContrato") %>',
                        data: "{ 'contratoPK':'" + contratoPK + "', 'imovelPK': '" + $('#<%=hfImovelPK.ClientID%>').val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {

                            if (data.d > 0) {

                                $('#<%=txtPasta.ClientID %>').val('');
                                getDivPastas($('#<%=hfImovelPK.ClientID%>').val())
                                $('.statusContrato').css("color", "green");
                                $('.statusContrato').html('&nbsp;&nbsp;Cadastrado&nbsp;&nbsp;')
                                $('.statusContrato').fadeIn();
                                setTimeout(function () {
                                    $('.statusContrato').fadeOut();
                                    //$('.statusPasta').html('')
                                }, 3000);

                            } else {

                                $('#<%=txtPasta.ClientID %>').val('');
                                $('.statusContrato').css("color", "red");
                                $('.statusContrato').html('&nbsp;&nbsp;Não Cadastrado&nbsp;&nbsp;')
                                $('.statusContrato').fadeIn();
                                setTimeout(function () {
                                    $('.statusContrato').fadeOut();
                                    //$('.statusPasta').html('')
                                }, 3000);

                            }

                        },
                        error: function (XHR, errStatus, errorThrown) {
                            var err = JSON.parse(XHR.responseText);
                            errorMessage = err.Message;
                            alert(errorMessage);
                        }
                    });

                },
                minLength: 1
            });

            /***************************************************************************************** AUTOCOMPLETE CONTRATO **/

            $(document).on('click', '.btnPastas', function (e) {

                <%--$('#<%=lblCadastradoPasta.ClientID%>').css("background-color", "rgb(92, 184, 92)");
                $('#<%=lblCadastradoPasta.ClientID%>').css("border-radius", "2px");
                $('#<%=lblCadastradoPasta.ClientID%>').css("color", "white");
                $('#<%=lblCadastradoPasta.ClientID%>').fadeIn();--%>


                setTimeout(function () {
                    $('#<%=txtPasta.ClientID %>').val('');
                    $('#<%=lblCadastradoPasta.ClientID %>').fadeOut();

                    getDivPastas($('#<%=hfImovelPK.ClientID%>').val())

                }, 3000);

                

            });


            <%--$(document).on('click', '.btnDCartoriais', function (e) {



                
                var matricula = $('#<%=txtMatricula.ClientID%>').val();
                var rLivro = $('#<%=txtRLivro.ClientID%>').val();
                var comarca = $('#<%=txtComarca.ClientID%>').val();




                var dCartoriais = (matricula + '¨' + rLivro + '¨' + comarca)
                
                if (dCartoriais == "¨¨") {
                    return;
                }

                if ($('#<%=hfDCartoriais.ClientID%>').val() == "") {
                    document.getElementById('<%=hfDCartoriais.ClientID%>').value += dCartoriais;
                } else {
                    document.getElementById('<%=hfDCartoriais.ClientID%>').value += '+' + dCartoriais;
                }


                var txt = document.getElementById('tableDCartoriais').innerHTML;

                txt += "<tr>"
                    + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>"
                    + matricula
                    + "</td>"
                    + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>"
                    + rLivro
                    + "</td>"
                    + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;' >"
                    + comarca
                    + "</td>"
                    + "<td style=' padding-left: 10px; padding-right: 10px;  border-bottom: 1px solid #cccccc;'>"
                    + "<span style=' padding-bottom:1px; ' class='glyphicon glyphicon-remove'  onclick='javascript:removeDCartoriais(this)' ></span>"
                    + "</td>"
                + "</tr>";





                






                document.getElementById('tableDCartoriais').innerHTML = txt;
                setTimeout(function () {

                    document.getElementById('<%=txtMatricula.ClientID%>').value = "";
                    document.getElementById('<%=txtRLivro.ClientID%>').value = "";
                    document.getElementById('<%=txtComarca.ClientID%>').value = "";
                }, 10);

            });--%>


            function getContrato(numero, objeto) {


                $.ajax({
                    url: '<%=ResolveUrl("~/Service.asmx/getContratoImovel") %>',
                    data: "{ 'prefix':'" + numero +"|"+ objeto + "'}",
                    dataType: "json",
                    async: false,
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        //alert(data.d.toString());
                        result = parseInt(data.d.toString());

                        /*if (data.d.toString() != "1") {
                            //alert('CERTO');
                        }*/

                    },
                    error: function (response) {
                        alert(response.responseText);

                    },
                    failure: function (response) {
                        alert(response.responseText);

                    }
                });

                return result;

            }

            
            


            $(document).on('click', '.btnContratos', function (e)  {

                

                <%--promissario = $('#<%=txtPromissario.ClientID%>').val();//0
                promitente = $('#<%=txtPromitente.ClientID%>').val();//1
                tipoContrato = $('#<%=txtTContrato.ClientID%>').val();//2--%>
                


                if ($('#<%=txtNumero.ClientID%>').val() != "") {
                    numero = $('#<%=txtNumero.ClientID%>').val();//3
                } else {
                    prazo = "NULL";
                }



<%--                if ($('#<%=txtPrazo.ClientID%>').val() != "") {
                    prazo = $('#<%=txtPrazo.ClientID%>').val();//4
                } else {
                    prazo = "NULL";
                }--%>

                





              <%--  objeto = $('#<%=txtObjeto.ClientID%>').val();//5--%>
                
                <%--if ($('#<%=txtDAssinatura.ClientID%>').val() == "") {

                    dataAssinatura = "";

                } else {


                    dataConvert = $('#<%=txtDAssinatura.ClientID%>').val().split('/');
                    dataAssinatura = dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0];
                    //dataAssinatura = $('#').val();//6
                }--%>

               <%-- if ($('#<%=txtDTermino.ClientID%>').val() == "") {

                    dataTermino = "";

                } else {

                    dataConvert = $('#<%=txtDTermino.ClientID%>').val().split('/');
                    dataTermino = dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0];
                    //dataTermino = $('#').val();//7
                }
                finalidade = $('#<%=txtFinalidade.ClientID%>').val();//8



                if ($('#<%=txtATerreno.ClientID%>').val() != "") {

                    areaTerreno = $('#<%=txtATerreno.ClientID%>').val().split('.');//9
                    areaTerreno = areaTerreno.join('');
                    areaTerreno = areaTerreno.replace(",", "virgulaaspx");
                } else {
                    areaTerreno = "NULL";
                }

                if ($('#<%=txtABenfeitoria.ClientID%>').val() != "") {

                    areaBenfeitoria = $('#<%=txtABenfeitoria.ClientID%>').val().split('.');//10
                    areaBenfeitoria = areaBenfeitoria.join('');
                    areaBenfeitoria = areaBenfeitoria.replace(",", "virgulaaspx");

                } else {
                    areaBenfeitoria = "NULL";
                }

                situacaoContrato = $('#<%=txtSContrato.ClientID%>').val();//11

                if ($('#<%=txtDSituacao.ClientID%>').val() == "") {

                    dataSituacao = "";

                } else {

                    dataConvert = $('#<%=txtDSituacao.ClientID%>').val().split('/');
                    dataSituacao = dataConvert[2] + "-" + dataConvert[1] + "-" + dataConvert[0];
                    //dataSituacao = $('#').val();//12
                }--%>


               <%-- uniPrazo = $('#<%=ddlUPrazo.ClientID%>').val();//13--%>




                var valores = [promissario, promitente, tipoContrato, numero, prazo, objeto,
                dataAssinatura, dataTermino, finalidade, areaTerreno, areaBenfeitoria, situacaoContrato, dataSituacao, uniPrazo];
                
                var contrato = valores.join("|");

                var txt = document.getElementById('tableContratos').innerHTML;
                var classid = " ";
                var style = "";
                if (promissario == "" && promitente == "" && tipoContrato == "" && numero != "" && prazo == "" && objeto != "" && dataAssinatura == ""
                && dataTermino == "" && finalidade == "" && areaTerreno == "" && areaBenfeitoria == "" && situacaoContrato == "" && dataSituacao == "" && uniPrazo == "0") {

                    



                    contratopk = getContrato(numero, objeto);

                    

                    //alert("Depois timeout" + contratopk)

                    if (contratopk != 0) {

                        //alert("obj" + contratopk)
                        if ($('#<%=hfContratos.ClientID%>').val() == "") {
                            document.getElementById('<%=hfContratos.ClientID%>').value += "_id" + contratopk;
                        } else {
                            document.getElementById('<%=hfContratos.ClientID%>').value += '+' + "_id" + contratopk;
                        }

                        classid = "_id" + contratopk;
                        style = "background-color: #cce5fa;"

                    } else {
                        //alert("Entrou")
                        return
                    }

                } else {

                    if ($('#<%=hfContratos.ClientID%>').val() == "") {
                        document.getElementById('<%=hfContratos.ClientID%>').value += contrato;
                    } else {
                        document.getElementById('<%=hfContratos.ClientID%>').value += '+' + contrato;
                    }

                    classid = valores.join("");

                }

                

                txt += "<tr style='"+ style +"' class='" + classid + "'>"
                    + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>"
                    + valores[3]
                    + "</td>"
                    + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc; '>"
                    + valores[5]
                    + "</td>"
                    + "<td style=' padding-left: 10px; padding-right: 10px;  border-bottom: 1px solid #cccccc;'>"
                    + "<span style=' padding-bottom:1px; ' class='glyphicon glyphicon-remove'  onclick='javascript:removeContrato(this)' id='" + classid + "'></span>"
                    + "</td>"
                + "</tr>";

                document.getElementById('tableContratos').innerHTML = txt;

                setTimeout(function () {
                    document.getElementById('<%=txtPromissario.ClientID%>').value = "";//0
                   <%-- document.getElementById('<%=txtPromitente.ClientID%>').value = "";//1
                    document.getElementById('<%=txtTContrato.ClientID%>').value = "";//2--%>
                    document.getElementById('<%=txtNumero.ClientID%>').value = "";//3
                    <%--document.getElementById('<%=txtPrazo.ClientID%>').value = "";//4
                  --%> <%-- document.getElementById('<%=txtObjeto.ClientID%>').value = "";//5--%>
                   <%-- document.getElementById('<%=txtDAssinatura.ClientID%>').value = "";//6
                    document.getElementById('<%=txtDTermino.ClientID%>').value = "";//7
                    document.getElementById('<%=txtFinalidade.ClientID%>').value = "";//8
                    document.getElementById('<%=txtATerreno.ClientID%>').value = "";//9
                    document.getElementById('<%=txtABenfeitoria.ClientID%>').value = "";;//10
                    document.getElementById('<%=txtSContrato.ClientID%>').value = "";//11
                    document.getElementById('<%=txtDSituacao.ClientID%>').value = "";//12--%>
                   <%-- document.getElementById('<%=ddlUPrazo.ClientID%>').value = "0";//13--%>
                }, 10);

            });

        });

        //////////////////////////////////////////
        //                                      //
        //           PASTAS                     //
        //                                      //
        //////////////////////////////////////////
        function getDivPastas(imovelPK) {
            $.ajax({
                url: '<%=ResolveUrl("~/Service.asmx/GetPastasGrid") %>',
                data: "{ 'imovelPK': '" + imovelPK + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    var parsed = $.parseJSON(data.d);
                    var txt = "";
                    $.each(parsed, function (i, jsondata) {
                        txt += '<span id="' + jsondata.COD_PASTA_CODEMIG + '" style="padding-right:2px; padding-left:2px; margin-right: 5px; border: 1px solid #cccccc; border-radius: 2px;">' + jsondata.COD_PASTA_CODEMIG + ' &nbsp;<span style=" padding-bottom:1px; " class="glyphicon glyphicon-remove"  onclick="javascript:removePasta(' + jsondata.COD_PASTA_PK + ', ' + $('#<%=hfImovelPK.ClientID%>').val() + ')" id="' + jsondata.COD_PASTA_PK + '"></span></span>';
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
        /////////////////////////////////////////
        function removePasta(pastaPK, imovelPK) {

            if (confirm("Deseja excluir Pasta?")) {

                $.ajax({
                    type: "POST",
                    url: '<%=ResolveUrl("~/Service.asmx/removePastaImovel") %>',
                    data: "{ 'pastaPK':'" + pastaPK + "', 'imovelPK': '" + imovelPK + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d > 0) {
                            //alert(data.d)
                            //alert(imovelPK)
                            getDivPastas(imovelPK)
                            $('.statusPasta').css("background-color", "rgb(217, 83, 79)");
                            $('.statusPasta').html('&nbsp;&nbsp;Deletado&nbsp;&nbsp;')
                            $('.statusPasta').fadeIn();
                            setTimeout(function () {
                                $('.statusPasta').fadeOut();
                                //$('.statusPasta').html('')
                            }, 3000);

                        }

                    },
                    error: function (XHR, errStatus, errorThrown) {
                        var err = JSON.parse(XHR.responseText);
                        errorMessage = err.Message;
                        alert(errorMessage);
                    }
                });

            }
        }
        //////////////////////////////////////////
        //                                      //
        //           DADOS CARTORIAIS           //
        //                                      //
        //////////////////////////////////////////
        function getTableDCartoriais(imovelPK) {
            $.ajax({
                url: '<%=ResolveUrl("~/Service.asmx/GetDadosCartoriais") %>',
                data: "{ 'imovelPK': '" + imovelPK + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var parsed = $.parseJSON(data.d);
                    var cont = 0;
                    var txt = "";
                    $.each(parsed, function (i, jsondata) {
                        if (cont == 0) {
                            txt += "<tr> "
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Matrícula "
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Comarca "
                                + "</td>"
                                + "<td style='padding-left: 10px; padding-right: 10px; border-bottom: 1px solid #cccccc;'> "
                                + "   <center><i class='fa fa-gear'></i></center> "
                                + "</td> "
                                + "</tr> ";
                            txt += '<tr>'
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; '>"
                                + jsondata.NUM_MATRICULA
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;' >"
                                + jsondata.COMARCA
                                + "</td>"
                                + "<td style=''>"
                                + '<center><i title="editar"  style="cursor:pointer;margin-right:4px;" onclick="javascript:editDCartoriais(' + jsondata.COD_MATRICULA_PK + ',\'' + jsondata.NUM_MATRICULA + '\'' + ',\'' + jsondata.COMARCA + '\');" class="fa fa-pencil-square-o"></i><span style="cursor:pointer;" title="deletar" onclick="javascript:removeDCartoriais(' + jsondata.COD_MATRICULA_PK + ');" class="glyphicon glyphicon-remove "></span></center>'
                                + "</td>"
                                + "</tr>";

                        } else {
                            txt += '<tr>'
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; '>"
                                + jsondata.NUM_MATRICULA
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; ' >"
                                + jsondata.COMARCA
                                + "</td>"
                                + "<td style=''>"
                                + '<center><i title="editar"  style="cursor:pointer;margin-right:4px;" onclick="javascript:editDCartoriais(' + jsondata.COD_MATRICULA_PK + ',\'' + jsondata.NUM_MATRICULA + '\'' + ',\'' + jsondata.COMARCA + '\');" class="fa fa-pencil-square-o"></i><span style="cursor:pointer;" title="deletar" onclick="javascript:removeDCartoriais(' + jsondata.COD_MATRICULA_PK + ');" class="glyphicon glyphicon-remove "></span></center>'
                                + "</td>"
                                + "</tr>";
                        }
                        cont++;

                    })
                    document.getElementById('tableDCartoriais').innerHTML = txt;

                },
                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });
        }
        
        ///////////////////////////////////////////
        function removeDCartoriais(dCartoriaisPK) {

            if (confirm("Deseja excluir dados cartoriais?")) {

                $.ajax({
                    type: "POST",
                    url: '<%=ResolveUrl("~/Service.asmx/removeDCartoriaisImovel") %>',
                    data: "{ 'dCartoriaisPK':'" + dCartoriaisPK + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d > 0) {
                            getTableDCartoriais($('#<%=hfImovelPK.ClientID%>').val())
                            $('.statusDCartoriais').css("color", "green");
                            $('.statusDCartoriais').html('&nbsp;&nbsp;Deletado&nbsp;&nbsp;')
                            $('.statusDCartoriais').fadeIn();
                            setTimeout(function () {
                                $('.statusDCartoriais').fadeOut();
                                limpaDCartoriais()
                            }, 3000);
                        } else {
                            $('.statusDCartoriais').css("color", "red");
                            $('.statusDCartoriais').html('&nbsp;&nbsp;Não deletado&nbsp;&nbsp;')
                            $('.statusDCartoriais').fadeIn();
                            setTimeout(function () {
                                $('.statusDCartoriais').fadeOut();
                            }, 3000);
                        }

                    },
                    error: function (XHR, errStatus, errorThrown) {
                        var err = JSON.parse(XHR.responseText);
                        errorMessage = err.Message;
                        alert(errorMessage);
                    }
                });

            }
        }
        //////////////////////////////////////////////////////////////////////////
        function editDCartoriais(dCartoriaisPK, numMatricula, comarca) {

            $('.cadastrarDCartoriais').fadeOut();
            setTimeout(function () {
                $('.atualizarDCartoriais').fadeIn();
                $('#limparDCartoriais').fadeIn();
            }, 1000);
            
            
            $('#<%=HiddenFieldDCartoriais.ClientID %>').val(dCartoriaisPK);
            $('#<%=txtMatricula.ClientID %>').val(numMatricula);
            <%--$('#<%=txtRLivro.ClientID %>').val(refLivro);--%>
            $('#<%=txtComarca.ClientID %>').val(comarca);

        }
        /////////////////////////////
        function limpaDCartoriais() {

            $('.atualizarDCartoriais').fadeOut();
            $('#limparDCartoriais').fadeOut();
            
            setTimeout(function () {
                $('.cadastrarDCartoriais').fadeIn();
            }, 1000);

            $('#<%=txtMatricula.ClientID %>').val('')
            <%--$('#<%=txtRLivro.ClientID %>').val('')--%>
            $('#<%=txtComarca.ClientID %>').val('')
        }
        //////////////////////////////////////////
        //                                      //
        //           TRIBUTOS                   //
        //                                      //
        //////////////////////////////////////////
        function getTableTributos(imovelPK) {
            $.ajax({
                url: '<%=ResolveUrl("~/Service.asmx/GetTributos") %>',
                data: "{ 'imovelPK': '" + imovelPK + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var parsed = $.parseJSON(data.d);
                    var cont = 0;
                    var txt = "";
                    $.each(parsed, function (i, jsondata) {
                        if (cont == 0) {
                            txt += "<tr> "
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Tipo "
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Certidão Negativa "
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Ano "
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Valor "
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Código "
                                + "</td>"
                                + "<td style='padding-left: 10px; padding-right: 10px; border-bottom: 1px solid #cccccc;'> "
                                + "   <center><i class='fa fa-gear'></i></center> "
                                + "</td> "
                                + "</tr> ";
                            txt += '<tr>'
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; '>"
                                + jsondata.TIPO_TRIBUTO
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; '>"
                                + jsondata.CERTIDAO_NEGATIVA
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;' >"
                                + jsondata.ANO_PAGAMENTO
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;' >"
                                + jsondata.VALOR_PAGO
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;' >"
                                + jsondata.COD_TRIBUTO
                                + "</td>"
                                + "<td style=''>"
                                + '<center><i title="editar"  style="cursor:pointer;margin-right:4px;" onclick="javascript:editTributo(' + jsondata.COD_TRIBUTO_PK + ',\'' + jsondata.TIPO_TRIBUTO + '\'' + ',\'' + jsondata.CERTIDAO_NEGATIVA + '\'' + ',' + jsondata.ANO_PAGAMENTO + ',' + jsondata.VALOR_PAGO + ',\'' + jsondata.COD_TRIBUTO + '\');" class="fa fa-pencil-square-o"></i><span style="cursor:pointer;" title="deletar" onclick="javascript:removeTributo(' + jsondata.COD_TRIBUTO_PK + ');" class="glyphicon glyphicon-remove "></span></center>'
                                + "</td>"
                                + "</tr>";

                        } else {
                            txt += '<tr>'
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; '>"
                                + jsondata.TIPO_TRIBUTO
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; '>"
                                + jsondata.CERTIDAO_NEGATIVA
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;' >"
                                + jsondata.ANO_PAGAMENTO
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;' >"
                                + jsondata.VALOR_PAGO
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;' >"
                                + jsondata.COD_TRIBUTO
                                + "</td>"
                                + "<td style=''>"
                                + '<center><i title="editar"  style="cursor:pointer;margin-right:4px;" onclick="javascript:editTributo(' + jsondata.COD_TRIBUTO_PK + ',\'' + jsondata.TIPO_TRIBUTO + '\'' + ',\'' + jsondata.CERTIDAO_NEGATIVA + '\'' + ',' + jsondata.ANO_PAGAMENTO + ',' + jsondata.VALOR_PAGO + ',\'' + jsondata.COD_TRIBUTO + '\');" class="fa fa-pencil-square-o"></i><span style="cursor:pointer;" title="deletar" onclick="javascript:removeTributo(' + jsondata.COD_TRIBUTO_PK + ');" class="glyphicon glyphicon-remove "></span></center>'
                                + "</td>"
                                + "</tr>";
                        }
                        cont++;

                    })
                    document.getElementById('tableTributos').innerHTML = txt;

                },
                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });
        }

        ///////////////////////////////////////////
        function removeTributo(tributoPK) {

            if (confirm("Deseja excluir tributo?")) {

                $.ajax({
                    type: "POST",
                    url: '<%=ResolveUrl("~/Service.asmx/removeTributosImovel") %>',
                    data: "{ 'tributoPK':'" + tributoPK + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d > 0) {
                            getTableTributos($('#<%=hfImovelPK.ClientID%>').val())
                            $('.statusTributos').css("color", "green");
                            $('.statusTributos').html('&nbsp;&nbsp;Deletado&nbsp;&nbsp;')
                            $('.statusTributos').fadeIn();
                            setTimeout(function () {
                                $('.statusTributos').fadeOut();
                                limpaTributos()
                            }, 3000);
                        } else {
                            $('.statusTributos').css("color", "red");
                            $('.statusTributos').html('&nbsp;&nbsp;Não deletado&nbsp;&nbsp;')
                            $('.statusTributos').fadeIn();
                            setTimeout(function () {
                                $('.statusTributos').fadeOut();
                            }, 3000);
                        }

                    },
                    error: function (XHR, errStatus, errorThrown) {
                        var err = JSON.parse(XHR.responseText);
                        errorMessage = err.Message;
                        alert(errorMessage);
                    }
                });

            }
        }
        //////////////////////////////////////////////////////////////////////////
        function editTributo(codTributoPK, tipo, cNegativa, ano, valor, codTributo) {

            $('.cadastrarTributos').fadeOut();
            setTimeout(function () {
                $('.atualizarTributos').fadeIn();
                $('#limparTributos').fadeIn();
            }, 1000);


            $('#<%=HiddenFieldTributos.ClientID %>').val(codTributoPK);

            $('#<%=ddlTTributo.ClientID %>').val(tipo.split('(')[0]);

            if (tipo.split('(')[0] == 'OUTRO') {
                $('#<%=txtTTributo.ClientID %>').prop('disabled', false)
                $('#<%=txtTTributo.ClientID %>').val(tipo.split('(')[1].replace(')', ''));
            }
                

            $('#<%=ddlCNegativa.ClientID %>').val(cNegativa);
            $('#<%=txtAno.ClientID %>').val(ano);
            $('#<%=txtValor.ClientID %>').val(valor);
            $('#<%=txtCodigo.ClientID %>').val(codTributo);

        }
        /////////////////////////////
        function limpaTributos() {

            $('.atualizarTributos').fadeOut();
            $('#limparTributos').fadeOut();

            setTimeout(function () {
                $('.cadastrarTributos').fadeIn();
            }, 1000);

            $('#<%=ddlTTributo.ClientID %>').val('0');

            $('#<%=txtTTributo.ClientID %>').val('');
            $('#<%=txtTTributo.ClientID %>').prop('disabled', true)
            
            $('#<%=ddlCNegativa.ClientID %>').val('0');
            $('#<%=txtAno.ClientID %>').val('');
            $('#<%=txtValor.ClientID %>').val('');
            $('#<%=txtCodigo.ClientID %>').val('');

        }
        //////////////////////////////////////////
        //                                      //
        //           CONTRATOS                  //
        //                                      //
        //////////////////////////////////////////
        function getTableContratos(imovelPK) {
            $.ajax({
                url: '<%=ResolveUrl("~/Service.asmx/GetContratosGrid") %>',
                data: "{ 'imovelPK': '" + imovelPK + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    var parsed = $.parseJSON(data.d);
                    var txt = "";
                    var cont = 0;

                    $.each(parsed, function (i, jsondata) {

                        /*date = new Date(parseInt(jsondata.DATA_ASSINATURA.substr(6)))
                        var jsonAssinatura = JSON.stringify(date).split("T")[0].split("-")
                        dataAssinatura = jsonAssinatura[2] + "/" + jsonAssinatura[1] + "/" + jsonAssinatura[0].replace('"', '')
                        */
                        var toString = '\'' + jsondata.PROMISSARIO + '\',' + jsondata.NUM_CONTRATO + ', \'' + jsondata.DATA_ASSINATURA + '\', \'' + jsondata.DATA_VENCIMENTO + '\', ' + jsondata.COD_CONTRATO_PK;
                            
                        //alert(toString)
                        
                        if (cont == 0) {
                            txt += "<tr> "
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Número "
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; border-bottom: 1px solid #cccccc;'>Promissário "
                                + "</td>"
                                + "<td style='padding-left: 10px; padding-right: 10px; border-bottom: 1px solid #cccccc;'> "
                                + "   <center><i class='fa fa-gear'></i></center> "
                                + "</td> "
                                + "</tr> ";
                            txt += '<tr>'
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;'>"
                                + jsondata.NUM_CONTRATO
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;'>"
                                + jsondata.PROMISSARIO
                                + "</td>"
                                + "<td style=''>"
                                + '<center><i title="editar"  style="cursor:pointer;margin-right:4px;" onclick="javascript:editContrato(' + toString + ');" class="fa fa-pencil-square-o"></i><span style="cursor:pointer;" title="deletar" onclick="javascript:removeContrato(' + jsondata.COD_CONTRATO_PK + ', ' + $('#<%=hfImovelPK.ClientID%>').val() + ')" class="glyphicon glyphicon-remove "></span></center>'
                                + "</td>"
                                + "</tr>";

                        } else {
                            txt += '<tr>'
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;'>"
                                + jsondata.NUM_CONTRATO
                                + "</td>"
                                + "<td style='white-space: nowrap; padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;'>"
                                + jsondata.PROMISSARIO
                                + "</td>"
                                + "<td style=''>"
                                + '<center><i title="editar"  style="cursor:pointer;margin-right:4px;" onclick="javascript:editContrato(' + toString + ');" class="fa fa-pencil-square-o"></i><span style="cursor:pointer;" title="deletar" onclick="javascript:removeContrato(' + jsondata.COD_CONTRATO_PK + ', ' + $('#<%=hfImovelPK.ClientID%>').val() + ')" class="glyphicon glyphicon-remove "></span></center>'
                                + "</td>"
                                + "</tr>";
                        }
                        cont++;

                    })

                    document.getElementById('tableContratos').innerHTML = txt;

                },
                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });
        }
        /////////////////////////////////////////
        function removeContrato(contratoPK, imovelPK) {



            if (confirm("Deseja excluir contrato?")) {

                $.ajax({
                    type: "POST",
                    url: '<%=ResolveUrl("~/Service.asmx/removeContratoImovel") %>',
                    data: "{ 'contratoPK':'" + contratoPK + "', 'imovelPK': '" + imovelPK + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d > 0) {
                            //alert(data.d)
                            //alert(imovelPK)
                            getTableContratos($('#<%=hfImovelPK.ClientID%>').val())
                            $('.statusContrato').css("color", "green");
                            $('.statusContrato').html('&nbsp;&nbsp;Deletado&nbsp;&nbsp;')
                            $('.statusContrato').fadeIn();
                            setTimeout(function () {
                                $('.statusContrato').fadeOut();
                                //$('.statusPasta').html('')
                            }, 3000);

                        }

                    },
                    error: function (XHR, errStatus, errorThrown) {
                        var err = JSON.parse(XHR.responseText);
                        errorMessage = err.Message;
                        alert(errorMessage);
                    }
                });

            }
        }
        /////////////////////////////////////////////////////////////////////////////
        function editContrato(promissario, numContrato, dataAssinatura, dataVencimento, contratoPK) {
            $('.cadastrarContratos').fadeOut();
            setTimeout(function () {
                $('.atualizarContratos').fadeIn();
                $('#limparContratos').fadeIn();
            }, 1000);

            $('#<%=HiddenFieldContratos.ClientID %>').val(contratoPK);

            $('#<%=txtPromissario.ClientID%>').val(promissario);//12
           <%-- $('#<%=txtPromitente.ClientID%>').val(promitente);//1
            $('#<%=txtTContrato.ClientID%>').val(tipoContrato);//2--%>
            $('#<%=txtNumero.ClientID%>').val(numContrato);//3
            <%--$('#<%=txtObjeto.ClientID%>').val(objeto);//5--%>
           <%-- $('#<%=txtFinalidade.ClientID%>').val(finalidade);//8
            $('#<%=txtATerreno.ClientID%>').val(areaTerreno);//9
            $('#<%=txtABenfeitoria.ClientID%>').val(areaBenfeitoria);;//10
            $('#<%=txtSContrato.ClientID%>').val(situacaoContrato);//11--%>

           <%-- $('#<%=ddlUPrazo.ClientID%>').val(unidadePrazo);//12--%>
            <%--$('#<%=txtPrazo.ClientID%>').val(prazo);//4--%>


            date = new Date(parseInt(dataAssinatura.substr(6)))
            var jsonAssinatura = JSON.stringify(date).split("T")[0].split("-")
            dataAssinatura = jsonAssinatura[2] + "/" + jsonAssinatura[1] + "/" + jsonAssinatura[0].replace('"', '')

            date = new Date(parseInt(dataVencimento.substr(6)))
            var jsonVencimento = JSON.stringify(date).split("T")[0].split("-")
            dataVencimento = jsonVencimento[2] + "/" + jsonVencimento[1] + "/" + jsonVencimento[0].replace('"', '')

            $('#<%=txtDAssinatura.ClientID%>').val(dataAssinatura);//6
            $('#<%=txtDVencimento.ClientID%>').val(dataVencimento);//7
            <%--$('#<%=txtDSituacao.ClientID%>').val(dataSituacao);//12--%>

        }
        ///////////////////////////
        function limpaContratos() {

            $('.atualizarContratos').fadeOut();
            $('#limparContratos').fadeOut();

            setTimeout(function () {
                $('.cadastrarContratos').fadeIn();
            }, 1000);

            $('#<%=HiddenFieldContratos.ClientID %>').val('');

            $('#<%=txtPromissario.ClientID%>').val('');//12
            <%--$('#<%=txtPromitente.ClientID%>').val('');//1
            $('#<%=txtTContrato.ClientID%>').val('');//2--%>
            $('#<%=txtNumero.ClientID%>').val('');//3
           <%-- $('#<%=txtObjeto.ClientID%>').val('');//5--%>
            <%--$('#<%=txtFinalidade.ClientID%>').val('');//8
            $('#<%=txtATerreno.ClientID%>').val('');//9
            $('#<%=txtABenfeitoria.ClientID%>').val('');;//10
            $('#<%=txtSContrato.ClientID%>').val('');//11--%>

            <%--$('#<%=ddlUPrazo.ClientID%>').val('0');//12--%>
            <%--$('#<%=txtPrazo.ClientID%>').val('');//4--%>

            $('#<%=txtDAssinatura.ClientID%>').val('');//6
            $('#<%=txtDVencimento.ClientID%>').val('');//7
            <%--$('#<%=txtDSituacao.ClientID%>').val('');//12--%>

        }



        jQuery(function ($) {
            
            //Máscaras Validação
            $(".txtArea").maskMoney({ thousands: '.', decimal: ',' });
            $('.txtNumero').mask("0000000000");
            $('.numeroTxt').mask("0000000000");
            $(".cepTxt").mask("00000-000", { clearIfNotMatch: true });
            $(".data").mask("00/00/0000", { clearIfNotMatch: true });
            $(".area").maskMoney({ thousands: '.', decimal: ',', affixesStay: false });
            $(".ano").mask("0000", { clearIfNotMatch: true });
            $(".dinheiro").maskMoney({ prefix: 'R$ ', allowNegative: true, thousands: '.', decimal: ',', affixesStay: false });
            $('.txtPrazo').mask("0000000000000");

           <%-- $(".ddlUPrazo").change(function () {

                if ($('#<%=ddlUPrazo.ClientID%>').val() == "0") {
                    $('#<%=txtPrazo.ClientID%>').prop('disabled', true);
                }
                else {
                    $('#<%=txtPrazo.ClientID%>').prop('disabled', false);
                }
            });--%>

            /*
            *Exibe/Esconde formulário, muda o ícone triangular
            */
            $("#showCadastroPastas").click(function () {
                //if (document.getElementById('showCadastroPastas').className == 'glyphicon glyphicon-triangle-bottom pull-right') {
                $(".informacoes").hide(1000);
                $(".tributos").hide(1000)
                $(".dadoscartoriais").hide(1000);
                $(".contrato").hide(1000);
                $(".cadastroPastas").show(1000);

                
            
                $("#showCadastroTributo").removeClass('active');
                $("#showCadastroContratos").removeClass('active');
                $("#showCadastroDCartoriais").removeClass('active');
                $("#showCadastroInfo").removeClass('active');
                $("#showCadastroPastas").addClass('active');
                <%--$('#<%=bntCadastrar.ClientID%>').fadeIn(1000);--%>
                 /*   document.getElementById('hideCadastro').className = 'glyphicon glyphicon-triangle-top pull-right';
                } else {
                    $(".cadastroImovel").hide(1000)
                    document.getElementById('hideCadastro').className = 'glyphicon glyphicon-triangle-bottom pull-right';

                };*/
            });

            $("#showCadastroInfo").click(function () {
                //if (document.getElementById('showCadastroPastas').className == 'glyphicon glyphicon-triangle-bottom pull-right') {
                $(".cadastroPastas").hide(1000);
                $(".tributos").hide(1000)
                $(".dadoscartoriais").hide(1000);
                $(".contrato").hide(1000);
                $(".informacoes").show(1000);


                $("#showCadastroPastas").removeClass('active');
                $("#showCadastroTributos").removeClass('active');
                $("#showCadastroContratos").removeClass('active');
                $("#showCadastroInfo").addClass('active');
                $("#showCadastroDCartoriais").removeClass('active');
            });



         

            $("#showCadastroDCartoriais").click(function () {
                //if (document.getElementById('hideDadosCartoriais').className == 'glyphicon glyphicon-triangle-bottom pull-right') {
                $(".dadoscartoriais").show(1000);
                $(".tributos").hide(1000);
                $(".cadastroPastas").hide(1000);
                $(".informacoes").hide(1000);
                $(".contrato").hide(1000);


                $("#showCadastroPastas").removeClass('active');
                $("#showCadastroTributos").removeClass('active');
                $("#showCadastroContratos").removeClass('active');
                $("#showCadastroInfo").removeClass('active');
                $("#showCadastroDCartoriais").addClass('active');
                    /*document.getElementById('hideDadosCartoriais').className = 'glyphicon glyphicon-triangle-top pull-right';
                } else {
                    $(".dadoscartoriais").hide(1000)
                    document.getElementById('hideDadosCartoriais').className = 'glyphicon glyphicon-triangle-bottom pull-right';

                };*/
            });

            

            $("#showCadastroTributos").click(function () {
                $(".informacoes").hide(1000);
                $(".cadastroPastas").hide(1000);
                $(".tributos").show(1000);
                $(".dadoscartoriais").hide(1000);
                $(".contrato").hide(1000);


                $("#showCadastroPastas").removeClass('active');
                $("#showCadastroTributos").addClass('active');
                $("#showCadastroContratos").removeClass('active');
                $("#showCadastroInfo").removeClass('active');
                $("#showCadastroDCartoriais").removeClass('active');
            });

            $("#showCadastroContratos").click(function () {
                $(".informacoes").hide(1000);
                $(".cadastroPastas").hide(1000);
                $(".tributos").hide(1000);
                $(".dadoscartoriais").hide(1000);
                $(".contrato").show(1000);


                $("#showCadastroPastas").removeClass('active');
                $("#showCadastroTributos").removeClass('active');
                $("#showCadastroContratos").addClass('active');
                $("#showCadastroInfo").removeClass('active');
                $("#showCadastroDCartoriais").removeClass('active');
            });

            

        });


        $(function () {
            /**
            * Executa ao clicar em cadastro de volume
            */
            $(document).on('click', '.cadastroInfo', function (e) {

                setTimeout(function () {
                    $('#<%=lblCadastradoInfo.ClientID %>').val('');
                    $('#<%=lblCadastradoInfo.ClientID %>').fadeOut();

                }, 3000);

            });

            $(document).on('click', '.updateInfo', function (e) {

               
                setTimeout(function () {
                    $('#<%=lblCadastradoInfo.ClientID %>').val('');
                    $('#<%=lblCadastradoInfo.ClientID %>').fadeOut();
                    $('#limpartudo').fadeIn();
                    $('.deleteImovel').fadeIn();

                }, 3000);

            });
            $(document).on('click', '.cadastrarDCartoriais', function (e) {

                setTimeout(function () {
                    $('#<%=lblCadastradoDCartoriais.ClientID %>').val('');
                    $('#<%=lblCadastradoDCartoriais.ClientID %>').fadeOut();

                    getTableDCartoriais($('#<%=hfImovelPK.ClientID%>').val())
                }, 3000);

            });

            $(document).on('click', '.atualizarDCartoriais', function (e) {


                setTimeout(function () {

                    $('#<%=lblCadastradoDCartoriais.ClientID%>').val('');
                    $('#<%=lblCadastradoDCartoriais.ClientID%>').fadeOut();
                    

                    getTableDCartoriais($('#<%=hfImovelPK.ClientID%>').val())
                }, 3000);

            });

            $(document).on('click', '.cadastrarTributos', function (e) {

                setTimeout(function () {
                    $('#<%=lblCadastradoTributos.ClientID %>').val('');
                    $('#<%=lblCadastradoTributos.ClientID %>').fadeOut();

                    getTableTributos($('#<%=hfImovelPK.ClientID%>').val())
                }, 3000);

            });

            $(document).on('click', '.atualizarTributos', function (e) {


                setTimeout(function () {

                    $('#<%=lblCadastradoTributos.ClientID%>').val('');
                    $('#<%=lblCadastradoTributos.ClientID%>').fadeOut();


                    getTableTributos($('#<%=hfImovelPK.ClientID%>').val())
                }, 3000);

            });

            $(document).on('click', '.cadastrarContratos', function (e) {

                setTimeout(function () {
                    $('#<%=lblCadastradoContratos.ClientID %>').val('');
                    $('#<%=lblCadastradoContratos.ClientID %>').fadeOut();

                    getTableContratos($('#<%=hfImovelPK.ClientID%>').val())
                }, 3000);

            });

            $(document).on('click', '.atualizarContratos', function (e) {


                setTimeout(function () {

                    $('#<%=lblCadastradoContratos.ClientID%>').val('');
                    $('#<%=lblCadastradoContratos.ClientID%>').fadeOut();


                    getTableContratos($('#<%=hfImovelPK.ClientID%>').val())
                }, 3000);

            });


        });



        <%--
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
        --%>
    </script>
    <script>


        var markers = [];
        
        
        function initMap() {
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 15,
                center: { lat: -19.926, lng: -43.921 }
            });

            var geocoder = new google.maps.Geocoder();

            
           
                geocodeAddress(geocoder, map);
                
            
            

           // document.getElementById('submitGeo').addEventListener('click', function () {
                
               // geocodeAddress(geocoder, map);


            //});


            




        }


        

        function geocodeAddress(geocoder, resultsMap) {

            var tipologradouro = ""
            var estado = "";
            if (document.getElementById('<%=ddlEstados.ClientID%>').value == "0") {
                estado = "";
            }
            else {
                estado = document.getElementById('<%=ddlEstados.ClientID%>').value;
            }
            if (document.getElementById('<%=ddlTipo.ClientID%>').value == "0") {
                tipologradouro = "";
            }
            else {
                tipologradouro = document.getElementById('<%=ddlTipo.ClientID%>').value

            }
            var precisao = "";
            var type = "";
            var address = tipologradouro + " " +
                          document.getElementById('<%=txtNRua.ClientID%>').value + ", " +
                          document.getElementById('<%=numeroTxt.ClientID%>').value + ", " +
                          document.getElementById('<%=txtBairro.ClientID%>').value + ", " +
                          document.getElementById('<%=SearchCidade.ClientID%>').value + ", " +
                          estado + ", " +
                          document.getElementById('<%=txtCEP.ClientID%>').value;


            if (estado != "") {



                geocoder.geocode({ 'address': address + ', Brasil', 'region': 'BR' }, function (results, status) {



                    if (status === google.maps.GeocoderStatus.OK) {

                        resultsMap.setCenter(results[0].geometry.location);

                        for (var i = 0; i < markers.length; i++) {
                            markers[i].setMap(null);
                        }



                        var iconBase = 'https://maps.google.com/mapfiles/kml/shapes/';



                        var marker = new google.maps.Marker({
                            draggable: true,
                            map: resultsMap,
                            icon: 'img/pin.png',
                            position: results[0].geometry.location
                        });
                        markers.push(marker);

                        document.getElementById('<%=hfLat.ClientID%>').value = marker.getPosition().lat();
                        document.getElementById('<%=hfLng.ClientID%>').value = marker.getPosition().lng();

                        /*setTimeout(function () {
    
                        }, 5000);*/

                        google.maps.event.addListener(marker, 'dragend', function (event) {
                            document.getElementById('<%=hfLat.ClientID%>').value = marker.getPosition().lat();
                            document.getElementById('<%=hfLng.ClientID%>').value = marker.getPosition().lng();

                        });

                        google.maps.event.addListener(marker, 'drag', function (event) {
                            document.getElementById('latlng').innerHTML = marker.getPosition().lat() + ", " + marker.getPosition().lng();
                        });

                        ///////alert precisão e starus;




                        var precisao = results[0].geometry.location_type;


                        document.getElementById('<%=hfTypes.ClientID%>').value = results[0].types[0];

                        if (results[0].geometry.location_type == "ROOFTOP") {
                            document.getElementById('<%=hfPrecisao.ClientID%>').value = "EXATA";
                        }
                        else if (results[0].geometry.location_type == "RANGE_INTERPOLATED") {
                            document.getElementById('<%=hfPrecisao.ClientID%>').value = "INTERPOLADA";
                        }
                        else if (results[0].geometry.location_type == "GEOMETRIC_CENTER") {
                            document.getElementById('<%=hfPrecisao.ClientID%>').value = "CENTROIDE";
                        }
                        else if (results[0].geometry.location_type == "APPROXIMATE") {

                            document.getElementById('<%=hfPrecisao.ClientID%>').value = "APROXIMADO";
                        }
                        else {
                            document.getElementById('<%=hfPrecisao.ClientID%>').value = results[0].geometry.location_type;

                        }

                        type = results[0].types[0];
                        // chamar função para cadastrar endereço na classe serivce

                    } else {
                        alert('Geocode was not successful for the following reason: ' + status);
                    }
                });
            }
        }



    </script>
    <script src="https://maps.googleapis.com/maps/api/js?signed_in=true&callback=initMap" async defer></script>
    
</asp:Content>
