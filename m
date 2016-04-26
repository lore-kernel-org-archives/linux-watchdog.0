Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45799 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbcDZBlM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 Apr 2016 21:41:12 -0400
Subject: Re: [PATCH] watchdog: f71808e_wdt: Fix typo
To: Knud Poulsen <knpo@ieee.org>
References: <571E3917.5030704@ieee.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Linux Watchdog <linux-watchdog@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <571EC736.70508@roeck-us.net>
Date: Mon, 25 Apr 2016 18:41:10 -0700
MIME-Version: 1.0
In-Reply-To: <571E3917.5030704@ieee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/25/2016 08:34 AM, Knud Poulsen wrote:
> Spelling/ typo
>
> Signed-off-by: Knud Poulsen <knpo@ieee.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/f71808e_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
> index 016bd93..f6d7add 100644
> --- a/drivers/watchdog/f71808e_wdt.c
> +++ b/drivers/watchdog/f71808e_wdt.c
> @@ -38,7 +38,7 @@
>
>   #define SIO_F71808FG_LD_WDT	0x07	/* Watchdog timer logical device */
>   #define SIO_UNLOCK_KEY		0x87	/* Key to enable Super-I/O */
> -#define SIO_LOCK_KEY		0xAA	/* Key to diasble Super-I/O */
> +#define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */
>
>   #define SIO_REG_LDSEL		0x07	/* Logical device select */
>   #define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
>

