Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44451 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbeH1Rtl (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Aug 2018 13:49:41 -0400
Subject: Re: [PATCH 2/2] watchdog: renesas_wdt: stop when unregistering
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
References: <20180828101348.12443-1-wsa+renesas@sang-engineering.com>
 <20180828101348.12443-3-wsa+renesas@sang-engineering.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ecfc84c3-edaf-c683-7b8c-114304b6da8d@roeck-us.net>
Date: Tue, 28 Aug 2018 06:57:52 -0700
MIME-Version: 1.0
In-Reply-To: <20180828101348.12443-3-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/28/2018 03:13 AM, Wolfram Sang wrote:
> We want to go into a sane state when unregistering. Currently, it
> happens that the watchdog stops when unbinding because of RuntimePM
> stopping the core clock. When rebinding, the core clock gets reactivated
> and the watchdog fires even though it hasn't been opened by userspace
> yet. Strange scenario, yes, but sane state is much preferred anyhow.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/renesas_wdt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
> index 88d81feba4e6..f45cb183fa75 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -234,6 +234,7 @@ static int rwdt_probe(struct platform_device *pdev)
>   	watchdog_set_drvdata(&priv->wdev, priv);
>   	watchdog_set_nowayout(&priv->wdev, nowayout);
>   	watchdog_set_restart_priority(&priv->wdev, 0);
> +	watchdog_stop_on_unregister(&priv->wdev);
>   
>   	/* This overrides the default timeout only if DT configuration was found */
>   	ret = watchdog_init_timeout(&priv->wdev, 0, &pdev->dev);
> 
