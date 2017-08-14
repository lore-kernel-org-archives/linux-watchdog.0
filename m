Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33189 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdHNPhy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 11:37:54 -0400
Date: Mon, 14 Aug 2017 08:37:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Huibin Hong <huibin.hong@rock-chips.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] watchdog: dw_wdt: fix overflow issue in
 dw_wdt_top_in_seconds
Message-ID: <20170814153752.GB7025@roeck-us.net>
References: <1501159843-6623-1-git-send-email-huibin.hong@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501159843-6623-1-git-send-email-huibin.hong@rock-chips.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Jul 27, 2017 at 08:50:43PM +0800, Huibin Hong wrote:
> If top is 15, (1 << (16 + top)) may be negative.
> 
> Change-Id: I76e4a603a54f093e64a4b266008570e3afcdb35a

No Change-Id in upstream patches, please.

> Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>

I am having trouble applying this patch. What is its baseline version ?

Guenter

> ---
>  drivers/watchdog/dw_wdt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 6ea0634..059c974 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -81,7 +81,9 @@ static inline int dw_wdt_top_in_seconds(unsigned top)
>  	 * There are 16 possible timeout values in 0..15 where the number of
>  	 * cycles is 2 ^ (16 + i) and the watchdog counts down.
>  	 */
> -	return (1 << (16 + top)) / clk_get_rate(dw_wdt.clk);
> +	unsigned int cycles = 1 << (16 + top);
> +
> +	return cycles / clk_get_rate(dw_wdt.clk);
>  }
>  
>  static int dw_wdt_get_top(void)
> -- 
> 1.9.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
