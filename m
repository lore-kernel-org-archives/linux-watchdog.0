Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:55332 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdJVRmj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Oct 2017 13:42:39 -0400
Received: by mail-pg0-f68.google.com with SMTP id 15so5399809pgc.12
        for <linux-watchdog@vger.kernel.org>; Sun, 22 Oct 2017 10:42:38 -0700 (PDT)
Date: Sun, 22 Oct 2017 10:42:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, lee.jones@linaro.org,
        support.opensource@diasemi.com, wim@iguana.be,
        kernel@pengutronix.de
Subject: Re: [6/6] watchdog: da9062: add protective delay before stop
Message-ID: <20171022174237.GA20542@roeck-us.net>
References: <20171017153027.24665-7-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017153027.24665-7-m.grzeschik@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 17, 2017 at 05:30:27PM +0200, Michael Grzeschik wrote:
> In case some application was writing to the watchdog before closing we
> have to ensure that we add enough delay before writing again to the
> DA9062AA_CONTROL_F register. The delay otherwise can only be ensured by
> min_hw_heartbeat_ms for pings.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  drivers/watchdog/da9062_wdt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> index 8297bcf0b9f75..1fe88826c6981 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -129,6 +129,8 @@ static int da9062_wdt_stop(struct watchdog_device *wdd)
>  	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
>  	int ret;
>  
> +	mdelay(DA9062_RESET_PROTECTION_MS);
> +

Please use msleep() here. A 300ms hot loop is a bit excessive.

Thanks,
Guenter

>  	ret = da9062_reset_watchdog_timer(wdt);
>  	if (ret) {
>  		dev_err(wdt->hw->dev, "Failed to ping the watchdog (err = %d)\n",
