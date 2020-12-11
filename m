Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB8EC2BBCD
	for <linux-watchdog@archiver.kernel.org>; Fri, 11 Dec 2020 01:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C14223C18
	for <linux-watchdog@archiver.kernel.org>; Fri, 11 Dec 2020 01:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404595AbgLKBWf (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 10 Dec 2020 20:22:35 -0500
Received: from foss.arm.com ([217.140.110.172]:49882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394793AbgLKBWV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 10 Dec 2020 20:22:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0858F152D;
        Thu, 10 Dec 2020 17:20:33 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 583903F66B;
        Thu, 10 Dec 2020 17:20:30 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.xyz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 16/21] dt-bindings: watchdog: sun4i: Add A100 compatible
Date:   Fri, 11 Dec 2020 01:19:29 +0000
Message-Id: <20201211011934.6171-17-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20201211011934.6171-1-andre.przywara@arm.com>
References: <20201211011934.6171-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Add a binding for A100's watchdog controller.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml  | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
index e8f226376108..5ac607de8be4 100644
--- a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
@@ -21,6 +21,9 @@ properties:
       - items:
           - const: allwinner,sun50i-a64-wdt
           - const: allwinner,sun6i-a31-wdt
+      - items:
+          - const: allwinner,sun50i-a100-wdt
+          - const: allwinner,sun6i-a31-wdt
       - items:
           - const: allwinner,sun50i-h6-wdt
           - const: allwinner,sun6i-a31-wdt
-- 
2.17.5

