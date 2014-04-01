Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:42446
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751073AbaDAF3l (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Apr 2014 01:29:41 -0400
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <linux@roeck-us.net>, <wim@iguana.be>, <shawn.guo@linaro.org>,
	<linux-watchdog@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv3 0/2] imx2-wdt: Add regmap-mmio support
Date: Tue, 1 Apr 2014 12:46:36 +0800
Message-ID: <1396327598-28535-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


This patches are preparing for Vybird, LS1 and LS2. And on LS1 the IP will
in BE mode.

And this has been test on Vybird.

This patch series is based the following regmap patches:

1, https://patchwork.kernel.org/patch/3896321/   ===> <applied>
   regmap: mmio: add regmap_mmio_{regsize, count}_check. 
   https://patchwork.kernel.org/patch/3896331/   ===> <applied>
   regmap: mmio: Add support for 1/2/8 bytes wide register address.
   https://patchwork.kernel.org/patch/3901021/   ===> <applied>
   regmap: mmio: Add regmap_mmio_regbits_check.


2, The above three and this one are a must.
   https://patchwork.kernel.org/patch/3912671/   ===> <pending>
   regmap: mmio: Fix the bug of 'offset' value parsing.


3, The following ones are not a must, but will make the IMX2
   watchdog driver much simplifier and easy to use.
   https://patchwork.kernel.org/patch/3912401/   ===> <pending>
   regmap: implement LE formatting/parsing for 16/32-bit values.
   https://patchwork.kernel.org/patch/3912751/   ===> <pending>
   regmap: add DT endianness binding support.
   https://patchwork.kernel.org/patch/3912741/   ===> <pending>
   regmap: Add the DT binding documentation for endianness


The above all regmap patches have been test using SAI(32-bit
regmap-mmio), SGTL5000(codec 16-bit regmap-i2c) and IMX2 Watchdog
(16-bit regmap-mmio).


Changes in V3:
- convert to use regmap-mmio API.

Changes in V2:
- Add the detail information in the commit comment.
- 'big-endians' --> 'big-endian'.



Xiubo Li (2):
  watchdog: imx2_wdt: Sort the header files alphabetically
  watchdog: imx2_wdt: convert to use regmap API.

 drivers/watchdog/imx2_wdt.c | 62 +++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 24 deletions(-)

-- 
1.8.4


