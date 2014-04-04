Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from [207.46.163.237] ([207.46.163.237]:6002 "EHLO
	na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751215AbaDDBOk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Apr 2014 21:14:40 -0400
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: "wim@iguana.be" <wim@iguana.be>,
	"shawn.guo@linaro.org" <shawn.guo@linaro.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv4 2/2] watchdog: imx2_wdt: convert to use regmap API.
Date: Fri, 4 Apr 2014 01:13:37 +0000
Message-ID: <6563b26412a7457ba38e2dcf0bdcb643@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1396487059-15298-1-git-send-email-Li.Xiubo@freescale.com>
 <1396487059-15298-3-git-send-email-Li.Xiubo@freescale.com>
 <20140403163604.GA11832@roeck-us.net>
In-Reply-To: <20140403163604.GA11832@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> > +	base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> > +	imx2_wdt.regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
> > +						    &imx2_wdt_regmap_config);
> 
> This patch causes the following buiild failure:
> 
> Building arm:imx_v4_v5_defconfig ... failed
> --------------
> Error log:
> drivers/built-in.o: In function `imx2_wdt_probe':
> clk-composite.c:(.init.text+0x82c4): undefined reference to
> `devm_regmap_init_mmio_clk'
> make: *** [vmlinux] Error 1
> --------------
> 
> This is on top of
> 
> b33ce44 Merge branch 'for-3.15/drivers' of git://git.kernel.dk/linux-block
> 
> Does it have build dependencies on code which is (or was) not yet available
> in mainline ?
> 

This is caused by not compiling the regmap core.

Could you add the following patch to have a try ?
==========================
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 79d2589..3e55fa9 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -369,6 +369,7 @@ config MAX63XX_WATCHDOG
 config IMX2_WDT
        tristate "IMX2+ Watchdog"
        depends on ARCH_MXC
+       select REGMAP_MMIO
        help
          This is the driver for the hardware watchdog
          on the Freescale IMX2 and later processors.
--------------------------

If it's okey, I'll sent the v5 series to fix this.

Thanks very much,

BRs
Xiubo


