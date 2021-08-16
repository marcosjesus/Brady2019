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
  [DevExpress.ExpressApp.DC.XafDefaultProperty("NumeroVolume")]
  [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("NF - Etiqueta(s)")]
  [DevExpress.Persistent.Base.DefaultClassOptionsAttribute]
  [DevExpress.Persistent.Base.ImageNameAttribute("BO_Note")]
  [DevExpress.Persistent.Base.NavigationItemAttribute("NaoVisivel")]
  public partial class NFe_Etiqueta : DevExpress.Persistent.BaseImpl.BaseObject
  {
    private System.Int64 _numeroVolume;
    private CielPostal.Module.BusinessObjects.NFe_Header _nFe_Header;
    public NFe_Etiqueta(DevExpress.Xpo.Session session)
      : base(session)
    {
    }
    [DevExpress.Xpo.AssociationAttribute("NFe_Etiquetas-NFe_Header")]
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Nota Fiscal")]
    public CielPostal.Module.BusinessObjects.NFe_Header NFe_Header
    {
      get
      {
        return _nFe_Header;
      }
      set
      {
        SetPropertyValue("NFe_Header", ref _nFe_Header, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Volume")]
    public System.Int64 NumeroVolume
    {
      get
      {
        return _numeroVolume;
      }
      set
      {
        SetPropertyValue("NumeroVolume", ref _numeroVolume, value);
      }
    }
  }
}