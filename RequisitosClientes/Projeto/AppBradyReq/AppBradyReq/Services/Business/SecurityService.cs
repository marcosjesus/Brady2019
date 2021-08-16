using AppBradyReq.Models;
using AppBradyReq.Services.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AppBradyReq.Services.Business
{
    public class SecurityService
    {

        SecurityDAO daoService = new SecurityDAO();

        public bool Authenticate(UserModel user)
        {
            return daoService.FindByUser(user);
        }


        public int FindIDbyUser(string usuario)
        {
            return daoService.FindIDByUser(usuario);
        }
    }
}