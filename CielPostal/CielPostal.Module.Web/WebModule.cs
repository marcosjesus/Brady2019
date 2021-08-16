using System;
using System.ComponentModel;
using System.Collections.Generic;

using DevExpress.ExpressApp;
using DevExpress.ExpressApp.Updating;

namespace CielPostal.Module.Web
{
    [ToolboxItemFilter("Xaf.Platform.Web")]
    public sealed partial class CielPostalAspNetModule : ModuleBase
    {
        public CielPostalAspNetModule()
        {
            InitializeComponent();
        }
        public override IEnumerable<ModuleUpdater> GetModuleUpdaters(IObjectSpace objectSpace, Version versionFromDB)
        {
            return ModuleUpdater.EmptyModuleUpdaters;
        }
    }
}
