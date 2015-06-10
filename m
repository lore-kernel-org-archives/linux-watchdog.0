Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34681 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933742AbbFJNnH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 10 Jun 2015 09:43:07 -0400
Received: by payr10 with SMTP id r10so35367027pay.1
        for <linux-watchdog@vger.kernel.org>; Wed, 10 Jun 2015 06:43:06 -0700 (PDT)
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
Subject: [PATCH v5 2/8] ARM64: add SBSA Generic Watchdog device node in foundation-v8.dts
Date: Wed, 10 Jun 2015 21:41:47 +0800
Message-Id: <1433943713-32466-3-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1433943713-32466-1-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
 <1433943713-32466-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This can be a example of adding SBSA Generic Watchdog device node
into some dts files for the Soc which contains SBSA Generic Watchdog.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 arch/arm64/boot/dts/arm/foundation-v8.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dts b/arch/arm64/boot/dts/arm/foundation-v8.dts
index 4eac8dc..962a07e 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dts
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dts
@@ -237,4 +237,14 @@
 			};
 		};
 	};
+	watchdog@2a440000 {
+		compatible = "arm,sbsa-gwdt";
+		reg = <0x0 0x2a440000 0 0x10000>,
+			<0x0 0x2a450000 0 0x10000>;
+		reg-names = "control",
+			"refresh";
+		interrupts = <0 27 4>;
+		interrupt-names = "ws0";
+		timeout-sec = <10 5>;
+	};
 };
-- 
1.9.1

