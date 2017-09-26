Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33444 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbdIZPNM (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 26 Sep 2017 11:13:12 -0400
Date: Tue, 26 Sep 2017 08:13:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-watchdog@vger.kernel.org, kernel@pengutronix.de,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] watchdog: dw_wdt: add stop watchdog operation
Message-ID: <20170926151309.GA14894@roeck-us.net>
References: <20170926061123.29614-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170926061123.29614-1-o.rempel@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Sep 26, 2017 at 08:11:22AM +0200, Oleksij Rempel wrote:
> The only way of stopping the watchdog is by resetting it.
> Add the watchdog op for stopping the device and reset if
> a reset line is provided.
> 
> At same time WDOG_HW_RUNNING should be remove from dw_wdt_start.
> As commented by Guenter Roeck:
> dw_wdt sets WDOG_HW_RUNNING in its open function. Result is
> that the kref_get() in watchdog_open() won't be executed. But then
> kref_put() in close will be called since the watchdog now does stop.
> This causes the imbalance.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> changes v4:
>  - remove WDOG_HW_RUNNING from dw_wdt_start.
> 
> changes v3:
>  - don't return error if rst is not present and set WDOG_HW_RUNNING bit
>    to notify watchdog core.
> 
> changes v2:
>  - test if dw_wdt->rst is NULL instead of IS_ERR
> 
>  drivers/watchdog/dw_wdt.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 36be987ff9ef..c2f4ff516230 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -127,14 +127,27 @@ static int dw_wdt_start(struct watchdog_device *wdd)
>  
>  	dw_wdt_set_timeout(wdd, wdd->timeout);
>  
> -	set_bit(WDOG_HW_RUNNING, &wdd->status);
> -
>  	writel(WDOG_CONTROL_REG_WDT_EN_MASK,
>  	       dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
>  
>  	return 0;
>  }
>  
> +static int dw_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
> +
> +	if (!dw_wdt->rst) {
> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
> +		return 0;
> +	}
> +
> +	reset_control_assert(dw_wdt->rst);
> +	reset_control_deassert(dw_wdt->rst);
> +
> +	return 0;
> +}
> +
>  static int dw_wdt_restart(struct watchdog_device *wdd,
>  			  unsigned long action, void *data)
>  {
> @@ -173,6 +186,7 @@ static const struct watchdog_info dw_wdt_ident = {
>  static const struct watchdog_ops dw_wdt_ops = {
>  	.owner		= THIS_MODULE,
>  	.start		= dw_wdt_start,
> +	.stop		= dw_wdt_stop,
>  	.ping		= dw_wdt_ping,
>  	.set_timeout	= dw_wdt_set_timeout,
>  	.get_timeleft	= dw_wdt_get_timeleft,
> -- 
> 2.11.0
> 
