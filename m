Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45581 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965048AbcBCRUl (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Feb 2016 12:20:41 -0500
From: fu.wei@linaro.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, wim@iguana.be,
	linux@roeck-us.net, corbet@lwn.net, catalin.marinas@arm.com,
	will.deacon@arm.com, Suravee.Suthikulpanit@amd.com
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
	timur@codeaurora.org, dyoung@redhat.com, panand@redhat.com,
	graeme.gregory@linaro.org, al.stone@linaro.org,
	hanjun.guo@linaro.org, jcm@redhat.com, arnd@arndb.de,
	leo.duran@amd.com, sudeep.holla@arm.com, Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v10 1/5] Documentation: add sbsa-gwdt driver documentation
Date: Thu,  4 Feb 2016 01:18:39 +0800
Message-Id: <1454519923-25230-2-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

The sbsa-gwdt.txt documentation in devicetree/bindings/watchdog is for
introducing SBSA(Server Base System Architecture) Generic Watchdog
device node info into FDT.

Also add sbsa-gwdt introduction in watchdog-parameters.txt

Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 .../devicetree/bindings/watchdog/sbsa-gwdt.txt     | 35 ++++++++++++++++++++++
 Documentation/watchdog/watchdog-parameters.txt     |  5 ++++
 2 files changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
new file mode 100644
index 0000000..73a5d0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
@@ -0,0 +1,35 @@
+* SBSA (Server Base System Architecture) Generic Watchdog
+
+The SBSA Generic Watchdog Timer is used to force a reset of the system
+after two stages of timeout have elapsed.  A detailed definition of the
+watchdog timer can be found in the ARM document: ARM-DEN-0029 - Server
+Base System Architecture (SBSA)
+
+Required properties:
+- compatible: Should at least contain "arm,sbsa-gwdt".
+
+- reg: Each entry specifies the base physical address of a register frame
+  and the length of that frame; currently, two frames must be defined,
+  in this order:
+  1: Watchdog control frame;
+  2: Refresh frame.
+
+- interrupts: Should contain the Watchdog Signal 0 (WS0) SPI (Shared
+  Peripheral Interrupt) number of SBSA Generic Watchdog.
+
+Optional properties
+- timeout-sec: Watchdog timeout values (in seconds).
+
+- status: Indicates the device is not available for use. Should be "okay"
+  or "disabled" for available/unavailable. Default is "okay".
+
+Example for FVP Foundation Model v8:
+
+watchdog@2a440000 {
+	compatible = "arm,sbsa-gwdt";
+	reg = <0x0 0x2a440000 0 0x1000>,
+	      <0x0 0x2a450000 0 0x1000>;
+	interrupts = <0 27 4>;
+	timeout-sec = <30>;
+	status = "okay";
+};
diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 9f9ec9f..300eb4d 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -284,6 +284,11 @@ sbc_fitpc2_wdt:
 margin: Watchdog margin in seconds (default 60s)
 nowayout: Watchdog cannot be stopped once started
 -------------------------------------------------
+sbsa_gwdt:
+timeout: Watchdog timeout in seconds. (default 20s)
+nowayout: Watchdog cannot be stopped once started
+	(default=kernel config parameter)
+-------------------------------------------------
 sc1200wdt:
 isapnp: When set to 0 driver ISA PnP support will be disabled (default=1)
 io: io port
-- 
2.5.0

