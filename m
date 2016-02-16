Return-path: <fu.wei@linaro.org>
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
        graeme.gregory@linaro.org, al.stone@linaro.org, hanjun.guo@linaro.org,
        jcm@redhat.com, arnd@arndb.de, leo.duran@amd.com, sudeep.holla@arm.com,
        Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v13 3/4] ARM64: add SBSA Generic Watchdog device node in amd-seattle-soc.dtsi
Date: Wed, 17 Feb 2016 01:08:49 +0800
Message-Id: <1455642530-19103-4-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1455642530-19103-1-git-send-email-fu.wei@linaro.org>
References: <1455642530-19103-1-git-send-email-fu.wei@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

From: Fu Wei <fu.wei@linaro.org>

This can be a example of adding SBSA Generic Watchdog device node
into some dts files for the Soc which contains SBSA Generic Watchdog.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index 2874d92..0a8ca1d 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -84,6 +84,14 @@
 			clock-names = "uartclk", "apb_pclk";
 		};
 
+		watchdog0: watchdog@e0bb0000 {
+			compatible = "arm,sbsa-gwdt";
+			reg = <0x0 0xe0bc0000 0 0x1000>,
+				<0x0 0xe0bb0000 0 0x1000>;
+			interrupts = <0 337 4>;
+			timeout-sec = <15>;
+		};
+
 		spi0: ssp@e1020000 {
 			status = "disabled";
 			compatible = "arm,pl022", "arm,primecell";
-- 
2.5.0
