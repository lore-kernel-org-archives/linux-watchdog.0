Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39035 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbbKBOeJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Nov 2015 09:34:09 -0500
Subject: Re: [PATCH] watchdog: pnx4008: make global wdt_clk static
To: Vladimir Zapolskiy <vz@mleia.com>, Wim Van Sebroeck <wim@iguana.be>
References: <1445993735-7817-1-git-send-email-vz@mleia.com>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5637745F.8080007@roeck-us.net>
Date: Mon, 2 Nov 2015 06:34:07 -0800
MIME-Version: 1.0
In-Reply-To: <1445993735-7817-1-git-send-email-vz@mleia.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/27/2015 05:55 PM, Vladimir Zapolskiy wrote:
> Silences sparse warning:
>
>    drivers/watchdog/pnx4008_wdt.c:83:25:
>      warning: symbol 'wdt_clk' was not declared. Should it be static?
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/pnx4008_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
> index 4224b3e..a8ade06 100644
> --- a/drivers/watchdog/pnx4008_wdt.c
> +++ b/drivers/watchdog/pnx4008_wdt.c
> @@ -80,7 +80,7 @@ static unsigned int heartbeat = DEFAULT_HEARTBEAT;
>
>   static DEFINE_SPINLOCK(io_lock);
>   static void __iomem	*wdt_base;
> -struct clk		*wdt_clk;
> +static struct clk	*wdt_clk;
>
>   static int pnx4008_wdt_start(struct watchdog_device *wdd)
>   {
>

