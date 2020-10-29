Return-Path: <SRS0=q9YU=EE=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D86EC2D0A3
	for <linux-watchdog@archiver.kernel.org>; Thu, 29 Oct 2020 16:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0266B20FC3
	for <linux-watchdog@archiver.kernel.org>; Thu, 29 Oct 2020 16:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603988572;
	bh=ZQl6PwB8eYHHaSUd4Ly+rkyj1Ds05w1/MvOZFY01+tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZbZQweQrj3IsYXy3JHFlfUfxVbqY6sBJlIvg2fuy7Cd7JTiTzW3ukJYfIyu/sLMem
	 pqCeUCG2cpXa8RxZHDpNNL2mstHND9jAcTkswcXRwWqfcvNyYi3CXxjFC3wPHU5R1/
	 hs1wb/eYV6Q6Bmgk4IHlRB/wS4XA2sAR3EN/shAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgJ2QWh (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:22:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgJ2QWg (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 29 Oct 2020 12:22:36 -0400
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E14420790;
        Thu, 29 Oct 2020 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603988504;
        bh=ZQl6PwB8eYHHaSUd4Ly+rkyj1Ds05w1/MvOZFY01+tI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dWim0MDONb1LcpzbZAtSdDBHCinv4taJds8d5+eZYro+kp0EGRaqvSl1u5Mg9MOFe
         FHax7egJRxwhHrf/IQ+wdDuKFL4HGId1r7jfGP51g84gHBl01nyy+Yht+BAyNx2qLA
         UWCvXYtbi4zELbc5BRLIAopIgEaMWGI3NwX6APVw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 2/2] ARM: dts: freescale: align watchdog node name with dtschema
Date:   Thu, 29 Oct 2020 17:21:33 +0100
Message-Id: <20201029162133.81016-2-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201029162133.81016-1-krzk@kernel.org>
References: <20201029162133.81016-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

The dtschema expects watchdog device node name to be "watchdog":

  arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dt.yaml: wdog@2ad0000:
    $nodename:0: 'wdog@2ad0000' does not match '^watchdog(@.*|-[0-9a-f])?$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 6a2c09199047..1393fc7e56bb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -401,7 +401,7 @@ gpio1: gpio@2310000 {
 			#interrupt-cells = <2>;
 		};
 
-		wdog0: wdog@2ad0000 {
+		wdog0: watchdog@2ad0000 {
 			compatible = "fsl,ls1012a-wdt",
 				     "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 0464b8aa4bc4..d550f00f1f6a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -725,7 +725,7 @@ lpuart5: serial@29a0000 {
 			status = "disabled";
 		};
 
-		wdog0: wdog@2ad0000 {
+		wdog0: watchdog@2ad0000 {
 			compatible = "fsl,ls1043a-wdt", "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
 			interrupts = <0 83 0x4>;
-- 
2.25.1

