Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.13]:56132 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479AbaDWQAH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Apr 2014 12:00:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: wim@iguana.be, dbaryshkov@gmail.com, dwmw2@infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 3/5] ARM: sunxi: Select restart drivers
Date: Wed, 23 Apr 2014 18:00:03 +0200
Message-ID: <5061177.3hiLYCoYmE@wuerfel>
In-Reply-To: <1398265476-29373-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1398265476-29373-1-git-send-email-maxime.ripard@free-electrons.com> <1398265476-29373-4-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wednesday 23 April 2014 17:04:34 Maxime Ripard wrote:
> Make sure we have the restart hooks in the kernel by selecting them in Kconfig.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-sunxi/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index b57d7d53b9d3..5fe80cc9b524 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -9,6 +9,10 @@ config ARCH_SUNXI
>         select HAVE_ARM_ARCH_TIMER
>         select PINCTRL
>         select PINCTRL_SUNXI
> +       select POWER_RESET
> +       select POWER_RESET_SUN6I
> +       select POWER_SUPPLY
>         select RESET_CONTROLLER
>         select SUN4I_TIMER
>         select SUN5I_HSTIMER
> +       select SUNXI_WATCHDOG

I think you can't select SUNXI_WATCHDOG without also selecting WATCHDOG
first. I would prefer not to do that however, and leave it up to the
defconfig to enable it, loading the reset/watchdog driver as a module
seems entirely reasonable in a multiplatform distro kernel.

	Arnd
