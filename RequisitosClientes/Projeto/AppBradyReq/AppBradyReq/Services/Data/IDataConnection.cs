using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AppBradyReq.Models;

namespace AppBradyReq.DataAccess
{
    public interface IDataConnection
    {
        // Cadastro - Glossario
        List<GlossarioModel> GetGlossario_All();

        GlossarioModel GetGlossario_One(int id);

        int CreateOrUpdate(GlossarioModel glossario);

        int Delete(int id);

        List<GlossarioModel> PesquisaPeloTitulo(string searchTitulo);

        List<GlossarioModel> PesquisaPelaDescricao(string searchDescricao);

        //Cadastro - Item
        List<ItemModel> GetItem_All();

        //CheckList - Pesquisa pelo CNPJ
        List<RequisitoModel> PesquisaPeloCNPJ(string searchCNPJ);

        List<ClienteModel> GetCliente_All();






    }
}
