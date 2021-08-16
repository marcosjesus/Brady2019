using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AppBradyReq.Models
{
    public class ItemModel
    {
        [Required]
        [DisplayName("ID")]
        public int Item_Id { get; set; }

        [Required]
        [DisplayName("Item de Requisito")]
        public string Nome { get; set; }

        [Required]
        [DisplayName("Usuário")]
        public int Tsis_usucod { get; set; }

        public ItemModel()
        {
            Item_Id = -1;
            Nome = "Nenhuma";
            Tsis_usucod = -1;
        }

        public ItemModel(int item_Id, string nome, int tsis_usucod)
        {
            Item_Id = item_Id;
            Nome = nome;
            Tsis_usucod = tsis_usucod;
        }
    }
}