using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AppBradyReq.Models
{
    public class MercadoModel
    {
        public int Mercado_ID { get; set; }
        public string Nome { get; set; }
        public int Tsis_usucod { get; set; }

        public MercadoModel()
        {
            Mercado_ID = -1;
            Nome = "Nenhum";
            Tsis_usucod = -1;
        }

        public MercadoModel(int mercado_ID, string nome, int tsis_usucod)
        {
            Mercado_ID = mercado_ID;
            Nome = nome;
            Tsis_usucod = tsis_usucod;
        }
    }
}