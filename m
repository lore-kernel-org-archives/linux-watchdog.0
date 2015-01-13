Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38361 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbbAMOYN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 13 Jan 2015 09:24:13 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YB2OD-0011Jg-GL
	for linux-watchdog@vger.kernel.org; Tue, 13 Jan 2015 14:24:13 +0000
Date: Tue, 13 Jan 2015 06:23:41 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	wim@iguana.be, linux-watchdog@vger.kernel.org, kernel@stlinux.com,
	David Paris <david.paris@st.com>
Subject: Re: [4/4] watchdog: st_wdt: Add new driver for ST's LPC Watchdog
Message-ID: <20150113142341.GA15707@roeck-us.net>
References: <1414077524-6469-5-git-send-email-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1414077524-6469-5-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Oct 23, 2014 at 04:18:44PM +0100, Lee Jones wrote:
> Signed-off-by: David Paris <david.paris@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Digging myself out of my hole. Sorry for the laaaate reply.

> ---
>  drivers/watchdog/Kconfig  |  16 +++
>  drivers/watchdog/Makefile |   1 +
>  drivers/watchdog/st_wdt.c | 317 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 334 insertions(+)
>  create mode 100644 drivers/watchdog/st_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f57312f..c8abf57 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -432,6 +432,22 @@ config SIRFSOC_WATCHDOG
>  	  Support for CSR SiRFprimaII and SiRFatlasVI watchdog. When
>  	  the watchdog triggers the system will be reset.
>  
> +config ST_WATCHDOG
> +       tristate "STMicroelectronics LPC Watchdog"
> +       depends on ARCH_STI && OF
> +       depends on !RTC_DRV_ST_LPC

RTC_DRV_ST_LPC is not in mainline nor in -next. Is this still current ?

> +       select WATCHDOG_CORE
> +       help
> +	 Say Y here to include Watchdog timer support for the watchdog
> +	 existing in the LPC of STMicroelectronics SOCs.
> +	 !!! BE CARREFUL !!!
> +	 This driver shares hardware resources with RTC Alarm part of the
> +	 LPC. Both LPC Watchdog driver and LPC RTC driver cannot be
> +	 used together.
> +

Arnd has asked if/how this is enforced by the code. Was this ever resolved ?

> +	 To compile this driver as a module, choose M here: the
> +	 module will be called st-wdt.
> +

[ ... ]

> +	watchdog_set_drvdata(&st_wdog_dev, st_wdog);
> +	watchdog_set_nowayout(&st_wdog_dev, WATCHDOG_NOWAYOUT);
> +
> +	/* Init Watchdog timeout with value in DT */
> +	ret = watchdog_init_timeout(&st_wdog_dev, 0, &pdev->dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to initialise watchdog timeout\n");

Missing clk_disable_unprepare().

> +		return ret;
> +	}
> +
> +	ret = watchdog_register_device(&st_wdog_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to register watchdog\n");
> +		clk_disable_unprepare(clk);
> +		return ret;
> +	}
> +
> +	st_wdog_setup(st_wdog, true);
> +
> +	dev_info(&pdev->dev, "LPC Watchdog driver registered, reset type is %s",
> +		 st_wdog->warm_reset ? "warm" : "cold");

Missing newline.

Guenter
