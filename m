Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: "wim@iguana.be" <wim@iguana.be>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        Shawn Guo <Shawn.Guo@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: FW: [PATCHv2 1/2] watchdog: imx2_wdt: Sort the header files
 alphabetically
Date: Fri, 28 Mar 2014 04:15:49 +0000
Message-ID: <605e46d4edf64b94939e566e5bfe9c33@BY2PR03MB505.namprd03.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Forward to Shawn,

Thanks,



> -----Original Message-----
> From: Xiubo Li [mailto:Li.Xiubo@freescale.com]
> Sent: Wednesday, March 26, 2014 10:22 AM
> To: wim@iguana.be; w.sang@pengutronix.de; linux-watchdog@vger.kernel.org;
> linux@roeck-us.net
> Cc: linux-kernel@vger.kernel.org; Xiubo Li-B47053
> Subject: [PATCHv2 1/2] watchdog: imx2_wdt: Sort the header files
> alphabetically
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/imx2_wdt.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index dd51d95..1795922 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -21,19 +21,19 @@
>   * Halt on suspend:	Manual		Can be automatic
>   */
> 
> +#include <linux/clk.h>
> +#include <linux/fs.h>
>  #include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/platform_device.h>
> -#include <linux/watchdog.h>
> -#include <linux/clk.h>
> -#include <linux/fs.h>
> -#include <linux/io.h>
> -#include <linux/uaccess.h>
>  #include <linux/timer.h>
> -#include <linux/jiffies.h>
> +#include <linux/uaccess.h>
> +#include <linux/watchdog.h>
> 
>  #define DRIVER_NAME "imx2-wdt"
> 
> --
> 1.8.4
> 
