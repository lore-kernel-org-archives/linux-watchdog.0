Return-path: <baoyou.xie@linaro.org>
From: Baoyou Xie <baoyou.xie@linaro.org>
To: jun.nie@linaro.org,
	wim@iguana.be,
	linux@roeck-us.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawnguo@kernel.org,
	baoyou.xie@linaro.org,
	xie.baoyou@zte.com.cn,
	chen.chaokai@zte.com.cn,
	wang.qiang01@zte.com.cn
Subject: [PATCH v3 2/3] MAINTAINERS: add zx2967 watchdog controller driver to ARM ZTE architecture
Date: Fri, 20 Jan 2017 21:03:17 +0800
Message-Id: <1484917398-15604-2-git-send-email-baoyou.xie@linaro.org>
In-Reply-To: <1484917398-15604-1-git-send-email-baoyou.xie@linaro.org>
References: <1484917398-15604-1-git-send-email-baoyou.xie@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

Add the zx2967 watchdog controller driver as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index edfdea3..275c434 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1990,11 +1990,13 @@ F:	drivers/clk/zte/
 F:	drivers/reset/reset-zx2967.c
 F:	drivers/soc/zte/
 F:	drivers/thermal/zx*
+F:	drivers/watchdog/zx2967_wdt.c
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
 F:	Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
 F:	Documentation/devicetree/bindings/soc/zte/
 F:	Documentation/devicetree/bindings/thermal/zx*
+F:	Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
 F:	include/dt-bindings/soc/zx*.h
 
 ARM/ZYNQ ARCHITECTURE
-- 
2.7.4
