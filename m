Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59176 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbdHNOrx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 10:47:53 -0400
Date: Mon, 14 Aug 2017 07:47:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 2/2] watchdog: cadence_wdt: Show information when driver
 is probed
Message-ID: <20170814144750.GC14491@roeck-us.net>
References: <6c3cef5b847f315f5fc1eb891b040e33719e88c7.1501832354.git.michal.simek@xilinx.com>
 <32d58c86a3afbdfc25fe26a9e51df917ce5da4ac.1501832354.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32d58c86a3afbdfc25fe26a9e51df917ce5da4ac.1501832354.git.michal.simek@xilinx.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Aug 04, 2017 at 09:39:17AM +0200, Michal Simek wrote:
> Showing message that driver is loaded is common across drivers.
> This change also fixes checkpatch (--strict) warning
> "Alignment should match open parenthesis".
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
>  drivers/watchdog/cadence_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
> index dadd3b0c2d49..064cf7b6c1c5 100644
> --- a/drivers/watchdog/cadence_wdt.c
> +++ b/drivers/watchdog/cadence_wdt.c
> @@ -368,7 +368,7 @@ static int cdns_wdt_probe(struct platform_device *pdev)
>  	}
>  	platform_set_drvdata(pdev, wdt);
>  
> -	dev_dbg(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds%s\n",
> +	dev_info(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds%s\n",
>  		 wdt->regs, cdns_wdt_device->timeout,
>  		 nowayout ? ", nowayout" : "");
>  
> -- 
> 1.9.1
> 
