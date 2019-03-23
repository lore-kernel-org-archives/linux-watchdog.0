Return-Path: <SRS0=MUxE=R2=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85453C43381
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Mar 2019 21:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D282133F
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Mar 2019 21:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ax2CAfHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfCWVS6 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:18:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44977 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbfCWVRL (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 23 Mar 2019 17:17:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so1872391wrn.11
        for <linux-watchdog@vger.kernel.org>; Sat, 23 Mar 2019 14:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K20dmGWJ700LL+vpJjpcnDlimzQRZKLYUWDMmgR6T8c=;
        b=Ax2CAfHOTtSVpQD45ZlHkjQ1osTfDL6m+S2jsdo6/daBbRaOSRhb+YHpJsmcYagxYl
         LzuawF35/KY3VeCxMJrCCt+W7l6v/DBsN+vtzTjsEqUzAKuGpJ6P5J1BPeA25dM0SGYk
         UXh99ev8n35Vc82HR/XgHc+9ssKMZYPFZ00ck2Sob/F0CdVs/FHZ08EMlRwwsY6RGdpn
         qHhMd8SEeqbFRz14MnvdcwneYd+jFv37DFIa3Hodt0wMui421gW0RZnIbk0/J7GwYQ4D
         eX+VS7aSmMoA803EHq3QY3hUL7+i3kub/m14dyWIUREkoaiSny3QdlFMtg53culKeldb
         NRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K20dmGWJ700LL+vpJjpcnDlimzQRZKLYUWDMmgR6T8c=;
        b=t3O1hCoTCQQHjNnqzF2FzmA3yWP1sTUlyxEEE44U6WB/uk2vPsbG254WvKh+O7VS/b
         0nA/Dfv1sUBowxj4SFWb4dgl8BPweCWrZ8fyjNkf6oGM+rf/P0tCyqUXtcYvPnDl7OVd
         lM33T6PoX7yx9IdpFNQj6memzA6lJNDjF8oMFBUijAQ98e1s23NtPMOXmVwyR2eXMv02
         q50fXSLdjcAcHvZTj3U1vNiJ6Avnmuxru4gotda/h1u4ZWBPAjdr5KmlFN+8FsVC2ObK
         owZ5IFdjVTE+nZuvzxytJ4b6nMiiUOPvyvTKw22pAd8wJ1qe8NNEkq61R5Ym6ojhbiS5
         AiFg==
X-Gm-Message-State: APjAAAURhG7L90alMLTulWcxl4QAGVJN3PXVj/7t2dN9d7e+VIoZnuyc
        vO0gISgcvwbcYXAl64Kojs2QPg==
X-Google-Smtp-Source: APXvYqzvPU9gvnf+4ndL3DNOrj6Hhfv+9uwIhBaEw+FF+rFWoOLTgkZJrKyNDTGLxRXVrXwEUc4CcA==
X-Received: by 2002:a05:6000:1291:: with SMTP id f17mr10665878wrx.201.1553375829378;
        Sat, 23 Mar 2019 14:17:09 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:17:08 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     sean.wang@kernel.org, ryder.lee@mediatek.com,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        chaotian.jing@mediatek.com, yong.mao@mediatek.com,
        jjian.zhou@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 12/24] dt-bindings: mediatek: infracfg: add support for MT8516
Date:   Sat, 23 Mar 2019 22:16:00 +0100
Message-Id: <20190323211612.860-13-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Add binding documentation of infracfg for MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../bindings/arm/mediatek/mediatek,infracfg.txt          | 1 +
 include/dt-bindings/clock/mt8516-clk.h                   | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index 417bd83d1378..cbc38a8ee985 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -15,6 +15,7 @@ Required Properties:
 	- "mediatek,mt7629-infracfg", "syscon"
 	- "mediatek,mt8135-infracfg", "syscon"
 	- "mediatek,mt8173-infracfg", "syscon"
+	- "mediatek,mt8516-infracfg", "syscon"
 - #clock-cells: Must be 1
 - #reset-cells: Must be 1
 
diff --git a/include/dt-bindings/clock/mt8516-clk.h b/include/dt-bindings/clock/mt8516-clk.h
index 8d44cb32efba..956ee2c0748e 100644
--- a/include/dt-bindings/clock/mt8516-clk.h
+++ b/include/dt-bindings/clock/mt8516-clk.h
@@ -8,6 +8,15 @@
 #ifndef _DT_BINDINGS_CLK_MT8516_H
 #define _DT_BINDINGS_CLK_MT8516_H
 
+/* INFRACFG */
+
+#define CLK_IFR_MUX1_SEL		0
+#define CLK_IFR_ETH_25M_SEL		1
+#define CLK_IFR_I2C0_SEL		2
+#define CLK_IFR_I2C1_SEL		3
+#define CLK_IFR_I2C2_SEL		4
+#define CLK_IFR_NR_CLK			5
+
 /* TOPCKGEN */
 
 #define CLK_TOP_CLK_NULL		0
-- 
2.20.1

