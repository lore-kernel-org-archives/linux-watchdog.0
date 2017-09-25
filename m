Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36523 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933946AbdIYQQq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 25 Sep 2017 12:16:46 -0400
Date: Mon, 25 Sep 2017 09:16:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-watchdog@vger.kernel.org, kernel@pengutronix.de,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] watchdog: dw_wdt: add stop watchdog operation
Message-ID: <20170925161643.GA32601@roeck-us.net>
References: <20170925052531.1692-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925052531.1692-1-o.rempel@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Sep 25, 2017 at 07:25:30AM +0200, Oleksij Rempel wrote:
> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> The only way of stopping the watchdog is by resetting it.
> Add the watchdog op for stopping the device and reset if
> a reset line is provided.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> ---
> 
> changes v3:
>  - don't return error if rst is not present and set WDOG_HW_RUNNING bit
>    to notify watchdog core.
> 
> changes v2:
>  - test if dw_wdt->rst is NULL instead of IS_ERR
> 
>  drivers/watchdog/dw_wdt.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 36be987ff9ef..6cc56b18ee52 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -135,6 +135,21 @@ static int dw_wdt_start(struct watchdog_device *wdd)
>  	return 0;
>  }
>  
> +static int dw_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
> +
> +	if (!dw_wdt->rst) {
> +		set_bit(WDOG_HW_RUNNING, &wdd->status);

Setting WDOG_HW_RUNNING should be dropped from dw_wdt_start().

Guenter

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
> @@ -173,6 +188,7 @@ static const struct watchdog_info dw_wdt_ident = {
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
