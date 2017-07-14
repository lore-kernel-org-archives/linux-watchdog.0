Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:54678 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdGNUcZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Jul 2017 16:32:25 -0400
From: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@savoirfairelinux.com, robh@kernel.org, linux@roeck-us.net,
        linus.walleij@linaro.org, shawnguo@kernel.org
Cc: fabio.estevam@nxp.com, mark@embeddedarm.com, kris@embeddedarm.com,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Subject: [PATCH v5 1/8] of: documentation: add bindings documentation for TS-4600
Date: Fri, 14 Jul 2017 16:32:11 -0400
Message-Id: <20170714203218.14409-2-sebastien.bourdelin@savoirfairelinux.com>
In-Reply-To: <20170714203218.14409-1-sebastien.bourdelin@savoirfairelinux.com>
References: <20170714203218.14409-1-sebastien.bourdelin@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This adds the documentation for the TS-4600 by Technologic Systems.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
---
Changes v4 -> v5:
  - fix missing signed off

Changes v3 -> v4:
  - rebase on master

Changes v2 -> v3:
  - rebase on master

Changes v1 -> v2:
  - rebase on master
  - add ack by Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/technologic.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/technologic.txt b/Documentation/devicetree/bindings/arm/technologic.txt
index 33797acad846..e9d6d6575566 100644
--- a/Documentation/devicetree/bindings/arm/technologic.txt
+++ b/Documentation/devicetree/bindings/arm/technologic.txt
@@ -1,6 +1,11 @@
 Technologic Systems Platforms Device Tree Bindings
 --------------------------------------------------
 
+TS-4600 is a System-on-Module based on the Freescale i.MX28 System-on-Chip.
+It can be mounted on a carrier board providing additional peripheral connectors.
+Required root node properties:
+	- compatible = "technologic,imx28-ts4600", "fsl,imx28"
+
 TS-4800 board
 Required root node properties:
 	- compatible = "technologic,imx51-ts4800", "fsl,imx51";
-- 
2.13.0

