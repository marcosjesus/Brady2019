using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AppBradyReq.Models
{
    public class AreaModel
    {

        public int Area_ID { get; set; }
        public string Nome { get; set; }
        public int Tsis_usucod { get; set; }

        public AreaModel()
        {
            Area_ID = -1;
            Nome = "Nenhum";
            Tsis_usucod = -1;
        }

        public AreaModel(int area_ID, string nome, int tsis_usucod)
        {
            Area_ID = area_ID;
            Nome = nome;
            Tsis_usucod = tsis_usucod;
        }
    }






}