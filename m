Return-Path: <SRS0=FDC7=DM=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4AAC4363D
	for <linux-watchdog@archiver.kernel.org>; Mon,  5 Oct 2020 02:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0622A207BC
	for <linux-watchdog@archiver.kernel.org>; Mon,  5 Oct 2020 02:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgJECav (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 4 Oct 2020 22:30:51 -0400
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:58638 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgJECav (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 4 Oct 2020 22:30:51 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 0952UJZB030419; Mon, 5 Oct 2020 11:30:19 +0900
X-Iguazu-Qid: 2wHHgduBp73RaYNiTb
X-Iguazu-QSIG: v=2; s=0; t=1601865019; q=2wHHgduBp73RaYNiTb; m=mzVgT+raf7tL2XDhO/z2qyUpv6tU0JCBbql3y2BecF0=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1112) id 0952UHLA013163;
        Mon, 5 Oct 2020 11:30:18 +0900
Received: from enc01.toshiba.co.jp ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 0952UHx1000197;
        Mon, 5 Oct 2020 11:30:17 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 0952UHQW031179;
        Mon, 5 Oct 2020 11:30:17 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/2] watchdog: bindings: Add binding documentation for Toshiba Visconti watchdog device
Date:   Mon,  5 Oct 2020 11:30:11 +0900
X-TSB-HOP: ON
Message-Id: <20201005023012.603026-2-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201005023012.603026-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20201005023012.603026-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Add documentation for the binding of Toshiba Visconti SoC's watchdog.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Reviewed-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../watchdog/toshiba,visconti-wdt.yaml        | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
new file mode 100644
index 000000000000..690e19ce4b87
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 Toshiba Electronic Devices & Storage Corporation
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/watchdog/toshiba,visconti-wdt.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Toshiba Visconti SoCs PIUWDT Watchdog timer
+
+maintainers:
+  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    enum:
+      - toshiba,visconti-wdt
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  timeout-sec: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        wdt_clk: wdt-clk {
+            compatible = "fixed-clock";
+            clock-frequency = <150000000>;
+            #clock-cells = <0>;
+        };
+
+        watchdog@28330000 {
+            compatible = "toshiba,visconti-wdt";
+            reg = <0 0x28330000 0 0x1000>;
+            clocks = <&wdt_clk>;
+            timeout-sec = <20>;
+        };
+    };
-- 
2.27.0

