Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36780 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254AbbHXRCi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 24 Aug 2015 13:02:38 -0400
Received: by pdbmi9 with SMTP id mi9so55444706pdb.3
        for <linux-watchdog@vger.kernel.org>; Mon, 24 Aug 2015 10:02:38 -0700 (PDT)
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
Subject: [PATCH v7 2/8] ARM64: add SBSA Generic Watchdog device node in foundation-v8.dts
Date: Tue, 25 Aug 2015 01:01:17 +0800
Message-Id: <1440435683-7343-3-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1440435683-7343-1-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
 <1440435683-7343-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This can be a example of adding SBSA Generic Watchdog device node
into some dts files for the Soc which contains SBSA Generic Watchdog.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 arch/arm64/boot/dts/arm/foundation-v8.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dts b/arch/arm64/boot/dts/arm/foundation-v8.dts
index 4eac8dc..824431f 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dts
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dts
@@ -237,4 +237,11 @@
 			};
 		};
 	};
+	watchdog@2a440000 {
+		compatible = "arm,sbsa-gwdt";
+		reg = <0x0 0x2a440000 0 0x1000>,
+			<0x0 0x2a450000 0 0x1000>;
+		interrupts = <0 27 4>;
+		timeout-sec = <10 5>;
+	};
 };
-- 
2.4.3

