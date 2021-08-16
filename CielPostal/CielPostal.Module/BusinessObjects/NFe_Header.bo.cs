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

namespace CielPostal.Module.BusinessObjects
{
    public partial class NFe_Header
    {
        [Action(ToolTip = "Imprimir Etiqueta", ImageName = "Action_Printing_Print", Caption = "Imprimir Etiqueta", TargetObjectsCriteria = "[ACF_Contrato] Is Not Null")]
        public void ImprimirEtiqueta()
        {

            if (ACF_Contrato != null && CodigoRastreio != null)
            {

                string strEtiqueta;
                string etqNameFileFrom;
                string etqNameFileTo;

                StreamWriter etqFile;

                if (!Directory.Exists(@"C:\Temp\ZPL"))
                {

                    Directory.CreateDirectory(@"C:\Temp\ZPL");

                }

                foreach (NFe_Etiqueta etqNFe in NFe_Etiquetas)
                {

                    strEtiqueta = ACF_Contrato.ZPL_Configuracao.CodigoZPL;

                    strEtiqueta = strEtiqueta.Replace(@"%%CodigoRastreio%%", CodigoRastreio)
                                             .Replace(@"%%Transportador%%", ServicoTransporte)
                                             .Replace(@"%%RazaoSocialDestinatario%%", RazaoSocialDestinatario)
                                             .Replace(@"%%EnderecoDestinatario%%", EnderecoDestinatario)
                                             .Replace(@"%%BairroDestinatario%%", BairroDestinatario)
                                             .Replace(@"%%CEPCidadeEstadoDestinatario%%", CEPDestinatario + " - " + CidadeDestinatario + " - " + EstadoDestinatario)
                                             .Replace(@"%%CEPDestinatario%%", CEPDestinatario)
                                             .Replace(@"%%NumeroPedido%%", NumeroPedido)
                                             .Replace(@"%%NumeroDelivery%%", NumeroDelivery)
                                             .Replace(@"%%NumeroNFe%%", NumeroNFe)
                                             .Replace(@"%%NumeroVolumeAtual%%", etqNFe.NumeroVolume.ToString())
                                             .Replace(@"%%NumeroVolumeTotal%%", NFe_Etiquetas.Count.ToString())
                                             .Replace(@"%%PesoBrutoTotalNFe%%", PesoBrutoTotalNFe.ToString())
                                             .Replace(@"%%PesoLiquidoTotalNFe%%", PesoLiquidoTotalNFe.ToString());

                    etqNameFileFrom = @"C:\Temp\ZPL\" + NumeroNFe + "_" + etqNFe.NumeroVolume.ToString() + ".txt";
                    etqNameFileTo = ACF_Contrato.ZPL_Configuracao.EnderecoImpressora + NumeroNFe + "_" + etqNFe.NumeroVolume.ToString() + ".txt";

                    etqFile = new StreamWriter(etqNameFileFrom);

                    etqFile.WriteLine(strEtiqueta);

                    etqFile.Close();

                    if (ACF_Contrato.ZPL_Configuracao.AutenticarUsuario)
                    {

                        Impersonator loginImpersonator = new Impersonator(ACF_Contrato.ZPL_Configuracao.Usuario, ACF_Contrato.ZPL_Configuracao.Dominio, ACF_Contrato.ZPL_Configuracao.Senha);

                    }

                    File.Copy(etqNameFileFrom, etqNameFileTo, true);

                }

            }


        }

        [Action(ToolTip = "Rastrear Entrega", ImageName = "Action_NavigationBar", Caption = "Rastrear Entrega", TargetObjectsCriteria = "[ACF_Contrato] Is Not Null And CodigoRastreio Is Not Null And Not ProdutoEntregue")]
        public void RastrearEntrega()
        {

            if (ACF_Contrato != null && CodigoRastreio != null && !ProdutoEntregue)
            {

                WebRequest _Requisicao;
                WebResponse _Retorno;
                Stream _Stream;
                DataSet _DataSet;
                DataTable _DataTableSRO;
                DataTable _DataTableObjeto;
                DataTable _DataTableEvento;

                if (ACF_Contrato.CodigoSAP != "Genérico" && DataEmissao != null && DataEmissao >= DateTime.Now.AddDays(-30) )
                {

                    _Requisicao = WebRequest.Create(@"http://websro.correios.com.br/sro_bin/sroii_xml.eventos?Usuario=" + ACF_Contrato.SRO_Configuracao.UsuarioWeb + "&Senha=" + ACF_Contrato.SRO_Configuracao.SenhaWeb + "&Tipo=L&Resultado=T&Objetos=" + CodigoRastreio);
                    _Requisicao.Timeout = 5000;
                    _Retorno = _Requisicao.GetResponse();

                    _Stream = _Retorno.GetResponseStream();

                    _DataSet = new DataSet();
                    _DataSet.ReadXml(_Stream);

                    if (_DataSet.Tables.Count > 0)
                    {

                        _DataTableSRO = _DataSet.Tables["sroxml"];
                        if (_DataTableSRO.Rows.Count == 1)
                        {

                            if (!_DataTableSRO.Columns.Contains("error"))
                            {

                                if (Convert.ToInt16(_DataTableSRO.Rows[0]["qtd"]) == 1)
                                {

                                    _DataTableObjeto = _DataSet.Tables["objeto"];
                                    if (_DataTableObjeto.Rows.Count == 1)
                                    {

                                        if (Convert.ToString(_DataTableObjeto.Rows[0]["numero"]) == CodigoRastreio)
                                        {

                                            while (NFe_SROs.Count > 0)
                                            {

                                                NFe_SROs[0].Delete();

                                            }

                                            _DataTableEvento = _DataSet.Tables["evento"];
                                            foreach (DataRow _DataRowEvento in _DataTableEvento.Rows)
                                            {

                                                NFe_SRO _NFe_SRO = new NFe_SRO(this.Session);
                                                NFe_SROs.Add(_NFe_SRO);

                                                if (((Convert.ToString(_DataRowEvento["tipo"]) == "BDE") || (Convert.ToString(_DataRowEvento["tipo"]) == "BDI") || (Convert.ToString(_DataRowEvento["tipo"]) == "BDR")) && Convert.ToInt16(_DataRowEvento["status"]) == 1)
                                                {

                                                    ProdutoEntregue = true;

                                                }

                                                XPCollection findSRO_Evento = new XPCollection(this.Session, typeof(SRO_Evento), CriteriaOperator.Parse("Status = " + Convert.ToString(_DataRowEvento["status"]) + " And SRO_TipoEvento.Tipo = '" + Convert.ToString(_DataRowEvento["tipo"]) + "'"));
                                                foreach (SRO_Evento _SRO_Evento in findSRO_Evento)
                                                {
                                                    _NFe_SRO.SRO_Evento = _SRO_Evento;
                                                }

                                                if (_DataTableEvento.Columns.Contains("data"))
                                                {
                                                    _NFe_SRO.Data = Convert.ToDateTime(_DataRowEvento["data"]);
                                                }

                                                if (_DataTableEvento.Columns.Contains("hora"))
                                                {
                                                    _NFe_SRO.Hora = TimeSpan.Parse(Convert.ToString(_DataRowEvento["hora"]));
                                                }

                                                if (_DataTableEvento.Columns.Contains("descricao"))
                                                {
                                                    _NFe_SRO.Descricao = Convert.ToString(_DataRowEvento["descricao"]);
                                                }

                                                if (_DataTableEvento.Columns.Contains("recebedor"))
                                                {
                                                    _NFe_SRO.Recebedor = Convert.ToString(_DataRowEvento["recebedor"]);
                                                }

                                                if (_DataTableEvento.Columns.Contains("documento"))
                                                {
                                                    _NFe_SRO.Documento = Convert.ToString(_DataRowEvento["documento"]);
                                                }

                                                if (_DataTableEvento.Columns.Contains("comentario"))
                                                {
                                                    _NFe_SRO.Comentario = Convert.ToString(_DataRowEvento["comentario"]);
                                                }

                                                if (_DataTableEvento.Columns.Contains("local"))
                                                {
                                                    _NFe_SRO.Local = Convert.ToString(_DataRowEvento["local"]);
                                                }

                                                if (_DataTableEvento.Columns.Contains("codigo"))
                                                {
                                                    _NFe_SRO.Codigo = Convert.ToString(_DataRowEvento["codigo"]);
                                                }

                                                if (_DataTableEvento.Columns.Contains("cidade"))
                                                {
                                                    _NFe_SRO.Cidade = Convert.ToString(_DataRowEvento["cidade"]);
                                                }

                                                if (_DataTableEvento.Columns.Contains("uf"))
                                                {
                                                    _NFe_SRO.UF = Convert.ToString(_DataRowEvento["uf"]);
                                                }

                                                if (_DataTableEvento.Columns.Contains("sto"))
                                                {
                                                    _NFe_SRO.STO = Convert.ToString(_DataRowEvento["sto"]);
                                                }

                                                _NFe_SRO.Save();

                                            }

                                            if (this.Session.InTransaction)
                                            {
                                                this.Session.CommitTransaction();
                                            }

                                        }

                                    }

                                }

                            }

                        }


                    }

                }
                else
                {

                    ProdutoEntregue = true;

                    if (this.Session.InTransaction)
                    {
                        this.Session.CommitTransaction();
                    }

                }
                
            }

        }

        [Action(ToolTip = "Gerar Código Rastreio", ImageName = "Action_Printing_PageSetup", Caption = "Gerar Código Rastreio", TargetObjectsCriteria = "[ACF_Contrato] Is Not Null And CodigoRastreio Is Null")]
        public void GerarCodigoRastreio()
        {

            if (ACF_Contrato != null && CodigoRastreio == null)
            {

                int iCalc;
                int iCheckDigito;
                int[] iFatores = { 8, 6, 4, 2, 3, 5, 9, 7 };

                ACF_Contrato.SRO_Configuracao.NumeroAtual += 1;
                CodigoRastreio = ACF_Contrato.SRO_Configuracao.NumeroAtual.ToString().PadLeft(8,'0');

                iCalc = 0;
                for (int iCount = 0; iCount < CodigoRastreio.Length; iCount++)
                {
                    iCalc = iCalc + (iFatores[iCount] * Convert.ToInt32(CodigoRastreio[iCount].ToString()));
                }

                iCalc = iCalc % 11;
                if (iCalc == 0)
                {
                    iCheckDigito = 5;
                }
                else if (iCalc == 1)
                {
                    iCheckDigito = 0;
                }
                else
                {
                    iCheckDigito = 11 - iCalc;
                }

                CodigoRastreio = ACF_Contrato.SRO_Configuracao.Prefixo + CodigoRastreio + iCheckDigito.ToString() + ACF_Contrato.SRO_Configuracao.Sufixo;

            }

        }

        [Action(ToolTip = "Obter NFe", ImageName = "Action_WindowList", Caption = "Obter NFe")]
        public void ObterNFe()
        {

            this.Delete();

            XPCollection findSonda_NFe = new XPCollection(this.Session, typeof(Sonda_NFe), CriteriaOperator.Parse("IntervaloConsulta > 0"));
            foreach (Sonda_NFe _Sonda_NFe in findSonda_NFe)
            {

                SqlConnection sqlConnectionSonda = new SqlConnection(_Sonda_NFe.ConnectionString);
                SqlCommand cmdSQLNFe = new SqlCommand(_Sonda_NFe.SQLNFe, sqlConnectionSonda);
                SqlDataReader readerSonda_NFe;

                sqlConnectionSonda.Open();

                readerSonda_NFe = cmdSQLNFe.ExecuteReader();

                while (readerSonda_NFe.Read())
                {
                    XPCollection findACF_Contrato = new XPCollection(this.Session, typeof(ACF_Contrato), CriteriaOperator.Parse("CodigoSAP = '" + (string)readerSonda_NFe["ServicoTransporte"] + "'"));

                    if (findACF_Contrato.Count == 0)
                    {

                        findACF_Contrato = new XPCollection(this.Session, typeof(ACF_Contrato), CriteriaOperator.Parse("CodigoSAP = 'Genérico'"));

                    }

                    foreach (ACF_Contrato _ACF_Contrato in findACF_Contrato)
                    {

                        XPCollection findNFe_Header = new XPCollection(this.Session, typeof(NFe_Header), CriteriaOperator.Parse("CNPJEmitente == '" + (string)readerSonda_NFe["CNPJEmitente"] + "' And NumeroNFe == '" + (string)readerSonda_NFe["NumeroNFe"] + "' And SerieNFe == '" + (string)readerSonda_NFe["SerieNFe"] + "'"));
                        if (findNFe_Header.Count == 0)
                        {

                            NFe_Header _NFe_Header = new NFe_Header(this.Session);

                            _NFe_Header.BairroDestinatario = (string)readerSonda_NFe["BairroDestinatario"];
                            _NFe_Header.CEPDestinatario = (string)readerSonda_NFe["CEPDestinatario"];
                            _NFe_Header.CidadeDestinatario = (string)readerSonda_NFe["CidadeDestinatario"];
                            _NFe_Header.CNPJDestinatario = (string)readerSonda_NFe["CNPJDestinatario"];
                            _NFe_Header.CNPJEmitente = (string)readerSonda_NFe["CNPJEmitente"];
                            _NFe_Header.EnderecoDestinatario = (string)readerSonda_NFe["EnderecoDestinatario"];
                            _NFe_Header.EstadoDestinatario = (string)readerSonda_NFe["EstadoDestinatario"];
                            _NFe_Header.InscricaoEstadualDestinatario = (string)readerSonda_NFe["InscricaoEstadualDestinatario"];
                            _NFe_Header.NumeroNFe = (string)readerSonda_NFe["NumeroNFe"];
                            _NFe_Header.DataEmissao = (DateTime)readerSonda_NFe["DataEmissao"];
                            _NFe_Header.NumeroPedido = (string)readerSonda_NFe["NumeroPedido"];
                            _NFe_Header.NumeroDelivery = (string)readerSonda_NFe["NumeroDelivery"];
                            _NFe_Header.PesoBrutoTotalNFe = (decimal)readerSonda_NFe["PesoBrutoTotalNFe"];
                            _NFe_Header.PesoLiquidoTotalNFe = (decimal)readerSonda_NFe["PesoLiquidoTotalNFe"];
                            _NFe_Header.RazaoSocialDestinatario = (string)readerSonda_NFe["RazaoSocialDestinatario"];
                            _NFe_Header.RazaoSocialEmitente = (string)readerSonda_NFe["RazaoSocialEmitente"];
                            _NFe_Header.SerieNFe = (string)readerSonda_NFe["SerieNFe"];
                            _NFe_Header.ServicoTransporte = (string)readerSonda_NFe["ServicoTransporte"];
                            _NFe_Header.ValorTotalNFe = (decimal)readerSonda_NFe["ValorTotalNFe"];

                            _NFe_Header.ACF_Contrato = _ACF_Contrato;

                            for (int _NumeroVolumes = 1; _NumeroVolumes <= (int)readerSonda_NFe["VolumesNFe"]; _NumeroVolumes++)
                            {

                                NFe_Etiqueta _NFe_Etiqueta = new NFe_Etiqueta(this.Session);

                                _NFe_Etiqueta.NumeroVolume = _NumeroVolumes;

                                _NFe_Etiqueta.NFe_Header = _NFe_Header;

                                _NFe_Etiqueta.Save();

                            }

                            _NFe_Header.GerarCodigoRastreio();
                            _NFe_Header.ImprimirEtiqueta();

                            _NFe_Header.Save();

                        }

                        if (this.Session.InTransaction)
                        {
                            this.Session.CommitTransaction();
                        }

                    }

                }

                sqlConnectionSonda.Close();

            }

        }
    }
}
