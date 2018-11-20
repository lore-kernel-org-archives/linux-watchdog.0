Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:52714 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeKUIIV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Nov 2018 03:08:21 -0500
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 4/5] ARM: bcm283x: Extend the WDT DT node out to cover the whole PM block.
Date: Tue, 20 Nov 2018 13:37:01 -0800
Message-Id: <20181120213702.27958-5-eric@anholt.net>
In-Reply-To: <20181120213702.27958-1-eric@anholt.net>
References: <20181120213702.27958-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

It was covering part of the PM block's range, up to the WDT regs.  To
support the rest of the PM block's functionality, we need the full
register range plus the AXI Async Bridge regs for PM sequencing.

This doesn't convert any of the consumers over to the new binding yet,
since we will need to be careful in coordinating our usage of firmware
services that might power domains on and off versus the bcm2835-pm
driver's access of those same domains.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm283x.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 31b29646b14c..bd5be68b4561 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -121,8 +121,16 @@
 		};
 
 		watchdog@7e100000 {
-			compatible = "brcm,bcm2835-pm-wdt";
-			reg = <0x7e100000 0x28>;
+			compatible = "brcm,bcm2835-pm", "brcm,bcm2835-pm-wdt";
+			#power-domain-cells = <1>;
+			#reset-cells = <1>;
+			reg = <0x7e100000 0x114>,
+			      <0x7e00a000 0x24>;
+			clocks = <&clocks BCM2835_CLOCK_V3D>,
+				 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
+				 <&clocks BCM2835_CLOCK_H264>,
+				 <&clocks BCM2835_CLOCK_ISP>;
+			clock-names = "v3d", "peri_image", "h264", "isp";
 		};
 
 		clocks: cprman@7e101000 {
-- 
2.19.1
