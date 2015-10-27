Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33823 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbbJ0W2I (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Oct 2015 18:28:08 -0400
MIME-Version: 1.0
In-Reply-To: <1445255774-32887-2-git-send-email-B48286@freescale.com>
References: <1445255774-32887-1-git-send-email-B48286@freescale.com>
	<1445255774-32887-2-git-send-email-B48286@freescale.com>
Date: Tue, 27 Oct 2015 17:28:06 -0500
Message-ID: <CADRPPNQqu6bzHxyo22VWYVeDtQS3d_CR2veb7+N+arvQy5opvA@mail.gmail.com>
Subject: Re: [PATCH V5 2/6] watchdog: Add support for Freescale Layerscape platforms
From: Li Yang <leoli@freescale.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org,
	Zhiqiang Hou <B48286@freescale.com>,
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

Can you help to review the patch and pick it for the next merge window?

Regards,
Leo

On Mon, Oct 19, 2015 at 6:56 AM, Zhiqiang Hou <B48286@freescale.com> wrote:
> From: Shaohui Xie <Shaohui.Xie@freescale.com>
>
> Modify watchdog/Kconfig file to support Layerscape platforms.
>
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>
> Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> ---
> V5: V4 V3 V2
>  - No change.
>
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 79e1aa1..448dbaf 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -446,7 +446,7 @@ config MAX63XX_WATCHDOG
>
>  config IMX2_WDT
>         tristate "IMX2+ Watchdog"
> -       depends on ARCH_MXC
> +       depends on ARCH_MXC || ARCH_LAYERSCAPE
>         select REGMAP_MMIO
>         select WATCHDOG_CORE
>         help
> --
