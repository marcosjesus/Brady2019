using System;
using System.Collections.Generic;
using System.Text;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Base;
using DevExpress.Persistent.BaseImpl;
using DevExpress.Xpo;
using DevExpress.Xpo.DB;
using DevExpress.Data.Filtering;
using System.IO;
using Zeta.Tools;
using System.Data.SqlClient;
using System.Xml;

namespace CielPostal.Module.BusinessObjects
{
    public partial class ZPL_Configuracao
    {
        [Action(ToolTip = "Imprimir Etiqueta (teste)", ImageName = "Action_Printing_Print", Caption = "Imprimir Etiqueta (teste)", TargetObjectsCriteria = "EnderecoImpressora Is Not Null And CodigoZPL Is Not Null")]
        public void ImprimirEtiquetaTeste()
        {
            string strEtiqueta;
            string etqNameFileFrom;
            string etqNameFileTo;            

            StreamWriter etqFile;

            if (!Directory.Exists(@"C:\Temp\ZPL"))
            {

                Directory.CreateDirectory(@"C:\Temp\ZPL");

            }

            strEtiqueta = CodigoZPL;

            strEtiqueta = strEtiqueta.Replace(@"%%CodigoRastreio%%", "")
                                        .Replace(@"%%RazaoSocialDestinatario%%", "")
                                        .Replace(@"%%EnderecoDestinatario%%", "")
                                        .Replace(@"%%BairroDestinatario%%", "")
                                        .Replace(@"%%CEPCidadeEstadoDestinatario%%", "")
                                        .Replace(@"%%CEPDestinatario%%", "")
                                        .Replace(@"%%NumeroPedido%%", "")
                                        .Replace(@"%%NumeroNFe%%", "")
                                        .Replace(@"%%NumeroVolumeAtual%%", "")
                                        .Replace(@"%%NumeroVolumeTotal%%", "")
                                        .Replace(@"%%PesoBrutoTotalNFe%%", "")
                                        .Replace(@"%%PesoBrutoTotalNFe%%", "");

            etqNameFileFrom = @"C:\Temp\ZPL\TesteZPL.txt";
            etqNameFileTo = EnderecoImpressora + "TesteZPL" + ".txt";

            etqFile = new StreamWriter(etqNameFileFrom);

            etqFile.WriteLine(strEtiqueta);

            etqFile.Close();

            if (AutenticarUsuario)
            {

                Impersonator loginImpersonator = new Impersonator(Usuario, Dominio, Senha);

            }

            File.Copy(etqNameFileFrom, etqNameFileTo, true);

        }

        [Action(ToolTip = "Login (teste)", ImageName = "Action_Security_ChangePassword", Caption = "Login (teste)", TargetObjectsCriteria = "AutenticarUsuario = true")]
        public void LoginTeste()
        {

            if (AutenticarUsuario)
            {

                Impersonator loginImpersonator = new Impersonator(Usuario, Dominio, Senha);

            }

        }

    }

}
