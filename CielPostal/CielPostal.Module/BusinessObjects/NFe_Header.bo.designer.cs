//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Base;
using DevExpress.Persistent.BaseImpl;
using DevExpress.Xpo;
namespace CielPostal.Module.BusinessObjects
{
  [DefaultClassOptions]
  [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Nota Fiscal")]
  [DevExpress.ExpressApp.DC.XafDefaultProperty("NumeroNFe")]
  [DevExpress.Persistent.Base.NavigationItemAttribute("Consulta")]
  [DevExpress.Persistent.Base.ImageNameAttribute("BO_List")]
  public partial class NFe_Header : DevExpress.Persistent.BaseImpl.BaseObject
  {
    private System.DateTime _dataEmissao;
    private System.String _numeroDelivery;
    private System.Boolean _produtoEntregue;
    private System.String _codigoRastreio;
    private System.String _servicoTransporte;
    private CielPostal.Module.BusinessObjects.ACF_Contrato _aCF_Contrato;
    private System.String _razaoSocialEmitente;
    private System.String _cNPJEmitente;
    private System.Decimal _pesoLiquidoTotalNFe;
    private System.String _estadoDestinatario;
    private System.String _cidadeDestinatario;
    private System.String _bairroDestinatario;
    private System.String _inscricaoEstadualDestinatario;
    private System.Decimal _valorTotalNFe;
    private System.Decimal _pesoBrutoTotalNFe;
    private System.String _cEPDestinatario;
    private System.String _enderecoDestinatario;
    private System.String _razaoSocialDestinatario;
    private System.String _cNPJDestinatario;
    private System.String _numeroPedido;
    private System.String _serieNFe;
    private System.String _numeroNFe;
    public NFe_Header(DevExpress.Xpo.Session session)
      : base(session)
    {
    }
    [DevExpress.Xpo.SizeAttribute(14)]
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Emitente - CNPJ")]
    public System.String CNPJEmitente
    {
      get
      {
        return _cNPJEmitente;
      }
      set
      {
        SetPropertyValue("CNPJEmitente", ref _cNPJEmitente, value);
      }
    }
    [DevExpress.Xpo.SizeAttribute(250)]
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Emitente - Razão Social")]
    public System.String RazaoSocialEmitente
    {
      get
      {
        return _razaoSocialEmitente;
      }
      set
      {
        SetPropertyValue("RazaoSocialEmitente", ref _razaoSocialEmitente, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("NF - Número")]
    [DevExpress.Xpo.SizeAttribute(10)]
    public System.String NumeroNFe
    {
      get
      {
        return _numeroNFe;
      }
      set
      {
        SetPropertyValue("NumeroNFe", ref _numeroNFe, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("NF - Série")]
    [DevExpress.Xpo.SizeAttribute(4)]
    public System.String SerieNFe
    {
      get
      {
        return _serieNFe;
      }
      set
      {
        SetPropertyValue("SerieNFe", ref _serieNFe, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Número Pedido")]
    [DevExpress.Xpo.SizeAttribute(10)]
    public System.String NumeroPedido
    {
      get
      {
        return _numeroPedido;
      }
      set
      {
        SetPropertyValue("NumeroPedido", ref _numeroPedido, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Destinatário - CNPJ")]
    [DevExpress.Xpo.SizeAttribute(14)]
    public System.String CNPJDestinatario
    {
      get
      {
        return _cNPJDestinatario;
      }
      set
      {
        SetPropertyValue("CNPJDestinatario", ref _cNPJDestinatario, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Destinatário - I.E.")]
    [DevExpress.Xpo.SizeAttribute(25)]
    public System.String InscricaoEstadualDestinatario
    {
      get
      {
        return _inscricaoEstadualDestinatario;
      }
      set
      {
        SetPropertyValue("InscricaoEstadualDestinatario", ref _inscricaoEstadualDestinatario, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Destinatário - Razão Social")]
    [DevExpress.Xpo.SizeAttribute(250)]
    public System.String RazaoSocialDestinatario
    {
      get
      {
        return _razaoSocialDestinatario;
      }
      set
      {
        SetPropertyValue("RazaoSocialDestinatario", ref _razaoSocialDestinatario, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Destinatário - Endereço")]
    [DevExpress.Xpo.SizeAttribute(250)]
    public System.String EnderecoDestinatario
    {
      get
      {
        return _enderecoDestinatario;
      }
      set
      {
        SetPropertyValue("EnderecoDestinatario", ref _enderecoDestinatario, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Destinatário - Bairro")]
    public System.String BairroDestinatario
    {
      get
      {
        return _bairroDestinatario;
      }
      set
      {
        SetPropertyValue("BairroDestinatario", ref _bairroDestinatario, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Destinatário - CEP")]
    [DevExpress.Xpo.SizeAttribute(8)]
    public System.String CEPDestinatario
    {
      get
      {
        return _cEPDestinatario;
      }
      set
      {
        SetPropertyValue("CEPDestinatario", ref _cEPDestinatario, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Destinatário - Município")]
    [DevExpress.Xpo.SizeAttribute(250)]
    public System.String CidadeDestinatario
    {
      get
      {
        return _cidadeDestinatario;
      }
      set
      {
        SetPropertyValue("CidadeDestinatario", ref _cidadeDestinatario, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Destinatário - UF")]
    [DevExpress.Xpo.SizeAttribute(2)]
    public System.String EstadoDestinatario
    {
      get
      {
        return _estadoDestinatario;
      }
      set
      {
        SetPropertyValue("EstadoDestinatario", ref _estadoDestinatario, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("NF - Valor Total")]
    public System.Decimal ValorTotalNFe
    {
      get
      {
        return _valorTotalNFe;
      }
      set
      {
        SetPropertyValue("ValorTotalNFe", ref _valorTotalNFe, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("NF - Peso Bruto Total")]
    public System.Decimal PesoBrutoTotalNFe
    {
      get
      {
        return _pesoBrutoTotalNFe;
      }
      set
      {
        SetPropertyValue("PesoBrutoTotalNFe", ref _pesoBrutoTotalNFe, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("NF - Peso Líquido Total")]
    public System.Decimal PesoLiquidoTotalNFe
    {
      get
      {
        return _pesoLiquidoTotalNFe;
      }
      set
      {
        SetPropertyValue("PesoLiquidoTotalNFe", ref _pesoLiquidoTotalNFe, value);
      }
    }
    [DevExpress.Xpo.SizeAttribute(250)]
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Serviço de Transporte")]
    public System.String ServicoTransporte
    {
      get
      {
        return _servicoTransporte;
      }
      set
      {
        SetPropertyValue("ServicoTransporte", ref _servicoTransporte, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Código de Rastreamento")]
    [DevExpress.Xpo.SizeAttribute(250)]
    public System.String CodigoRastreio
    {
      get
      {
        return _codigoRastreio;
      }
      set
      {
        SetPropertyValue("CodigoRastreio", ref _codigoRastreio, value);
      }
    }
    [DevExpress.Xpo.AssociationAttribute("NFe_Etiquetas-NFe_Header")]
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Volumes")]
    public XPCollection<CielPostal.Module.BusinessObjects.NFe_Etiqueta> NFe_Etiquetas
    {
      get
      {
        return GetCollection<CielPostal.Module.BusinessObjects.NFe_Etiqueta>("NFe_Etiquetas");
      }
    }
    [DevExpress.Xpo.AssociationAttribute("NFe_SROs-NFe_Header")]
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Rastreamento")]
    public XPCollection<CielPostal.Module.BusinessObjects.NFe_SRO> NFe_SROs
    {
      get
      {
        return GetCollection<CielPostal.Module.BusinessObjects.NFe_SRO>("NFe_SROs");
      }
    }
    [DevExpress.Xpo.AssociationAttribute("NFe_Headers-ACF_Contrato")]
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("ACF - Contrato")]
    public CielPostal.Module.BusinessObjects.ACF_Contrato ACF_Contrato
    {
      get
      {
        return _aCF_Contrato;
      }
      set
      {
        SetPropertyValue("ACF_Contrato", ref _aCF_Contrato, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Produto Entregue")]
    public System.Boolean ProdutoEntregue
    {
      get
      {
        return _produtoEntregue;
      }
      set
      {
        SetPropertyValue("ProdutoEntregue", ref _produtoEntregue, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Delivery")]
    public System.String NumeroDelivery
    {
      get
      {
        return _numeroDelivery;
      }
      set
      {
        SetPropertyValue("NumeroDelivery", ref _numeroDelivery, value);
      }
    }
    public System.DateTime DataEmissao
    {
      get
      {
        return _dataEmissao;
      }
      set
      {
        SetPropertyValue("DataEmissao", ref _dataEmissao, value);
      }
    }
  }
}