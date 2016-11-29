Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36657 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753564AbcK2A7f (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 28 Nov 2016 19:59:35 -0500
Date: Mon, 28 Nov 2016 16:59:28 -0800
From: Eduardo Valentin <edubezval@gmail.com>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH V2 03/10] Documentation: devicetree: thermal: da9062/61
 TJUNC temperature binding
Message-ID: <20161129005927.GA1848@localhost.localdomain>
References: <cover.1477501000.git.stwiss.opensource@diasemi.com>
 <d8c986e39bafc2b8a1c5c23e722f61cdd021e9be.1477501000.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8c986e39bafc2b8a1c5c23e722f61cdd021e9be.1477501000.git.stwiss.opensource@diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 26, 2016 at 05:56:37PM +0100, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Device tree binding information for DA9062 and DA9061 thermal junction
> temperature monitor.
> 
> Binding descriptions for the DA9061 and DA9062 thermal TJUNC supervisor
> device driver, using a single THERMAL_TRIP_HOT trip-wire and allowing for
> a configurable polling period for over-temperature polling.
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> This patch applies against linux-next and v4.8
> 
> v1 -> v2
>  - Patch renamed from [PATCH V1 08/10] to [PATCH V2 03/10] -- these
>    changes were made to fix checkpatch warnings caused by the patch
>    set dependency order
>  - A second example for DA9061 is provided to highlight the use of a
>    fall-back compatible option for the DA9062 watchdog driver
> 
> Hi,
> 
> This patch depends on acceptance of the main code for the thermal device
> driver:
>   [PATCH V2 09/10] thermal: da9061: TJUNC temperature driver 
> 
> The previous [PATCH V1 08/10] was acked-by: Rob Herring, however this has
> not been added because changes have been made to add a new binding
> example. This describes the use of DA9061.
> This addition was made after alterations to the device driver meant that a
> fall-back compatible string could reuse the DA9062 device driver.
>  
> Regards,
> Steve Twiss, Dialog Semiconductor Ltd.
> 
> 
>  .../devicetree/bindings/thermal/da9062-thermal.txt | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/da9062-thermal.txt b/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
> new file mode 100644
> index 0000000..fb207ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
> @@ -0,0 +1,37 @@
> +* Dialog DA9062/61 TJUNC Thermal Module
> +
> +This module is part of the DA9061/DA9062. For more details about entire
> +DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da9062.txt
> +
> +Junction temperature thermal module uses an interrupt signal to identify
> +high THERMAL_TRIP_HOT temperatures for the PMIC device.
> +
> +Required properties:
> +
> +- compatible: should be one of:
> +        dlg,da9061-thermal
> +        dlg,da9062-thermal
> +
> +Optional properties:
> +
> +- dlg,tjunc-temp-polling-period-ms : Specify the polling period, measured
> +    in milliseconds, between thermal zone device update checks.


Can you please elaborate on why you need this chip manufacture specific property?

Can we use the polling property of already existing in the 
Documentation/devicetree/bindings/thermal/thermal.txt

See the polling properties.

> +
> +Example: DA9061
> +
> +	pmic0: da9062@58 {
> +		thermal {
> +			compatible = "dlg,da9062-thermal";
> +			dlg,tjunc-temp-polling-period-ms = <3000>;

Same

> +		};
> +	};
> +
> +Example: DA9061 using a fall-back compatible for the DA9062 onkey driver
> +
> +	pmic0: da9061@58 {
> +		thermal {
> +			compatible = "dlg,da9061-thermal", "dlg,da9062-thermal";
> +			dlg,tjunc-temp-polling-period-ms = <3000>;

Same 
> +		};
> +	};
> +
> -- 
> end-of-patch for PATCH V2
> 
