Return-Path: <SRS0=LoHY=7M=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7239FC433E0
	for <linux-watchdog@archiver.kernel.org>; Sat, 30 May 2020 07:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534A2207DF
	for <linux-watchdog@archiver.kernel.org>; Sat, 30 May 2020 07:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgE3HgW (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 30 May 2020 03:36:22 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:52042 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgE3HgW (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 30 May 2020 03:36:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 33F29803087C;
        Sat, 30 May 2020 07:36:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jdq06Q_cn1cH; Sat, 30 May 2020 10:36:19 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, <linux-mips@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/7] dt-bindings: watchdog: dw-wdt: Support devices with asynch clocks
Date:   Sat, 30 May 2020 10:35:52 +0300
Message-ID: <20200530073557.22661-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200530073557.22661-1-Sergey.Semin@baikalelectronics.ru>
References: <20200530073557.22661-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

DW Watchdog IP core can be synthesised with asynchronous timer/APB
clocks support (WDT_ASYNC_CLK_MODE_ENABLE == 1). In this case
separate clock signals are supposed to be used to feed watchdog timer
and APB interface of the device. Let's update the DW Watchdog DT node
schema so it would support the optional APB3 bus clock specified along
with the mandatory watchdog timer reference clock.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@vger.kernel.org

---

Changelog v2:
- It's a new patch unpinned from the previous one.
---
 .../devicetree/bindings/watchdog/snps,dw-wdt.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
index 4f6944756ab4..5bf6dc6377f3 100644
--- a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
@@ -24,8 +24,16 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 1
     items:
       - description: Watchdog timer reference clock
+      - description: APB3 interface clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: tclk
+      - const: pclk
 
   resets:
     description: Phandle to the DW Watchdog reset lane
-- 
2.26.2

