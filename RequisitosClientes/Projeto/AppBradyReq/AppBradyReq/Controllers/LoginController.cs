using AppBradyReq.Models;
using AppBradyReq.Services.Business;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AppBradyReq.Controllers
{
    public class LoginController : Controller
    {
        // GET: Login
        public ActionResult Index()
        {
            return View("Login");
        }

        public ActionResult Logout()
        {
            Session.RemoveAll();
            return RedirectToAction("Index", "Home");
        }

        public ActionResult Login(UserModel userModel)

        {
            //  return "Results: Username = " + userModel.Username + " PW = " + userModel.Password;
            SecurityService securityService = new SecurityService();
            Boolean success = securityService.Authenticate(userModel);
            if (success)
            {
                //return View("LoginSuccess", userModel);
                Session["Usuario"] = userModel.Username;
                int UserID = securityService.FindIDbyUser(userModel.Username);
                Session["UsuarioID"] = UserID;

                return RedirectToAction("Index", "Home");
            }
            else
            {
                return View("LoginFailure");
            }
        }
    }
}