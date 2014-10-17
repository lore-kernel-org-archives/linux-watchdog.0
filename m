Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35032 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbaJQR60 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 Oct 2014 13:58:26 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XfBnG-000G39-8y
	for linux-watchdog@vger.kernel.org; Fri, 17 Oct 2014 17:58:26 +0000
Message-ID: <544158B7.5090000@roeck-us.net>
Date: Fri, 17 Oct 2014 10:58:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Abhilash Kesavan <a.kesavan@samsung.com>,
	linux-watchdog@vger.kernel.org
CC: wim@iguana.be, Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	naveenkrishna.ch@gmail.com
Subject: Re: [PATCH] watchdog: s3c2410_wdt: Fix the mask bit offset for Exynos7
References: <1413562373-12734-1-git-send-email-a.kesavan@samsung.com>
In-Reply-To: <1413562373-12734-1-git-send-email-a.kesavan@samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/17/2014 09:12 AM, Abhilash Kesavan wrote:
> The watchdog mask bit offset listed for Exynos7 is incorrect.
> Fix this.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>   drivers/watchdog/s3c2410_wdt.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 8532c3e..1626dc6 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -161,7 +161,7 @@ static const struct s3c2410_wdt_variant drv_data_exynos5420 = {
>   static const struct s3c2410_wdt_variant drv_data_exynos7 = {
>   	.disable_reg = EXYNOS5_WDT_DISABLE_REG_OFFSET,
>   	.mask_reset_reg = EXYNOS5_WDT_MASK_RESET_REG_OFFSET,
> -	.mask_bit = 0,
> +	.mask_bit = 23,
>   	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
>   	.rst_stat_bit = 23,	/* A57 WDTRESET */
>   	.quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT,
>

Naveen, can you confirm / Ack ?

Thanks,
Guenter

