Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:56479 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751696AbaEZTDB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 May 2014 15:03:01 -0400
Date: Mon, 26 May 2014 21:02:59 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-watchdog@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] watchdog: ath79_wdt: avoid spurious restarts on AR934x
Message-ID: <20140526190259.GA21584@spo001.leaseweb.com>
References: <1397640881-21741-1-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1397640881-21741-1-git-send-email-juhosg@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Gabor,

> On some AR934x based systems, where the frequency of
> the AHB bus is relatively high, the built-in watchdog
> causes a spurious restart when it gets enabled.
> 
> The possible cause of these restarts is that the timeout
> value written into the TIMER register does not reaches
> the hardware in time.
> 
> Add an explicit delay into the ath79_wdt_enable function
> to avoid the spurious restarts.
> 
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/watchdog/ath79_wdt.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
> index 399c3fd..0e67d96 100644
> --- a/drivers/watchdog/ath79_wdt.c
> +++ b/drivers/watchdog/ath79_wdt.c
> @@ -20,6 +20,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/bitops.h>
> +#include <linux/delay.h>
>  #include <linux/errno.h>
>  #include <linux/fs.h>
>  #include <linux/io.h>
> @@ -90,6 +91,15 @@ static inline void ath79_wdt_keepalive(void)
>  static inline void ath79_wdt_enable(void)
>  {
>  	ath79_wdt_keepalive();
> +
> +	/*
> +	 * Updating the TIMER register requires a few microseconds
> +	 * on the AR934x SoCs at least. Use a small delay to ensure
> +	 * that the TIMER register is updated within the hardware
> +	 * before enabling the watchdog.
> +	 */
> +	udelay(2);
> +
>  	ath79_wdt_wr(WDOG_REG_CTRL, WDOG_CTRL_ACTION_FCR);
>  	/* flush write */
>  	ath79_wdt_rr(WDOG_REG_CTRL);

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

