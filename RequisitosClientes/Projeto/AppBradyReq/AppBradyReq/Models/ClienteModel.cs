using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AppBradyReq.Models
{
    public class ClienteModel
    {
        public int Cliente_Id { get; set; }
        [Required]
        [DisplayName("Cód SAP")]
        public int Tsop_Clisapclicod { get; set; }

        [Required]
        [DisplayName("CNPJ")]
        public string Tsop_Clisapclicgc { get; set; }

        [Required]
        [DisplayName("Grupo")]
        public string Tsop_Ordbilgruclinom { get; set; }

        [Required]
        [DisplayName("Cliente")]
        public string Tsop_Clisapclinom { get; set; }

        [Required]
        [DisplayName("Mercado ID")]
        public int Mercado_Id { get; set; }

        public ClienteModel(int cliente_Id, int tsop_Clisapclicod, string tsop_Clisapclicgc, string tsop_Ordbilgruclinom, string tsop_Clisapclinom, int mercado_Id, int tsis_usucod)
        {
            Cliente_Id = cliente_Id;
            Tsop_Clisapclicod = tsop_Clisapclicod;
            Tsop_Clisapclicgc = tsop_Clisapclicgc;
            Tsop_Ordbilgruclinom = tsop_Ordbilgruclinom;
            Tsop_Clisapclinom = tsop_Clisapclinom;
            Mercado_Id = mercado_Id;
            Tsis_usucod = tsis_usucod;
        }

        [Required]
        [DisplayName("Usuário")]
        public int Tsis_usucod { get; set; }

        public ClienteModel()
        {
            Cliente_Id = -1;
            Tsop_Clisapclicod = -1;
            Tsop_Clisapclicgc = "Nenhum";
            Tsop_Ordbilgruclinom = "Nenhum";
            Tsop_Clisapclinom = "Nenhum";
            Mercado_Id = -1;
            Tsis_usucod = -1;
        }
    }
}