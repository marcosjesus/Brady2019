using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AppBradyReq.Models
{
    public class UsuarioPortalModel
    {
        public int UsuarioPortal_ID { get; set; }
        public string Nome { get; set; }
        public int Tsis_usucod { get; set; }

        public UsuarioPortalModel()
        {
            UsuarioPortal_ID = -1;
            Nome = "Nenhum";
            Tsis_usucod = -1;
        }

        public UsuarioPortalModel(int usuarioPortal_ID, string nome, int tsis_usucod)
        {
            UsuarioPortal_ID = usuarioPortal_ID;
            Nome = nome;
            Tsis_usucod = tsis_usucod;
        }
    }
}