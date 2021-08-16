using AppBradyReq.Models;
using AppBradyReq.Services.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AppBradyReq.Controllers
{
    public class CheckListController : Controller
    {
        // GET: CheckList

        public ActionResult Cliente()
        {
            List<ClienteModel> cliente = new List<ClienteModel>();

            CadastroDAO cadastroDAO = new CadastroDAO();

            cliente = cadastroDAO.GetCliente_All();

            return View("Cliente", cliente);
        }

        public ActionResult SearchClienteReq()
        {
            return View("SearchClienteReq");
        }

        public ActionResult PesquisaPeloCNPJ(string searchCNPJ)
        {
            CadastroDAO cadastroDAO = new CadastroDAO();

            List<RequisitoModel> searchResults = cadastroDAO.PesquisaPeloCNPJ(searchCNPJ);

            if (searchResults.ToList().Count() > 0)
            {
                Session["CNPJ"] = searchCNPJ;
            }

            return View("ClienteRequisito", searchResults);
        }

        public ActionResult ListaItem( int cliente,  int id)
        {
            CadastroDAO cadastroDAO = new CadastroDAO();

            List<RequisitoItemModel> listaItens = cadastroDAO.BuscaListaItens(cliente, id);

            return View("ListaItemdoRequisito", listaItens);
        }

        public ActionResult Create(int cliente, int id_requisito, int id_item)
        {

            CadastroDAO cadastroDAO = new CadastroDAO();

            cadastroDAO.CreateRequisitoCliente(cliente, id_requisito, id_item);

            List<RequisitoModel> searchResults = cadastroDAO.PesquisaPeloCodigo(cliente);

            return View("ClienteRequisito", searchResults);
        }

        public ActionResult ExcluirItem(int cliente, int id)
        {

            CadastroDAO cadastroDAO = new CadastroDAO();

            cadastroDAO.ExcluirRequisitoCliente(cliente, id);

            List<RequisitoModel> searchResults = cadastroDAO.PesquisaPeloCodigo(cliente);

            return View("ClienteRequisito", searchResults);

        }


        public ActionResult EnviaEmail()
        {

            return View("EnviaEmail");
        }


    }
}