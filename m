Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47974 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484Ab3J3JbA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Oct 2013 05:31:00 -0400
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be
Cc: t.figa@samsung.com, devicetree@vger.kernel.org,
	dianders@chromium.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, sachin.kamat@linaro.org
Subject: [PATCH V4 1/3] ARM: dts: Add pmu sysreg node to Exynos5 dtsi file
Date: Wed, 30 Oct 2013 15:21:11 +0530
Message-id: <1383126673-29033-2-git-send-email-l.krishna@samsung.com>
In-reply-to: <1383126673-29033-1-git-send-email-l.krishna@samsung.com>
References: <1383126673-29033-1-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds pmusysreg node to Exynos5 dtsi file to handle PMU
register accesses in a centralized way using syscon driver

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 arch/arm/boot/dts/exynos5.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index e52b038..918e732 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -106,4 +106,9 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	pmu_sys_reg: pmusysreg@1004000 {
+		compatible = "syscon";
+		reg = <0x10040000 0x5000>;
+	};
 };
-- 
1.7.10.4

