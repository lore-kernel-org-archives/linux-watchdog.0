Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43662 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751872AbbL0UGH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 27 Dec 2015 15:06:07 -0500
Date: Sun, 27 Dec 2015 21:06:04 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	sebastian.hesselbarth@gmail.com
Subject: Re: [PATCH] watchdog: dw_wdt: fix signedness bug in dw_wdt_top_in_seconds()
Message-ID: <20151227200604.GA24971@spo001.leaseweb.nl>
References: <1450189527-1015-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1450189527-1015-1-git-send-email-jszhang@marvell.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jisheng,

> On 64bit platforms, "(1 << (16 + top)) / clk_get_rate(dw_wdt.clk)" is
> sign-extended to 64bit then converted to unsigned 64bit, finally divide
> the clk rate. If the top is the maximum TOP i.e 15, "(1 << (16 +15))"
> will be sign-extended to 0xffffffff80000000, then converted to unsigned
> 0xffffffff80000000, which is a huge number, thus the final result is
> wrong.
> 
> We fix this issue by giving usigned value(1U in this case) at first.
> 
> Let's assume clk rate is 25MHZ,
> Before the patch:
> dw_wdt_top_in_seconds(15) = -864612050
> 
> After the patch:
> dw_wdt_top_in_seconds(15) = 85
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/watchdog/dw_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 6ea0634..8fefa4ad 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -81,7 +81,7 @@ static inline int dw_wdt_top_in_seconds(unsigned top)
>  	 * There are 16 possible timeout values in 0..15 where the number of
>  	 * cycles is 2 ^ (16 + i) and the watchdog counts down.
>  	 */
> -	return (1 << (16 + top)) / clk_get_rate(dw_wdt.clk);
> +	return (1U << (16 + top)) / clk_get_rate(dw_wdt.clk);
>  }
>  
>  static int dw_wdt_get_top(void)
> -- 
> 2.6.4
> 

Patch is added to linux-watchdog-next.

Kind regards,
Wim.

