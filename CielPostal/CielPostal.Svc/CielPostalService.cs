using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using CielPostal.Svc.ServiceNFe_Method;
using System.Timers;

namespace CielPostal.Svc
{
    public partial class CielPostalService : ServiceBase
    {
        public static System.Timers.Timer timerGetNFe;
        public static bool stopedRequest;
        public static EventLog eventLogCiel;

        public CielPostalService()
        {
            InitializeComponent();

            eventLogCiel = new System.Diagnostics.EventLog();

            if (!System.Diagnostics.EventLog.SourceExists("CielPostal"))
            {
                System.Diagnostics.EventLog.CreateEventSource("CielPostal", "CielPostal");
            }

            eventLogCiel.Source = "CielPostal";
            eventLogCiel.Log = "CielPostal";

            timerGetNFe = new Timer();
            timerGetNFe.AutoReset = false;
            timerGetNFe.Interval = 30000;
            timerGetNFe.Elapsed += new System.Timers.ElapsedEventHandler(timerGetNFe_Elapsed);
            timerGetNFe.Enabled = true;

        }

        protected override void OnStart(string[] args)
        {

            eventLogCiel.WriteEntry("Serviço CielPostal esta sendo iniciado.", EventLogEntryType.Information);
            stopedRequest = false;
            timerGetNFe.Enabled = true;

        }

        protected override void OnStop()
        {

            eventLogCiel.WriteEntry("Serviço CielPostal esta sendo encerrado.", EventLogEntryType.Information);
            stopedRequest = true;

        }

        static void timerGetNFe_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {

            try
            {

                NFe_MethodClient client = new NFe_MethodClient();

                eventLogCiel.WriteEntry("Obtendo NFe Sonda.", EventLogEntryType.Information);
                try
                {
                    
                    client.CreateNFe();

                }
                catch (Exception except)
                {

                    eventLogCiel.WriteEntry("Create NFe: " + except.Message, EventLogEntryType.Error);

                }

                eventLogCiel.WriteEntry("Atualizando Entrega Correios.", EventLogEntryType.Information);
                try
                {

                    client.UpdateSRONFe();

                }
                catch (Exception except)
                {

                    eventLogCiel.WriteEntry("Update SRO NFe: " + except.Message, EventLogEntryType.Error);

                }

                // eventLogCiel.WriteEntry("Obtendo Pedidos ECOM.");
                // client.CapturarPedidos();

                // eventLogCiel.WriteEntry("Atualizando Estoque ECOM.");
                // client.AtualizarEstoque();

                try
                {

                    client.Close();

                }
                catch (Exception except)
                {

                    eventLogCiel.WriteEntry("NFe Method Client (CLOSE): " + except.Message, EventLogEntryType.Error);

                }

            }
            catch (Exception except)
            {

                eventLogCiel.WriteEntry("NFe Method Client (CREATE): " + except.Message, EventLogEntryType.Error);

            }

            if (!stopedRequest)
            {
                
                timerGetNFe.Enabled = true;

            }

        }

    }

}
