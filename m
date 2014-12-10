Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:53923 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbaLJAd6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Dec 2014 19:33:58 -0500
Date: Wed, 10 Dec 2014 09:33:52 +0900
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wim Van Sebroeck <wim@iguana.be>, Wolfram Sang <wsa@the-dreams.de>,
	Magnus Damm <magnus.damm@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lee Jones <lee.jones@linaro.org>,
	linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH 0/4] ARM: shmobile: koelsch: Add DA9063 watchdog restart
 support
Message-ID: <20141210003352.GH9690@verge.net.au>
References: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Dec 09, 2014 at 12:22:45PM +0100, Geert Uytterhoeven wrote:
> 	Hi Wim, Wolfram, Simon, Magnus,
> 
> This patch series add restart support for r8a7791/koelsch through the watchdog
> in the DA9063 PMIC. Restart can be triggered in two ways:
>   1. Timeout of the watchdog timer,
>   2. Manual system restart, shutting down the DA9063.
> 
> Dependencies:
>   - There are no strict merge order dependencies,
>   - While manual restart depends on patch 1, patches 3 and 4 can be merged
>     now, as restart on watchdog timeout works without patch 1.
> 
> Patches:
>   - Patch 1 is intended for the watchdog tree (based on watchdog/next),
>   - Patch 2 is intended for the i2c tree (based on i2c/next),
>   - Patches 3 and 4 are intended for the shmobile tree (based on
>     renesas-devel-20141209-v3.18).

Patches 3 and 4 look like they could be queued up for v3.20 now.
Shall I do so?

> This was tested on r8a7791/koelsch.
> I expect this restart method to be usable on r8a7791/lager and r8a7794/alt,
> too.
> 
> Thanks!
> 
> Geert Uytterhoeven (4):
>   watchdog: da9063: Add restart handler support
>   DT: i2c: Add devices handled by the da9063 MFD driver
>   ARM: shmobile: koelsch: Add DA9063 PMIC device node for system restart
>   ARM: shmobile: Enable DA9063 watchdog in multiplatform defconfig
> 
>  .../devicetree/bindings/i2c/trivial-devices.txt    |  1 +
>  arch/arm/boot/dts/r8a7791-koelsch.dts              |  7 +++++
>  arch/arm/configs/shmobile_defconfig                |  3 ++
>  drivers/watchdog/da9063_wdt.c                      | 32 +++++++++++++++++++++-
>  4 files changed, 42 insertions(+), 1 deletion(-)
> 
> -- 
> 1.9.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
