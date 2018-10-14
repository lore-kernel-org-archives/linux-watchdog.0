Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37506 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeJNLr7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 Oct 2018 07:47:59 -0400
Subject: Re: [PATCH] watchdog: ts4800: release syscon device node in
 ts4800_wdt_probe()
To: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Damien Riegel <damien.riegel@savoirfairelinux.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
References: <1539463863-21867-1-git-send-email-khoroshilov@ispras.ru>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5817b7ed-1480-6499-9074-58c47f29221f@roeck-us.net>
Date: Sat, 13 Oct 2018 21:08:22 -0700
MIME-Version: 1.0
In-Reply-To: <1539463863-21867-1-git-send-email-khoroshilov@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/13/2018 01:51 PM, Alexey Khoroshilov wrote:
> Put syscon device node when it is not needed anymore.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/ts4800_wdt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/ts4800_wdt.c b/drivers/watchdog/ts4800_wdt.c
> index 2b8de8602b67..89843b16b04a 100644
> --- a/drivers/watchdog/ts4800_wdt.c
> +++ b/drivers/watchdog/ts4800_wdt.c
> @@ -135,6 +135,7 @@ static int ts4800_wdt_probe(struct platform_device *pdev)
>   	/* set regmap and offset to know where to write */
>   	wdt->feed_offset = reg;
>   	wdt->regmap = syscon_node_to_regmap(syscon_np);
> +	of_node_put(syscon_np);
>   	if (IS_ERR(wdt->regmap)) {
>   		dev_err(&pdev->dev, "cannot get parent's regmap\n");
>   		return PTR_ERR(wdt->regmap);
> 
