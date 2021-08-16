using AppBradyReq.Models;
using AppBradyReq.Services.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AppBradyReq.Controllers
{
    public class MapeadoController : Controller
    {
        // GET: Mapeado
        public ActionResult Mercado()
        {
            List<MercadoModel> mercado = new List<MercadoModel>();

            CadastroDAO cadastroDAO = new CadastroDAO();

            mercado = cadastroDAO.GetMercado_All();

            return View("Mercado", mercado);
        }


        public ActionResult Clientes(int id)
        {
            List<ClienteModel> clientes = new List<ClienteModel>();

            CadastroDAO cadastroDAO = new CadastroDAO();

            clientes = cadastroDAO.GetLista_Clientes(id)
;
            return View("Clientes", clientes);
        }
    }
}