Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35573 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbdAKImQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 11 Jan 2017 03:42:16 -0500
Received: by mail-wm0-f44.google.com with SMTP id r126so5986028wmr.0
        for <linux-watchdog@vger.kernel.org>; Wed, 11 Jan 2017 00:42:15 -0800 (PST)
Subject: Re: [PATCH 32/62] watchdog: meson_gxbb_wdt: Convert to use device
 managed functions and other improvements
To: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-2-git-send-email-linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org
From: Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <58d70a1d-74ce-b046-9647-61c3f7ba0d21@baylibre.com>
Date: Wed, 11 Jan 2017 09:42:12 +0100
MIME-Version: 1.0
In-Reply-To: <1484095516-12720-2-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/11/2017 01:44 AM, Guenter Roeck wrote:
> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
> Other improvements as listed below.
> 
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts used
> to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Use devm_add_action_or_reset() for calls to clk_disable_unprepare
> - Check return value from clk_prepare_enable()
> - Replace 'val = e; return val;' with 'return e;'
> - Replace 'if (e) return e; return 0;' with 'return e;'
> - Drop assignments to otherwise unused variables
> - Replace 'if (e) { return expr; }' with 'if (e) return expr;'
> - Drop remove function
> - Use devm_watchdog_register_driver() to register watchdog device
> - Replace shutdown function with call to watchdog_stop_on_reboot()
> 
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/meson_gxbb_wdt.c | 38 ++++++++++----------------------------
>  1 file changed, 10 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> index 45d47664a00a..913d8a644460 100644
> --- a/drivers/watchdog/meson_gxbb_wdt.c
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -203,7 +203,14 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->clk))
>  		return PTR_ERR(data->clk);
>  
> -	clk_prepare_enable(data->clk);
> +	ret = clk_prepare_enable(data->clk);
> +	if (ret)
> +		return ret;
> +	ret = devm_add_action_or_reset(&pdev->dev,
> +				       (void(*)(void *))clk_disable_unprepare,
> +				       data->clk);
> +	if (ret)
> +		return ret;
>  
>  	platform_set_drvdata(pdev, data);
>  
> @@ -224,37 +231,12 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>  
>  	meson_gxbb_wdt_set_timeout(&data->wdt_dev, data->wdt_dev.timeout);
>  
> -	ret = watchdog_register_device(&data->wdt_dev);
> -	if (ret) {
> -		clk_disable_unprepare(data->clk);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int meson_gxbb_wdt_remove(struct platform_device *pdev)
> -{
> -	struct meson_gxbb_wdt *data = platform_get_drvdata(pdev);
> -
> -	watchdog_unregister_device(&data->wdt_dev);
> -
> -	clk_disable_unprepare(data->clk);
> -
> -	return 0;
> -}
> -
> -static void meson_gxbb_wdt_shutdown(struct platform_device *pdev)
> -{
> -	struct meson_gxbb_wdt *data = platform_get_drvdata(pdev);
> -
> -	meson_gxbb_wdt_stop(&data->wdt_dev);
> +	watchdog_stop_on_reboot(&data->wdt_dev);
> +	return devm_watchdog_register_device(&pdev->dev, &data->wdt_dev);
>  }
>  
>  static struct platform_driver meson_gxbb_wdt_driver = {
>  	.probe	= meson_gxbb_wdt_probe,
> -	.remove	= meson_gxbb_wdt_remove,
> -	.shutdown = meson_gxbb_wdt_shutdown,
>  	.driver = {
>  		.name = "meson-gxbb-wdt",
>  		.pm = &meson_gxbb_wdt_pm_ops,
> 

Was on my todo list, glad you did this !

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
