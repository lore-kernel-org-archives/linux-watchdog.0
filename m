Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:9315 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbbBCK0H (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Feb 2015 05:26:07 -0500
From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To: <wim@iguana.be>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <Zubair.Kakakhel@imgtec.com>,
	<paul@crapouillou.net>
Subject: [PATCH_V3 0/2] watchdog: jz4740: Add DT support
Date: Tue, 3 Feb 2015 10:25:46 +0000
Message-ID: <1422959148-38075-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

Here are two simple patches that add DT support to the jz4740 watchdog driver.

Patches are based on 3.19-rc7. Quite disjoint and stay within jz4740
so should apply easily on other trees.

If you would like to have them rebased to a different tree, please tell.

V3 Changed
Added Reviewed-by: Guenter Roeck <linux@roeck-us.net> 
Typo in commit message.
Rebased to rc7

V2 Changes
Renamed binding to jz4740 instead of jz47xx
Removed clk bindings. They can be added later when the clock tree is fixed.
Rather than add bindings now and change later.

Added MODULE_DEVICE_TABLE()

Thank-you

ZubairLK

Zubair Lutfullah Kakakhel (2):
  dt: watchdog: Add DT binding documentation for jz4740 watchdog timer
  watchdog: jz4740: Add DT support

 .../devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt      | 12 ++++++++++++
 drivers/watchdog/jz4740_wdt.c                                | 10 ++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt

-- 
1.9.1

