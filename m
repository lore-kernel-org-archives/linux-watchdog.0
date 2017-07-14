Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:54814 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdGNUc1 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Jul 2017 16:32:27 -0400
From: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@savoirfairelinux.com, robh@kernel.org, linux@roeck-us.net,
        linus.walleij@linaro.org, shawnguo@kernel.org
Cc: fabio.estevam@nxp.com, mark@embeddedarm.com, kris@embeddedarm.com,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Subject: [PATCH v5 8/8] ARM: dts: TS-4600: add watchdog support
Date: Fri, 14 Jul 2017 16:32:18 -0400
Message-Id: <20170714203218.14409-9-sebastien.bourdelin@savoirfairelinux.com>
In-Reply-To: <20170714203218.14409-1-sebastien.bourdelin@savoirfairelinux.com>
References: <20170714203218.14409-1-sebastien.bourdelin@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This enables support for the watchdog located in the FPGA.

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
---
Changes v4 -> v5:
  - fix missing signed off
---
 arch/arm/boot/dts/imx28-ts4600-common.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-ts4600-common.dtsi b/arch/arm/boot/dts/imx28-ts4600-common.dtsi
index a90bd934e4a3..9e177d33ba9c 100644
--- a/arch/arm/boot/dts/imx28-ts4600-common.dtsi
+++ b/arch/arm/boot/dts/imx28-ts4600-common.dtsi
@@ -116,6 +116,11 @@
 		ts,strobe-gpios = <&gpio0 25 GPIO_ACTIVE_HIGH>;
 		ts,ale-gpios    = <&gpio0 26 GPIO_ACTIVE_HIGH>;
 		ts,rdy-gpios    = <&gpio0 21 GPIO_ACTIVE_HIGH>;
+
+		watchdog@2a {
+			compatible = "technologic,ts4600-wdt";
+			reg = <0x2a>;
+		};
 	};
 
 };
-- 
2.13.0

