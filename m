Return-Path: <SRS0=MUxE=R2=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597F3C43381
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Mar 2019 21:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197332133F
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Mar 2019 21:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gRcI8qk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfCWVSG (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:18:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41561 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbfCWVRg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 23 Mar 2019 17:17:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1so5950791wrs.8
        for <linux-watchdog@vger.kernel.org>; Sat, 23 Mar 2019 14:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QB4pjNOOMnBwXIhRx23uDsfNX8oVmyijr1lF+PZ65vU=;
        b=gRcI8qk14/5A6nqyNSMeXQrwqS6WKzYLv6nWSXvqPb6E4mVwXNtQqTKhOmMpCqSf5C
         0U+8DR1xJ/qGF6iYomA32a2TAWWhlyAuX2AhvS2faQ+HBfSfGiQ4YuVGupg6GYeaR3Pt
         rLQLG1q4Z3leKpSr3JFgh5iJqgvXFTL2/r3Hnz1oVsuBAGVjXoVVsCsogw08yN9hx0lY
         MIxtNG10+yIWD5tW+UDjcrGGckhMImeH1t87aVayWS8PYTWag24xiRxmz7wyiSdrnDmW
         ZqIqD24bQUznyqXxzNB7J4wKVA1p59uy8YpmKPhgAXrWPqIE3srVuUL7fzqUS/RwHEh5
         AjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QB4pjNOOMnBwXIhRx23uDsfNX8oVmyijr1lF+PZ65vU=;
        b=Wu3TCIP561cfThQgyWTGr6qtAHIoEdrq/b1jXoCVPv0JrTezBXQPvmPmGpW69AySiH
         /kyWClDCwKS1KJa3cGKGLf70gYWfIiV+O0gENVUn7Yr0TRDzUy/lOxeKHJ2012YAFrgA
         IyyQaOX9sYlyn+2kq0fY5c7gTJe0SI0yibBiJlPYjCsPAk96QbiUUdv9urWrPUFZE8Xy
         E05utnyGN4yXqzfmF6PDvYE9WiF09Gc3lSGHIfn0psWJ65pPOhE0zL8M15ZoST6auyb7
         yiowKwuaOcgql3DbUvQ4x//fGDtXuhKxBIXvbshRC3qcZtneb3nS7jPwn9bffKa5ilq/
         ynkA==
X-Gm-Message-State: APjAAAWamSwUM/6L0g/bDUyYE/BhbPfYUlQsbf3JbR25iMI4EWGMqTLe
        cg5/rzLxK/dVis7zOzX9N3GTHw==
X-Google-Smtp-Source: APXvYqziKNMuaFGLkZcr8sEo6Yur9v3yt4F4jK1dXAYXgvfenj34DDZ+FktqjzRCEW8uoVHByXrLkQ==
X-Received: by 2002:adf:f98d:: with SMTP id f13mr9970170wrr.98.1553375853974;
        Sat, 23 Mar 2019 14:17:33 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:17:33 -0700 (PDT)
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
Subject: [PATCH 21/24] dt-bindings: irq: mtk,sysirq: add support for MT8516
Date:   Sat, 23 Mar 2019 22:16:09 +0100
Message-Id: <20190323211612.860-22-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Add binding documentation of mediatek,sysirq for MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../bindings/interrupt-controller/mediatek,sysirq.txt          | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
index c5d589108a94..deaaba70d548 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
@@ -1,10 +1,11 @@
-+Mediatek MT65xx/MT67xx/MT81xx sysirq
++Mediatek MT65xx/MT67xx/MT81xx/MT85xx sysirq
 
 Mediatek SOCs sysirq support controllable irq inverter for each GIC SPI
 interrupt.
 
 Required properties:
 - compatible: should be
+	"mediatek,mt8516-sysirq", "mediatek,mt6577-sysirq": for MT8516
 	"mediatek,mt8173-sysirq", "mediatek,mt6577-sysirq": for MT8173
 	"mediatek,mt8135-sysirq", "mediatek,mt6577-sysirq": for MT8135
 	"mediatek,mt8127-sysirq", "mediatek,mt6577-sysirq": for MT8127
-- 
2.20.1

