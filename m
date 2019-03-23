Return-Path: <SRS0=MUxE=R2=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C079C43381
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Mar 2019 21:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2892133F
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Mar 2019 21:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dJk++uOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfCWVTM (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:19:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45752 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfCWVQ7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 23 Mar 2019 17:16:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so5964136wra.12
        for <linux-watchdog@vger.kernel.org>; Sat, 23 Mar 2019 14:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XjSY7GkEUKTVia2V0gFbX9EZoOEjMqM9LfrLzseMi5w=;
        b=dJk++uOx5tpZufmmq0SOswI/AqF9PCcaFhN0q0rCUw5njHqtJLv5MKR3ZR2KOC/hus
         k+h9uovDHQ+mY6Lytc+UfKuxYusxcrAWABcn2cQ5ege4cGwNCV24N/k1cjc604giAIoq
         7AlGeZ3lPlwypJ3TrPfPIIVgbp+PFmydj1zMcG2RR+C+/oSpzx9CDyPFuymaIjzI1RYe
         kuSGryHEowptYI+LcGval1WkVnr2Y8UFJisyRUz2KZd07H2xqgosXAUPnAAg0B8Rn4x0
         6ivVKXCs/8sT/MI6WTmv3XYcefKa826X1emJe/XZuPSgpN9xzry8RV9Y+dE2S6USK9YH
         WfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XjSY7GkEUKTVia2V0gFbX9EZoOEjMqM9LfrLzseMi5w=;
        b=f8PaXlA6kFxgh9nFaE4gaKtu1qDwo7imSHFoBBCB+s6p+oJbmGV53o3yRfxHi9T3rq
         zB8vW1G5EaP1sZMTaBHSLk4MXI3s2GJEFNi80Aog4O+E3Qhknn4TjLwWvnDXmpLIoqkf
         RxjF3+ZKq37kIQKhtsUEWKbawX1uSPXk0BnOreYb+Ce1dKZ0f9NRgWvZx408ddjX7sVM
         8e4R1mpKCk6HH8HWfpZcRm5Zagm3VK2pgkbT/S7CT86ZbWyjGscVn4FFz5sAVCDsyZKt
         /3M6LTAb6vo1p+FOc+T6QjrMoKu1S7APxoEN+hJyDb/X3pX8qFljgdTVDzxZfPskdRJB
         fR7A==
X-Gm-Message-State: APjAAAWZCfQ5sc7k+ZUEfx+HF0iqcKkHXH1lzC96Kx7ukVsBwituj2QM
        MSp+ykuLfVitRvNAKAAM2b236A==
X-Google-Smtp-Source: APXvYqyYO48bTY3cyp2gU4ct6hmi4qwhdUyjfSzlyOoq5TPdIWdzRX4XfQYrpZ4rO7Tx/wA8f82/MA==
X-Received: by 2002:adf:dc08:: with SMTP id t8mr11186790wri.103.1553375817902;
        Sat, 23 Mar 2019 14:16:57 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:16:57 -0700 (PDT)
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
Subject: [PATCH 08/24] dt-bindings: mmc: mtk-sd: add mtk-sd support for MT8516
Date:   Sat, 23 Mar 2019 22:15:56 +0100
Message-Id: <20190323211612.860-9-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Add binding documentation of mtk-sd for MT8516 SoCs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index f5bcda3980cc..91a2ec59e497 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -11,6 +11,7 @@ Required properties:
 	"mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
 	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
 	"mediatek,mt8183-mmc": for mmc host ip compatible with mt8183
+	"mediatek,mt8516-mmc": for mmc host ip compatible with mt8516
 	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
 	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
 	"mediatek,mt7622-mmc": for MT7622 SoC
-- 
2.20.1

