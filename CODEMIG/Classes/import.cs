using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CODEMIG.Classes
{
    public class import
    {
        public string Reverse(string text)
        {
            char[] cArray = text.ToCharArray();
            string reverse = String.Empty;
            for (int i = cArray.Length - 1; i > -1; i--)
            {
                reverse += cArray[i];
            }
            return reverse;
        }
        public DataTable excel(string arquivo)
        {
            string ext = string.Empty; 
            string aspas = "\""; 
            string Conexao = string.Empty;
            for (int i = arquivo.Length - 1; i < arquivo.Length; i--) 
            { 
                if (arquivo[i] != '.') 
                { 
                    ext += arquivo[i];
                } 
                else 
                { 
                    ext += "."; break;
                } 
            }
            ext = Reverse(ext);
            if (ext == ".xls") 
            {
                Conexao = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" + arquivo + ";" + "Extended Properties=" + aspas + "Excel 8.0;HDR=YES" + aspas;
            }
            if (ext == ".xlsx") 
            { 
                Conexao = "Provider=Microsoft.ACE.OLEDB.12.0; Data Source=" + arquivo + ";" + "Extended Properties=" + aspas + "Excel 12.0;HDR=YES" + aspas; 
            } 
            System.Data.OleDb.OleDbConnection Cn = new System.Data.OleDb.OleDbConnection();
            Cn.ConnectionString = Conexao; Cn.Open(); 
            object[] Restricoes = { null, null, null, "TABLE" };
            DataTable DTSchema = Cn.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, Restricoes);
            if (DTSchema.Rows.Count > 0) 
            { 
                string Sheet = DTSchema.Rows[0]["TABLE_NAME"].ToString();
                System.Data.OleDb.OleDbCommand Comando = new System.Data.OleDb.OleDbCommand("SELECT * FROM [" + Sheet + "]", Cn);
                DataTable Dados = new DataTable();
                System.Data.OleDb.OleDbDataAdapter DA = new System.Data.OleDb.OleDbDataAdapter(Comando); 
                DA.Fill(Dados);
                Cn.Close(); return Dados;
            } return null; 
        }


    }
}