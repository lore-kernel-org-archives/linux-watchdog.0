Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53233 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbbGWQLD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Jul 2015 12:11:03 -0400
Message-ID: <55B1120F.7010204@roeck-us.net>
Date: Thu, 23 Jul 2015 09:10:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Eddie Huang <eddie.huang@mediatek.com>,
	Wim Van Sebroeck <wim@iguana.be>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sascha Hauer <kernel@pengutronix.de>,
	Greta Zhang <greta.zhang@mediatek.com>,
	Roger Lu <roger.lu@mediatek.com>
Subject: Re: [PATCH v2 1/2] watchdog: add wdt suspend/resume support
References: <1437630551-39650-1-git-send-email-eddie.huang@mediatek.com> <1437630551-39650-2-git-send-email-eddie.huang@mediatek.com>
In-Reply-To: <1437630551-39650-2-git-send-email-eddie.huang@mediatek.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/22/2015 10:49 PM, Eddie Huang wrote:
> From: Greta Zhang <greta.zhang@mediatek.com>
>
> add wdt driver suspend/resume support
>
> Signed-off-by: Greta Zhang <greta.zhang@mediatek.com>
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>


Subject line should identify the driver, ie mtk_wdt.
"wdt" doesn't really help.

Other than that,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>   drivers/watchdog/mtk_wdt.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 938b987..056412c 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -221,17 +221,47 @@ static int mtk_wdt_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int mtk_wdt_suspend(struct device *dev)
> +{
> +	struct mtk_wdt_dev *mtk_wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&mtk_wdt->wdt_dev))
> +		mtk_wdt_stop(&mtk_wdt->wdt_dev);
> +
> +	return 0;
> +}
> +
> +static int mtk_wdt_resume(struct device *dev)
> +{
> +	struct mtk_wdt_dev *mtk_wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&mtk_wdt->wdt_dev)) {
> +		mtk_wdt_start(&mtk_wdt->wdt_dev);
> +		mtk_wdt_ping(&mtk_wdt->wdt_dev);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
>   static const struct of_device_id mtk_wdt_dt_ids[] = {
>   	{ .compatible = "mediatek,mt6589-wdt" },
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, mtk_wdt_dt_ids);
>
> +static const struct dev_pm_ops mtk_wdt_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(mtk_wdt_suspend,
> +				mtk_wdt_resume)
> +};
> +
>   static struct platform_driver mtk_wdt_driver = {
>   	.probe		= mtk_wdt_probe,
>   	.remove		= mtk_wdt_remove,
>   	.driver		= {
>   		.name		= DRV_NAME,
> +		.pm		= &mtk_wdt_pm_ops,
>   		.of_match_table	= mtk_wdt_dt_ids,
>   	},
>   };
>

