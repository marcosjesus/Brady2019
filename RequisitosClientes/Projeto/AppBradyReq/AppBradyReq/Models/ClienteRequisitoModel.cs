using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AppBradyReq.Models
{
    public class ClienteRequisitoModel
    {
        public string Tsop_Clisapclicod { get; set; }
        public ClienteModel cliente { get; set; } = new ClienteModel();
        public List<RequisitoModel> Requisito { get; set; } = new List<RequisitoModel>();
        public List<ItemModel> Item { get; set; } = new List<ItemModel>();
        public int Tsis_Usucod { get; set; }
    }
}