Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:34815 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753579AbcENSbY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 14 May 2016 14:31:24 -0400
Date: Sat, 14 May 2016 20:31:22 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Knud Poulsen <knpo@ieee.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Linux Watchdog <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH] watchdog: f71808e_wdt: Fix typo
Message-ID: <20160514183122.GC21026@spo001.leaseweb.nl>
References: <571E3917.5030704@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571E3917.5030704@ieee.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Knud,

> Spelling/ typo
> 
> Signed-off-by: Knud Poulsen <knpo@ieee.org>
> ---
>  drivers/watchdog/f71808e_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
> index 016bd93..f6d7add 100644
> --- a/drivers/watchdog/f71808e_wdt.c
> +++ b/drivers/watchdog/f71808e_wdt.c
> @@ -38,7 +38,7 @@
> 
>  #define SIO_F71808FG_LD_WDT	0x07	/* Watchdog timer logical device */
>  #define SIO_UNLOCK_KEY		0x87	/* Key to enable Super-I/O */
> -#define SIO_LOCK_KEY		0xAA	/* Key to diasble Super-I/O */
> +#define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */
> 
>  #define SIO_REG_LDSEL		0x07	/* Logical device select */
>  #define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
> -- 
> 2.5.5

This patch was added to linux-watchdog-next.

Kind Regards,
Wim.

