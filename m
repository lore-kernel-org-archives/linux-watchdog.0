Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35899 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbdC1RZO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Mar 2017 13:25:14 -0400
Received: by mail-it0-f67.google.com with SMTP id 190so4773250itm.3
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Mar 2017 10:25:13 -0700 (PDT)
Message-ID: <1490721901.24147.2.camel@gmail.com>
Subject: Re: [PATCH v2] watchdog: gpio: Add "keep-armed-on-close" feature
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: linux@roeck-us.net
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Date: Tue, 28 Mar 2017 13:25:01 -0400
In-Reply-To: <20170314141111.24888-1-slemieux.tyco@gmail.com>
References: <20170314141111.24888-1-slemieux.tyco@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

ping

On Tue, 2017-03-14 at 10:11 -0400, Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
> 
> There is a need to allow a grace period after the watchdog software
> client has closed. It could be used for syncing the filesystem or
> allow graceful termination while still providing a hardware reset
> in case the system has hung.
> 
> The "always-running" configuration from device-tree does not provide
> this since it will automatically keep the hardware watchdog alive as
> soon as the software client closes (i.e. keep toggling the GPIO line
> regardless of the state of the soft part of the watchdog).
> 
> The "keep-armed-on-close" member in the GPIO watchdog implementation
> indicates if an expired timeout should cause a reset.
> 
> This patch add a new "keep-armed-on-close" device-tree configuration
> that will keep the watchdog "armed" until the next timeout period after
> a close. During this period, the hardware watchdog is kept alive.
> A software watchdog client that wants to provide a grace period before
> a hard reset can set the timeout before properly closing.
> 
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> ---
> * This patch depend on the:
>   "watchdog: gpio: Convert to use infrastructure triggered keepalives";
>   ref. https://lkml.org/lkml/2016/2/28/239 (version 8)
> 
> Changes from v1 to v2:
> * Rebased on-top of the "watchdog: gpio: keepalives" patch.
>   - Updated the management of the "WDOG_HW_RUNNING" flag.
> * Tested with v4.11-rc1.
> 
>  Documentation/devicetree/bindings/watchdog/gpio-wdt.txt |  3 +++
>  drivers/watchdog/gpio_wdt.c                             | 10 ++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
> index 83d28146e39b..48db076771b2 100644
> --- a/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
> @@ -17,6 +17,9 @@ Optional Properties:
>  - always-running: If the watchdog timer cannot be disabled, add this flag to
>    have the driver keep toggling the signal without a client. It will only cease
>    to toggle the signal when the device is open and the timeout elapsed.
> +- keep-armed-on-close: if the watchdog timer need to keep toggling the signal
> +  when close, until the timeout elapsed, add this flag to have the driver
> +  keep toggling the signal, until the timeout elapsed.
>  - timeout-sec: Contains the watchdog timeout in seconds.
>  - start-at-init: Start kicking watchdog as soon as driver is loaded.
>  
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index 7b46d224cb56..2f4799bee9bd 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -29,6 +29,7 @@ struct gpio_wdt_priv {
>  	bool			active_low;
>  	bool			state;
>  	bool			always_running;
> +	bool			keep_armed_on_close;
>  	unsigned int		hw_algo;
>  	struct watchdog_device	wdd;
>  };
> @@ -78,6 +79,13 @@ static int gpio_wdt_stop(struct watchdog_device *wdd)
>  {
>  	struct gpio_wdt_priv *priv = watchdog_get_drvdata(wdd);
>  
> +	if(priv->keep_armed_on_close) {
> +		/* Keep the driver running on close. */
> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
> +
> +		return 0;
> +	}
> +
>  	if (!priv->always_running) {
>  		gpio_wdt_disable(priv);
>  		clear_bit(WDOG_HW_RUNNING, &wdd->status);
> @@ -148,6 +156,8 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>  
>  	priv->always_running = of_property_read_bool(pdev->dev.of_node,
>  						     "always-running");
> +	priv->keep_armed_on_close = of_property_read_bool(pdev->dev.of_node,
> +						 "keep-armed-on-close");
>  
>  	watchdog_set_drvdata(&priv->wdd, priv);
>  


