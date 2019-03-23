Return-Path: <SRS0=MUxE=R2=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83C9C10F05
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Mar 2019 21:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8543321873
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Mar 2019 21:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="umCsq9Pq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfCWVSD (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:18:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55538 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbfCWVRi (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 23 Mar 2019 17:17:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so5260171wmf.5
        for <linux-watchdog@vger.kernel.org>; Sat, 23 Mar 2019 14:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7xHx2kMMmyCPivD0kj6JwonWBPSQbREOh3tc4neJNQ=;
        b=umCsq9PqTukIbQZFJszXGXCQsURHlTmh26S3zIbaHFI20nrz53fBAPTyUbf1xa6jWI
         N8flfejGhUlYgYnQcRp87P26uXo08eouV59sptxe8oDLV93FPLQiT8mIojywjdiPb+Ke
         vfUVIK7K6r4/gjD4Y7xFcNU31UjMGaYn3H77j0lgPdWVOTKEk2gcoWXLDLPP7Fwe4heZ
         lFvK6cQ4NeAg2zG7SrY4lP71x3V86Dtf92aiFxsdgseToaMVvUZfzFG+OQaC3A464rAG
         jughwue83zWoORp/mccEZtCDZaNSp+xzA72jJ+2fty1qkdKJQ/23S1E7FfljOs8OWAEK
         LlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7xHx2kMMmyCPivD0kj6JwonWBPSQbREOh3tc4neJNQ=;
        b=Bf50Uod86qbF5aZsMpwcWn8SoQYwgbaLygNf0jjJmJHBrWPnNcC6466/zLjIhEW4KY
         cOnZ8LzR4xeDGu9wtvh7xgGQXnbgbIKAUSLGElHPCqVW52Ij6kHaZoyOdO8Ni/rBOVIU
         2ZPogd+kePYVqCfODElXT+HemQD6QX8Ljf7o4JkD6OSy2FO/oWh4TFSS7uFlvLI9svHT
         7TTrPmNVss948h1qG27l3wfuSQRtCj70MhnHjEibLWH6T9T6R2yvTxHZ8S2ABH9nq3oo
         OTwEQfk3PQW7pPdNOznZbK0sU+P0Dk/VaUurbG+bG2sWG68OtARyLXYsTUIz5Y3WG18L
         INnw==
X-Gm-Message-State: APjAAAWFwaYKiShGPPAM7XvU3zNlZKDP0jZAWWHzz9BnDuax6upTcFPd
        Kuh7s74OqZ5KTGbnEnsLIHmx7A==
X-Google-Smtp-Source: APXvYqyHGIr4B2bWU+qwj9n0UuN/TE088xPHOGB5zTzT30CU4oIaB/5rmnFpwMukP7CLSQPxJMxALQ==
X-Received: by 2002:a1c:7311:: with SMTP id d17mr911170wmb.115.1553375856228;
        Sat, 23 Mar 2019 14:17:36 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:17:35 -0700 (PDT)
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
Subject: [PATCH 22/24] dt-bindings: i2c: i2c-mtk: add support for MT8516
Date:   Sat, 23 Mar 2019 22:16:10 +0100
Message-Id: <20190323211612.860-23-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Add binding documentation of i2c-mtk for MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
index ee4c32454198..aac7b56f251f 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
@@ -12,6 +12,7 @@ Required properties:
       "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
       "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek MT7629
       "mediatek,mt8173-i2c": for MediaTek MT8173
+      "mediatek,mt8516-i2c", "mediatek,mt2712-i2c": for MediaTek MT8516
   - reg: physical base address of the controller and dma base, length of memory
     mapped region.
   - interrupts: interrupt number to the cpu.
-- 
2.20.1

