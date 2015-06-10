Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35605 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269AbbFJNnZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 10 Jun 2015 09:43:25 -0400
Received: by pacyx8 with SMTP id yx8so35320276pac.2
        for <linux-watchdog@vger.kernel.org>; Wed, 10 Jun 2015 06:43:25 -0700 (PDT)
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
Subject: [PATCH v5 3/8] ARM64: add SBSA Generic Watchdog device node in amd-seattle-soc.dtsi
Date: Wed, 10 Jun 2015 21:41:48 +0800
Message-Id: <1433943713-32466-4-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1433943713-32466-1-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
 <1433943713-32466-1-git-send-email-fu.wei@linaro.org>
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

