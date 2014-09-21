Return-path: <wens@mirror2.csie.ntu.edu.tw>
From: Chen-Yu Tsai <wens@csie.org>
To: Wim Van Sebroeck <wim@iguana.be>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] watchdog: sunxi: Add A31 watchdog support
Date: Mon, 22 Sep 2014 00:05:17 +0800
Message-Id: <1411315519-26257-1-git-send-email-wens@csie.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

This is v2 of the Allwinner A31 watchdog support series. This series adds
support for the watchdog hardware found in Allwinner A31 and later SoCs.
These new chips have multiple watchdogs, with separate interrupt lines
and registers, but the basic layout and operation is the same. This series
is based on Guenter's restart handler series.

Patch 1 prepares the sunxi-wdt driver for varying register offsets tied to
compatible strings. Various ioread32/iowrite32 calls have been replaced with
readl/writel as well.

Patch 2 adds the sun6i compatible string with accompanying register offset
data.

I tested this series on my Cubieboard (sun4i) and A23 tablet (sun8i), which
has the same watchdog hardware as the A31 (sun6i). This covers the 2 classes
of hardware supported.

After this series is merged, we can remove the power/reset driver for sun6i.


Changes since v1:
  - Mention replacing ioread32/iowrite32 calls in patch 1 commit message.


Cheers
ChenYu


Chen-Yu Tsai (2):
  watchdog: sunxi: support parameterized compatible strings
  watchdog: sunxi: Add A31 watchdog support

 drivers/watchdog/sunxi_wdt.c | 111 +++++++++++++++++++++++++++++++++----------
 1 file changed, 86 insertions(+), 25 deletions(-)

-- 
2.1.0
