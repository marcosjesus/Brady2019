using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AppBradyReq.Models
{
    public class UserModel
    {
        [Required]
        [DisplayName("Usuário")]
        public string Username { get; set; }

        [Required]
        [DisplayName("Senha")]
        public string Password { get; set; }

        public UserModel()
        {
            Username = "Nenhum";
            Password = "Nenhuma";
        }

        public UserModel(string username, string password)
        {
            Username = username;
            Password = password;
        }
    }
}