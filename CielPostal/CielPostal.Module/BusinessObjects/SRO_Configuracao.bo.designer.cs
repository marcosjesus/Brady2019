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
  [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("SRO - Faixa Numeração")]
  [DevExpress.ExpressApp.DC.XafDefaultPropertyAttribute("Descricao")]
  [DevExpress.Persistent.Base.NavigationItemAttribute("Configuração")]
  [DevExpress.Persistent.Base.ImageNameAttribute("BO_StateMachine")]
  public partial class SRO_Configuracao : DevExpress.Persistent.BaseImpl.BaseObject
  {
    private System.String _senhaWeb;
    private System.String _usuarioWeb;
    private System.Int64 _numeroAtual;
    private System.Int64 _numeroFinal;
    private System.Int64 _numeroInicial;
    private System.String _sufixo;
    private System.String _prefixo;
    private System.String _descricao;
    public SRO_Configuracao(DevExpress.Xpo.Session session)
      : base(session)
    {
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Descrição")]
    [DevExpress.Xpo.SizeAttribute(250)]
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
    public System.Int64 NumeroInicial
    {
      get
      {
        return _numeroInicial;
      }
      set
      {
        SetPropertyValue("NumeroInicial", ref _numeroInicial, value);
      }
    }
    public System.Int64 NumeroFinal
    {
      get
      {
        return _numeroFinal;
      }
      set
      {
        SetPropertyValue("NumeroFinal", ref _numeroFinal, value);
      }
    }
    public System.Int64 NumeroAtual
    {
      get
      {
        return _numeroAtual;
      }
      set
      {
        SetPropertyValue("NumeroAtual", ref _numeroAtual, value);
      }
    }
    [DevExpress.Xpo.AssociationAttribute("ACF_Contratos-SRO_Configuracao")]
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("ACF - Contratos")]
    public XPCollection<CielPostal.Module.BusinessObjects.ACF_Contrato> ACF_Contratos
    {
      get
      {
        return GetCollection<CielPostal.Module.BusinessObjects.ACF_Contrato>("ACF_Contratos");
      }
    }
    public System.String Prefixo
    {
      get
      {
        return _prefixo;
      }
      set
      {
        SetPropertyValue("Prefixo", ref _prefixo, value);
      }
    }
    public System.String Sufixo
    {
      get
      {
        return _sufixo;
      }
      set
      {
        SetPropertyValue("Sufixo", ref _sufixo, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Usuário Web")]
    public System.String UsuarioWeb
    {
      get
      {
        return _usuarioWeb;
      }
      set
      {
        SetPropertyValue("UsuarioWeb", ref _usuarioWeb, value);
      }
    }
    [DevExpress.ExpressApp.DC.XafDisplayNameAttribute("Senha Web")]
    public System.String SenhaWeb
    {
      get
      {
        return _senhaWeb;
      }
      set
      {
        SetPropertyValue("SenhaWeb", ref _senhaWeb, value);
      }
    }
  }
}