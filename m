Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E694449B24
	for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134754; cv=none; b=IjU9ei4xenrXavcRrEcKDjbmz0BTCYlJ9pBUACzgWtjiwTOBAdGjGDqz2kL+4E6dEg5QBJKK1XX6uLX4BD/RDVeiX2lilKsCL3H/imj4FCoFU9NGNLFx96WfB77NldeRFL15WqsGRUr9RjpW5C/pqu2csrBNMTxWSZwpb8Q6fX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134754; c=relaxed/simple;
	bh=YIP/2XJjUaaXh9qRpp0daB35u5sffzJAaPM09TSptAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPxyDt60dqF7dZ8UZ3edw3uFhlY2dg6m140gMt9qMm5FO29uqPbCHM4kBhz/9mEEGSvuVRGmp+5OD+xhMLDSUUNxYFjKcNgKM7uZ4TnXqp5hRRYtGQ8c7N2cjEA3TxVVYpif6EYAjOdfWEr2YsTMmSZ9v2L1Gj//LefdDuPvZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzAKUmks; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzAKUmks"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso6784815e9.0
        for <linux-watchdog@vger.kernel.org>; Wed, 19 Aug 2026 03:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787134749; x=1787739549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ESyY6mS85KjCUsI5x5vm2izKlsP3ozPFYVEFc322MuE=;
        b=UzAKUmksk7YyRl9M42B7F3qMuzqdjB0Pb60FyoYT7JgAhigDrcPK7Ee8TJf2A0Izob
         cCsgk4yeQwoYxe/wh0pec4MAs/niBCiOIc/PWioajUoNQJ80B/TS+qyiV4i04EnkMQur
         3YeIuKlEWapFNdhxbaOVKDTIMcz9IPaS++6CWwF1x+v5AuS9iShP5ciEZ+Sm+eSCZR1p
         9C0/Yph3l02b6VhVGrLVSpE9WVI01cD/u13uH22vRyeqZQ4Qy7m5LXE6sXSTytf5hDVz
         SxssEL1MPabNbrbbkaAWgkWA0maADQqAdaOPiwHxqMzkfzRjwjIjb4QjH/Dec+TT1J0H
         BkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787134749; x=1787739549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ESyY6mS85KjCUsI5x5vm2izKlsP3ozPFYVEFc322MuE=;
        b=qTi8euUiX8DyApz8eJWdpG+9IdmklwtFZyHfVSxYJKn2bKgDAKrKRiyhFC7wi4mwJM
         h8Uuea8zRHLrVl0dYfFcC4qLjVDk8wxGOmowbgD6wwpyQgLzhzs66biOLg92fEYKcCp5
         jTDKJHHJ4wHShBKbwlL2BKIzJY4dxCRA0fs8z8bI2t31a3YDDI2kBl0YOp57l71UhKOy
         jUTatcbXtPPkS2uya9miN6YVT4pNqY7n7BdxTfInqnzeurRJ9z1Qn4UQg28YxGBBJg5h
         cjNOWaQHmAwZsI8sseLALxhFl7SBuzAWCyAMUAC4WbnJSphtdnocIurWjHjwfnIIF2KH
         +/eQ==
X-Forwarded-Encrypted: i=1; AHgh+RqgjxxL23LjW3IJrFb9LtWnFtOi4/EHc8FSfWVe2co1O/Zabf1heArtV8k3xrrV0pZsbV3w6SmDZT8I9vzjdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXpSO99J4sTqroRI9955h8EFxwIhmsm+YqoofVtR/8hXEfAihZ
	pDZHjvHWszTEspWprwIsLmkENUOw82L0ka+Bx+VbENCNhGGEpuwxawSU
X-Gm-Gg: AR+sD12XyRYvVsA+Oz6KVxSjKeUd90eVAhy99ulzDF1DihqymJ39vEeOcwmu5UTjRby
	ofVEdzEG8LuSzQ7XNXTFEfT+HsRuI24ikFUvhDGZ0hN/YhIEDSryYT0vTC6xM9hJBB/zQkoz+IL
	FKVREi5rQuCxfjhsCNUAQr48XnyNb88f7rjxoCAWXMQbesuP+c9rNusK0Dma7139wKuBu4rZiwN
	LhB5Ob4VXc6Y9eypcRmVrCdCkIeo8RT3Dww8QYL0bPt3zIO4HVCld0f0OCuSqqjxka7f3C8wM03
	mTuW4xWBkItHS3av33N//BsFQrTGuJNmfQKzcro2oE+06bl6gDbqyv+SW7oU/9gns6C7nFUI3km
	0XcdD1lRlisuAXF7LZuZe7LXqfACDt/Onq/eefQAHr7DtfsTSq5rAZMD0qVhk70PecFpfNuDJhz
	MfIPhyU+Ypds2Ve9D1CY2ax0FJgY7Vi4+KwZY7Y4sEn3BV9hnmghAiMw==
X-Received: by 2002:a05:600c:528d:b0:493:bd2a:93be with SMTP id 5b1f17b1804b1-499aa17d6a0mr69083305e9.6.1787134749461;
        Wed, 19 Aug 2026 03:19:09 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9b7c987sm27316965e9.1.2026.08.19.03.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:19:09 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/7] dt-bindings: reset: Add mt6589 toprgu reset IDs
Date: Wed, 19 Aug 2026 12:16:22 +0200
Message-ID: <20260819101853.44681-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819101853.44681-1-l.scorcia@gmail.com>
References: <20260819101853.44681-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add IDs for the 12 mt6589 toprgu resets which can be used in device trees
to identify subsystem resets. The binding for the associated reset
controller mt6589-wdt is already upstream.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Acked-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 .../dt-bindings/reset/mediatek,mt6589-wdt.h   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 include/dt-bindings/reset/mediatek,mt6589-wdt.h

diff --git a/include/dt-bindings/reset/mediatek,mt6589-wdt.h b/include/dt-bindings/reset/mediatek,mt6589-wdt.h
new file mode 100644
index 000000000000..5e39c8cdd718
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt6589-wdt.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef _DT_BINDINGS_RESET_MEDIATEK_MT6589_WDT_H_
+#define _DT_BINDINGS_RESET_MEDIATEK_MT6589_WDT_H_
+
+/* TOPRGU reset IDs */
+#define MT6589_TOPRGU_INFRA_SW_RST		0
+#define MT6589_TOPRGU_MM_SW_RST			1
+#define MT6589_TOPRGU_MFG_SW_RST		2
+#define MT6589_TOPRGU_VENC_SW_RST		3
+#define MT6589_TOPRGU_VDEC_SW_RST		4
+#define MT6589_TOPRGU_IMG_SW_RST		5
+#define MT6589_TOPRGU_DDRPHY_SW_RST		6
+#define MT6589_TOPRGU_MD_SW_RST			7
+#define MT6589_TOPRGU_INFRA_AO_SW_RST		8
+#define MT6589_TOPRGU_MD_LITE_SW_RST		9
+#define MT6589_TOPRGU_APMIXED_SW_RST		10
+#define MT6589_TOPRGU_PWRAP_SPI_CTL_RST		11
+#define MT6589_TOPRGU_SW_RST_NUM		12
+
+#endif  /* _DT_BINDINGS_RESET_MEDIATEK_MT6589_WDT_H_ */
-- 
2.43.0

