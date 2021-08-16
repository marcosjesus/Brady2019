using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using CielPostal.Module.BusinessObjects;
using DevExpress.Xpo;
using DevExpress.Xpo.DB;
using System.Configuration;
using DevExpress.Xpo.Metadata;
using DevExpress.Data.Filtering;
using DevExpress.Persistent.BaseImpl;

namespace CielPostal.Wcf
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "NFe_Method" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select NFe_Method.svc or NFe_Method.svc.cs at the Solution Explorer and start debugging.
    public class NFe_Method : INFe_Method
    {
        public string GetData(int value)
        {
            return string.Format("You entered: {0}", value);
        }

        public CompositeType GetDataUsingDataContract(CompositeType composite)
        {
            if (composite == null)
            {
                throw new ArgumentNullException("composite");
            }
            if (composite.BoolValue)
            {
                composite.StringValue += "Suffix";
            }
            return composite;
        }

        public void CreateNFe()
        {

            XPDictionary dict = new ReflectionDictionary();
            dict.GetDataStoreSchema(typeof(NFe_Header).Assembly);
            string defaultConnectionString = "";
            if (ConfigurationManager.ConnectionStrings["ConnectionString"] != null)
                defaultConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            IDataStore store = DevExpress.Xpo.XpoDefault.GetConnectionProvider(defaultConnectionString, DevExpress.Xpo.DB.AutoCreateOption.DatabaseAndSchema);
            XpoDefault.DataLayer = new ThreadSafeDataLayer(dict, store);
            XpoDefault.Session = null;

            using (UnitOfWork session = new UnitOfWork(XpoDefault.DataLayer))
            {
                NFe_Header nfHeader = new NFe_Header(session);
                nfHeader.ObterNFe();
                nfHeader.Delete();
                session.CommitChanges();
            }

        }

        public void UpdateSRONFe()
        {

            XPDictionary dict = new ReflectionDictionary();
            dict.GetDataStoreSchema(typeof(NFe_Header).Assembly);
            string defaultConnectionString = "";
            if (ConfigurationManager.ConnectionStrings["ConnectionString"] != null)
                defaultConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            IDataStore store = DevExpress.Xpo.XpoDefault.GetConnectionProvider(defaultConnectionString, DevExpress.Xpo.DB.AutoCreateOption.DatabaseAndSchema);
            XpoDefault.DataLayer = new ThreadSafeDataLayer(dict, store);
            XpoDefault.Session = null;

            using (UnitOfWork session = new UnitOfWork(XpoDefault.DataLayer))
            {

                XPCollection nfHeaders = new XPCollection(session, typeof(NFe_Header), CriteriaOperator.Parse("ProdutoEntregue = false"));
                foreach (NFe_Header nfHeader in nfHeaders)
                {
                    
                    nfHeader.RastrearEntrega();

                }

                session.CommitChanges();

            }

        }

        public void CapturarPedidos()
        {

            XPDictionary dict = new ReflectionDictionary();
            dict.GetDataStoreSchema(typeof(ESO_Header).Assembly);
            string defaultConnectionString = "";
            if (ConfigurationManager.ConnectionStrings["ConnectionString"] != null)
                defaultConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            IDataStore store = DevExpress.Xpo.XpoDefault.GetConnectionProvider(defaultConnectionString, DevExpress.Xpo.DB.AutoCreateOption.DatabaseAndSchema);
            XpoDefault.DataLayer = new ThreadSafeDataLayer(dict, store);
            XpoDefault.Session = null;

            using (UnitOfWork session = new UnitOfWork(XpoDefault.DataLayer))
            {
                ESO_Header esoHeader = new ESO_Header(session);
                esoHeader.CapturarPedidos();
                esoHeader.Delete();
                session.CommitChanges();
            }

        }

        public void AtualizarEstoque()
        {

            XPDictionary dict = new ReflectionDictionary();
            dict.GetDataStoreSchema(typeof(ESO_Header).Assembly);
            string defaultConnectionString = "";
            if (ConfigurationManager.ConnectionStrings["ConnectionString"] != null)
                defaultConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            IDataStore store = DevExpress.Xpo.XpoDefault.GetConnectionProvider(defaultConnectionString, DevExpress.Xpo.DB.AutoCreateOption.DatabaseAndSchema);
            XpoDefault.DataLayer = new ThreadSafeDataLayer(dict, store);
            XpoDefault.Session = null;

            using (UnitOfWork session = new UnitOfWork(XpoDefault.DataLayer))
            {
                ESO_Header esoHeader = new ESO_Header(session);
                esoHeader.AtualizarEstoque();
                esoHeader.Delete();
                session.CommitChanges();
            }

        }

    }
}
