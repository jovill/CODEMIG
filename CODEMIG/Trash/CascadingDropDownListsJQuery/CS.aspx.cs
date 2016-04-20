using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Collections;

public partial class _Default : System.Web.UI.Page 
{
protected void Page_Load(object sender, EventArgs e)
{
    if (!IsPostBack)
    {
        this.PopulateContinents();
    }
}

private void PopulateContinents()
{
    String strConnString = ConfigurationManager
        .ConnectionStrings["conString"].ConnectionString;
    String strQuery = "select ID, ContinentName from Continents";
    using (SqlConnection con = new SqlConnection(strConnString))
    {
        using (SqlCommand cmd = new SqlCommand())
        {
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = strQuery;
            cmd.Connection = con;
            con.Open();
            ddlContinents.DataSource = cmd.ExecuteReader();
            ddlContinents.DataTextField = "ContinentName";
            ddlContinents.DataValueField = "ID";
            ddlContinents.DataBind();
            con.Close();
        }
    }
}

[System.Web.Services.WebMethod]
public static ArrayList PopulateCountries(int continentId)
{
    ArrayList list = new ArrayList();
    String strConnString = ConfigurationManager
        .ConnectionStrings["conString"].ConnectionString;
    String strQuery = "select ID, CountryName from Countries where ContinentID=@ContinentID";
    using (SqlConnection con = new SqlConnection(strConnString))
    {
        using (SqlCommand cmd = new SqlCommand())
        {
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@ContinentID", continentId);
            cmd.CommandText = strQuery;
            cmd.Connection = con;
            con.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            while (sdr.Read())
            {
                list.Add(new ListItem(
               sdr["CountryName"].ToString(),
               sdr["ID"].ToString()
                ));
            }
            con.Close();
            return list;
        }
    }
}

[System.Web.Services.WebMethod]
public static ArrayList PopulateCities(int countryId)
{
    ArrayList list = new ArrayList();
    String strConnString = ConfigurationManager
        .ConnectionStrings["conString"].ConnectionString;
    String strQuery = "select ID, CityName from Cities where CountryID=@CountryID";
    using (SqlConnection con = new SqlConnection(strConnString))
    {
        using (SqlCommand cmd = new SqlCommand())
        {
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@CountryID", countryId);
            cmd.CommandText = strQuery;
            cmd.Connection = con;
            con.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            while (sdr.Read())
            {
                list.Add(new ListItem(
               sdr["CityName"].ToString(),
               sdr["ID"].ToString()
                ));
            }
            con.Close();
            return list;
        }
    }
}

private void PopulateDropDownList(ArrayList list, DropDownList ddl)
{
    ddl.DataSource = list;
    ddl.DataTextField = "Text";
    ddl.DataValueField = "Value";
    ddl.DataBind();
}

protected void Submit(object sender, EventArgs e)
{
    string continent = Request.Form[ddlContinents.UniqueID];
    string country = Request.Form[ddlCountries.UniqueID];
    string city = Request.Form[ddlCities.UniqueID];

    // Repopulate Countries and Cities
    PopulateDropDownList(PopulateCountries(int.Parse(continent)), ddlCountries);
    PopulateDropDownList(PopulateCities(int.Parse(country)), ddlCities);
    ddlCountries.Items.FindByValue(country).Selected = true;
    ddlCities.Items.FindByValue(city).Selected = true;
}
}
