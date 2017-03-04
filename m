Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46869 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbdCDQDb (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 4 Mar 2017 11:03:31 -0500
Subject: Re: [PATCH 1/4] watchdog: sama5d4: fix WDDIS handling
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <20170302173114.28508-1-alexandre.belloni@free-electrons.com>
 <20170302173114.28508-2-alexandre.belloni@free-electrons.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Wenyou.Yang@microchip.com, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <75caf7fe-8922-cd7e-897f-59cb763c1583@roeck-us.net>
Date: Sat, 4 Mar 2017 07:04:58 -0800
MIME-Version: 1.0
In-Reply-To: <20170302173114.28508-2-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/02/2017 09:31 AM, Alexandre Belloni wrote:
> The datasheet states: "When setting the WDDIS bit, and while it is set, the
> fields WDV and WDD must not be modified."
>
> Because the whole configuration is already cached inside .mr, wait for the
> user to enable the watchdog to configure it so it is enabled and configured
> at the same time (what the IP is actually expecting).
>
> When the watchdog is already enabled, it is not an issue to reconfigure it.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sama5d4_wdt.c | 48 ++++++++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
> index f709962018ac..5cee20caca78 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -44,6 +44,8 @@ MODULE_PARM_DESC(nowayout,
>  	"Watchdog cannot be stopped once started (default="
>  	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>
> +#define wdt_enabled (!(wdt->mr & AT91_WDT_WDDIS))
> +
>  #define wdt_read(wdt, field) \
>  	readl_relaxed((wdt)->reg_base + (field))
>
> @@ -89,7 +91,16 @@ static int sama5d4_wdt_set_timeout(struct watchdog_device *wdd,
>  	wdt->mr &= ~AT91_WDT_WDD;
>  	wdt->mr |= AT91_WDT_SET_WDV(value);
>  	wdt->mr |= AT91_WDT_SET_WDD(value);
> -	wdt_write(wdt, AT91_WDT_MR, wdt->mr);
> +
> +	/*
> +	 * WDDIS has to be 0 when updating WDD/WDV. The datasheet states: When
> +	 * setting the WDDIS bit, and while it is set, the fields WDV and WDD
> +	 * must not be modified.
> +	 * If the watchdog is enabled, then the timeout can be updated. Else,
> +	 * wait that the user enables it.
> +	 */
> +	if (wdt_enabled)
> +		wdt_write(wdt, AT91_WDT_MR, wdt->mr & ~AT91_WDT_WDDIS);
>
>  	wdd->timeout = timeout;
>
> @@ -145,23 +156,20 @@ static int of_sama5d4_wdt_init(struct device_node *np, struct sama5d4_wdt *wdt)
>
>  static int sama5d4_wdt_init(struct sama5d4_wdt *wdt)
>  {
> -	struct watchdog_device *wdd = &wdt->wdd;
> -	u32 value = WDT_SEC2TICKS(wdd->timeout);
>  	u32 reg;
> -
>  	/*
> -	 * Because the fields WDV and WDD must not be modified when the WDDIS
> -	 * bit is set, so clear the WDDIS bit before writing the WDT_MR.
> +	 * When booting and resuming, the bootloader may have changed the
> +	 * watchdog configuration.
> +	 * If the watchdog is already running, we can safely update it.
> +	 * Else, we have to disable it properly.
>  	 */
> -	reg = wdt_read(wdt, AT91_WDT_MR);
> -	reg &= ~AT91_WDT_WDDIS;
> -	wdt_write(wdt, AT91_WDT_MR, reg);
> -
> -	wdt->mr |= AT91_WDT_SET_WDD(value);
> -	wdt->mr |= AT91_WDT_SET_WDV(value);
> -
> -	wdt_write(wdt, AT91_WDT_MR, wdt->mr);
> -
> +	if (wdt_enabled) {
> +		wdt_write(wdt, AT91_WDT_MR, wdt->mr);
> +	} else {
> +		reg = wdt_read(wdt, AT91_WDT_MR);
> +		if (!(reg & AT91_WDT_WDDIS))
> +			wdt_write(wdt, AT91_WDT_MR, reg | AT91_WDT_WDDIS);
> +	}
>  	return 0;
>  }
>
> @@ -172,6 +180,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	void __iomem *regs;
>  	u32 irq = 0;
> +	u32 timeout;
>  	int ret;
>
>  	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> @@ -221,6 +230,11 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>
> +	timeout = WDT_SEC2TICKS(wdd->timeout);
> +
> +	wdt->mr |= AT91_WDT_SET_WDD(timeout);
> +	wdt->mr |= AT91_WDT_SET_WDV(timeout);
> +
>  	ret = sama5d4_wdt_init(wdt);
>  	if (ret)
>  		return ret;
> @@ -263,9 +277,7 @@ static int sama5d4_wdt_resume(struct device *dev)
>  {
>  	struct sama5d4_wdt *wdt = dev_get_drvdata(dev);
>
> -	wdt_write(wdt, AT91_WDT_MR, wdt->mr & ~AT91_WDT_WDDIS);
> -	if (wdt->mr & AT91_WDT_WDDIS)
> -		wdt_write(wdt, AT91_WDT_MR, wdt->mr);
> +	sama5d4_wdt_init(wdt);
>
>  	return 0;
>  }
>

