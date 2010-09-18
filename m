Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34418 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab0IRAhs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 Sep 2010 20:37:48 -0400
Received: by wwb39 with SMTP id 39so1515655wwb.1
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Sep 2010 17:37:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1284764008-19469-2-git-send-email-timur@freescale.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
	<1284764008-19469-2-git-send-email-timur@freescale.com>
Date: Fri, 17 Sep 2010 20:37:47 -0400
Message-ID: <AANLkTi=Ks7hkDq1g1SyHLf4Lf8tsew-KnvKOgyQxjcWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/watchdog: allow the e500 watchdog driver to
 be compiled as a module
From: Josh Boyer <jwboyer@gmail.com>
To: Timur Tabi <timur@freescale.com>
Cc: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	kumar.gala@freescale.com, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Sep 17, 2010 at 6:53 PM, Timur Tabi <timur@freescale.com> wrote:
> Register the __init and __exit functions in the PowerPC e500 watchdog driver
> as module entry/exit functions, and modify the Kconfig entry.
>
> Add a .release method for the PowerPC e500 watchdog driver, so that the
> watchdog is disabled when the driver is closed.

This is used for more than just e500.

>
> Loosely based on original code from Jiang Yutang <b14898@freescale.com>.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This patch requires:
>
>        powerpc: export ppc_tb_freq so that modules can reference it
>
>  drivers/watchdog/Kconfig     |    5 ++++-
>  drivers/watchdog/booke_wdt.c |   39 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 24efd8e..d9cf5a9 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -957,9 +957,12 @@ config PIKA_WDT
>          the Warp platform.
>
>  config BOOKE_WDT
> -       bool "PowerPC Book-E Watchdog Timer"
> +       tristate "PowerPC Book-E Watchdog Timer"
>        depends on BOOKE || 4xx
>        ---help---
> +         Watchdog driver for PowerPC e500 chips, such as the Freescale
> +         MPC85xx SOCs.
> +

Again, used for more than e500.  That || 4xx in the depends statement
right above your addition isn't there for fun :).

josh
