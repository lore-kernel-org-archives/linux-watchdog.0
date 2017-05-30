Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:34341 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdE3LLP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 30 May 2017 07:11:15 -0400
MIME-Version: 1.0
In-Reply-To: <1494734105-15506-1-git-send-email-linux@roeck-us.net>
References: <1494734105-15506-1-git-send-email-linux@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 May 2017 13:11:08 +0200
Message-ID: <CAMuHMdV+6PWBj1W1Rt=mxg3BZSAWWarU1Gf_mYyX9TZCJam-QA@mail.gmail.com>
Subject: Re: [GIT PULL] watchdog updates for v4.12
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi G=C3=BCnter, Linus, Wim,

On Sun, May 14, 2017 at 5:55 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> As requested by Wim:
>
> Please pull watchdog updates for Linux v4.12 from signed tag:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.gi=
t watchdog-for-linus-v4.12
>
> Note: I had to drop one of the patches affecting drivers/watchdog/iTCO_wd=
t.c
> because it and some other patches affecting the same file came in from
> another tree, causing severe and unnecessary conflicts. Other than that,
> the tree is about two weeks old, even though it looks like some of the
> patches are brand new.

What happened to this pull request?

It seems to have been superseded by "[GIT PULL REQUEST] watchdog - v4.12-rc=
1
Fixes", which did get pulled, but the latter included less commits.

E.g. the rza_wdt driver was not included.
In addition, it has also disappeared from linux-next?

Thanks!

> Thanks,
> Guenter
> ------
>
> The following changes since commit 39da7c509acff13fc8cb12ec1bb20337c988ed=
36:
>
>   Linux 4.11-rc6 (2017-04-09 09:49:44 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git =
tags/watchdog-for-linus-v4.12
>
> for you to fetch changes up to edf44420d704503d349025f22ab1973350427cca:
>
>   watchdog: bcm281xx: Fix use of uninitialized spinlock. (2017-05-13 20:2=
6:30 -0700)
>
> ----------------------------------------------------------------
> Watchdog patches for v4.12
>
> New drivers for STM32 and Renesas RZA watchdogs
> Added support for F71868 to f71808e_wdt
> Bug fixes and minor improvements in several drivers
>
> ----------------------------------------------------------------
> Alexandre Belloni (4):
>       watchdog: sama5d4: fix WDDIS handling
>       watchdog: sama5d4: fix race condition
>       watchdog: sama5d4: simplify probe
>       watchdog: sama5d4: Add comment explaining what happens on resume
>
> Andy Shevchenko (1):
>       watchdog: intel-mid_wdt: Keep watchdog running
>
> Arnd Bergmann (1):
>       watchdog: orion: fix compile-test dependencies
>
> Chris Brandt (2):
>       watchdog: add rza_wdt driver
>       watchdog: renesas-wdt: add support for rza
>
> Eric Anholt (1):
>       watchdog: bcm281xx: Fix use of uninitialized spinlock.
>
> Guenter Roeck (1):
>       watchdog: gpio: Convert to use infrastructure triggered keepalives
>
> Johan Hovold (1):
>       watchdog: pcwd_usb: fix NULL-deref at probe
>
> Krzysztof Kozlowski (3):
>       watchdog: s3c2410: Constify local structures
>       watchdog: s3c2410: Simplify getting driver data
>       watchdog: s3c2410: Minor code cleanup
>
> Maciej S. Szmigiero (1):
>       watchdog: f71808e_wdt: Add F71868 support
>
> Paolo Bonzini (1):
>       iTCO_wdt: all versions count down twice
>
> Shile Zhang (1):
>       watchdog: wdt_pci: fix build error if SOFTWARE_REBOOT is defined
>
> Steve Twiss (1):
>       Documentation: devicetree: watchdog: da9062/61 watchdog timer bindi=
ng
>
> Tomas Melin (1):
>       watchdog: cadence_wdt: fix timeout setting
>
> Uwe Kleine-K=C3=B6nig (1):
>       watchdog: orion: make license info match the file header
>
> Wei Yongjun (1):
>       watchdog: zx2967: remove redundant dev_err call in zx2967_wdt_probe=
()
>
> Yannick Fertre (2):
>       dt-bindings: watchdog: Document STM32 IWDG bindings
>       drivers: watchdog: Add STM32 IWDG driver
>
>  .../devicetree/bindings/watchdog/da9062-wdt.txt    |  23 ++
>  .../devicetree/bindings/watchdog/renesas-wdt.txt   |   4 +-
>  .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  19 ++
>  Documentation/watchdog/watchdog-parameters.txt     |   2 +-
>  drivers/watchdog/Kconfig                           |  29 ++-
>  drivers/watchdog/Makefile                          |   2 +
>  drivers/watchdog/bcm_kona_wdt.c                    |   3 +-
>  drivers/watchdog/cadence_wdt.c                     |   2 +-
>  drivers/watchdog/f71808e_wdt.c                     |  27 ++-
>  drivers/watchdog/gpio_wdt.c                        |  73 ++----
>  drivers/watchdog/iTCO_wdt.c                        |  22 +-
>  drivers/watchdog/intel-mid_wdt.c                   |  17 +-
>  drivers/watchdog/orion_wdt.c                       |   2 +-
>  drivers/watchdog/pcwd_usb.c                        |   3 +
>  drivers/watchdog/rza_wdt.c                         | 199 +++++++++++++++=
+
>  drivers/watchdog/s3c2410_wdt.c                     |  58 +++--
>  drivers/watchdog/sama5d4_wdt.c                     |  96 +++++---
>  drivers/watchdog/stm32_iwdg.c                      | 253 +++++++++++++++=
++++++
>  drivers/watchdog/wdt_pci.c                         |   2 +-
>  drivers/watchdog/zx2967_wdt.c                      |   4 +-
>  20 files changed, 686 insertions(+), 154 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt=
.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/st,stm32-i=
wdg.txt
>  create mode 100644 drivers/watchdog/rza_wdt.c
>  create mode 100644 drivers/watchdog/stm32_iwdg.c

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
