using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AppBradyReq.Models
{
    public class LegendaPortalModel
    {
        public int LegendaPortal_Id { get; set; }
        public string Legenda { get; set; }
        public int Tsis_usucod { get; set; }

        public LegendaPortalModel()
        {
            LegendaPortal_Id = -1;
            Legenda = "Nenhuma";
            Tsis_usucod = -1;
        }

        public LegendaPortalModel(int legendaPortal_Id, string legenda, int tsis_usucod)
        {
            LegendaPortal_Id = legendaPortal_Id;
            Legenda = legenda;
            Tsis_usucod = tsis_usucod;
        }
    }
}