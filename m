Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43526 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbbJFAVF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 5 Oct 2015 20:21:05 -0400
Subject: Re: [PATCH] wdt: intel-mid: add Magic Closure flag
To: David Cohen <david.a.cohen@linux.intel.com>, wim@iguana.be
References: <1444088998-20835-1-git-send-email-david.a.cohen@linux.intel.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <561313EC.4060105@roeck-us.net>
Date: Mon, 5 Oct 2015 17:21:00 -0700
MIME-Version: 1.0
In-Reply-To: <1444088998-20835-1-git-send-email-david.a.cohen@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/05/2015 04:49 PM, David Cohen wrote:
> Adding WDIOF_MAGICCLOSE to Intel MID watchdog driver. Once the watchdog
> is opened, it makes sense to disable watchdog only if it was gracefully
> released.
>
> Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>

Makes sense.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/intel-mid_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
> index 0a436b5d1e84..db36d12e2b52 100644
> --- a/drivers/watchdog/intel-mid_wdt.c
> +++ b/drivers/watchdog/intel-mid_wdt.c
> @@ -101,7 +101,7 @@ static irqreturn_t mid_wdt_irq(int irq, void *dev_id)
>
>   static const struct watchdog_info mid_wdt_info = {
>   	.identity = "Intel MID SCU watchdog",
> -	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
> +	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
>   };
>
>   static const struct watchdog_ops mid_wdt_ops = {
>

