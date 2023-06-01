Return-Path: <linux-watchdog-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CCDC77B7E
	for <linux-watchdog@archiver.kernel.org>; Thu,  1 Jun 2023 05:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjFAFrj (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 1 Jun 2023 01:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjFAFqy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Jun 2023 01:46:54 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35E710C4;
        Wed, 31 May 2023 22:46:24 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id 15877463C8;
        Thu,  1 Jun 2023 08:46:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pjGDMhnDduQ0-singxOus;
        Thu, 01 Jun 2023 08:46:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685598380;
        bh=rKLeo/d/8Wk8XKAwLVEqsT3NI7ElKFwC7e7Tg4clcm8=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=ckC3R7ZkEWFOO9/o9sMo2setllhfgcsZnGTp8OrocGoUBkZJd94PGDdmjzI3VS2Ox
         KxFNdtpylDHvWGl0mAX5IW0JQG6Hoh9TxmVUk5XbGVR9byBmECYMSmS+g7lzGUqjLv
         uZ/2BO0NXD0aERg9PVuHshMwoZmhmV9BkELe5oho=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 31/43] dt-bindings: wdt: Add ts72xx
Date:   Thu,  1 Jun 2023 08:45:36 +0300
Message-Id: <20230601054549.10843-13-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Add DT binding for Technologic Systems TS-72xx watchdog.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    v0 -> v1:
    
    - changed maintainers
    
    Krzysztof Kozlowski:
    - renamed file
    - dropped quotes
    - added description for reg
    - dropped label
    - use fallback compatible and list all possible compatibles

 .../watchdog/technologic,ts7200-wdt.yaml      | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/technologic,ts7200-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/technologic,ts7200-wdt.yaml b/Documentation/devicetree/bindings/watchdog/technologic,ts7200-wdt.yaml
new file mode 100644
index 000000000000..4f7f004ffdd3
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/technologic,ts7200-wdt.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/technologic,ts7200-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Technologic Systems TS-72xx based SBCs watchdog
+
+maintainers:
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: technologic,ts7200-wdt
+      - items:
+          - enum:
+              - technologic,ts7300-wdt
+              - technologic,ts7260-wdt
+              - technologic,ts7250-wdt
+          - const: technologic,ts7200-wdt
+
+  reg:
+    items:
+      - description: control register
+      - description: feed register
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog@23800000 {
+      compatible = "technologic,ts7200-wdt";
+      reg = <0x23800000 0x01>, <0x23c00000 0x01>;
+      timeout-sec = <30>;
+    };
+
+...
+
-- 
2.37.4

