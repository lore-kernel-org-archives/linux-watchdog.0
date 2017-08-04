Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38437 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbdHDNsA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 4 Aug 2017 09:48:00 -0400
Subject: Re: [PATCH 2/2] watchdog: cadence_wdt: Show information when driver
 is probed
To: Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
References: <6c3cef5b847f315f5fc1eb891b040e33719e88c7.1501832354.git.michal.simek@xilinx.com>
 <32d58c86a3afbdfc25fe26a9e51df917ce5da4ac.1501832354.git.michal.simek@xilinx.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <6ad8cad8-e1a4-57ec-d25f-dc6b0935a6fb@roeck-us.net>
Date: Fri, 4 Aug 2017 06:47:56 -0700
MIME-Version: 1.0
In-Reply-To: <32d58c86a3afbdfc25fe26a9e51df917ce5da4ac.1501832354.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/04/2017 12:39 AM, Michal Simek wrote:
> Showing message that driver is loaded is common across drivers.

Across watchdog drivers, which I am always half-annoyed about.
Is this really valuable ?

Guenter

> This change also fixes checkpatch (--strict) warning
> "Alignment should match open parenthesis".
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>   drivers/watchdog/cadence_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
> index dadd3b0c2d49..064cf7b6c1c5 100644
> --- a/drivers/watchdog/cadence_wdt.c
> +++ b/drivers/watchdog/cadence_wdt.c
> @@ -368,7 +368,7 @@ static int cdns_wdt_probe(struct platform_device *pdev)
>   	}
>   	platform_set_drvdata(pdev, wdt);
>   
> -	dev_dbg(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds%s\n",
> +	dev_info(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds%s\n",
>   		 wdt->regs, cdns_wdt_device->timeout,
>   		 nowayout ? ", nowayout" : "");
>   
> 

