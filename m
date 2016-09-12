Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58014 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757742AbcILNBM (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 12 Sep 2016 09:01:12 -0400
Subject: Re: [PATCH] watchdog: rt2880_wdt: Remove assignment of dev pointer
To: Matt Redfearn <matt.redfearn@imgtec.com>,
        Wim Van Sebroeck <wim@iguana.be>
References: <1473672913-10484-1-git-send-email-matt.redfearn@imgtec.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d836fe83-8daa-9e17-4eca-41331c480a24@roeck-us.net>
Date: Mon, 12 Sep 2016 06:01:06 -0700
MIME-Version: 1.0
In-Reply-To: <1473672913-10484-1-git-send-email-matt.redfearn@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/12/2016 02:35 AM, Matt Redfearn wrote:
> Commit 0254e953537c ("watchdog: Drop pointer to watchdog device from
> struct watchdog_device") removed the dev pointer from struct
> watchdog_device, but this driver was still assigning it, leading to a
> compilation error:
>
> drivers/watchdog/rt2880_wdt.c: In function ‘rt288x_wdt_probe’:
> drivers/watchdog/rt2880_wdt.c:161:16: error: ‘struct watchdog_device’
> has no member named ‘dev’
>   rt288x_wdt_dev.dev = &pdev->dev;
>                 ^
> scripts/Makefile.build:289: recipe for target
> 'drivers/watchdog/rt2880_wdt.o' failed
>
> Fix this by removing the assignment.
>
> Fixes: 0254e953537c

Fixes: 0254e953537c ("watchdog: Drop pointer to watchdog device ...")

> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

Cc: stable@vger.kernel.org # v4.5+

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>
>  drivers/watchdog/rt2880_wdt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
> index 1967919ae743..14b4fd428fff 100644
> --- a/drivers/watchdog/rt2880_wdt.c
> +++ b/drivers/watchdog/rt2880_wdt.c
> @@ -158,7 +158,6 @@ static int rt288x_wdt_probe(struct platform_device *pdev)
>
>  	rt288x_wdt_freq = clk_get_rate(rt288x_wdt_clk) / RALINK_WDT_PRESCALE;
>
> -	rt288x_wdt_dev.dev = &pdev->dev;
>  	rt288x_wdt_dev.bootstatus = rt288x_wdt_bootcause();
>  	rt288x_wdt_dev.max_timeout = (0xfffful / rt288x_wdt_freq);
>  	rt288x_wdt_dev.parent = &pdev->dev;
>

