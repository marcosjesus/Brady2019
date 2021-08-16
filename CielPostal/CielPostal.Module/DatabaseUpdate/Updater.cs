using System;

using DevExpress.ExpressApp;
using DevExpress.ExpressApp.Updating;
using DevExpress.Xpo;
using DevExpress.Data.Filtering;
using DevExpress.Persistent.BaseImpl;
using DevExpress.ExpressApp.Security;
using DevExpress.ExpressApp.Security.Strategy;
using CielPostal.Module.BusinessObjects;

namespace CielPostal.Module.DatabaseUpdate
{
    public class Updater : ModuleUpdater
    {
        public Updater(IObjectSpace objectSpace, Version currentDBVersion) : base(objectSpace, currentDBVersion) { }
        public override void UpdateDatabaseAfterUpdateSchema()
        {
            base.UpdateDatabaseAfterUpdateSchema();

            SecuritySystemRole adminRole = ObjectSpace.FindObject<SecuritySystemRole>(new BinaryOperator("Name", "Administrador"));
            if (adminRole == null)
            {
                adminRole = ObjectSpace.CreateObject<SecuritySystemRole>();
                adminRole.Name = "Administrador";
                adminRole.IsAdministrative = true;
            }
            
            SecuritySystemUser userCiel = ObjectSpace.FindObject<SecuritySystemUser>(new BinaryOperator("UserName", "Ciel"));
            if (userCiel == null)
            {
                userCiel = ObjectSpace.CreateObject<SecuritySystemUser>();
                userCiel.UserName = "Ciel";
                userCiel.SetPassword("Ciel-123");
                userCiel.Roles.Add(adminRole);
            }

        }
    }
}
