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
using DevExpress.ExpressApp.Utils;
using System.Net;
using System.Data;
using System.Xml.Linq;
using System.Linq;

namespace CielPostal.Module.BusinessObjects
{
    public partial class ESO_Header
    {

        [Action(ToolTip = "Capturar Pedidos", ImageName = "Action_Printing_Print", Caption = "Capturar Pedidos")]
        public void CapturarPedidos()
        {

            XPCollection findESO_Configuracao = new XPCollection(this.Session, typeof(ESO_Configuracao));

            if (findESO_Configuracao.Count == 0)
            {

                throw new Exception("Configuração Pedidos de Venda ECOM não encontrada.");

            }

            foreach (ESO_Configuracao _ESO_Configuracao in findESO_Configuracao)
            {

                this.Delete();

                for (int iDays = -31; iDays < 1; iDays++ )
                {

                    XElement root = XElement.Load(String.Format("{0}/Seton{1:yyyy-MM-dd}.xml", _ESO_Configuracao.URLGimba, System.DateTime.Now.AddDays(iDays)));
                    var queryItem = from xmlItem in root.Descendants("Produto")
                                    select new
                                    {

                                        Codigo = (string)xmlItem.Element("Codigo"),
                                        Quantidade = (double)xmlItem.Element("Quantidade"),

                                    };

                    XPCollection findESO_Header = new XPCollection(this.Session, typeof(ESO_Header), CriteriaOperator.Parse(String.Format("Parceiro == 'Gimba' And DataEmissao == '{0:yyyyMMdd}'", System.DateTime.Now.AddDays(iDays))));
                    if (findESO_Header.Count == 0 && queryItem.Count() > 0)
                    {


                        ESO_Header _ESO_Header = new ESO_Header(this.Session)
                        {

                            DataEmissao = System.DateTime.Now.AddDays(iDays).Date,
                            Parceiro = "Gimba",
                            PedidoParceiro = System.DateTime.Now.AddDays(iDays).ToString("yyyyMMdd")

                        };

                        foreach (var xmlItem in queryItem)
                        {

                            string sCodigo = xmlItem.Codigo;
                            double dQuantidade = xmlItem.Quantidade;

                            ESO_Item _ESO_Item = new ESO_Item(this.Session)
                            {

                                ESO_Header = _ESO_Header,
                                Quantidade = dQuantidade,
                                Produto = sCodigo

                            };

                            _ESO_Item.Save();


                        }

                        _ESO_Header.Save();

                    }

                }

                if (this.Session.InTransaction)
                {

                    this.Session.CommitTransaction();

                }

                break;
            
            }

        }

        [Action(ToolTip = "Atualizar Estoque", ImageName = "Action_Printing_Print", Caption = "Atualizar Estoque")]
        public void AtualizarEstoque()
        {

            Impersonator loginImpersonator = new Impersonator("petrelra", "brc", "Ciel-123456");

            XPCollection findESO_Configuracao = new XPCollection(this.Session, typeof(ESO_Configuracao));

            if (findESO_Configuracao.Count == 0)
            {

                throw new Exception("Configuração Pedidos de Venda ECOM não encontrada.");

            }

            foreach (ESO_Configuracao _ESO_Configuracao in findESO_Configuracao)
            {

                this.Delete();

                var queryItem = from csvItem in File.ReadAllLines(_ESO_Configuracao.ArquivoEstoqueGimba)
                                let csvColumns = csvItem.Split(';')
                                select new
                                {

                                    Codigo = csvColumns[0],
                                    Quantidade = csvColumns[1],

                                };

                List<Gimba.ItemEstoque> aItems = new List<Gimba.ItemEstoque>();
                List<Gimba.ItemEstoque> aResultItems = new List<Gimba.ItemEstoque>();

                Gimba.EstoqueSoapClient _EstoqueSoap = new Gimba.EstoqueSoapClient();

                foreach (var item in queryItem)
                {

                    Gimba.ItemEstoque _ItemEstoque = new Gimba.ItemEstoque()
                    {

                        CodigoProduto = item.Codigo,
                        Quantidade = Convert.ToInt32(item.Quantidade)

                    };

                    aItems.Add(_ItemEstoque);

                    if (aItems.Count >= 50)
                    {

                        aResultItems.AddRange(_EstoqueSoap.Atualizar(aItems.ToArray()));
                        aItems.Clear();

                    }

                }

                if (aItems.Count > 0)
                {

                    aResultItems.AddRange(_EstoqueSoap.Atualizar(aItems.ToArray()));
                    aItems.Clear();

                }

                File.Delete(_ESO_Configuracao.ArquivoEstoqueGimba);
                
                List<string> aLines = new List<string>();

                foreach (var item in aResultItems)
                {

                    aLines.Add(String.Format("{0};{1};{2}", item.CodigoProduto, item.Quantidade, item.MensagemRetorno));

                }

                File.WriteAllLines(String.Format("{0}.{1:yyyyMMddhhmmss}.log", _ESO_Configuracao.ArquivoEstoqueGimba, System.DateTime.Now), aLines);
                
                break;

            }
                            
        }

    }

}
