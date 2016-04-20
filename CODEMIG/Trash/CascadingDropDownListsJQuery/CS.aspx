<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="CS.aspx.cs" Inherits="_Default" EnableEventValidation = "false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
<script type = "text/javascript">
var pageUrl = '<%=ResolveUrl("~/CS.aspx")%>'
function PopulateContinents() {
    $("#<%=ddlCountries.ClientID%>").attr("disabled", "disabled");
    $("#<%=ddlCities.ClientID%>").attr("disabled", "disabled");
    if ($('#<%=ddlContinents.ClientID%>').val() == "0") {
        $('#<%=ddlCountries.ClientID %>').empty().append('<option selected="selected" value="0">Please select</option>');
        $('#<%=ddlCities.ClientID %>').empty().append('<option selected="selected" value="0">Please select</option>');
    }
    else {
        $('#<%=ddlCountries.ClientID %>').empty().append('<option selected="selected" value="0">Loading...</option>');
        $.ajax({
            type: "POST",
            url: pageUrl + '~/CS.aspx/PopulateCountries',
            data: '{continentId: ' + $('#<%=ddlContinents.ClientID%>').val() + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnCountriesPopulated,
            failure: function(response) {
                alert(response.d);
            }
        });
    }
}

function OnCountriesPopulated(response) {
    PopulateControl(response.d, $("#<%=ddlCountries.ClientID %>"));
}
</script>
<script type = "text/javascript">
function PopulateCities() {
    $("#<%=ddlCities.ClientID%>").attr("disabled", "disabled");
    if ($('#<%=ddlCountries.ClientID%>').val() == "0") {
        $('#<%=ddlCities.ClientID %>').empty().append('<option selected="selected" value="0">Please select</option>');
    }
    else {
        $('#<%=ddlCities.ClientID %>').empty().append('<option selected="selected" value="0">Loading...</option>');
        $.ajax({
            type: "POST",
            url: pageUrl + '/PopulateCities',
            data: '{countryId: ' + $('#<%=ddlCountries.ClientID%>').val() + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnCitiesPopulated,
            failure: function(response) {
                alert(response.d);
            }
        });
    }
}

function OnCitiesPopulated(response) {
    PopulateControl(response.d, $("#<%=ddlCities.ClientID %>"));
}
</script>
<script type = "text/javascript">
function PopulateControl(list, control) {
    if (list.length > 0) {
        control.removeAttr("disabled");
        control.empty().append('<option selected="selected" value="0">Please select</option>');
        $.each(list, function() {
            control.append($("<option></option>").val(this['Value']).html(this['Text']));
        });
    }
    else {
        control.empty().append('<option selected="selected" value="0">Not available<option>');
    }
}
</script>
</head>
<body>
    <form id="form1" runat="server">
<div>
Continents:<asp:DropDownList ID="ddlContinents" runat="server" AppendDataBoundItems="true"
             onchange = "PopulateContinents();">
    <asp:ListItem Text = "Please select" Value = "0"></asp:ListItem>                 
</asp:DropDownList>
<br /><br />
Country:<asp:DropDownList ID="ddlCountries" runat="server"
             onchange = "PopulateCities();">
    <asp:ListItem Text = "Please select" Value = "0"></asp:ListItem>                 
</asp:DropDownList>
<br /><br />
City:<asp:DropDownList ID="ddlCities" runat="server">
    <asp:ListItem Text = "Please select" Value = "0"></asp:ListItem>                 
</asp:DropDownList> 
<br />
<asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick = "Submit" />                
</div>
    </form>
</body>
</html>
