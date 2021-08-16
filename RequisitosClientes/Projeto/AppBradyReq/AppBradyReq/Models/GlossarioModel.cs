using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AppBradyReq.Models
{
    public class GlossarioModel
    {
        [DisplayName("ID")]
        public int RQCL_Glossario_ID { get; set; }

        [Required]
        [DisplayName ("Título")]
        public string Titulo { get; set; }

        [Required]
        [DisplayName("Descrição")]
        public string Descricao { get; set; }

        [Required]
        [DisplayName("Usuário")]
        public int Tsis_usucod { get; set; }


        public GlossarioModel()
        {
            RQCL_Glossario_ID = -1;
            Titulo = "Nenhum";
            Descricao = "Nenhuma";
            Tsis_usucod = -1;
        }
        
            
        public GlossarioModel(int rqcl_glossario_id, string titulo, string descricao, int tsis_usucod)
        {
            RQCL_Glossario_ID = rqcl_glossario_id;
            Titulo = titulo;
            Descricao = descricao;
            Tsis_usucod = tsis_usucod;
        }
    }
}