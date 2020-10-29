Return-Path: <SRS0=q9YU=EE=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B857C56201
	for <linux-watchdog@archiver.kernel.org>; Thu, 29 Oct 2020 16:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE956214DB
	for <linux-watchdog@archiver.kernel.org>; Thu, 29 Oct 2020 16:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603988574;
	bh=D0HoGSVDCybatgdLHprF7ihRpv/b7k8buAv4EbT5FRE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xQ2pPXqUWhlDHXsvGxnRGXgT14mbBxY2XVApCPkepDt96/sSe2j5A3ejb9oSHveRP
	 JbeNH0laHFaRSZapKZjIktLlQM7rzUM/awfTLih7Aa26NJ8eQOAbOZ8d2XXMqm9kZp
	 x4O+DTDLyHHIIRF7GPlTzBn+nbA2U+8c6LpBeDg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgJ2QWh (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:22:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgJ2QWg (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 29 Oct 2020 12:22:36 -0400
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1115206FB;
        Thu, 29 Oct 2020 16:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603988500;
        bh=D0HoGSVDCybatgdLHprF7ihRpv/b7k8buAv4EbT5FRE=;
        h=From:To:Cc:Subject:Date:From;
        b=JXb+z71NH/3s5bjVDbaOTda+CAWCErEZASiAXCplQeSwV1MWh4CxblyxeOMx09JqV
         kbnQB0KWqPRgNv58rw9g2qozpKkgVQNTAfCDfyJkLD1/We2isEgwJ3fwof+cozbnIH
         L749SfdSwOU8xzIu34rlDaQLYcU/R9sBw/cWDjGk=
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
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: watchdog: fsl-imx: document NXP compatibles
Date:   Thu, 29 Oct 2020 17:21:32 +0100
Message-Id: <20201029162133.81016-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Document all ARMv5, ARMv6, ARMv7 and ARMv8 NXP (i.MX, Layerscape)
compatibles used in DTSes (even though driver binds only to
fsl,imx21-wdt) to fix dtbs_check warnings like:

  arch/arm/boot/dts/imx53-qsb.dt.yaml: gpio@53fe0000: compatible:
    ['fsl,imx53-gpio', 'fsl,imx35-gpio'] is not valid under any of the given schemas

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Add also Layerscape,
2. Add Rob's review tag.
---
 .../bindings/watchdog/fsl-imx-wdt.yaml           | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
index 991b4e33486e..fb7695515be1 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
@@ -18,10 +18,26 @@ properties:
       - const: fsl,imx21-wdt
       - items:
           - enum:
+              - fsl,imx25-wdt
+              - fsl,imx27-wdt
+              - fsl,imx31-wdt
+              - fsl,imx35-wdt
+              - fsl,imx50-wdt
+              - fsl,imx51-wdt
+              - fsl,imx53-wdt
+              - fsl,imx6q-wdt
+              - fsl,imx6sl-wdt
+              - fsl,imx6sll-wdt
+              - fsl,imx6sx-wdt
+              - fsl,imx6ul-wdt
+              - fsl,imx7d-wdt
               - fsl,imx8mm-wdt
               - fsl,imx8mn-wdt
               - fsl,imx8mp-wdt
               - fsl,imx8mq-wdt
+              - fsl,ls1012a-wdt
+              - fsl,ls1043a-wdt
+              - fsl,vf610-wdt
           - const: fsl,imx21-wdt
 
   reg:
-- 
2.25.1

