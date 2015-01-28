Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34690 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755855AbbA1Uqk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 28 Jan 2015 15:46:40 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YGXq4-002EBs-JW
	for linux-watchdog@vger.kernel.org; Wed, 28 Jan 2015 18:59:44 +0000
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: [GIT PULL] watchdog updates for Linux 3.20
Date: Wed, 28 Jan 2015 10:59:38 -0800
Message-Id: <1422471578-6925-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Wim,

This is my watchdog pull request for 3.20. The branch is currently based
on v3.19-rc6.

Please consider pulling watchdog updates for Linux 3.20 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.gi=
t watchdog-for-wim-3.20

The tag has been applied on top of the watchdog-next branch. The branch i=
ncludes
a number of patches I collected over the last few months. It does not inc=
lude
all submitted patches; only the ones I reviewed and felt comfortable with=
 are
included. Some may already be in your -next branch.

I reviewed all patches and ran build tests as well as source verification=
 tests
with both smatch and spatch. The branch has been on my Linux repository f=
or a
while, so presumably Fenguang's robot will have built the code as well. T=
he most
recent build results are available at http://server.roeck-us.net:8010/bui=
lders.

If you don't want to apply the entire series, please consider applying wh=
atever
subset you might feel comfortable with.

Thanks,
Guenter
------

The following changes since commit 26bc420b59a38e4e6685a73345a0def461136d=
ce:

  Linux 3.19-rc6 (2015-01-25 20:04:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git =
watchdog-next

for you to fetch changes up to e98f3f4aff1d5f576566abb99f5e0965ccc68d32:

  watchdog: dw_wdt: Try to get a 30 second watchdog by default (2015-01-2=
8 10:51:57 -0800)

----------------------------------------------------------------
Doug Anderson (2):
      watchdog: dw_wdt: pat the watchdog before enabling it
      watchdog: dw_wdt: Try to get a 30 second watchdog by default

Geert Uytterhoeven (1):
      watchdog: da9063: Add restart handler support

Guenter Roeck (1):
      watchdog: w83627hf_wdt: Add support for NCT6791 and NCT6792

John Crispin (2):
      watchdog: rt2880_wdt: minor clean up
      watchdog: add MT7621 watchdog support

Krzysztof Kozlowski (1):
      watchdog: imx2: Constify struct regmap_config and watchdog_ops

Masanari Iida (1):
      watchdog: hpwdt: Fix initialization message in hpwdt.c

Matthias Brugger (2):
      watchdog: Add driver for Mediatek watchdog
      ARM: mediatek: dts: Add bindings for watchdog

Mike Looijmans (1):
      gpio_wdt: Add "always_running" feature to GPIO watchdog

Naidu Tellapati (2):
      watchdog: ImgTec PDC Watchdog Timer Driver
      DT: watchdog: Add ImgTec PDC Watchdog Timer binding documentation

Paolo Teti (1):
      WD: add IT8783 ID

Rafa=C5=82 Mi=C5=82ecki (1):
      watchdog: bcm47xx_wdt.c: add restart handler support

Tony Lindgren (1):
      watchdog: Fix omap watchdogs to enable the magic close bit

 .../devicetree/bindings/watchdog/gpio-wdt.txt      |   5 +
 .../devicetree/bindings/watchdog/imgpdc-wdt.txt    |  19 ++
 .../devicetree/bindings/watchdog/mt7621-wdt.txt    |  12 +
 .../devicetree/bindings/watchdog/mtk-wdt.txt       |  13 +
 drivers/watchdog/Kconfig                           |  30 +++
 drivers/watchdog/Makefile                          |   3 +
 drivers/watchdog/bcm47xx_wdt.c                     |  21 +-
 drivers/watchdog/da9063_wdt.c                      |  32 ++-
 drivers/watchdog/dw_wdt.c                          |  32 ++-
 drivers/watchdog/gpio_wdt.c                        |  37 ++-
 drivers/watchdog/hpwdt.c                           |   2 +-
 drivers/watchdog/imgpdc_wdt.c                      | 289 +++++++++++++++=
++++++
 drivers/watchdog/imx2_wdt.c                        |   4 +-
 drivers/watchdog/it87_wdt.c                        |   6 +-
 drivers/watchdog/mt7621_wdt.c                      | 187 +++++++++++++
 drivers/watchdog/mtk_wdt.c                         | 252 +++++++++++++++=
+++
 drivers/watchdog/omap_wdt.c                        |   2 +-
 drivers/watchdog/retu_wdt.c                        |   2 +-
 drivers/watchdog/rt2880_wdt.c                      |   9 +-
 drivers/watchdog/twl4030_wdt.c                     |   2 +-
 drivers/watchdog/w83627hf_wdt.c                    |  14 +-
 include/linux/bcm47xx_wdt.h                        |   1 +
 22 files changed, 943 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/imgpdc-wdt=
.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/mt7621-wdt=
.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.tx=
t
 create mode 100644 drivers/watchdog/imgpdc_wdt.c
 create mode 100644 drivers/watchdog/mt7621_wdt.c
 create mode 100644 drivers/watchdog/mtk_wdt.c
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
