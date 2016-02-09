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
Subject: [PATCH v11 2/4] ARM64: add SBSA Generic Watchdog device node in foundation-v8.dts
Date: Wed, 10 Feb 2016 01:00:38 +0800
Message-Id: <1455037240-16192-3-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1455037240-16192-1-git-send-email-fu.wei@linaro.org>
References: <1455037240-16192-1-git-send-email-fu.wei@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

From: Fu Wei <fu.wei@linaro.org>

This can be a example of adding SBSA Generic Watchdog device node
into some dts files for the Soc which contains SBSA Generic Watchdog.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 arch/arm64/boot/dts/arm/foundation-v8.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dts b/arch/arm64/boot/dts/arm/foundation-v8.dts
index 4eac8dc..75da16b 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dts
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dts
@@ -237,4 +237,12 @@
 			};
 		};
 	};
+	watchdog@2a440000 {
+		compatible = "arm,sbsa-gwdt";
+		reg = <0x0 0x2a440000 0 0x1000>,
+			<0x0 0x2a450000 0 0x1000>;
+		interrupts = <0 27 4>;
+		timeout-sec = <30>;
+		status = "okay";
+	};
 };
-- 
2.5.0
