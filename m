Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36319 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbeINSvk (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Sep 2018 14:51:40 -0400
Subject: Re: [PATCH 1/2] watchdog: sama5d4: fix timeout-sec usage
To: Romain Izard <romain.izard.pro@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180914101339.7382-1-romain.izard.pro@gmail.com>
 <20180914101339.7382-2-romain.izard.pro@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <0953b2f9-83b1-b57b-2a26-fa0527c8a548@roeck-us.net>
Date: Fri, 14 Sep 2018 06:37:04 -0700
MIME-Version: 1.0
In-Reply-To: <20180914101339.7382-2-romain.izard.pro@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/14/2018 03:13 AM, Romain Izard wrote:
> When using watchdog_init_timeout to update the default timeout value,
> an error means that there is no "timeout-sec" in the relevant device
> tree node.
> 
> This should not prevent binding of the driver to the device.
> 
> Fixes: 976932e40036 ("watchdog: sama5d4: make use of timeout-secs provided in devicetree")
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/sama5d4_wdt.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
> index 255169916dbb..1e93c1b0e3cf 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -247,11 +247,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	ret = watchdog_init_timeout(wdd, wdt_timeout, &pdev->dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "unable to set timeout value\n");
> -		return ret;
> -	}
> +	watchdog_init_timeout(wdd, wdt_timeout, &pdev->dev);
>   
>   	timeout = WDT_SEC2TICKS(wdd->timeout);
>   
> 
