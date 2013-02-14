Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:40034 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857Ab3BNHV5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Feb 2013 02:21:57 -0500
Received: by mail-ob0-f169.google.com with SMTP id ta14so2127812obb.28
        for <linux-watchdog@vger.kernel.org>; Wed, 13 Feb 2013 23:21:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1360758150-23004-1-git-send-email-fabio.porcedda@gmail.com>
References: <1360758150-23004-1-git-send-email-fabio.porcedda@gmail.com>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Thu, 14 Feb 2013 08:21:36 +0100
Message-ID: <CAHkwnC_umHuPA07u0DKCfTS2O6W2v83-nhkEDA_KY+rMbMv01A@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] watchdog: dt: add support for the timeout-sec dt property
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>
Cc: devicetree-discuss@lists.ozlabs.org,
	Wenyou Yang <wenyou.yang@atmel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Feb 13, 2013 at 1:22 PM, Fabio Porcedda
<fabio.porcedda@gmail.com> wrote:
> Hi all,
> this patchset add the timeout-sec property to the watchdog core,
> to the at91sam9_wdt driver and on all framework enabled watchdog driver
> with dt support.
> The at91sam9_wdt is tested on evk-pr3,
> the other drivers are compile tested only.

Because in the watchdog-next tree there is already the reworked first
patch of the v7,
i will send the v9 rebased over the  watchdog-next tree, dropping the
first and second patch.

Fabio

> Best regards
> Fabio Porcedda
>
> changes:
> v8:
>   - watchdog_is_valid_timeout(): export in watchdog.h
>   - watchdog_is_valid_timeout(): use in watchdog_set_timeout()
>   - watchdog_is_valid_timeout(): split patch
>   - watchdog_init_timeout(): return -EINVAL for out of range values.
>   - watchdog_init_timeout(): use struct device instead of struct device_node
> v7:
>   - rebase over v3.8-rc2
>   - remove the patch already merged
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
>   watchdog: core: add and use watchdog_is_valid_timeout function
>   watchdog: core: dt: add support for the timeout-sec dt property
>   watchdog: orion_wdt: add timeout-sec property binding
>   watchdog: pnx4008: add timeout-sec property binding
>   watchdog: s3c2410_wdt: add timeout-sec property binding
>   watchdog: at91sam9_wdt: add timeout-sec property binding
>   watchdog: orion_wdt: move the min_timeout initialization
>
>  .../devicetree/bindings/watchdog/atmel-wdt.txt     |  4 ++
>  .../devicetree/bindings/watchdog/marvel.txt        |  5 +++
>  .../devicetree/bindings/watchdog/pnx4008-wdt.txt   |  4 ++
>  .../devicetree/bindings/watchdog/samsung-wdt.txt   |  3 ++
>  Documentation/watchdog/watchdog-kernel-api.txt     | 10 +++++
>  drivers/watchdog/Kconfig                           |  1 +
>  drivers/watchdog/at91sam9_wdt.c                    | 16 ++++++--
>  drivers/watchdog/orion_wdt.c                       | 10 ++---
>  drivers/watchdog/pnx4008_wdt.c                     |  7 ++--
>  drivers/watchdog/s3c2410_wdt.c                     |  6 ++-
>  drivers/watchdog/watchdog_core.c                   | 48 ++++++++++++++++++++++
>  drivers/watchdog/watchdog_dev.c                    |  3 +-
>  include/linux/watchdog.h                           |  4 ++
>  13 files changed, 104 insertions(+), 17 deletions(-)
>
> --
> 1.8.1.1
>



--
Fabio Porcedda
