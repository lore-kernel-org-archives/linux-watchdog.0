Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34059 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbbFBEGM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 2 Jun 2015 00:06:12 -0400
Received: by pdbki1 with SMTP id ki1so123385114pdb.1
        for <linux-watchdog@vger.kernel.org>; Mon, 01 Jun 2015 21:06:11 -0700 (PDT)
From: fu.wei@linaro.org
To: Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org, timur@codeaurora.org,
	ashwin.chaugule@linaro.org, arnd@arndb.de, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
	catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v4 1/7] Documentation: add sbsa-gwdt.txt documentation
Date: Tue,  2 Jun 2015 12:05:01 +0800
Message-Id: <1433217907-928-2-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1433217907-928-1-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
 <1433217907-928-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

The sbsa-gwdt.txt documentation in devicetree/bindings/watchdog is for
introducing SBSA(Server Base System Architecture) Generic Watchdog
device node info into FDT.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 .../devicetree/bindings/watchdog/sbsa-gwdt.txt     | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
new file mode 100644
index 0000000..010e5c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
@@ -0,0 +1,36 @@
+* SBSA(Server Base System Architecture) Generic Watchdog
+
+The SBSA Generic Watchdog Timer is used for resetting the system after
+two stages of timeout.
+More details: ARM-DEN-0029 - Server Base System Architecture (SBSA)
+
+Required properties:
+- compatible : Should at least contain "arm,sbsa-gwdt".
+
+- reg : base physical address of the frames and length of memory mapped region.
+
+- reg-names : Should contain the resource reg names to show the order of
+  the values in "reg".
+  Must include the following entries : "refresh", "control".
+
+- interrupts : Should at least contain WS0 interrupt,
+  the WS1 Signal is optional.
+
+- interrupt-names : Should contain the resource interrupt names.
+  Must include the following entries : "ws0". "ws1" is optional.
+
+Optional properties
+- timeout-sec : Watchdog pre-timeout and timeout values (in seconds).
+	The first is timeout values, then pre-timeout.
+
+Example for FVP Foundation Model v8:
+
+watchdog@2a440000 {
+	compatible = "arm,sbsa-gwdt";
+	reg = <0x0 0x2a440000 0 0x10000>,
+	      <0x0 0x2a450000 0 0x10000>;
+	reg-names = "control", "refresh";
+	interrupts = <0 27 4>;
+	interrupt-names = "ws0";
+	timeout-sec = <10 5>;
+};
-- 
1.9.1

