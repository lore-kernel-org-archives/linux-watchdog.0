Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41659 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423604AbdD1C1R (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 27 Apr 2017 22:27:17 -0400
Subject: Re: [PATCH] watchdog: bcm281xx: Fix use of uninitialized spinlock.
To: Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
References: <20170428010232.19905-1-eric@anholt.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <936cc171-cc1e-b00e-dee1-061fcd42c93f@roeck-us.net>
Date: Thu, 27 Apr 2017 19:27:12 -0700
MIME-Version: 1.0
In-Reply-To: <20170428010232.19905-1-eric@anholt.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/27/2017 06:02 PM, Eric Anholt wrote:
> The bcm_kona_wdt_set_resolution_reg() call takes the spinlock, so
> initialize it earlier.  Fixes a warning at boot with lock debugging
> enabled.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/bcm_kona_wdt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
> index 6fce17d5b9f1..a5775dfd8d5f 100644
> --- a/drivers/watchdog/bcm_kona_wdt.c
> +++ b/drivers/watchdog/bcm_kona_wdt.c
> @@ -304,6 +304,8 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
>  	if (!wdt)
>  		return -ENOMEM;
>
> +	spin_lock_init(&wdt->lock);
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	wdt->base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(wdt->base))
> @@ -316,7 +318,6 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>
> -	spin_lock_init(&wdt->lock);
>  	platform_set_drvdata(pdev, wdt);
>  	watchdog_set_drvdata(&bcm_kona_wdt_wdd, wdt);
>  	bcm_kona_wdt_wdd.parent = &pdev->dev;
>

