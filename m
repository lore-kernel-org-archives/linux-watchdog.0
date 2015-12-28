Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42217 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbbL1PXh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Dec 2015 10:23:37 -0500
Date: Mon, 28 Dec 2015 07:23:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: Additional patches in my watchdog-next branch
Message-ID: <20151228152335.GA18627@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

I have a number of patches pending in my watchdog-next branch which are=
 not
in your watchdog-next repository. Below is a summary, rebased onto your
repository. This does not include the patches I had submitted.

Please consider those patches for v4.5.

Thanks,
Guenter

---

The following changes since commit 62e21f5d90f162208e43b8a248b01e1a4a24=
ecbd:

  watchdog: cadence_wdt: use to_platform_device() (2015-12-27 21:15:34 =
+0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.gi=
t=20

for you to fetch changes up to dffb1339276a535f54497a4d1520118a5e04fbc6=
:

  watchdog: atlas7: add watchdog driver of CSRatlas7 (2015-12-27 15:08:=
50 -0800)

----------------------------------------------------------------
Carlo Caione (2):
      watchdog: meson: Enable meson SoC specific data
      watchdog: meson: Add meson8b SoC specific data

Damien Riegel (1):
      watchdog: ts4800: add driver for TS-4800 watchdog

Guo Zeng (1):
      watchdog: atlas7: add watchdog driver of CSRatlas7

Mans Rullgard (1):
      watchdog: add support for Sigma Designs SMP86xx/SMP87xx

Martyn Welch (2):
      Add binding documentation for Zodiac Watchdog Timer
      watchdog: Zodiac Aerospace RAVE Switch Watchdog Processor Driver

M=C3=A5ns Rullg=C3=A5rd (1):
      devicetree: watchdog: add binding for Sigma Designs SMP8642 watch=
dog

Oleksij Rempel (2):
      watchdog: add Alphascale asm9260-wdt driver
      DT: watchdog: add Alphascale asm9260 watchdog binding documentati=
on.

 .../bindings/watchdog/alphascale-asm9260.txt       |  35 ++
 .../bindings/watchdog/sigma,smp8642-wdt.txt        |  18 +
 .../devicetree/bindings/watchdog/ts4800-wdt.txt    |  25 ++
 .../devicetree/bindings/watchdog/ziirave-wdt.txt   |  19 +
 drivers/watchdog/Kconfig                           |  51 +++
 drivers/watchdog/Makefile                          |   5 +
 drivers/watchdog/asm9260_wdt.c                     | 403 +++++++++++++=
++++++++
 drivers/watchdog/atlas7_wdt.c                      | 242 +++++++++++++
 drivers/watchdog/meson_wdt.c                       |  65 +++-
 drivers/watchdog/tangox_wdt.c                      | 225 ++++++++++++
 drivers/watchdog/ts4800_wdt.c                      | 215 +++++++++++
 drivers/watchdog/ziirave_wdt.c                     | 381 +++++++++++++=
++++++
 12 files changed, 1667 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/alphasca=
le-asm9260.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/sigma,sm=
p8642-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-w=
dt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/ziirave-=
wdt.txt
 create mode 100644 drivers/watchdog/asm9260_wdt.c
 create mode 100644 drivers/watchdog/atlas7_wdt.c
 create mode 100644 drivers/watchdog/tangox_wdt.c
 create mode 100644 drivers/watchdog/ts4800_wdt.c
 create mode 100644 drivers/watchdog/ziirave_wdt.c
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
