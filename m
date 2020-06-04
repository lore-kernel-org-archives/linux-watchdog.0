Return-Path: <SRS0=bB/U=7R=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5F0C433E2
	for <linux-watchdog@archiver.kernel.org>; Thu,  4 Jun 2020 21:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF5C207ED
	for <linux-watchdog@archiver.kernel.org>; Thu,  4 Jun 2020 21:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="o+vZLnBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgFDVLb (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgFDVL1 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 4 Jun 2020 17:11:27 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F093C08C5C0;
        Thu,  4 Jun 2020 14:11:27 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6EC4F22FEC;
        Thu,  4 Jun 2020 23:11:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1591305083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P765amx+zU7utCaFALSE7pMeVXYJ3s6D40KdmPjCfT0=;
        b=o+vZLnBILoGeGtjkZYEjU3M/+S6xYOToJEX/7gk23eNCLUBCLhENgtkUUAVtsAeRSsDS3L
        leim1CLueSc6cX/lKurHP4QdcyCZaLrqO9rFdEYw41Q2ZZs3Zgmq7WVRxLrB3POPMIBd/i
        6AG59cvQ4zkLT/G5GUCy2Eyk/vLwlew=
From:   Michael Walle <michael@walle.cc>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 08/11] arm64: dts: freescale: sl28: enable sl28cpld
Date:   Thu,  4 Jun 2020 23:10:36 +0200
Message-Id: <20200604211039.12689-9-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200604211039.12689-1-michael@walle.cc>
References: <20200604211039.12689-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Add the board management controller node.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../freescale/fsl-ls1028a-kontron-sl28.dts    | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 360b3a168c10..8712fe82727b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -8,6 +8,7 @@
 
 /dts-v1/;
 #include "fsl-ls1028a.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Kontron SMARC-sAL28";
@@ -170,6 +171,107 @@
 		reg = <0x32>;
 	};
 
+	sl28cpld@4a {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "kontron,sl28cpld-r1";
+		reg = <0x4a>;
+
+		watchdog@4 {
+			compatible = "kontron,sl28cpld-wdt";
+			reg = <0x4>;
+			kontron,assert-wdt-timeout-pin;
+		};
+
+		hwmon@b {
+			compatible = "kontron,sl28cpld-fan";
+			reg = <0xb>;
+		};
+
+		sl28cpld_pwm0: pwm@c {
+			#pwm-cells = <2>;
+			compatible = "kontron,sl28cpld-pwm";
+			reg = <0xc>;
+		};
+
+		sl28cpld_pwm1: pwm@e {
+			#pwm-cells = <2>;
+			compatible = "kontron,sl28cpld-pwm";
+			reg = <0xe>;
+		};
+
+		sl28cpld_gpio0: gpio@10 {
+			compatible = "kontron,sl28cpld-gpio";
+			reg = <0x10>;
+			interrupts-extended = <&gpio2 6
+					       IRQ_TYPE_EDGE_FALLING>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-line-names =
+				"GPIO0_CAM0_PWR_N", "GPIO1_CAM1_PWR_N",
+				"GPIO2_CAM0_RST_N", "GPIO3_CAM1_RST_N",
+				"GPIO4_HDA_RST_N", "GPIO5_PWM_OUT",
+				"GPIO6_TACHIN", "GPIO7";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		sl28cpld_gpio1: gpio@15 {
+			compatible = "kontron,sl28cpld-gpio";
+			reg = <0x15>;
+			interrupts-extended = <&gpio2 6
+					       IRQ_TYPE_EDGE_FALLING>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-line-names =
+				"GPIO8", "GPIO9", "GPIO10", "GPIO11",
+				"", "", "", "";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		sl28cpld_gpio2: gpio@1a {
+			compatible = "kontron,sl28cpld-gpo";
+			reg = <0x1a>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-line-names =
+				"LCD0 voltage enable",
+				"LCD0 backlight enable",
+				"eMMC reset", "LVDS bridge reset",
+				"LVDS bridge power-down",
+				"SDIO power enable",
+				"", "";
+		};
+
+		sl28cpld_gpio3: gpio@1b {
+			compatible = "kontron,sl28cpld-gpi";
+			reg = <0x1b>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-line-names =
+				"Power button", "Force recovery", "Sleep",
+				"Battery low", "Lid state", "Charging",
+				"Charger present", "";
+		};
+
+		sl28cpld_intc: interrupt-controller@1c {
+			compatible = "kontron,sl28cpld-intc";
+			reg = <0x1c>;
+			interrupts-extended = <&gpio2 6
+					       IRQ_TYPE_EDGE_FALLING>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	eeprom@50 {
 		compatible = "atmel,24c32";
 		reg = <0x50>;
-- 
2.20.1

