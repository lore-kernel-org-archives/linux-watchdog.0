Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:50304 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbdG2W0K (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 29 Jul 2017 18:26:10 -0400
Date: Sun, 30 Jul 2017 00:26:08 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Moritz Fischer <mdf@kernel.org>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        a.zummo@towertech.it, wim@iguana.be, linux@roeck-us.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-rtc@vger.kernel.org,
        Moritz Fischer <moritz.fischer@ettus.com>
Subject: Re: [PATCH 2/2] mfd: ds1374: Add Dallas/Maxim DS1374 Multi Function
 Device
Message-ID: <20170729222608.awlcjefi7wzfnahj@piout.net>
References: <1499975665-14581-1-git-send-email-mdf@kernel.org>
 <1499975665-14581-2-git-send-email-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499975665-14581-2-git-send-email-mdf@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 13/07/2017 at 12:54:25 -0700, Moritz Fischer wrote:
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 52a70ee..1703611 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -120,6 +120,16 @@ config DA9062_WATCHDOG
>  
>  	  This driver can be built as a module. The module name is da9062_wdt.
>  
> +config DS1374_WATCHDOG
> +	tristate "Maxim/Dallas 1374 Watchdog"

If you want to keep the backward compatibility, this probably needs to
be defaulting to RTC_DRV_DS1374 when RTC_DRV_DS1374_WDT is selected.

Also, maybe we need to make RTC_DRV_DS1374_WDT not user selectable.

If you don't think backward compatibility can be achieved, then we can
drop everything.

Else, the RTC part seems fine to me but the driver may be cleaned up a
bit further afterwards.

> +	depends on MFD_DS1374
> +	depends on REGMAP_I2C
> +	select WATCHDOG_CORE
> +	help
> +	  Support for the watchdog in the Maxim/Dallas DS1374 MFD.
> +
> +	  This driver can be built as a module. The module name is ds1374-wdt.
> +
>  config GPIO_WATCHDOG
>  	tristate "Watchdog device controlled through GPIO-line"
>  	depends on OF_GPIO

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
