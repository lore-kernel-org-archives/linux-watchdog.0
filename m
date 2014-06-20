Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2lp0209.outbound.protection.outlook.com ([207.46.163.209]:19877
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932189AbaFTIBA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Jun 2014 04:01:00 -0400
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: "wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH v2] watchdog: imx2_wdt: adds big endianness support.
Date: Fri, 20 Jun 2014 07:58:45 +0000
Message-ID: <af580b419cb54df38ac8fcf08fc22d1e@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1401763514-32589-1-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1401763514-32589-1-git-send-email-Li.Xiubo@freescale.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

I'd like to know the state of this patch.
:)

Thanks,

BRs
Xiubo


> -----Original Message-----
> From: Xiubo Li [mailto:Li.Xiubo@freescale.com]
> Sent: Tuesday, June 03, 2014 10:45 AM
> To: wim@iguana.be; linux-watchdog@vger.kernel.org
> Cc: robh+dt@kernel.org; pawel.moll@arm.com; mark.rutland@arm.com;
> ijc+devicetree@hellion.org.uk; galak@codeaurora.org; Xiubo Li-B47053
> Subject: [PATCH v2] watchdog: imx2_wdt: adds big endianness support.
> 
> This watchdog driver will be working on IMX2+, Vybrid, LS1, LS2+
> platforms, and will be in different endianness mode in those SoCs:
> 
>     SoCs       WDT endian mode
> ------------------------------------
>     IMX2+           LE
>     Vybird          LE
>     LS1             BE
>     LS2             LE
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
> 
> 
> Changes in V2:
> - Document the use of the 'big-endian' property.
> 
> 
> 
> 
>  Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt | 5 +++++
>  drivers/watchdog/imx2_wdt.c                                | 7 +++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> index 2144af1..e52ba2d 100644
> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
> @@ -5,10 +5,15 @@ Required properties:
>  - reg : Should contain WDT registers location and length
>  - interrupts : Should contain WDT interrupt
> 
> +Optional property:
> +- big-endian: If present the watchdog device's registers are implemented
> +  in big endian mode, otherwise in little mode.
> +
>  Examples:
> 
>  wdt@73f98000 {
>  	compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
>  	reg = <0x73f98000 0x4000>;
>  	interrupts = <58>;
> +	big-endian;
>  };
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 9d4874f..68c3d37 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -28,6 +28,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> +#include <linux/of_address.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/timer.h>
> @@ -190,10 +191,12 @@ static struct regmap_config imx2_wdt_regmap_config = {
> 
>  static int __init imx2_wdt_probe(struct platform_device *pdev)
>  {
> +	struct device_node *np = pdev->dev.of_node;
>  	struct imx2_wdt_device *wdev;
>  	struct watchdog_device *wdog;
>  	struct resource *res;
>  	void __iomem *base;
> +	bool big_endian;
>  	int ret;
>  	u32 val;
> 
> @@ -201,6 +204,10 @@ static int __init imx2_wdt_probe(struct platform_device
> *pdev)
>  	if (!wdev)
>  		return -ENOMEM;
> 
> +	big_endian = of_property_read_bool(np, "big-endian");
> +	if (big_endian)
> +		imx2_wdt_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(base))
> --
> 1.8.4

