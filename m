Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45337 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756249AbbKRQYF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Nov 2015 11:24:05 -0500
Subject: Re: [PATCH] watchdog: mtk_wdt: Use MODE_KEY when stopping the
 watchdog
To: Nicolas Boichat <drinkcat@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>
References: <1447814701-23504-1-git-send-email-drinkcat@chromium.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <564CA620.7080700@roeck-us.net>
Date: Wed, 18 Nov 2015 08:24:00 -0800
MIME-Version: 1.0
In-Reply-To: <1447814701-23504-1-git-send-email-drinkcat@chromium.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/17/2015 06:45 PM, Nicolas Boichat wrote:
> WDT_MODE value need to be or-ed with MODE_KEY when setting
> watchdog mode. Add it to mtk_wdt_stop function, so that the
> watchdog can be stopped (e.g. during suspend).
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/mtk_wdt.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 6ad9df9..b751f43 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -123,6 +123,7 @@ static int mtk_wdt_stop(struct watchdog_device *wdt_dev)
>
>   	reg = readl(wdt_base + WDT_MODE);
>   	reg &= ~WDT_MODE_EN;
> +	reg |= WDT_MODE_KEY;
>   	iowrite32(reg, wdt_base + WDT_MODE);
>
>   	return 0;
>

