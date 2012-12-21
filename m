Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:53357 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab2LULRh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 21 Dec 2012 06:17:37 -0500
Received: by mail-oa0-f44.google.com with SMTP id n5so4537942oag.3
        for <linux-watchdog@vger.kernel.org>; Fri, 21 Dec 2012 03:17:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1353588716-28917-1-git-send-email-fabio.porcedda@gmail.com>
References: <1353588716-28917-1-git-send-email-fabio.porcedda@gmail.com>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Fri, 21 Dec 2012 12:09:55 +0100
Message-ID: <CAHkwnC-kOM2dzv9QmxbTgAYg5e2Ni39ixQR73cHt_5krMqwPbA@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] watchdog: dt: add support for the timeout-sec dt property
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>
Cc: devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Nov 22, 2012 at 1:51 PM, Fabio Porcedda
<fabio.porcedda@gmail.com> wrote:
> Hi all,
> this patchset add the timeout-sec property to the watchdog core,
> to the at91sam9_wdt driver and on all framework enabled watchdog driver
> with dt support.
> The at91sam9_wdt is tested on evk-pr3,
> the other drivers are compile tested only.
>
> This patchset depends on the patchset already sent:
> "[PATCH v9 0/3 RESEND] watchdog: at91sam9_wdt: add device tree support"
> that is already pulled in arm-soc/for-next branch.

Ping.

The dependency is already merged.

> Best regards
> Fabio Porcedda
>
> changes:
> v6:
>   - remove patch for function of_get_timeout_sec as aked by Rob Herring
>   - add Acked-by: Jason Cooper <jason@lakedaemon.net>
>   - add Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> v5:
>   - fix codestyle for compilance ti checkpatch.pl about
>     "ERROR: do not initialise statics to 0 or NULL"
>     for s3c2410_wdt.c:56 and at91sam9_wdt.c:63
> v4:
>   - add of_get_timeout_sec
>   - add s3c2410_wdt driver
>   - split driver patch
>   - fixed watchdog_init_timeout handling of min_timeout and max_timeout
> v3:
>   - rename watchdog_probe_dt_timeout ->  watchdog_init_timeout
>   - move the watchdog_init_timeout function from inline to watchdog_core.c
>   - add timeout parameter handling code to watchdog_init_timeout
>   - add timeout-sec property to the pnx4008-wdt driver
>   - add two small commit for fixup and cleanup
> v2:
>   - change "timeout" to "timeout-sec" as asked by Jean-Christophe
>   - at91sam9_wdt: use the new helper function
>   - at91sam9_wdt: add bounds checking
>   - watchdog.h: add bounds checking
>
> Fabio Porcedda (7):
>   watchdog: core: dt: add support for the timeout-sec dt property
>   watchdog: orion_wdt: add timeout-sec property binding
>   watchdog: pnx4008: add timeout-sec property binding
>   watchdog: s3c2410_wdt: add timeout-sec property binding
>   watchdog: at91sam9_wdt: add timeout-sec property binding
>   watchdog: orion_wdt: move the min_timeout initialization
>   watchdog: WatchDog Timer Driver Core - fix comment
>
>  .../devicetree/bindings/watchdog/atmel-wdt.txt     |  4 +++
>  .../devicetree/bindings/watchdog/marvel.txt        |  5 +++
>  .../devicetree/bindings/watchdog/pnx4008-wdt.txt   |  4 +++
>  .../devicetree/bindings/watchdog/samsung-wdt.txt   |  3 ++
>  Documentation/watchdog/watchdog-kernel-api.txt     | 10 ++++++
>  drivers/watchdog/Kconfig                           |  1 +
>  drivers/watchdog/at91sam9_wdt.c                    | 16 ++++++++--
>  drivers/watchdog/orion_wdt.c                       | 10 +++---
>  drivers/watchdog/pnx4008_wdt.c                     |  7 ++--
>  drivers/watchdog/s3c2410_wdt.c                     |  6 ++--
>  drivers/watchdog/watchdog_core.c                   | 37 ++++++++++++++++++++++
>  include/linux/watchdog.h                           |  5 ++-
>  12 files changed, 92 insertions(+), 16 deletions(-)
>
> --
> 1.8.0
>

--
Fabio Porcedda
