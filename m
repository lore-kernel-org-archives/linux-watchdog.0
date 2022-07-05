Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EC7C43334
	for <linux-watchdog@archiver.kernel.org>; Tue,  5 Jul 2022 00:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiGEAKq (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 4 Jul 2022 20:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGEAKp (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 4 Jul 2022 20:10:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554827679;
        Mon,  4 Jul 2022 17:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D46A5617CC;
        Tue,  5 Jul 2022 00:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F723C3411E;
        Tue,  5 Jul 2022 00:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656979844;
        bh=GZXdKDMAyi94zceUrqKEoALCT5a3//6hTpa2tObUO3U=;
        h=From:To:Cc:Subject:Date:From;
        b=k7YOU1K4x82eEDkkeGHZhkXb8G+rEx4IzH3e8hIuYfBamCcpWrtk14Tuw2kBIPK76
         3BbSZA44l3Qv//AgrOaGIPBokdCzzDJXKI8pP4G1ROdgkFbpELmEMZoZj98uwZip6R
         pSVo8BNNd0zysUDd8yVE/QepF0N35vjOaLSwr0kzTR69g/GGnatauULax1XZHaJ7dJ
         aoary8r2/08bFNkREfLwITFPdFh0eKc2KFgPJTGTXHWdOm0861vXdzXoJBmvfOozYJ
         p30LCl+MnLdnj9HX+3hqNhiKiYCx4hs9Z3J67T1tFCkcJXXBpFKLAb/fpp0+H2uLNH
         baLBeoJ1rbSKQ==
Received: by pali.im (Postfix)
        id 7C05979F; Tue,  5 Jul 2022 02:10:41 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: watchdog: max63xx: Add GPIO binding
Date:   Tue,  5 Jul 2022 02:10:22 +0200
Message-Id: <20220705001023.14660-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

GPIO is optional and used for WDI logic.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
Changes in v3:
* Extend description
---
 Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
index ab9641e845db..a0cf9e6c371d 100644
--- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
+++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
@@ -27,6 +27,10 @@ properties:
     description: This is a 1-byte memory-mapped address
     maxItems: 1
 
+  gpios:
+    description: Optional GPIO used for controlling WDI (watchdog input) when WDI bit is not mapped to memory
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.20.1

