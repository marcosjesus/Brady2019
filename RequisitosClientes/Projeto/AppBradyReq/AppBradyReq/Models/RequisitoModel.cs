using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AppBradyReq.Models
{
    public class RequisitoModel
    {
        public RequisitoModel(int rqcl_Requisito_Id, ClienteModel cliente, string nome, string cadastroCliente, string cadastroProduto, int rqcl_Area_ID, List<AreaModel> area, string recepcao, int tsis_UsuCod, bool possui)
        {
            Rqcl_Requisito_Id = rqcl_Requisito_Id;
            Cliente = cliente;
            Nome = nome;
            CadastroCliente = cadastroCliente;
            CadastroProduto = cadastroProduto;
            Rqcl_Area_ID = rqcl_Area_ID;
            Area = area;
            Recepcao = recepcao;
            Tsis_UsuCod = tsis_UsuCod;
            Possui = possui;
        }

        public int Rqcl_Requisito_Id { get; set; }
        public ClienteModel Cliente { get; set; } = new ClienteModel();
        public string Nome { get; set; }
        public string CadastroCliente { get; set; }
        public string CadastroProduto { get; set; }
        public int Rqcl_Area_ID { get; set; }
        public List<AreaModel> Area { get; set; } = new List<AreaModel>();
        public string Recepcao { get; set; }
        public int Tsis_UsuCod { get; set; }
        public Boolean Possui { get; set; }

        public RequisitoModel()
        {
            Rqcl_Requisito_Id = -1;
            Cliente.Cliente_Id = -1;
            Nome = "Nenhum";
            CadastroCliente = "N";
            CadastroProduto = "N";
            Rqcl_Area_ID = -1;
            Recepcao = "Nenhum";
            Tsis_UsuCod = -1;
            Possui = false;
        }

    }
}