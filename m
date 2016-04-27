Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42204 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbcD0Bl2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Apr 2016 21:41:28 -0400
Subject: Re: [PATCH] watchdog: remove error message when unable to allocate
 watchdog device
To: Colin King <colin.king@canonical.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1461691129-4764-1-git-send-email-colin.king@canonical.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <572018C5.9020403@roeck-us.net>
Date: Tue, 26 Apr 2016 18:41:25 -0700
MIME-Version: 1.0
In-Reply-To: <1461691129-4764-1-git-send-email-colin.king@canonical.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/26/2016 10:18 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The dev_err message is superfluous because the failure is already
> printed by dev_kzalloc, so remove it.
>
Nitpick: devm_kzalloc

> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> ---
>   drivers/watchdog/jz4740_wdt.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index 6a7d5c3..c8d51dd 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -160,10 +160,8 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>
>   	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct jz4740_wdt_drvdata),
>   			       GFP_KERNEL);
> -	if (!drvdata) {
> -		dev_err(&pdev->dev, "Unable to alloacate watchdog device\n");
> +	if (!drvdata)
>   		return -ENOMEM;
> -	}
>
>   	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
>   		heartbeat = DEFAULT_HEARTBEAT;
>

