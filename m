Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:54766 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbdGNUc1 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Jul 2017 16:32:27 -0400
From: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@savoirfairelinux.com, robh@kernel.org, linux@roeck-us.net,
        linus.walleij@linaro.org, shawnguo@kernel.org
Cc: fabio.estevam@nxp.com, mark@embeddedarm.com, kris@embeddedarm.com,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Subject: [PATCH v5 6/8] dt-bindings: watchdog: add documentation for TS4600 watchdog controller
Date: Fri, 14 Jul 2017 16:32:16 -0400
Message-Id: <20170714203218.14409-7-sebastien.bourdelin@savoirfairelinux.com>
In-Reply-To: <20170714203218.14409-1-sebastien.bourdelin@savoirfairelinux.com>
References: <20170714203218.14409-1-sebastien.bourdelin@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds dt-binding documentation for TS4600 watchdog controller.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
---
Changes v4 -> v5:
  - fix missing signed off

v4:
  - this documentation was previously merged with the watchdog driver
  and had been acked by Rob Herring, no changes have been done since.
---
 .../devicetree/bindings/watchdog/ts4600-wdt.txt          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt b/Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt
new file mode 100644
index 000000000000..7de00ceae341
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/ts4600-wdt.txt
@@ -0,0 +1,16 @@
+TS-4600 Technologic Systems Watchdog
+
+Required properties:
+- compatible: must be "technologic,ts4600-wdt"
+- reg: offset to the FPGA's watchdog register
+
+Optional property:
+- timeout-sec: contains the watchdog timeout in seconds.
+
+Example:
+
+watchdog {
+	compatible = "technologic,ts4600-wdt";
+	reg = <0x2a>;
+	timeout-sec = <10>;
+};
-- 
2.13.0

