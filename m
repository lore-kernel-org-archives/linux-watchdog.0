Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33312 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757239AbcCCLox (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Mar 2016 06:44:53 -0500
Subject: Re: [PATCH v2] watchdog: tangox_wdt: test clock rate to avoid
 division by 0
To: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
References: <1456993453-7958-1-git-send-email-wsa@the-dreams.de>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56D823B2.6040004@roeck-us.net>
Date: Thu, 3 Mar 2016 03:44:50 -0800
MIME-Version: 1.0
In-Reply-To: <1456993453-7958-1-git-send-email-wsa@the-dreams.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/03/2016 12:24 AM, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> The clk API may return 0 on clk_get_rate, so we should check the result before
> using it as a divisor. For this, refactor the code to use a central
> error path.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/tangox_wdt.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
> index 709c1ed6fd79b9..cfbed7e051b619 100644
> --- a/drivers/watchdog/tangox_wdt.c
> +++ b/drivers/watchdog/tangox_wdt.c
> @@ -139,6 +139,10 @@ static int tangox_wdt_probe(struct platform_device *pdev)
>   		return err;
>
>   	dev->clk_rate = clk_get_rate(dev->clk);
> +	if (!dev->clk_rate) {
> +		err = -EINVAL;
> +		goto err;
> +	}
>
>   	dev->wdt.parent = &pdev->dev;
>   	dev->wdt.info = &tangox_wdt_info;
> @@ -171,10 +175,8 @@ static int tangox_wdt_probe(struct platform_device *pdev)
>   	}
>
>   	err = watchdog_register_device(&dev->wdt);
> -	if (err) {
> -		clk_disable_unprepare(dev->clk);
> -		return err;
> -	}
> +	if (err)
> +		goto err;
>
>   	platform_set_drvdata(pdev, dev);
>
> @@ -187,6 +189,10 @@ static int tangox_wdt_probe(struct platform_device *pdev)
>   	dev_info(&pdev->dev, "SMP86xx/SMP87xx watchdog registered\n");
>
>   	return 0;
> +
> + err:
> +	clk_disable_unprepare(dev->clk);
> +	return err;
>   }
>
>   static int tangox_wdt_remove(struct platform_device *pdev)
>

