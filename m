Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36326 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756632AbbKEVUU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Nov 2015 16:20:20 -0500
Received: by qkcl124 with SMTP id l124so37983046qkc.3
        for <linux-watchdog@vger.kernel.org>; Thu, 05 Nov 2015 13:20:09 -0800 (PST)
From: Akshay Bhat <akshay.bhat@timesys.com>
To: linux-watchdog@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, wim@iguana.be,
	tharvey@gateworks.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, shawnguo@kernel.org,
	kernel@pengutronix.de, linux@arm.linux.org.uk,
	linux-arm-kernel@lists.infradead.org, justin.waters@timesys.com,
	l.stach@pengutronix.de, festevam@gmail.com, sr@denx.de,
	Akshay Bhat <akshay.bhat@timesys.com>
Subject: [PATCH v4 0/2] imx6: Implement external watchdog reset
Date: Thu,  5 Nov 2015 16:19:20 -0500
Message-Id: <1446758362-11702-1-git-send-email-akshay.bhat@timesys.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

[Rebase to next-20151105 and re-sending work done by Tim Harvey]

The IMX6 watchdog supports assertion of a signal (WDOG_B) which
can be pinmux'd to an external pin. This is typically used for boards that
have PMIC's in control of the IMX6 power rails. In fact, failure to use
such an external reset on boards with external PMIC's can result in various
hangs due to the IMX6 not being fully reset [1] as well as the board failing
to reset because its PMIC has not been reset to provide adequate voltate for
the CPU when comming out of reset at 800Mhz when it was at 400Mhz prior to
reset.
 
This adds a new device-tree property 'ext-reset-output' to fsl-imx-wdt in
order to indicate the board has such a reset and to cause the watchdog to be
configured to assert WDOG_B instead of an internal reset both on a
watchdog timeout and in system_restart.
 
The second patch adds the watchdog configuration and pinmux for Gateworks
Ventana boards.
 
[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333689.html

Changes:
v3->v4:
- Rebase and test against linux-next tag next-20151105

History:
v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/347168.html
v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/348761.html
v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/360188.html

Tim Harvey (2):
  watchdog: imx2_wdt: add external reset support via 'ext-reset-output'
    dt prop
  ARM: dts: ventana: Add ext-reset support

 .../devicetree/bindings/watchdog/fsl-imx-wdt.txt     |  2 ++
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi                | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi                | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi                | 13 +++++++++++++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi                | 17 +++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi                | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi                | 12 ++++++++++++
 drivers/watchdog/imx2_wdt.c                          | 20 ++++++++++++++++++--
 8 files changed, 98 insertions(+), 2 deletions(-)

-- 
2.6.2

