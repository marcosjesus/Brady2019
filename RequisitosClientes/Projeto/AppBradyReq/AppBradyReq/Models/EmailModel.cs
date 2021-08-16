using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AppBradyReq.Models
{
    public class EmailModel
    {
        public EmailModel(ClienteModel cliente, string mensagem)
        {
            Cliente = cliente;
            Mensagem = mensagem;
        }

        public ClienteModel Cliente { get; set; } = new ClienteModel();
        public string Mensagem { get; set; }
    }
}