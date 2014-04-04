Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:56970 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbaDDRf5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Apr 2014 13:35:57 -0400
Message-ID: <533EED7A.20307@roeck-us.net>
Date: Fri, 04 Apr 2014 10:35:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio@elopez.com.ar>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	wim@iguana.be, carlo.caione@gmail.com
CC: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: sunxi: Fix compilation with C=2
References: <1396632265-16124-1-git-send-email-emilio@elopez.com.ar>
In-Reply-To: <1396632265-16124-1-git-send-email-emilio@elopez.com.ar>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/04/2014 10:24 AM, Emilio López wrote:
> When compiling sunxi_defconfig while using C=2, the following error
> causes the compilation to fail:
>
>      drivers/watchdog/sunxi_wdt.c:60:15: error: constant 0b0001 is not a valid number
>
> Fix it by using hex notation instead of the non-standard binary one
>

What defines "non-standard" here ? Isn't this a sparse problem that should possibly
be fixed in sparse instead ?

[ I don't mind changing it as the 0bXXXX notation doesn't seem to be used much
   in the kernel, but we should not claim something to be non-standard if it is
   just not widely used. As normal compilation doesn't seem to have a problem,
   we should be sure that it is non-standard if we claim it to be non-standard. ]

Thanks,
Guenter

> Signed-off-by: Emilio López <emilio@elopez.com.ar>
> ---
>   drivers/watchdog/sunxi_wdt.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
> index cd00a78..693b9d2 100644
> --- a/drivers/watchdog/sunxi_wdt.c
> +++ b/drivers/watchdog/sunxi_wdt.c
> @@ -57,17 +57,17 @@ struct sunxi_wdt_dev {
>    */
>
>   static const int wdt_timeout_map[] = {
> -	[1] = 0b0001,  /* 1s  */
> -	[2] = 0b0010,  /* 2s  */
> -	[3] = 0b0011,  /* 3s  */
> -	[4] = 0b0100,  /* 4s  */
> -	[5] = 0b0101,  /* 5s  */
> -	[6] = 0b0110,  /* 6s  */
> -	[8] = 0b0111,  /* 8s  */
> -	[10] = 0b1000, /* 10s */
> -	[12] = 0b1001, /* 12s */
> -	[14] = 0b1010, /* 14s */
> -	[16] = 0b1011, /* 16s */
> +	[1] = 0x1,  /* 1s  */
> +	[2] = 0x2,  /* 2s  */
> +	[3] = 0x3,  /* 3s  */
> +	[4] = 0x4,  /* 4s  */
> +	[5] = 0x5,  /* 5s  */
> +	[6] = 0x6,  /* 6s  */
> +	[8] = 0x7,  /* 8s  */
> +	[10] = 0x8, /* 10s */
> +	[12] = 0x9, /* 12s */
> +	[14] = 0xA, /* 14s */
> +	[16] = 0xB, /* 16s */
>   };
>
>   static int sunxi_wdt_ping(struct watchdog_device *wdt_dev)
>

