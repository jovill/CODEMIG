using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CODEMIG.Classes
{
    public class StringData
    {
        public String userRole = "";
        public String userID = "";
        public String user = "";
        public String userPw = "";
        public String userName = "";
        public String userProcesso = "";
        public String userHistorico = "";
        public String userContrato = "";
        public String userImovel = "";
        public String userEmpresas = "";
        public String userPermission = "";
        public int userSistema;

        public String recordStatus = "";

        public String toJson()
        {
            String json = "({ " +
                " userID: '" + this.userID
                + "', userName: '" + this.userName + "'"
                + "', userEmail: '" + this.user
                + "', userPw: '" + this.userPw
                + "',  userRole: '" + this.userRole
                + "',  recordStatus: '" + this.recordStatus + "' "
                + "', userProcesso: '"+this.userProcesso + "'"
                + "', userHistorico: '" + this.userHistorico + "'"
                + "', userContrato: '" + this.userContrato + "'"
                + "', userImovel: '" + this.userImovel + "'"
                + "', userEmpresas: '" + this.userEmpresas + "'"
                + "', userPermission: '" + this.userPermission + "'"
                 + "', userSistema: '" + this.userSistema + "'"
                + " })";
            return json;
        }

    }
}