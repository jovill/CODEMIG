<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/site.master" CodeBehind="login.aspx.cs" Inherits="login" %>


    <asp:Content runat="server" ContentPlaceHolderID="head">
        
    </asp:Content>

    <asp:Content runat="server" ContentPlaceHolderID="body">
        <center >
            <asp:Label runat="server" ID="sistema">

            </asp:Label>
        </center>

        
        <div class="col-md-5"></div>
        <div  class="col-md-2">

        <form runat="server" class="form-signin">
            <h3 class="form-signin-heading" style="color:#333333;">Autenticação</h3>
            <label for="inputEmail" class="sr-only">Nome de Usuário</label>
            <asp:TextBox runat="server" type="text" id="inputUser" class="form-control" placeholder="Nome de usuário" required autofocus></asp:TextBox>
            <br />
            <label for="inputPassword" class="sr-only">Senha</label>
            <asp:TextBox runat="server" type="password" id="inputPassword" class="form-control" placeholder="Senha" required></asp:TextBox>
            <div class="checkbox">
                <label>
                    <input type="checkbox" value="remember-me"> Lembre-me
                </label>
            </div>
            
            <asp:Button runat="server" OnClick="btnLogOn_Click" class="btn btn-md btn-primary btn-block" type="submit" Text="Entrar" />
            <br /><br />
            <asp:Label ID="Label1" runat="server" Text="" ></asp:Label> 

        </form>

        </div> <!-- /container -->
        <div class="col-md-5"></div>

        <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
        <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
        <script>
            localStorage.setItem('Tempo', 0);

            


        </script>
         
    </asp:Content>