Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43940 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752534AbbL1Vta (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Dec 2015 16:49:30 -0500
Date: Mon, 28 Dec 2015 22:49:28 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Oleksij Rempel <linux@rempel-privat.de>
Cc: linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v4 0/2] add Alphascale asm9260-wdt driver
Message-ID: <20151228214928.GA1395@spo001.leaseweb.nl>
References: <5652BFA5.9010101@roeck-us.net> <1448480003-8029-1-git-send-email-linux@rempel-privat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448480003-8029-1-git-send-email-linux@rempel-privat.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Oleksij,

> v2:
> - fix DT types
> - remove obsolet comments
> - add clk error handling
> - reduce log noise
> - allow to return an error in asm9260_wdt_get_dt_mode
> 
> v3:
> - split patch to two parts, binding documentation and driver
> - spelling fixes
> - make reset a required property. It will make the code easier
> - reduce timeout for asm9260_wdt_sys_reset
> - rework error handling in asm9260_wdt_get_dt_clks
> - asm9260_wdt_get_dt_mode - convert return type from int to void
> - don't touch watchdog_set_nowayout
> - don't do dev_err() if driver is still working, use dev_warn instead.
> - asm9260_wdt_remove - use asm9260_wdt_disable() instead of asm9260_wdt_shutdown()
> 
> v4:
> - update commit message
> - remove IRQF_SHARED flag. This SOC don't need it.
> - make "Watchdog enabled" more user freandly
> - add watchdog_unregister_device to asm9260_wdt_remove
> 
> Oleksij Rempel (2):
>   watchdog: add Alphascale asm9260-wdt driver
>   DT: watchdog: add Alphascale asm9260 watchdog binding documentation.
> 
>  .../bindings/watchdog/alphascale-asm9260.txt       |  35 ++
>  drivers/watchdog/Kconfig                           |  10 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/asm9260_wdt.c                     | 403 +++++++++++++++++++++
>  4 files changed, 449 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
>  create mode 100644 drivers/watchdog/asm9260_wdt.c
> 
> -- 
> 2.5.0
>

This new driver has been added o linux-watchdog-next.

Kind regards,
Wim.

