Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57479 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbdHOEtS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 15 Aug 2017 00:49:18 -0400
Subject: Re: [PATCH v2] watchdog: dw_wdt: fix overflow issue in
 dw_wdt_top_in_seconds
To: Huibin Hong <huibin.hong@rock-chips.com>
Cc: huangtao@rock-chips.com, Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1502765113-1025-1-git-send-email-huibin.hong@rock-chips.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <667541ac-48ab-f6ab-6b86-44aa96fe5bc7@roeck-us.net>
Date: Mon, 14 Aug 2017 21:49:16 -0700
MIME-Version: 1.0
In-Reply-To: <1502765113-1025-1-git-send-email-huibin.hong@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/14/2017 07:45 PM, Huibin Hong wrote:
> If top is 15, (1 << (16 + top)) may be negative.
> 
> Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
> ---
> 
> Changes in v2:
>      - Rebase mainline Linux 4.13-rc5
> 
>   drivers/watchdog/dw_wdt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 36be987..59ed958 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -72,7 +72,9 @@ static inline int dw_wdt_top_in_seconds(struct dw_wdt *dw_wdt, unsigned top)
>   	 * There are 16 possible timeout values in 0..15 where the number of
>   	 * cycles is 2 ^ (16 + i) and the watchdog counts down.
>   	 */
> -	return (1U << (16 + top)) / dw_wdt->rate;
> +	unsigned int cycles = 1 << (16 + top);
> +
> +	return (cycles / clk_get_rate(dw_wdt.clk));

Sorry I didn't catch this earlier. Why not use dw_wdt->rate ?
It has been checked against 0, and presumably the rate does not change
on its own. If it can change, you'll have to submit a separate patch
dropping the use of dw_wdt->rate entirely and explaining the reason.
You'll also have to make sure that the driver somehow catches the
rate change and adjusts its settings automatically; otherwise, timeouts
will be off target, and the system can reset unexpectedly.

Thanks,
Guenter

>   }
>   
>   static int dw_wdt_get_top(struct dw_wdt *dw_wdt)
> 

