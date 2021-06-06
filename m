Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F981C48BCD
	for <linux-watchdog@archiver.kernel.org>; Sun,  6 Jun 2021 12:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB9A613C7
	for <linux-watchdog@archiver.kernel.org>; Sun,  6 Jun 2021 12:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFFMSv (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 6 Jun 2021 08:18:51 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50527 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhFFMSt (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 6 Jun 2021 08:18:49 -0400
Received: from localhost.localdomain ([37.4.249.157]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MBlpC-1ldicJ2LKG-00C9pI; Sun, 06 Jun 2021 14:16:35 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
List-Id: <soc.lore.kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 4/7] dt-bindings: arm: bcm2835: Add Raspberry Pi 400 to DT schema
Date:   Sun,  6 Jun 2021 14:16:14 +0200
Message-Id: <1622981777-5023-5-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622981777-5023-1-git-send-email-stefan.wahren@i2se.com>
References: <1622981777-5023-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:cVfJsNfHgKU+HrX1Rd1+afRjOiBINazQoXGANvMB0aZbjGuQPLP
 tnJBRpYd6LOnJxUZ+JIbgxx68zrfem/FCkflXR9DGRSr47xAuwXvbhBOrDqqyr2MfIK5Jch
 XsO5Y+x16L1NacsMDCiqSvFjdsaxCU9eBlllAqsIvMqyHb/c12T8ItlBMdW6H3xqtANbTf/
 m4DWBRUBZO9Wjlm6bsq2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mWXsb6CCr94=:ZVJWJtVEi2BqtnJgmRV4bH
 1Jk/5OHS13vu9mlqWJu1kOs2xQ7TIEdpFEwWAskPBmiGK44wRzyfV4jiYCAu1ETfePIY5Tu9M
 xNzn/Y3fCQFYYXLxd0/wwiMwmi9BBwgAQlAQc4Cjl5H4yOhZQsPKYgg9ctUnyFsTj2FyUh9N9
 soPWFTwcTmqZUwlJjU6ti48pETg88qDkjZcd5z/nJjvhZVssIoA5FkMPDEQfsdwdvHW1rYt7l
 ttn12espMb95Y1r1dPjaDRNSlP5iBQowYJRQd43hoMGZgZxgdSvPBDvz1DU+e+cburLkh5K20
 UJKj4vEe9FzOxFTfltEkQY47k4xeqEEcZCuxD3HSFpWmdct4nyWSOb86PAds3SMyumxrWwWvT
 Nm2fM5yI7NVSbpsNU0LZiw64GJO2nHbza1QET7iku8cOZZhNq67wjPXUoTiAM4UjwEwXr3wAK
 10hRXkJNNDsjw7oN2GBvptb+yez942bzL1N7l3jxV4T1M6Z7zx0WspHsmNi10ItJO83/YZzU1
 5aLRamq6ELMrhBztXS72ZY=
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Add new Raspberry Pi 400 to DT schema.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
index 812ae8c..230b80d 100644
--- a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
@@ -18,6 +18,7 @@ properties:
       - description: BCM2711 based Boards
         items:
           - enum:
+              - raspberrypi,400
               - raspberrypi,4-model-b
           - const: brcm,bcm2711
 
-- 
2.7.4

