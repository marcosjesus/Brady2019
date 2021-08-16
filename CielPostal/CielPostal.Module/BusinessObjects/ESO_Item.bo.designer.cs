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
  [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Itens Pedido ECOM")]
  [DevExpress.Persistent.Base.NavigationItemAttribute("NaoVisivel")]
  public partial class ESO_Item : DevExpress.Persistent.BaseImpl.BaseObject
  {
    private System.Double _quantidade;
    private CielPostal.Module.BusinessObjects.ESO_Header _eSO_Header;
    private System.String _produto;
    public ESO_Item(DevExpress.Xpo.Session session)
      : base(session)
    {
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Produto")]
    public System.String Produto
    {
      get
      {
        return _produto;
      }
      set
      {
        SetPropertyValue("Produto", ref _produto, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Quantidade")]
    public System.Double Quantidade
    {
      get
      {
        return _quantidade;
      }
      set
      {
        SetPropertyValue("Quantidade", ref _quantidade, value);
      }
    }
    [DevExpress.Xpo.AssociationAttribute("ESO_Items-ESO_Header")]
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Pedido ECOM")]
    public CielPostal.Module.BusinessObjects.ESO_Header ESO_Header
    {
      get
      {
        return _eSO_Header;
      }
      set
      {
        SetPropertyValue("ESO_Header", ref _eSO_Header, value);
      }
    }
  }
}