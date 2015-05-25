Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35073 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbbEYKHt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 25 May 2015 06:07:49 -0400
Received: by pacwv17 with SMTP id wv17so68417228pac.2
        for <linux-watchdog@vger.kernel.org>; Mon, 25 May 2015 03:07:49 -0700 (PDT)
From: fu.wei@linaro.org
To: Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org, timur@codeaurora.org,
	ashwin.chaugule@linaro.org, arnd@arndb.de, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
	catalin.marinas@arm.com, will.deacon@arm.com,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v3 3/6] ARM64: add SBSA Generic Watchdog device node in amd-seattle-soc.dtsi
Date: Mon, 25 May 2015 18:03:10 +0800
Message-Id: <1432548193-19569-4-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1432548193-19569-1-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
 <1432548193-19569-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This can be a example of adding SBSA Generic Watchdog device node
into some dts files for the Soc which contains SBSA Generic Watchdog.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index 2874d92..95994eb 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -84,6 +84,17 @@
 			clock-names = "uartclk", "apb_pclk";
 		};
 
+		watchdog0: watchdog@e0bb0000 {
+			compatible = "arm,sbsa-gwdt";
+			reg = <0x0 0xe0bb0000 0 0x10000>,
+				<0x0 0xe0bc0000 0 0x10000>;
+			reg-names = "refresh",
+				"control";
+			interrupts = <0 337 4>;
+			interrupt-names = "ws0";
+			timeout-sec = <10 5>;
+		};
+
 		spi0: ssp@e1020000 {
 			status = "disabled";
 			compatible = "arm,pl022", "arm,primecell";
-- 
1.9.1

