Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60135 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeFDBiU (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 3 Jun 2018 21:38:20 -0400
Date: Sun, 3 Jun 2018 18:38:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Maxim Kochetkov <fido_max@inbox.ru>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: watchdog: orion_wdt: add wdt status init for handle_boot_enabled
Message-ID: <20180604013818.GA306@roeck-us.net>
References: <0334679d-12c5-00ba-e896-abbf5b6eaa01@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0334679d-12c5-00ba-e896-abbf5b6eaa01@inbox.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, May 30, 2018 at 07:59:12AM +0300, Maxim Kochetkov wrote:
> This patch add init of wdt.status for CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED
> 
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I can not get this patch to apply. Can you rebase to mainline and resend,
or at least let us know what you used as base version ?

Thanks,
Guenter

> ---
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --- a/drivers/watchdog/orion_wdt.c.orig	2018-04-19 09:54:12.000000000 +0300
> +++ b/drivers/watchdog/orion_wdt.c	2018-05-29 15:00:29.560000000 +0300
> @@ -581,6 +581,8 @@ static int orion_wdt_probe(struct platfo
>   	 */
>   	if (!orion_wdt_enabled(&dev->wdt))
>   		orion_wdt_stop(&dev->wdt);
> +	else
> +		set_bit(WDOG_HW_RUNNING, &dev->wdt.status);
> 
>   	/* Request the IRQ only after the watchdog is disabled */
>   	irq = platform_get_irq(pdev, 0);
