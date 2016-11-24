Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59260 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966808AbcKXPiN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 24 Nov 2016 10:38:13 -0500
Subject: Re: [PATCH] watchdog: davinci: add support for deferred probing
To: Tero Kristo <t-kristo@ti.com>, wim@iguana.be
References: <1479992308-27473-1-git-send-email-t-kristo@ti.com>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <34015fbb-a609-e02d-1ed0-1c605c476294@roeck-us.net>
Date: Thu, 24 Nov 2016 07:38:09 -0800
MIME-Version: 1.0
In-Reply-To: <1479992308-27473-1-git-send-email-t-kristo@ti.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/24/2016 04:58 AM, Tero Kristo wrote:
> devm_clk_get can fail with EPROBE_DEFER in case the clock provider is
> not ready yet. Handle this case gracefully, rather than dumping out
> a huge warning.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/davinci_wdt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
> index 17454ca..0e731d7 100644
> --- a/drivers/watchdog/davinci_wdt.c
> +++ b/drivers/watchdog/davinci_wdt.c
> @@ -166,8 +166,12 @@ static int davinci_wdt_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>
>  	davinci_wdt->clk = devm_clk_get(dev, NULL);
> -	if (WARN_ON(IS_ERR(davinci_wdt->clk)))
> +
> +	if (IS_ERR(davinci_wdt->clk)) {
> +		if (PTR_ERR(davinci_wdt->clk) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "failed to get clock node\n");
>  		return PTR_ERR(davinci_wdt->clk);
> +	}
>
>  	clk_prepare_enable(davinci_wdt->clk);
>
>

