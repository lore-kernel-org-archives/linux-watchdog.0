Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50289 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484AbbBUCU6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Feb 2015 21:20:58 -0500
From: Mathieu Olivari <mathieu@codeaurora.org>
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux@arm.linux.org.uk, wim@iguana.be, corbet@lwn.net,
	standby24x7@gmail.com, mathieu@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 3/3] ARM: msm: add watchdog entries to DT timer binding doc
Date: Fri, 20 Feb 2015 18:19:36 -0800
Message-Id: <1424485176-8348-4-git-send-email-mathieu@codeaurora.org>
In-Reply-To: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
References: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog has been reworked to use the same DT node as the timer.
This change is updating the device tree doc accordingly.

Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/msm/timer.txt | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/msm/timer.txt b/Documentation/devicetree/bindings/arm/msm/timer.txt
index 74607b6..5e10c34 100644
--- a/Documentation/devicetree/bindings/arm/msm/timer.txt
+++ b/Documentation/devicetree/bindings/arm/msm/timer.txt
@@ -9,11 +9,17 @@ Properties:
                "qcom,scss-timer" - scorpion subsystem
 
 - interrupts : Interrupts for the debug timer, the first general purpose
-               timer, and optionally a second general purpose timer in that
-               order.
+               timer, and optionally a second general purpose timer, and
+               optionally as well, 2 watchdog interrupts, in that order.
 
 - reg : Specifies the base address of the timer registers.
 
+- clocks: Reference to the parent clocks, one per output clock. The parents
+          must appear in the same order as the clock names.
+
+- clock-names: The name of the clocks as free-form strings. They should be in
+               the same order as the clocks.
+
 - clock-frequency : The frequency of the debug timer and the general purpose
                     timer(s) in Hz in that order.
 
@@ -29,9 +35,13 @@ Example:
                compatible = "qcom,scss-timer", "qcom,msm-timer";
                interrupts = <1 1 0x301>,
                             <1 2 0x301>,
-                            <1 3 0x301>;
+                            <1 3 0x301>,
+                            <1 4 0x301>,
+                            <1 5 0x301>;
                reg = <0x0200a000 0x100>;
                clock-frequency = <19200000>,
                                  <32768>;
+               clocks = <&sleep_clk>;
+               clock-names = "sleep";
                cpu-offset = <0x40000>;
        };
-- 
1.9.1

