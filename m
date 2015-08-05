Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:58226 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbbHEK7D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 5 Aug 2015 06:59:03 -0400
Date: Wed, 5 Aug 2015 12:40:30 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: <wim@iguana.be>, <robh+dt@kernel.org>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>, boris.brezillon@free-electrons.com,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	sylvain.rochet@finsecur.com, nicolas.ferre@atmel.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] drivers: watchdog: add a driver to support
 SAMA5D4 watchdog timer
Message-ID: <20150805124030.6e73b975@ipc1.ka-ro>
In-Reply-To: <1438765043-11030-2-git-send-email-wenyou.yang@atmel.com>
References: <1438765043-11030-1-git-send-email-wenyou.yang@atmel.com>
	<1438765043-11030-2-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

> From SAMA5D4, the watchdog timer is upgrated with a new feature,
> which is describled as in the datasheet, "WDT_MR can be written
> until a LOCKMR command is issued in WDT_CR".
> That is to say, as long as the bootstrap and u-boot don't issue
> a LOCKMR command, WDT_MR can be written more than once in the driver.
> 
> So the SAMA5D4 watchdog driver's implementation is different from
> the at91sam9260 watchdog driver implemented in file at91sam9_wdt.c.
> The user application open the device file to enable the watchdog timer
> hardware, and close to disable it, and set the watchdog timer timeout
> by seting WDV and WDD fields of WDT_MR register, and ping the watchdog
> by issuing WDRSTT command to WDT_CR register with hard-coded key.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>  drivers/watchdog/Kconfig            |    9 ++
>  drivers/watchdog/Makefile           |    1 +
>  drivers/watchdog/at91_sama5d4_wdt.c |  279 +++++++++++++++++++++++++++++++++++
>  drivers/watchdog/at91sam9_wdt.h     |    2 +
>  4 files changed, 291 insertions(+)
>  create mode 100644 drivers/watchdog/at91_sama5d4_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index e5e7c55..4ce8346 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -152,6 +152,15 @@ config ARM_SP805_WATCHDOG
>  	  ARM Primecell SP805 Watchdog timer. This will reboot your system when
>  	  the timeout is reached.
>  
> +config AT91_SAMA5D4_WATCHDOG
> +	tristate "Atmel SAMA5D4 Watchdog Timer"
> +	depends on ARCH_AT91
> +	select WATCHDOG_CORE
> +	help
> +	  Atmel SAMA5D4 watchdog timer is embedded into SAMA5D4 chips.
> +	  Its Watchdog Timer Mode Register can be written more than once.
> +	  This will reboot your system when the timeout is reached.
> +
>  config AT91RM9200_WATCHDOG
>  	tristate "AT91RM9200 watchdog"
>  	depends on SOC_AT91RM9200 && MFD_SYSCON
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 5c19294..c57569c 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
>  
>  # ARM Architecture
>  obj-$(CONFIG_ARM_SP805_WATCHDOG) += sp805_wdt.o
> +obj-$(CONFIG_AT91_SAMA5D4_WATCHDOG) += at91_sama5d4_wdt.o
consistency? Other AT91 entries don't have an '_' between 'AT91' and
the remainder of the Kconfig name.

>  obj-$(CONFIG_AT91RM9200_WATCHDOG) += at91rm9200_wdt.o
>  obj-$(CONFIG_AT91SAM9X_WATCHDOG) += at91sam9_wdt.o
[...]
> +static irqreturn_t atmel_wdt_irq_handler(int irq, void *dev_id)
> +{
> +	struct atmel_wdt *wdt = platform_get_drvdata(dev_id);
> +
> +	if (wdt_read(wdt, AT91_WDT_SR)) {
> +		pr_crit("Atmel Watchdog Software Reset\n");
> +		emergency_restart();
> +		pr_crit("Reboot didn't ?????\n");
>
Reboot didn't what? 'succeed' perhaps?

> +static const struct of_device_id atmel_wdt_of_match[] = {
> +	{ .compatible = "atmel,sama5d4-wdt", },
> +	{ },
The empty initializer must always be the last element of the array, so
there is no point in having a trailing ',' (whose purpose is to
facilitate adding more entries after the last one).
Without the comma there will be a compile error if (e.g. due to a
badly resolved merge conflict) an additional entry would be added after
the stop marker. With the comma after the stop marker any trailing
entries would silently be ignored.


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
