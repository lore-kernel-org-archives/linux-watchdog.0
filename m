Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54506 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbbGXCaZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Jul 2015 22:30:25 -0400
Message-ID: <55B1A33D.8010502@roeck-us.net>
Date: Thu, 23 Jul 2015 19:30:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	linux-watchdog@vger.kernel.org
CC: Andrew Bresticker <abrestic@chromium.org>,
	Naidu.Tellapati@imgtec.com
Subject: Re: [PATCH] watchdog: imgpdc: Unregister restart handler on remove
References: <1437682876-1561-1-git-send-email-ezequiel@vanguardiasur.com.ar>
In-Reply-To: <1437682876-1561-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/23/2015 01:21 PM, Ezequiel Garcia wrote:
> Commit c631f20068 ("watchdog: imgpdc: Add reboot support") introduced
> a restart handler but forgot to unregister it on driver removal. Fix it.
>
> Fixes: c631f20068 ("watchdog: imgpdc: Add reboot support")
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Good catch. Looks good. Note that you should use a 12-character SHA (c631f2006836).

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Build test only.
>
>   drivers/watchdog/imgpdc_wdt.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
> index 0f73621..15ab072 100644
> --- a/drivers/watchdog/imgpdc_wdt.c
> +++ b/drivers/watchdog/imgpdc_wdt.c
> @@ -316,6 +316,7 @@ static int pdc_wdt_remove(struct platform_device *pdev)
>   {
>   	struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
>
> +	unregister_restart_handler(&pdc_wdt->restart_handler);
>   	pdc_wdt_stop(&pdc_wdt->wdt_dev);
>   	watchdog_unregister_device(&pdc_wdt->wdt_dev);
>   	clk_disable_unprepare(pdc_wdt->wdt_clk);
>

