Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33883 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753329AbdBDBeq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Feb 2017 20:34:46 -0500
Received: by mail-pf0-f176.google.com with SMTP id e4so9607456pfg.1
        for <linux-watchdog@vger.kernel.org>; Fri, 03 Feb 2017 17:34:45 -0800 (PST)
From: Baoyou Xie <baoyou.xie@linaro.org>
To: jun.nie@linaro.org, wim@iguana.be, linux@roeck-us.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        baoyou.xie@linaro.org, xie.baoyou@zte.com.cn,
        chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
Subject: [PATCH v9 2/3] MAINTAINERS: add zx2967 watchdog controller driver to ARM ZTE architecture
Date: Sat,  4 Feb 2017 09:34:14 +0800
Message-Id: <1486172055-13162-2-git-send-email-baoyou.xie@linaro.org>
In-Reply-To: <1486172055-13162-1-git-send-email-baoyou.xie@linaro.org>
References: <1486172055-13162-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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

