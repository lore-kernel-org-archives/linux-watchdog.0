Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1blp0184.outbound.protection.outlook.com ([207.46.163.184]:26199
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753519AbaHYHCE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Aug 2014 03:02:04 -0400
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: Markus Pargmann <mpa@pengutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH] watchdog: imx2_wdt: Remove seperate big endian handling
Date: Mon, 25 Aug 2014 07:01:57 +0000
Message-ID: <4b9a55951535433aada42332b08f664f@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1408949015-28759-1-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1408949015-28759-1-git-send-email-mpa@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Markus,

Thanks for your work.

And there has already one patch for this:

"watchdog: imx2_wdt: Convert to use regmap framework's endianness method."

Thanks,

BRs
Xiubo



> -----Original Message-----
> From: Markus Pargmann [mailto:mpa@pengutronix.de]
> Sent: Monday, August 25, 2014 2:44 PM
> To: Wim Van Sebroeck
> Cc: linux-watchdog@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> kernel@pengutronix.de; Markus Pargmann; Xiubo Li-B47053
> Subject: [PATCH] watchdog: imx2_wdt: Remove seperate big endian handling
> 
> 3.18 will contain a patch that handles endianess within the regmap
> framework. It does not need any parsing of DT properties within the
> driver, so we can savely remove it here.
> The required mainline patch is
> 	(regmap: add DT endianness binding support.)
> 
> Cc: Xiubo Li <Li.Xiubo@freescale.com>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
> Hi,
> 
> This is the topic branch with the patches which replace the functionality of
> this code.
> https://git.kernel.org/cgit/linux/kernel/git/broonie/regmap.git/log/?h=topic/d
> t-endian
> 
> Best regards,
> 
> Markus
> 
> 
>  drivers/watchdog/imx2_wdt.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 68c3d379ffa8..9d4874f09948 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -28,7 +28,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> -#include <linux/of_address.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/timer.h>
> @@ -191,12 +190,10 @@ static struct regmap_config imx2_wdt_regmap_config = {
> 
>  static int __init imx2_wdt_probe(struct platform_device *pdev)
>  {
> -	struct device_node *np = pdev->dev.of_node;
>  	struct imx2_wdt_device *wdev;
>  	struct watchdog_device *wdog;
>  	struct resource *res;
>  	void __iomem *base;
> -	bool big_endian;
>  	int ret;
>  	u32 val;
> 
> @@ -204,10 +201,6 @@ static int __init imx2_wdt_probe(struct platform_device
> *pdev)
>  	if (!wdev)
>  		return -ENOMEM;
> 
> -	big_endian = of_property_read_bool(np, "big-endian");
> -	if (big_endian)
> -		imx2_wdt_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
> -
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(base))
> --
> 2.1.0.rc1

