Return-path: <fu.wei@linaro.org>
From: fu.wei@linaro.org
To: Suravee.Suthikulpanit@amd.com,
	linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: tekkamanninja@gmail.com,
	graeme.gregory@linaro.org,
	al.stone@linaro.org,
	hanjun.guo@linaro.org,
	timur@codeaurora.org,
	ashwin.chaugule@linaro.org,
	arnd@arndb.de,
	linux@roeck-us.net,
	vgandhi@codeaurora.org,
	wim@iguana.be,
	jcm@redhat.com,
	leo.duran@amd.com,
	corbet@lwn.net,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH 1/6] Documentation: add sbsa-gwdt.txt documentation
Date: Fri, 15 May 2015 19:08:05 +0800
Message-Id: <1431688090-2145-2-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1431688090-2145-1-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
 <1431688090-2145-1-git-send-email-fu.wei@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

From: Fu Wei <fu.wei@linaro.org>

The sbsa-gwdt.txt documentation in devicetree/bindings/watchdog is for
introducing SBSA(Server Base System Architecture) Generic Watchdog
device node info into FDT

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 .../devicetree/bindings/watchdog/sbsa-gwdt.txt     | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
new file mode 100644
index 0000000..bd1768d
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
+watchdog@2a450000 {
+	compatible = "arm,sbsa-gwdt";
+	reg = <0x0 0x2a450000 0 0x10000>,
+	      <0x0 0x2a440000 0 0x10000>;
+	reg-names = "refresh", "control";
+	interrupts = <0 27 4>;
+	interrupt-names = "ws0";
+	timeout-sec = <10 5>;
+};
-- 
1.9.1
