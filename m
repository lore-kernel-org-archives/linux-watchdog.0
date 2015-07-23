Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53631 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbbGWQMr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Jul 2015 12:12:47 -0400
Message-ID: <55B1127C.4080800@roeck-us.net>
Date: Thu, 23 Jul 2015 09:12:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Eddie Huang <eddie.huang@mediatek.com>,
	Wim Van Sebroeck <wim@iguana.be>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sascha Hauer <kernel@pengutronix.de>,
	Greta Zhang <greta.zhang@mediatek.com>
Subject: Re: [PATCH v2 2/2] watchdog: add wdt shutdown callback to disable
 wdt if enabled
References: <1437630551-39650-1-git-send-email-eddie.huang@mediatek.com> <1437630551-39650-3-git-send-email-eddie.huang@mediatek.com>
In-Reply-To: <1437630551-39650-3-git-send-email-eddie.huang@mediatek.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/22/2015 10:49 PM, Eddie Huang wrote:
> From: Greta Zhang <greta.zhang@mediatek.com>
>
> Without .shutdown(), watchdog might reset the system during power off.
> For example, if watchdog's timeout is set to 30s, then it is reset to
> zero by mtk_wdt_ping(). During power off, no app will ping watchdog,
> but watchdog is still running and may trigger reset.
>
> Signed-off-by: Greta Zhang <greta.zhang@mediatek.com>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>

Except for the subject line,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/mtk_wdt.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 056412c..6ad9df9 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -210,6 +210,14 @@ static int mtk_wdt_probe(struct platform_device *pdev)
>   	return 0;
>   }
>
> +static void mtk_wdt_shutdown(struct platform_device *pdev)
> +{
> +	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
> +
> +	if (watchdog_active(&mtk_wdt->wdt_dev))
> +		mtk_wdt_stop(&mtk_wdt->wdt_dev);
> +}
> +
>   static int mtk_wdt_remove(struct platform_device *pdev)
>   {
>   	struct mtk_wdt_dev *mtk_wdt = platform_get_drvdata(pdev);
> @@ -259,6 +267,7 @@ static const struct dev_pm_ops mtk_wdt_pm_ops = {
>   static struct platform_driver mtk_wdt_driver = {
>   	.probe		= mtk_wdt_probe,
>   	.remove		= mtk_wdt_remove,
> +	.shutdown	= mtk_wdt_shutdown,
>   	.driver		= {
>   		.name		= DRV_NAME,
>   		.pm		= &mtk_wdt_pm_ops,
>

