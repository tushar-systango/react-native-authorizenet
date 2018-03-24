using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Authorize.Net.RNAuthorizeNet
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNAuthorizeNetModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNAuthorizeNetModule"/>.
        /// </summary>
        internal RNAuthorizeNetModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNAuthorizeNet";
            }
        }
    }
}
