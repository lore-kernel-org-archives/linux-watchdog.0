Return-Path: <SRS0=DE07=V5=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D76C433FF
	for <linux-watchdog@archiver.kernel.org>; Thu,  1 Aug 2019 13:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01C32171F
	for <linux-watchdog@archiver.kernel.org>; Thu,  1 Aug 2019 13:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iqTpK417"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfHAN44 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:56:56 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:51003 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730664AbfHAN44 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Aug 2019 09:56:56 -0400
Received: by mail-wm1-f50.google.com with SMTP id v15so64777646wml.0
        for <linux-watchdog@vger.kernel.org>; Thu, 01 Aug 2019 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jQX65Is1Wqm0IPrwb1sLBW/ZNzd7xz+BApuzmHkBw2E=;
        b=iqTpK417HOmjCLppiN1pgsqLIb9hmFuQloL3t5z3tQacHlwVBnyZjq837feg2G8e5l
         hgGomxSa+NJ42noHa95qsb/NJkaC8CtXH+fHXapFJ4fbZus8ScjbmUkX1qDf8lKmaY2D
         Irued+5Zc64kUahQOreQUNK0Cbq0cW7KAgPKbAa3Kf7Ugp4c6c8YiyDD51G51hnaJW9/
         nSHwr/rxIZ5sn8NG78s/VuwSOtPpoZDPa//gy7Dyq3hiyBfrbg7Vg0G4KN8kkM7B4B8q
         SpDl23KDdKS3WmGuZK3WEOcmfmTt/AQ6dTf7Ad/mUF3jBu/cpkL8JP5pwMRPzqma7n0g
         FDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQX65Is1Wqm0IPrwb1sLBW/ZNzd7xz+BApuzmHkBw2E=;
        b=bfCDpIRQBtJKD6rW0Kd4G7QRETnGcAiMahprz+zyk/Yx8vqm0ewADT4PVJoxy/3Nxy
         liTtoUNDQImUpvPt51sj7NjE7yE30Y7Joj9gYKsqKcu2oqaP7P5vZsA0n7WHlnXCsbL1
         yW20Zpxu/SsK8pbUQNtn8SnZodbTpaTfnLFRB0gvPK0toYKQUOUn9ukWro17neimYiBU
         n+/MDSiO+uWpzcIwQoVWDKrXoVJPyILYhseKhjio4/Q7pmSp1IWPNAWt1XCYd58XLZNs
         GmMKJJ9RRXnGIkJpsNaF9kW+zUADuc3XxQe6+buDjCNKCBZICdONk48LUO6WaqzcWRR8
         R38Q==
X-Gm-Message-State: APjAAAWDnp4GkekeUDBcxYiZIkMnxCHG58PyXm4QIabiPYnV9x19qaM6
        yKmiHuTwS/o+XO3a1nvf9CK//A==
X-Google-Smtp-Source: APXvYqzGt2wbFLB67ZHPqMVrxGoErn2xr4WR71TxtiUp8m3r2ThDxZfQes8q9+8MpGjIMYB4CWR0lw==
X-Received: by 2002:a1c:ab06:: with SMTP id u6mr114504816wme.125.1564667814377;
        Thu, 01 Aug 2019 06:56:54 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u6sm69659952wml.9.2019.08.01.06.56.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 06:56:53 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [RFC 9/9] dt-bindings: watchdog: meson-gxbb-wdt: convert to yaml
Date:   Thu,  1 Aug 2019 15:56:44 +0200
Message-Id: <20190801135644.12843-10-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801135644.12843-1-narmstrong@baylibre.com>
References: <20190801135644.12843-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/watchdog/meson-gxbb-wdt.txt      | 16 --------
 .../bindings/watchdog/meson-gxbb-wdt.yaml     | 37 +++++++++++++++++++
 2 files changed, 37 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
deleted file mode 100644
index c7fe36fa739c..000000000000
--- a/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Meson GXBB SoCs Watchdog timer
-
-Required properties:
-
-- compatible : should be "amlogic,meson-gxbb-wdt"
-- reg : Specifies base physical address and size of the registers.
-- clocks : Should be a phandle to the Watchdog clock source, for GXBB the xtal
-	   is the default clock source.
-
-Example:
-
-wdt: watchdog@98d0 {
-	compatible = "amlogic,meson-gxbb-wdt";
-	reg = <0 0x98d0 0x0 0x10>;
-	clocks = <&xtal>;
-};
diff --git a/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.yaml b/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.yaml
new file mode 100644
index 000000000000..111377bb9860
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/meson-gxbb-wdt.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 BayLibre, SAS
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/watchdog/meson-gxbb-wdt.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Meson GXBB SoCs Watchdog timer
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson-gxbb-wdt
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      A phandle to the clock of this PHY
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+examples:
+  - |
+    watchdog@98d0 {
+          compatible = "amlogic,meson-gxbb-wdt";
+          reg = <0x98d0 0x10>;
+          clocks = <&xtal>;
+    };
-- 
2.22.0

