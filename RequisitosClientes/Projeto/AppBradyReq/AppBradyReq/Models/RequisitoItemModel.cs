using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AppBradyReq.Models
{
    public class RequisitoItemModel
    {


        public RequisitoModel Requisito { get; set; } = new RequisitoModel();
        public ItemModel Item { get; set; } = new ItemModel();
        public int Tsis_usucod { get; set; }

        public RequisitoItemModel( RequisitoModel requisito, ItemModel item, int tsis_usucod)
        {

            Requisito = requisito;
            Item = item;
            Tsis_usucod = tsis_usucod;
        }

        public RequisitoItemModel()
        {
            Requisito.Rqcl_Requisito_Id = -1;
            Requisito.Cliente.Tsop_Clisapclicod = -1;
            Requisito.Nome = "Nenhum";
            Item.Item_Id = -1;
            Item.Nome = "Nenhum";
            Tsis_usucod = 0;
        }



    }
}