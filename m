Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39598 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753481AbcLaTLg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 31 Dec 2016 14:11:36 -0500
Subject: Re: [PATCH] watchdog: orion: fix spelling mistake: "harcoded" ->
 "hardcoded"
To: Colin King <colin.king@canonical.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
References: <20161229214918.28526-1-colin.king@canonical.com>
Cc: linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9a8e4f8c-48b6-a8a5-6308-124d2ef4ec0b@roeck-us.net>
Date: Sat, 31 Dec 2016 11:11:33 -0800
MIME-Version: 1.0
In-Reply-To: <20161229214918.28526-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/29/2016 01:49 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in WARN message
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/orion_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index c6b8f4a..39be4dd 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -395,7 +395,7 @@ static void __iomem *orion_wdt_ioremap_rstout(struct platform_device *pdev,
>
>  	rstout = internal_regs + ORION_RSTOUT_MASK_OFFSET;
>
> -	WARN(1, FW_BUG "falling back to harcoded RSTOUT reg %pa\n", &rstout);
> +	WARN(1, FW_BUG "falling back to hardcoded RSTOUT reg %pa\n", &rstout);
>  	return devm_ioremap(&pdev->dev, rstout, 0x4);
>  }
>
>

