Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34484 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271AbbHXRC2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 24 Aug 2015 13:02:28 -0400
Received: by pdbfa8 with SMTP id fa8so55647957pdb.1
        for <linux-watchdog@vger.kernel.org>; Mon, 24 Aug 2015 10:02:28 -0700 (PDT)
From: fu.wei@linaro.org
To: Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org,
	linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, arnd@arndb.de, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
	catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
	dyoung@redhat.com, panand@redhat.com, Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v7 1/8] Documentation: add sbsa-gwdt.txt documentation
Date: Tue, 25 Aug 2015 01:01:16 +0800
Message-Id: <1440435683-7343-2-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1440435683-7343-1-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
 <1440435683-7343-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

The sbsa-gwdt.txt documentation in devicetree/bindings/watchdog is for
introducing SBSA(Server Base System Architecture) Generic Watchdog
device node info into FDT.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 .../devicetree/bindings/watchdog/sbsa-gwdt.txt     | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
new file mode 100644
index 0000000..8b43640
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
@@ -0,0 +1,32 @@
+* SBSA(Server Base System Architecture) Generic Watchdog
+
+The SBSA Generic Watchdog Timer is used for resetting the system after
+two stages of timeout.
+More details: ARM-DEN-0029 - Server Base System Architecture (SBSA)
+
+Required properties:
+- compatible : Should at least contain "arm,sbsa-gwdt".
+
+- reg : Specifies base physical address of the two register frames
+  and length of memory mapped region, order:
+  1: Watchdog control frame
+  2: Refresh frame.
+
+- interrupts : Should at least contain WS0 interrupt,
+  the WS1 interrupt is optional, order:
+  1: WS0 interrupt
+  2: WS1 interrupt
+
+Optional properties
+- timeout-sec : Watchdog pre-timeout and timeout values (in seconds).
+  The first is timeout values, then pre-timeout.
+
+Example for FVP Foundation Model v8:
+
+watchdog@2a440000 {
+	compatible = "arm,sbsa-gwdt";
+	reg = <0x0 0x2a440000 0 0x1000>,
+	      <0x0 0x2a450000 0 0x1000>;
+	interrupts = <0 27 4>;
+	timeout-sec = <10 5>;
+};
-- 
2.4.3

