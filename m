Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF95C35273
	for <linux-watchdog@archiver.kernel.org>; Fri, 18 Dec 2020 17:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C456D23B70
	for <linux-watchdog@archiver.kernel.org>; Fri, 18 Dec 2020 17:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgLRRib (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 18 Dec 2020 12:38:31 -0500
Received: from www.zeus03.de ([194.117.254.33]:35636 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbgLRRiT (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 18 Dec 2020 12:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=kk4glNSs1SM1Gf
        XglI+JXECfzcYWZ8e1yzurd6rIGbo=; b=unMH8bNVe1M+SVyvga9p7RbIF81Z1j
        7Vr2bhIV+UgFcQRzDh0OtmvEmwqvcJsgSP9OjeNJRDFC3VBmsxa/QuPTrlbsXogN
        zsbsvaH/DN2ZctrO5Dav6rRyVVRRtJbevG37H/rRfvtUrXlj1NZNf/flEVrc7kwY
        8hG4JAzXx38zE=
Received: (qmail 3906687 invoked from network); 18 Dec 2020 18:37:36 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Dec 2020 18:37:36 +0100
X-UD-Smtp-Session: l3s3148p1@sDVhkMC2ZpggAwDPXwIpAOUwDQytQs2L
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: watchdog: renesas,wdt: add r8a779a0 (V3U) support
Date:   Fri, 18 Dec 2020 18:37:26 +0100
Message-Id: <20201218173731.12839-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218173731.12839-1-wsa+renesas@sang-engineering.com>
References: <20201218173731.12839-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Please apply it to the watchdog-tree.

 Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index 6933005b52bd..ab66d3f0c476 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -50,6 +50,7 @@ properties:
               - renesas,r8a77980-wdt     # R-Car V3H
               - renesas,r8a77990-wdt     # R-Car E3
               - renesas,r8a77995-wdt     # R-Car D3
+              - renesas,r8a779a0-wdt     # R-Car V3U
           - const: renesas,rcar-gen3-wdt # R-Car Gen3 and RZ/G2
 
   reg:
-- 
2.29.2

