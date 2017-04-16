Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52686 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756683AbdDPTxb (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 16 Apr 2017 15:53:31 -0400
Subject: Re: [PATCH] drivers:watchdog:aspeed_wdt: using msleep instead of
 mdelay
To: Karim Eshapa <karim.eshapa@gmail.com>, joel@jms.id.au
References: <1492360388-20697-1-git-send-email-karim.eshapa@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7ca24742-8a82-da21-7b4c-ca807f995844@roeck-us.net>
Date: Sun, 16 Apr 2017 12:53:28 -0700
MIME-Version: 1.0
In-Reply-To: <1492360388-20697-1-git-send-email-karim.eshapa@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/16/2017 09:33 AM, Karim Eshapa wrote:
> that's useful for the scheduler, power management unless
> the driver needs to delay in atomic context
> look at documentation/timers/timers-howto
>
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
> ---
>  drivers/watchdog/aspeed_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 1c65258..17f06d1 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -115,7 +115,7 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
>
>  	aspeed_wdt_enable(wdt, 128 * WDT_RATE_1MHZ / 1000);
>
> -	mdelay(1000);
> +	msleep(1000);
>
>  	return 0;
>  }
>
Possibly, but how can you guarantee that the restart function is called with interrupts
enabled ? Also, why would it be necessary or even useful for the scheduler to do anything
while the system is in the process of restarting ?

Guenter

