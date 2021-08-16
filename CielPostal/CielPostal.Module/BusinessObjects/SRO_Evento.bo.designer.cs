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
  [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("SRO - Evento")]
  [DevExpress.ExpressApp.DC.XafDefaultProperty("Descricao")]
  [DevExpress.Persistent.Base.NavigationItemAttribute("Configuração")]
  [DevExpress.Persistent.Base.ImageNameAttribute("BO_Category")]
  public partial class SRO_Evento : DevExpress.Persistent.BaseImpl.BaseObject
  {
    private System.String _detalhe;
    private CielPostal.Module.BusinessObjects.SRO_TipoEvento _sRO_TipoEvento;
    private System.Int64 _status;
    private System.String _descricao;
    public SRO_Evento(DevExpress.Xpo.Session session)
      : base(session)
    {
    }
    [DevExpress.Xpo.AssociationAttribute("SRO_Eventos-SRO_TipoEvento")]
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Tipo de Evento")]
    public CielPostal.Module.BusinessObjects.SRO_TipoEvento SRO_TipoEvento
    {
      get
      {
        return _sRO_TipoEvento;
      }
      set
      {
        SetPropertyValue("SRO_TipoEvento", ref _sRO_TipoEvento, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Status")]
    public System.Int64 Status
    {
      get
      {
        return _status;
      }
      set
      {
        SetPropertyValue("Status", ref _status, value);
      }
    }
    [DevExpress.Xpo.SizeAttribute(250)]
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Decrição")]
    public System.String Descricao
    {
      get
      {
        return _descricao;
      }
      set
      {
        SetPropertyValue("Descricao", ref _descricao, value);
      }
    }
    [DevExpress.Xpo.SizeAttribute(300)]
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Detalhe")]
    public System.String Detalhe
    {
      get
      {
        return _detalhe;
      }
      set
      {
        SetPropertyValue("Detalhe", ref _detalhe, value);
      }
    }
    [DevExpress.Xpo.AssociationAttribute("NFe_SROs-SRO_Evento")]
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Rastreamento(s)")]
    public XPCollection<CielPostal.Module.BusinessObjects.NFe_SRO> NFe_SROs
    {
      get
      {
        return GetCollection<CielPostal.Module.BusinessObjects.NFe_SRO>("NFe_SROs");
      }
    }
  }
}
