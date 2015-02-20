Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 1.mo69.mail-out.ovh.net ([178.33.251.173]:35100 "EHLO
	1.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797AbbBTIXi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Feb 2015 03:23:38 -0500
Received: from mail409.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with SMTP id 0E778FF9872
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Feb 2015 08:48:29 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 2/2] at91sam9_wdt: Allow watchdog to reset device at early boot
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
In-Reply-To: <6c0a3a5bcd93d18437eeed04712b4aeff201a16f.1424262664.git.timo.kokkonen@offcode.fi>
Date: Fri, 20 Feb 2015 15:48:22 +0800
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	boris.brezillon@free-electrons.com,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Nicolas FERRE <nicolas.ferre@atmel.com>,
	alexandre.belloni@free-electrons.com
Content-Transfer-Encoding: 8BIT
Message-Id: <00B1658F-2F3A-4B90-ADCA-275770832180@jcrosoft.com>
References: <54B53160.6060309@roeck-us.net> <cover.1424262664.git.timo.kokkonen@offcode.fi> <cover.1424262664.git.timo.kokkonen@offcode.fi> <6c0a3a5bcd93d18437eeed04712b4aeff201a16f.1424262664.git.timo.kokkonen@offcode.fi>
To: Timo Kokkonen <timo.kokkonen@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


> On Feb 18, 2015, at 8:57 PM, Timo Kokkonen <timo.kokkonen@offcode.fi> wrote:
> 
> By default the driver will start a kernel timer which keeps on kicking
> the watchdog HW until user space has opened the watchdog
> device. Usually this is desirable as the watchdog HW is running by
> default and the user space may not have any watchdog daemon running at
> all.
> 
> However, on production systems it may be mandatory that also early
> crashes and lockups will lead to a watchdog reset, even if they happen
> before the user space has opened the watchdog device.
> 
> To resolve the issue, add a new device tree property
> "early-timeout-sec" which will let the kernel timer to ping the
> watchdog HW only as long as the specified timeout permits. The default
> is still to use kernel timer, but more strict behavior can be enabled
> via the device tree property.
> 
> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
> ---
> Documentation/devicetree/bindings/watchdog/watchdog.txt | 7 +++++++
> drivers/watchdog/at91sam9_wdt.c                         | 9 ++++++++-

This should not be handled by the driver but the kernel in a generic way

Best Regards,
J.
> 2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.txt b/Documentation/devicetree/bindings/watchdog/watchdog.txt
> index 7e3686c..32647cf 100644
> --- a/Documentation/devicetree/bindings/watchdog/watchdog.txt
> +++ b/Documentation/devicetree/bindings/watchdog/watchdog.txt
> @@ -4,9 +4,16 @@ using these definitions.
> 
> Optional properties:
> - timeout-sec: Contains the watchdog timeout in seconds.
> +- early-timeout-sec: If present, specifies a timeout value in seconds
> +  that the driver keeps on ticking the watchdog HW on behalf of user
> +  space. Once this timeout expires watchdog is left to expire in
> +  timeout-sec seconds. If this propery is set to zero, watchdog is
> +  started (or left running) so that a reset occurs in timeout-sec
> +  since the watchdog was started.
> 
> Example:
> 
> watchdog {
> 	 timeout-sec = <60>;
> +	 early-timeout-sec = <120>;
> };
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index 6df9405..1b40bfa 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -89,6 +89,8 @@ struct at91wdt {
> 	u32 mr_mask;
> 	unsigned long heartbeat;	/* WDT heartbeat in jiffies */
> 	bool nowayout;
> +	/* Timeout in jiffies for stopping the early timer */
> +	unsigned long early_timer;
> 	unsigned int irq;
> };
> 
> @@ -122,7 +124,8 @@ static void at91_ping(unsigned long data)
> {
> 	struct at91wdt *wdt = (struct at91wdt *)data;
> 	if (time_before(jiffies, wdt->next_heartbeat) ||
> -	    !watchdog_active(&wdt->wdd)) {
> +		(time_before(jiffies, wdt->early_timer) &&
> +			!watchdog_active(&wdt->wdd))) {
> 		at91_wdt_reset(wdt);
> 		mod_timer(&wdt->timer, jiffies + wdt->heartbeat);
> 	} else {
> @@ -316,6 +319,10 @@ static int of_at91wdt_init(struct device_node *np, struct at91wdt *wdt)
> 
> 	wdt->mr |= max | ((max - min) << 16);
> 
> +	if (!of_property_read_u32_index(np, "early-timeout-sec", 0,
> +					(u32 *)&wdt->early_timer))
> +		wdt->early_timer = wdt->early_timer * HZ + jiffies;
> +
> 	return 0;
> }
> #else
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

