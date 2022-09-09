Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632B9C6FA86
	for <linux-watchdog@archiver.kernel.org>; Fri,  9 Sep 2022 09:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiIIJI2 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 9 Sep 2022 05:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiIIJIZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 9 Sep 2022 05:08:25 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2698B98C85
        for <linux-watchdog@vger.kernel.org>; Fri,  9 Sep 2022 02:08:22 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:91db:705e:cfbc:a001])
        by albert.telenet-ops.be with bizsmtp
        id Hl8K2800C0sKggw06l8KF0; Fri, 09 Sep 2022 11:08:20 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oWZzm-004bXI-TZ; Fri, 09 Sep 2022 11:08:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oWZzm-004OW3-Gb; Fri, 09 Sep 2022 11:08:18 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, Thanh Quan <thanh.quan.xn@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: watchdog: renesas-wdt: Add r8a779g0 support
Date:   Fri,  9 Sep 2022 11:08:11 +0200
Message-Id: <e3a246be066d5e9c2231285bc1488fc12866cf5d.1662714387.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Thanh Quan <thanh.quan.xn@renesas.com>

Document support for the Watchdog Timer (WDT) Controller in the Renesas
R-Car V4H (R8A779G0) SoC.

Signed-off-by: Thanh Quan <thanh.quan.xn@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index a8d7dde5271b8f2f..b2647bbaa19ce6c8 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -65,6 +65,7 @@ properties:
           - enum:
               - renesas,r8a779a0-wdt     # R-Car V3U
               - renesas,r8a779f0-wdt     # R-Car S4-8
+              - renesas,r8a779g0-wdt     # R-Car V4H
           - const: renesas,rcar-gen4-wdt # R-Car Gen4
 
   reg:
-- 
2.25.1

