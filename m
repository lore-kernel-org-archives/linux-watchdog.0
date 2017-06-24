Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40547 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754667AbdFXWRu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 24 Jun 2017 18:17:50 -0400
Date: Sat, 24 Jun 2017 15:17:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Cc: wim@iguana.be, joel@jms.id.au, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, andrew@aj.id.au
Subject: Re: [2/2] drivers/watchdog: ASPEED reference dev tree properties for
 config
Message-ID: <20170624221747.GA10038@roeck-us.net>
References: <20170613203818.17399-3-cbostic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613203818.17399-3-cbostic@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jun 13, 2017 at 03:38:18PM -0500, Christopher Bostic wrote:
> Reference the system device tree when configuring the watchdog.
> Configure for external signal generation if optional attribute
> 'external-signal' is present in device tree.  Configure for
> reset system after timeout if the optional attribute
> 'no-system-reset' is not present.  Disabling system reset may be
> required in situations where one of the other watchdogs in the
> systems is responsible for this.
> 
> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> ---
>  drivers/watchdog/aspeed_wdt.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 1c65258..9deb4be 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -140,6 +140,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  {
>  	struct aspeed_wdt *wdt;
>  	struct resource *res;
> +	struct device_node *np;
>  	int ret;
>  
>  	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> @@ -170,8 +171,16 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  	 * the SOC and not the full chip
>  	 */
>  	wdt->ctrl = WDT_CTRL_RESET_MODE_SOC |
> -		WDT_CTRL_1MHZ_CLK |
> -		WDT_CTRL_RESET_SYSTEM;
> +		WDT_CTRL_1MHZ_CLK;
> +
> +	np = pdev->dev.of_node;
> +	if (np && !of_get_property(np, "no-system-reset", NULL))
> +		wdt->ctrl |= WDT_CTRL_RESET_SYSTEM;
> +
Please use of_property_read_bool(). Also, checking np for NULL is unnecessary
since the called function does that. Note that the above code as written is
wrong - if np is NULL, WDT_CTRL_RESET_SYSTEM will no longer be set.

The new properties should probably start with "aspeed," but I'll leave that
up to DT maintainers to decide.

> +	if (np && of_get_property(np, "external-signal", NULL))
> +		wdt->ctrl |= WDT_CTRL_WDT_EXT;
> +
> +	writel(wdt->ctrl, wdt->base + WDT_CTRL);
>  
>  	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
>  		aspeed_wdt_start(&wdt->wdd);
