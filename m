Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:40264 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057AbaDGQsT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 7 Apr 2014 12:48:19 -0400
Received: by mail-pa0-f50.google.com with SMTP id kq14so7039122pab.9
        for <linux-watchdog@vger.kernel.org>; Mon, 07 Apr 2014 09:48:18 -0700 (PDT)
Date: Mon, 7 Apr 2014 09:48:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Xiubo Li <Li.Xiubo@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: imx2_wdt:  convert to watchdog core api
Message-ID: <20140407164811.GA28025@roeck-us.net>
References: <1396722580-7058-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1396722580-7058-1-git-send-email-agust@denx.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Apr 05, 2014 at 08:29:40PM +0200, Anatolij Gustschin wrote:
> Convert the imx2_wdt driver to the new watchdog core api.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Looks pretty good, just a couple of nitpicks.

> ---
> NOTE: This patch applies on top of the imx2_wdt regmap-mmio support
> patch series http://comments.gmane.org/gmane.linux.kernel/1677735
> 
>  drivers/watchdog/Kconfig    |    1 +
>  drivers/watchdog/imx2_wdt.c |  292 ++++++++++++++++++-------------------------
>  2 files changed, 124 insertions(+), 169 deletions(-)
>  
[ ... ]

> -static void imx2_wdt_timer_ping(unsigned long arg)
> -{
> -	/* ping it every imx2_wdt.timeout / 2 seconds to prevent reboot */
> -	imx2_wdt_ping();
> -	mod_timer(&imx2_wdt.timer, jiffies + imx2_wdt.timeout * HZ / 2);
> +	regmap_read(wdev->regmap, IMX2_WDT_WCR, &val);
> +
> +	if (val & IMX2_WDT_WCR_WDE)
> +		return true;
> +	return false;
>  }

You can simplyfy this to

	return val & IMX2_WDT_WCR_WDE;

since C auto-converts from int to bool. If you feel fancy and don't
trust the C compiler, another option would be

	return !!(val & IMX2_WDT_WCR_WDE);

which would at least drop the if statement.

[ ... ]

> +
> +	wdog->timeout = clamp_t(unsigned, timeout, 1, IMX2_WDT_MAX_TIME);
> +	if (wdog->timeout != timeout)
>  		dev_warn(&pdev->dev, "Initial timeout out of range! "
> -			"Clamped from %u to %u\n", timeout, imx2_wdt.timeout);
> +			"Clamped from %u to %u\n", timeout, wdog->timeout);

Somewhat unrelated, but this results in a checkpatch warning.
I would suggest to put the string in a single line.

		dev_warn(&pdev->dev,
			 "Initial timeout out of range! Clamped from %u to %u\n",
			 timeout, wdog->timeout);

Guenter
