Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57719 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbbKIHcR (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 Nov 2015 02:32:17 -0500
From: fu.wei@linaro.org
To: linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: tekkamanninja@gmail.com, arnd@arndb.de, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
	catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
	dyoung@redhat.com, panand@redhat.com,
	Suravee.Suthikulpanit@amd.com, robherring2@gmail.com,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v9 1/5] Documentation: add sbsa-gwdt driver documentation
Date: Mon,  9 Nov 2015 15:31:15 +0800
Message-Id: <1447054279-12470-2-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1447054279-12470-1-git-send-email-fu.wei@linaro.org>
References: <1447054279-12470-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

The sbsa-gwdt.txt documentation in devicetree/bindings/watchdog is for
introducing SBSA(Server Base System Architecture) Generic Watchdog
device node info into FDT.

Also add sbsa-gwdt introduction in watchdog-parameters.txt

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 .../devicetree/bindings/watchdog/sbsa-gwdt.txt     | 34 ++++++++++++++++++++++
 Documentation/watchdog/watchdog-parameters.txt     |  6 ++++
 2 files changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
new file mode 100644
index 0000000..2da63db
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
@@ -0,0 +1,34 @@
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
+- timeout-sec: Watchdog timeout and pre-timeout values.
+  If used, at least first timeout value (in seconds) must be provided.
+  A second optional value (in seconds) may also be provided and
+  will be used as the pre-timeout value, if it is given.
+
+Example for FVP Foundation Model v8:
+
+watchdog@2a440000 {
+	compatible = "arm,sbsa-gwdt";
+	reg = <0x0 0x2a440000 0 0x1000>,
+	      <0x0 0x2a450000 0 0x1000>;
+	interrupts = <0 27 4>;
+	timeout-sec = <60 30>;
+};
diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 9f9ec9f..e62c8c4 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -284,6 +284,12 @@ sbc_fitpc2_wdt:
 margin: Watchdog margin in seconds (default 60s)
 nowayout: Watchdog cannot be stopped once started
 -------------------------------------------------
+sbsa_gwdt:
+timeout: Watchdog timeout in seconds. (default 60s)
+pretimeout: Watchdog pretimeout in seconds. (default 30s)
+nowayout: Watchdog cannot be stopped once started
+	(default=kernel config parameter)
+-------------------------------------------------
 sc1200wdt:
 isapnp: When set to 0 driver ISA PnP support will be disabled (default=1)
 io: io port
-- 
2.5.0

