Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:57880 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753806AbbBCACW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Feb 2015 19:02:22 -0500
Date: Tue, 3 Feb 2015 01:02:02 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	grant.likely@linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	heiko@sntech.de, yingjoe.chen@gmail.com, ibanezchen@gmail.com,
	greta.zhang@mediatek.com, eddie.huang@mediatek.com, wens@csie.org,
	linux@roeck-us.net, joe@perches.com
Subject: Re: [PATCH v5 0/2] ARM: mediatek: Add watchdog driver
Message-ID: <20150203000201.GA18024@spo001.leaseweb.nl>
References: <1421152136-5007-1-git-send-email-matthias.bgg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1421152136-5007-1-git-send-email-matthias.bgg@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Matthias,

> Mediatek SoCs have a watchdog driver. This patch set adds driver and DTS
> binding. The driver also implements a restart handler to reboot the SoC.
> 
> Changes for v5:
> - add newline in dev_info message
> - add tested-by and reviewed-by
> 
> Changes for v4:
> - fix indentation errors
> - delete unused include
> - reorganize while loop to eliminate code duplication
> - eliminate indirection to watchdog_device structure
> - delete unnecessary brackets
> 
> Changes for v3:
> - fix based on file name
> - fix style problems
> - fix error return value and warning message
> - delete unnecessary watchdog_set_drvdata
> - delete unused variable
> 
> Changes for v2:
> - we don't need to have the watchdog enabled to do a software reset
> - disable dual mode and irq mode when starting the watchdog
> - update commit message to name the SoCs the driver supports
> 
> 
> Matthias Brugger (2):
>   watchdog: Add driver for Mediatek watchdog
>   ARM: mediatek: dts: Add bindings for watchdog
> 
>  .../devicetree/bindings/watchdog/mtk-wdt.txt       |  13 ++
>  drivers/watchdog/Kconfig                           |  10 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/mtk_wdt.c                         | 252 +++++++++++++++++++++
>  4 files changed, 276 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>  create mode 100644 drivers/watchdog/mtk_wdt.c
> 

Both patches have been added to linux-watchdog-next.
I made a small change: I removed the .owner field in the platform_driver struct.
This is now normally set by the core.

Kind regards,
Wim.

