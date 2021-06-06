Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3F0C4743D
	for <linux-watchdog@archiver.kernel.org>; Sun,  6 Jun 2021 12:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96D4608FE
	for <linux-watchdog@archiver.kernel.org>; Sun,  6 Jun 2021 12:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhFFMSu (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 6 Jun 2021 08:18:50 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:49267 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhFFMSt (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 6 Jun 2021 08:18:49 -0400
Received: from localhost.localdomain ([37.4.249.157]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MrhHm-1l2AsP35e8-00ngV6; Sun, 06 Jun 2021 14:16:33 +0200
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
Subject: [PATCH V2 1/7] ARM: dts: bcm283x: Fix up MMC node names
Date:   Sun,  6 Jun 2021 14:16:11 +0200
Message-Id: <1622981777-5023-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622981777-5023-1-git-send-email-stefan.wahren@i2se.com>
References: <1622981777-5023-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:Z/8QOVZ2cHa4lrvfJQqghM920G55e/tsw2Kl4Gl3CPhqRzxY/3Q
 pT8KAXiiYtiG2LFpO056LY5tzxOi+Gl7HNwVXnCr+Uls5Fn7P4AA8tzcENmameXpJB0f9It
 8CH8xbxBjWLR5DpsYYCYLmH1B5T/npNc7UitcUViH5+GE/J+7E9mdNSn0WFUl1ASkuRaqAE
 ggvIa84w6NiZwRifXy9Sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JGozPp/tc2Y=:4TCkNj3rNqgSZbnKTrYoqP
 l1TepbDJDswV1l8Zp+ZeCLvGoYDTNt7cbcn/4aRectbcMXGtVbUa4BGolWhSQXyRXXF82jtfq
 WV7YYFnDSSPbxeS2Nb72G0gCb4p8y7Jhrn3OEmf9u0ioh1eJf0Qmc/e8F6dKFSGp8piXCrUDs
 V3ujKZDCWp3yRArZVwUJNGZYlmy6ASPsPdqFJVmSd0lFkl3rxbQULHxQLpJNwYu6h2Cs22aoQ
 vn2iVIvozWRyxj6rjV8yOvTeYtljiYkCQo7OFxC3jGL4z2thwaTbJwBCfiFCiEZMSE4lrE/Ym
 tknNkOdEI9gIh67xgYU2gX4FVuS1YmLzHlzM4S+ux++MtXvYaWsbMzMnTRNDEn0F46KP2rT8n
 L6yQC6wlLaFjrYdbEfsc2PZjeNPEuzL+FPoD/TNtgjp4m3pTgsOD0q1HJzN7QBFwJRqEG4FPM
 BaFNC8FdQobzUHTdhm421SGhsKQ1iN+JbUfHn7Og7L9xpZtZJ25GdM+HxxQ0bp+KsjDCoHC+J
 ztsPy592xs8odkDq9tJffA=
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Fix the node names for the MMC/SD card controller to conform
to the standard node name mmc@..

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
---
 arch/arm/boot/dts/bcm2711.dtsi | 2 +-
 arch/arm/boot/dts/bcm283x.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 720beec..d872064 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -413,7 +413,7 @@
 		ranges = <0x0 0x7e000000  0x0 0xfe000000  0x01800000>;
 		dma-ranges = <0x0 0xc0000000  0x0 0x00000000  0x40000000>;
 
-		emmc2: emmc2@7e340000 {
+		emmc2: mmc@7e340000 {
 			compatible = "brcm,bcm2711-emmc2";
 			reg = <0x0 0x7e340000 0x100>;
 			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index b83a864..0f3be55 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -420,7 +420,7 @@
 			status = "disabled";
 		};
 
-		sdhci: sdhci@7e300000 {
+		sdhci: mmc@7e300000 {
 			compatible = "brcm,bcm2835-sdhci";
 			reg = <0x7e300000 0x100>;
 			interrupts = <2 30>;
-- 
2.7.4

