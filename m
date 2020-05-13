Return-Path: <SRS0=xPb5=63=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6F6C2D0F8
	for <linux-watchdog@archiver.kernel.org>; Wed, 13 May 2020 05:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7767520718
	for <linux-watchdog@archiver.kernel.org>; Wed, 13 May 2020 05:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgEMFm4 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 13 May 2020 01:42:56 -0400
Received: from mx.socionext.com ([202.248.49.38]:59168 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbgEMFm4 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 13 May 2020 01:42:56 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 13 May 2020 14:42:53 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 218601800CF;
        Wed, 13 May 2020 14:42:54 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 13 May 2020 14:42:54 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id AB2C11A12AD;
        Wed, 13 May 2020 14:42:53 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] dt-bindings: watchdog: Convert UniPhier watchdog timer to json-schema
Date:   Wed, 13 May 2020 14:42:25 +0900
Message-Id: <1589348545-22244-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Convert UniPhier watchdog timer binding to DT schema format.

Cc: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/watchdog/socionext,uniphier-wdt.yaml  | 36 ++++++++++++++++++++++
 .../devicetree/bindings/watchdog/uniphier-wdt.txt  | 20 ------------
 2 files changed, 36 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml b/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
new file mode 100644
index 0000000..a059d16
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/socionext,uniphier-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier watchdog timer
+
+maintainers:
+  - Keiji Hayashibara <hayashibara.keiji@socionext.com>
+
+allOf:
+  - $ref: "watchdog.yaml#"
+
+properties:
+  compatible:
+    const: socionext,uniphier-wdt
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    // The UniPhier watchdog should be a subnode of a "syscon" compatible node.
+
+    sysctrl@61840000 {
+        compatible = "socionext,uniphier-ld11-sysctrl",
+                     "simple-mfd", "syscon";
+        reg = <0x61840000 0x10000>;
+
+        watchdog {
+            compatible = "socionext,uniphier-wdt";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt b/Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
deleted file mode 100644
index bf63375..0000000
--- a/Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-UniPhier watchdog timer controller
-
-This UniPhier watchdog timer controller must be under sysctrl node.
-
-Required properties:
-- compatible: should be "socionext,uniphier-wdt"
-
-Example:
-
-	sysctrl@61840000 {
-		compatible = "socionext,uniphier-ld11-sysctrl",
-			     "simple-mfd", "syscon";
-		reg = <0x61840000 0x4000>;
-
-		watchdog {
-			compatible = "socionext,uniphier-wdt";
-		}
-
-		other nodes ...
-	};
-- 
2.7.4

