Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:55516 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbdK1XLE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Nov 2017 18:11:04 -0500
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 0FDB961EC1
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Nov 2017 23:11:04 +0000 (UTC)
Date: Tue, 28 Nov 2017 16:11:02 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@www.linux-watchdog.org
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jimmy Vance <jimmy.vance@hpe.com>
Subject: Re: [GIT PULL REQUEST] watchdog - v4.15-rc1 Merge Window
Message-ID: <20171128231102.GA1077@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20171123143230.GA30745@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171123143230.GA30745@www.linux-watchdog.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Nov 23, 2017 at 03:32:30PM +0100, wim@www.linux-watchdog.org wrote:
> The following changes since commit 4dd3c2e5a4225e3df85afc6033e62ce8b09f0ed2:
> 
>   Merge tag 'nfsd-4.15' of git://linux-nfs.org/~bfields/linux (2017-11-18 11:22:04 -0800)
> 
> are available in the git repository at:
> 
>   git://www.linux-watchdog.org/linux-watchdog.git 
> 
> for you to fetch changes up to 14807b07a7d86b7e43eb044f859ae78c57366927:
> 
>   watchdog: pcwd_usb: remove unneeded DRIVER_LICENSE #define (2017-11-18 22:33:59 +0100)
> 

Wim,

I don't see a patch to the MAINTAINERS file to reflect the
change of maintainers for hpwdt from Jimmy Vance to myself.
Please see email thread:

	https://lkml.org/lkml/2017/10/9/930


Thanks

Jerry Hoemann



> ----------------------------------------------------------------
> Andreas Färber (2):
>       dt-bindings: watchdog: Add Realtek RTD1295
>       watchdog: Add Realtek RTD1295
> 
> Andrew Jeffery (4):
>       watchdog: aspeed: Retain watchdog enabled state
>       watchdog: aspeed: Fix 'Apseed' typo in Kconfig
>       watchdog: aspeed: Remove specific reference to AST2400 in Kconfig
>       watchdog: aspeed: Move init to arch_initcall
> 
> Arnd Bergmann (1):
>       watchdog: xen: use time64_t for timeouts
> 
> Chris Packham (1):
>       watchdog: orion: fix typo
> 
> Christophe Leroy (1):
>       watchdog: mpc8xxx: use the core worker function
> 
> Corentin Labbe (1):
>       watchdog: sunxi_wdt: use of_device_get_match_data
> 
> Eric Long (2):
>       dt-bindings: watchdog: Add Spreadtrum watchdog documentation
>       watchdog: Add Spreadtrum watchdog driver
> 
> Geert Uytterhoeven (1):
>       dt-bindings: watchdog: renesas-wdt: Add support for the r8a77970 wdt
> 
> Greg Kroah-Hartman (1):
>       watchdog: pcwd_usb: remove unneeded DRIVER_LICENSE #define
> 
> Guenter Roeck (2):
>       watchdog: Fix potential kref imbalance when opening watchdog
>       watchdog: Fix kref imbalance seen if handle_boot_enabled=0
> 
> Gustavo A. R. Silva (7):
>       watchdog: advantechwdt: mark expected switch fall-through
>       watchdog: alim1535_wdt: mark expected switch fall-through
>       watchdog: f71808e_wdt: mark expected switch fall-throughs
>       watchdog: pcwd_usb: mark expected switch fall-through
>       watchdog: pcwd_pci: mark expected switch fall-through
>       watchdog: watchdog_dev: mark expected switch fall-through
>       watchdog: wdt_pci: mark expected switch fall-through
> 
> Jerry Hoemann (2):
>       watchdog: hpwdt: SMBIOS check
>       watchdog: hpwdt: Check source of NMI
> 
> Linus Walleij (5):
>       watchdog: gpio: Add some local helper variables
>       watchdog: gpio: Convert to use GPIO descriptors
>       watchdog: gemini/ftwdt010: rename DT bindings
>       watchdog: gemini/ftwdt010: rename driver and symbols
>       watchdog: ftwdt010: Make interrupt optional
> 
> Mathieu Malaterre (2):
>       watchdog: jz4740: Add support for the watchdog in jz4780 SoC
>       dt: watchdog: Document compatibility with JZ4780
> 
> Matt Redfearn (1):
>       watchdog: indydog: Add dependency on SGI_HAS_INDYDOG
> 
> Michael Grzeschik (3):
>       watchdog: da9062: Add restart handler support
>       watchdog: da9062: Disable and wait before changing timeout
>       watchdog: da9062: use protection delay mechanism from core
> 
> Oleksij Rempel (1):
>       watchdog: dw_wdt: add stop watchdog operation
> 
> Radu Rendec (6):
>       watchdog: i6300esb: use the watchdog subsystem
>       watchdog: i6300esb: support multiple devices
>       watchdog: i6300esb: do not hardcode heartbeat limits
>       watchdog: i6300esb: remove info message and version number
>       watchdog: xen_wdt: use the watchdog subsystem
>       watchdog: xen_wdt: remove info message and version number
> 
> Rasmus Villemoes (1):
>       watchdog: gpio_wdt: set WDOG_HW_RUNNING in gpio_wdt_stop
> 
> Tomas Winkler (1):
>       watchdog: mei_wdt: don't use of variable length array
> 
>  .../bindings/watchdog/cortina,gemini-watchdog.txt  |  17 -
>  ...ina,gemin-watchdog.txt => faraday,ftwdt010.txt} |  11 +-
>  .../bindings/watchdog/ingenic,jz4740-wdt.txt       |   4 +-
>  .../bindings/watchdog/realtek,rtd119x.txt          |  17 +
>  .../devicetree/bindings/watchdog/renesas-wdt.txt   |   3 +-
>  .../devicetree/bindings/watchdog/sprd-wdt.txt      |  19 +
>  drivers/watchdog/Kconfig                           |  38 +-
>  drivers/watchdog/Makefile                          |   4 +-
>  drivers/watchdog/advantechwdt.c                    |   2 +-
>  drivers/watchdog/alim1535_wdt.c                    |   2 +-
>  drivers/watchdog/aspeed_wdt.c                      |  21 +-
>  drivers/watchdog/da9062_wdt.c                      |  48 ++-
>  drivers/watchdog/dw_wdt.c                          |  18 +-
>  drivers/watchdog/f71808e_wdt.c                     |   4 +-
>  drivers/watchdog/ftwdt010_wdt.c                    | 236 ++++++++++++
>  drivers/watchdog/gemini_wdt.c                      | 229 ------------
>  drivers/watchdog/gpio_wdt.c                        |  58 ++-
>  drivers/watchdog/hpwdt.c                           |  12 +-
>  drivers/watchdog/i6300esb.c                        | 377 +++++++------------
>  drivers/watchdog/jz4740_wdt.c                      |   1 +
>  drivers/watchdog/mei_wdt.c                         |   7 +-
>  drivers/watchdog/mpc8xxx_wdt.c                     |  84 ++---
>  drivers/watchdog/orion_wdt.c                       |   2 +-
>  drivers/watchdog/pcwd_pci.c                        |   2 +-
>  drivers/watchdog/pcwd_usb.c                        |   5 +-
>  drivers/watchdog/rtd119x_wdt.c                     | 168 +++++++++
>  drivers/watchdog/sprd_wdt.c                        | 399 +++++++++++++++++++++
>  drivers/watchdog/sunxi_wdt.c                       |   7 +-
>  drivers/watchdog/watchdog_dev.c                    |  19 +-
>  drivers/watchdog/wdt_pci.c                         |   2 +-
>  drivers/watchdog/xen_wdt.c                         | 255 +++----------
>  31 files changed, 1223 insertions(+), 848 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt
>  rename Documentation/devicetree/bindings/watchdog/{cortina,gemin-watchdog.txt => faraday,ftwdt010.txt} (55%)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/sprd-wdt.txt
>  create mode 100644 drivers/watchdog/ftwdt010_wdt.c
>  delete mode 100644 drivers/watchdog/gemini_wdt.c
>  create mode 100644 drivers/watchdog/rtd119x_wdt.c
>  create mode 100644 drivers/watchdog/sprd_wdt.c
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
