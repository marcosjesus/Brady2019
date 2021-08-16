using AppBradyReq.Models;
using AppBradyReq.Services.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AppBradyReq.Controllers
{
    public class CadastroController : Controller
    {
        // Glossario
        public ActionResult Glossario()
        {
            List<GlossarioModel> glossario = new List<GlossarioModel>();

            CadastroDAO cadastroDAO = new CadastroDAO();

            glossario = cadastroDAO.GetGlossario_All();

            return View("Glossario", glossario);
        }

        public ActionResult Details(int id)
        {
            CadastroDAO cadastroDAO = new CadastroDAO();

            GlossarioModel glossario = cadastroDAO.GetGlossario_One(id);


            return View("Details", glossario);
        }

        public ActionResult Create()
        {
            GlossarioModel glossario = new GlossarioModel();

            return View("GlossarioForm", glossario);
        }
  
        public ActionResult Edit( int id)
        {
            CadastroDAO cadastroDAO = new CadastroDAO();

            GlossarioModel glossario = cadastroDAO.GetGlossario_One(id);

            return View("GlossarioForm", glossario);
        }

        public ActionResult Delete(int id)
        {
            CadastroDAO cadastroDAO = new CadastroDAO();

            cadastroDAO.Delete(id);

            List<GlossarioModel> glossario = cadastroDAO.GetGlossario_All();


            return View("Glossario", glossario);
        }

        [HttpPost]
        public ActionResult ProcessCreate(GlossarioModel glossario)
        {
            CadastroDAO cadastroDAO = new CadastroDAO();

            cadastroDAO.CreateOrUpdate(glossario);

            return View("Details", glossario);
        }

        public ActionResult SearchForm()
        {
            return View("SearchForm");
        }

        public ActionResult PesquisaPeloTitulo(string searchTitulo)
        {
            CadastroDAO cadastroDAO = new CadastroDAO();
            List<GlossarioModel> searchResults = cadastroDAO.PesquisaPeloTitulo(searchTitulo);
            return View("Glossario", searchResults);
        }

        public ActionResult PesquisaPelaDescricao(string searchDescricao)
        {
            CadastroDAO cadastroDAO = new CadastroDAO();
            List<GlossarioModel> searchResults = cadastroDAO.PesquisaPelaDescricao(searchDescricao);
            return View("Glossario", searchResults);
        }

        // Item do Requisito
        public ActionResult Item()
        {
            List<ItemModel> item = new List<ItemModel>();

            CadastroDAO cadastroDAO = new CadastroDAO();

            item = cadastroDAO.GetItem_All();

            return View("Item", item);
        }






    }
}