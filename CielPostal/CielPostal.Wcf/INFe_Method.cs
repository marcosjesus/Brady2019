using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace CielPostal.Wcf
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "INFe_Method" in both code and config file together.
    [ServiceContract]
    public interface INFe_Method
    {

        [OperationContract]
        string GetData(int value);

        [OperationContract]
        CompositeType GetDataUsingDataContract(CompositeType composite);

        // TODO: Add your service operations here
        [OperationContract]
        void CreateNFe();

        [OperationContract]
        void UpdateSRONFe();

        [OperationContract]
        void CapturarPedidos();

        [OperationContract]
        void AtualizarEstoque();

    }


    // Use a data contract as illustrated in the sample below to add composite types to service operations.
    [DataContract]
    public class CompositeType
    {
        bool boolValue = true;
        string stringValue = "Hello ";

        [DataMember]
        public bool BoolValue
        {
            get { return boolValue; }
            set { boolValue = value; }
        }

        [DataMember]
        public string StringValue
        {
            get { return stringValue; }
            set { stringValue = value; }
        }
    }

}
