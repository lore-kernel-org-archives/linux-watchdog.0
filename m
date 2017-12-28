Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34044 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753976AbdL1Skz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 28 Dec 2017 13:40:55 -0500
Subject: Re: [PATCH 3/7] watchdog: JZ4740: Register a restart handler
To: Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20171228162939.3928-1-paul@crapouillou.net>
 <20171228162939.3928-4-paul@crapouillou.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e1871276-fc00-eefd-1a43-e528f6da1269@roeck-us.net>
Date: Thu, 28 Dec 2017 10:40:53 -0800
MIME-Version: 1.0
In-Reply-To: <20171228162939.3928-4-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/28/2017 08:29 AM, Paul Cercueil wrote:
> The watchdog driver can restart the system by simply configuring the
> hardware for a timeout of 0 seconds.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/jz4740_wdt.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index 92d6ca8ceb49..fa7f49a3212c 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -130,6 +130,14 @@ static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
>   	return 0;
>   }
>   
> +static int jz4740_wdt_restart(struct watchdog_device *wdt_dev,
> +			      unsigned long action, void *data)
> +{
> +	wdt_dev->timeout = 0;
> +	jz4740_wdt_start(wdt_dev);
> +	return 0;
> +}
> +
>   static const struct watchdog_info jz4740_wdt_info = {
>   	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
>   	.identity = "jz4740 Watchdog",
> @@ -141,6 +149,7 @@ static const struct watchdog_ops jz4740_wdt_ops = {
>   	.stop = jz4740_wdt_stop,
>   	.ping = jz4740_wdt_ping,
>   	.set_timeout = jz4740_wdt_set_timeout,
> +	.restart = jz4740_wdt_restart,
>   };
>   
>   #ifdef CONFIG_OF
> 

