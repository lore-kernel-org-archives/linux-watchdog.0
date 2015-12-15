Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41383 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965031AbbLOQPX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 15 Dec 2015 11:15:23 -0500
Subject: Re: [PATCH] watchdog: dw_wdt: fix signedness bug in
 dw_wdt_top_in_seconds()
To: Jisheng Zhang <jszhang@marvell.com>, wim@iguana.be
References: <1450189527-1015-1-git-send-email-jszhang@marvell.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	sebastian.hesselbarth@gmail.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56703C96.90105@roeck-us.net>
Date: Tue, 15 Dec 2015 08:15:18 -0800
MIME-Version: 1.0
In-Reply-To: <1450189527-1015-1-git-send-email-jszhang@marvell.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/15/2015 06:25 AM, Jisheng Zhang wrote:
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

Nice catch.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/dw_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index 6ea0634..8fefa4ad 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -81,7 +81,7 @@ static inline int dw_wdt_top_in_seconds(unsigned top)
>   	 * There are 16 possible timeout values in 0..15 where the number of
>   	 * cycles is 2 ^ (16 + i) and the watchdog counts down.
>   	 */
> -	return (1 << (16 + top)) / clk_get_rate(dw_wdt.clk);
> +	return (1U << (16 + top)) / clk_get_rate(dw_wdt.clk);
>   }
>
>   static int dw_wdt_get_top(void)
>

