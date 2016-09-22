Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54385 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933337AbcIVNUX (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 22 Sep 2016 09:20:23 -0400
Subject: Re: [PATCH 3/3] watchdog: dw_wdt: add stop watchdog operation
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-watchdog@vger.kernel.org
References: <1474527753-22194-1-git-send-email-s.trumtrar@pengutronix.de>
 <1474527753-22194-4-git-send-email-s.trumtrar@pengutronix.de>
Cc: kernel@pengutronix.de, Wim Van Sebroeck <wim@iguana.be>,
        linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a31adf6b-7398-e279-f51c-ad461b5ef1c6@roeck-us.net>
Date: Thu, 22 Sep 2016 06:20:11 -0700
MIME-Version: 1.0
In-Reply-To: <1474527753-22194-4-git-send-email-s.trumtrar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/22/2016 12:02 AM, Steffen Trumtrar wrote:
> The only way of stopping the watchdog is by resetting it.
> Add the watchdog op for stopping the device and reset if
> a reset line is provided.
>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> ---
>  drivers/watchdog/dw_wdt.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index e024722e8b3b..5b067984d5e8 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -137,6 +137,21 @@ static int dw_wdt_start(struct watchdog_device *wdd)
>  	return 0;
>  }
>
> +static int dw_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
> +
> +	if (IS_ERR(dw_wdt->rst)) {
> +		dev_warn(wdd->parent, "No reset line. Will not stop.\n");

As mentioned in the other patch, this warning is not warranted.

Also, you'll need to inform the watchdog core that the watchdog is still
running, otherwise the system _will_ reset. That would be a definite
and unwanted change in behavior.

> +		return PTR_ERR(dw_wdt->rst);

This is not an error. The code handled that situation before without
reporting an error, it can handle it now.

> +	}
> +
> +	reset_control_assert(dw_wdt->rst);
> +	reset_control_deassert(dw_wdt->rst);
> +
> +	return 0;
> +}
> +
>  static int dw_wdt_restart_handle(struct notifier_block *this,
>  				 unsigned long mode, void *cmd)
>  {
> @@ -177,6 +192,7 @@ static const struct watchdog_info dw_wdt_ident = {
>  static const struct watchdog_ops dw_wdt_ops = {
>  	.owner		= THIS_MODULE,
>  	.start		= dw_wdt_start,
> +	.stop		= dw_wdt_stop,
>  	.ping		= dw_wdt_ping,
>  	.set_timeout	= dw_wdt_set_timeout,
>  	.get_timeleft	= dw_wdt_get_timeleft,
>

