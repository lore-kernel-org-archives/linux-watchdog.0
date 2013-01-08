Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:53825 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756684Ab3AHQww (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 Jan 2013 11:52:52 -0500
Received: from mail439.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id C41AD10300F0
	for <linux-watchdog@vger.kernel.org>; Tue,  8 Jan 2013 16:45:57 +0100 (CET)
Date: Tue, 8 Jan 2013 16:34:47 +0100
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH v7 0/6] watchdog: dt: add support for the timeout-sec
 dt property
Message-ID: <20130108153447.GC7360@game.jcrosoft.org>
References: <1357639455-21935-1-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1357639455-21935-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11:04 Tue 08 Jan     , Fabio Porcedda wrote:
> Hi all,
> this patchset add the timeout-sec property to the watchdog core,
> to the at91sam9_wdt driver and on all framework enabled watchdog driver
> with dt support.
> The at91sam9_wdt is tested on evk-pr3,
> the other drivers are compile tested only.
> 

I'll prefer a macro to abstract the string in every driver

except this fine by me

Best Regards,
J.

> Best regards
> Fabio Porcedda
> 
> changes:
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
> Fabio Porcedda (6):
>   watchdog: core: dt: add support for the timeout-sec dt property
>   watchdog: orion_wdt: add timeout-sec property binding
>   watchdog: pnx4008: add timeout-sec property binding
>   watchdog: s3c2410_wdt: add timeout-sec property binding
>   watchdog: at91sam9_wdt: add timeout-sec property binding
>   watchdog: orion_wdt: move the min_timeout initialization
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
>  include/linux/watchdog.h                           |  3 ++
>  12 files changed, 91 insertions(+), 15 deletions(-)
> 
> -- 
> 1.8.0.3
> 
