Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:54034 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760357AbaJ1G4f (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Oct 2014 02:56:35 -0400
Received: by mail-qc0-f176.google.com with SMTP id x3so23067qcv.35
        for <linux-watchdog@vger.kernel.org>; Mon, 27 Oct 2014 23:56:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1413562373-12734-1-git-send-email-a.kesavan@samsung.com>
References: <1413562373-12734-1-git-send-email-a.kesavan@samsung.com>
Date: Tue, 28 Oct 2014 12:26:34 +0530
Message-ID: <CAM4voa=qwp09OJgmyM+YnYMLeAOMEV9R_2QMoLtuGDywrwqOZA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: s3c2410_wdt: Fix the mask bit offset for Exynos7
From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
To: linux-watchdog@vger.kernel.org, wim@iguana.be, linux@roeck-us.net
Cc: Naveen Krishna <naveenkrishna.ch@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim and Guenter,

On Fri, Oct 17, 2014 at 9:42 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> The watchdog mask bit offset listed for Exynos7 is incorrect.
> Fix this.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  drivers/watchdog/s3c2410_wdt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 8532c3e..1626dc6 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -161,7 +161,7 @@ static const struct s3c2410_wdt_variant drv_data_exynos5420 = {
>  static const struct s3c2410_wdt_variant drv_data_exynos7 = {
>         .disable_reg = EXYNOS5_WDT_DISABLE_REG_OFFSET,
>         .mask_reset_reg = EXYNOS5_WDT_MASK_RESET_REG_OFFSET,
> -       .mask_bit = 0,
> +       .mask_bit = 23,
>         .rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
>         .rst_stat_bit = 23,     /* A57 WDTRESET */
>         .quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT,

Naveen reviewed and ack'ed this fix. Can it be applied ?

Regards,
Abhilash
> --
> 1.7.9.5
>
