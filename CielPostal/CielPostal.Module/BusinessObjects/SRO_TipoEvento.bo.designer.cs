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
  [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("SRO - Tipo de Evento")]
  [DevExpress.ExpressApp.DC.XafDefaultProperty("Tipo")]
  [DevExpress.Persistent.Base.NavigationItemAttribute("Configuração")]
  [DevExpress.Persistent.Base.ImageNameAttribute("Action_Copy_CellValue")]
  public partial class SRO_TipoEvento : DevExpress.Persistent.BaseImpl.BaseObject
  {
    private System.String _significado;
    private System.String _tipo;
    public SRO_TipoEvento(DevExpress.Xpo.Session session)
      : base(session)
    {
    }
    [DevExpress.Xpo.SizeAttribute(250)]
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Tipo")]
    public System.String Tipo
    {
      get
      {
        return _tipo;
      }
      set
      {
        SetPropertyValue("Tipo", ref _tipo, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Significado")]
    [DevExpress.Xpo.SizeAttribute(250)]
    public System.String Significado
    {
      get
      {
        return _significado;
      }
      set
      {
        SetPropertyValue("Significado", ref _significado, value);
      }
    }
    [DevExpress.Xpo.AssociationAttribute("SRO_Eventos-SRO_TipoEvento")]
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Eventos")]
    public XPCollection<CielPostal.Module.BusinessObjects.SRO_Evento> SRO_Eventos
    {
      get
      {
        return GetCollection<CielPostal.Module.BusinessObjects.SRO_Evento>("SRO_Eventos");
      }
    }
  }
}