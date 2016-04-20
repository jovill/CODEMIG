<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/site.master" CodeBehind="home.aspx.cs" Inherits="home" %>


    <asp:Content runat="server" ContentPlaceHolderID="head">
        <link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
   
        <style type="text/css">
body {
  margin: 0;
  padding: 0;
}

.socialCircle-item {
  width: 80px;
  height: 80px;
  position: absolute;
  background: #ffffff;
  margin: 50%;
  text-align: center;
  color: red;
  font-size: 30px;
  cursor: pointer;
  border: 1px solid black;
}
.socialCircle-item i {

  color: #808080;
  
}

#logoC{
    display:none;


}

.socialCircle-container {
  position: relative;
  width: 100px;
  height: 100px;
  margin: 0 auto;
}

.socialCircle-center {
  width: 160px;
  height: 160px;
  background: #ffffff;
  margin: 50%;
  position: absolute;
  text-align: center;
  color: #ffffff;
  font-size: 60px;
  cursor: pointer;
  border: 1px solid red;
}
</style>
        
         </asp:Content>
 
    <asp:Content runat="server" ContentPlaceHolderID="body">

        
        

        <form runat="server" class="form-signin">
            <!--<asp:LinkButton runat="server" OnClick="bntCadastrar_Click" type="button" class="btn btn-primary btn-sm pull-right cadastrar" Style="width:100%;" >
                            <center>
                                Consulta
                            </center>
                        </asp:LinkButton>-->

            
        </form>
        <div class="row">
            <div runat="server" id="permissao" visible="false" class="alert alert-warning" >
                  
            </div>
       </div>
        <br/><br/><br/>
       <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4">
            <div runat="server" id="Pai" class="socialCircle-container">
 
   
  
                <div  runat="server" visible="true" id="filhoConsulta" class="socialCircle-item" title="Consulta" ><a href="http://sgp.codemig.com.br/consulta/consulta/?consulta=!#47295924031de8604#abd495347545c58" ><i class="fa fa-database"></i></a></div>
                
                <div  runat="server" visible="true" id="filhoPainel" class="socialCircle-item" title="Painel de Controle" ><a href="paineldecontrole.aspx"><i class="fa fa-gears"></i></a></div>
                <div  runat="server" visible="true" id="filhoImovel" class="socialCircle-item" title="Imovel" ><a href="imóvel.aspx"><i class="fa fa-building"></i></a></div>
                <div  runat="server" visible="true" id="filhoHistorico" class="socialCircle-item" title="Historico"><a href="historico.aspx"><i class="fa fa-th-list"></i></a></div>
                <div  runat="server" visible="true" id="filhoContrato" class="socialCircle-item" title="Contrato"><a href="contrato.aspx"><i class="fa fa-file-text"></i></a></div>
                <div  runat="server" visible="true" id="filhoProcesso" class="socialCircle-item" title="Processo"><a href="processo.aspx"><i class="fa fa-folder-open"></i></a></div>
                <div  runat="server" visible="true" id="filhoEmpresas" class="socialCircle-item" title="Empresa"><a href="empresas.aspx"><i class="fa fa-industry"></i></a></div>
                  
  
                 <div class="socialCircle-center closed" title="Menu"><img src="..\cadastro\img\fav.ico" /></div>
            </div>
        </div>
        <div class="col-md-4"></div>
       </div>
        
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script> 
<script src="scripts/socialCircle.js"></script> 
<script type="text/javascript">
    $(".socialCircle-center").socialCircle({
        rotate: 0,
        radius: 200,
        circleSize: 2,
        speed: 500
    });
</script>
<script type="text/javascript">
    

    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-36251023-1']);
    _gaq.push(['_setDomainName', 'jqueryscript.net']);
    _gaq.push(['_trackPageview']);

    (function () {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();

   
       


    
          
    


</script>
 <script>
     window.onload = function () {
         var url = document.URL;

         if (url.indexOf("aryagis") != -1) {

             document.getElementById('linkADEmpresa').style.display = 'block';


         }
         else {

             document.getElementById('linkADEmpresa').style.display = 'none';

         }
     }

    </script>
       

        <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
       
        <script>
            setTimeout(function () {
                $('#<%=permissao.ClientID%>').fadeOut();

            }, 5000);
            localStorage.setItem('Tempo', 0);
        </script>
         
    </asp:Content>