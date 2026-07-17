Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4840176FB1
	for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301302; cv=none; b=YQtiS8dBkmVL3UtktZAsEOf3ONYAepD3jF/KL3q+TuWAHVBbvsq4zGL9F9uXpK0DRiZPRMrKBx6NsjtPOP8+BaMbEsrxGRdtWdxrrcFAPXPlNqBXhIKPtdpBOsnFazWCgJqtZiIQpi0EzsKCbLuhTEia74su7DRaDmhyF17IALs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301302; c=relaxed/simple;
	bh=lzDkvhh2lb30hMamVDhq/leCdMYgOXSSuP4HjE1UCy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gm4rS7jVK8QTmRr3gwrFHesaeXe0l5X+tOPDDexoEoH/pEOZLa26fYBDgFbdSRBpvhKygMne64hFah7wXo1rugSlhEgICTBN1UKd5e8w+tqMQc/kvh/9EXny3nMIQ8RpD3NnikkBxVGBk+Nqt15pdRCUgMzCvclYRRnUZV6r8JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QstK1hXK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QstK1hXK"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso11786058a12.3
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784301299; x=1784906099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ns/s8X4FLGsUS48lb8y5zK7Xq5THvoJSYI6z68H4XAE=;
        b=QstK1hXKtW2idqVV5coUXEVYFyMKCaX6W6AGfpukFKdg6PEviclK0kpUxxvvlcoRDW
         Jma0FdExZXryduc2XvCU8gMgy+rEyP66ZczRuZ32DTKlU9UAwLKZGTgQ7tBpClsp/6xI
         qv0/+KnCYOUavsnfwot1GuLFWOEEpH1ssXRmyXcA/KVlnf1igmN/2IDZVRqnrySYK5nA
         EgeI+IGCanrCQDjJPJyBaTi2pYaIuh7qoIMaw7fYow+h4MEfCrIqeuwz9/U84uXw+s9v
         p/O67FXHgEocZuJq9zAZOsn94Xa9wOK4hYa1i3+inEaUhbaTNTArvShvymbjcOMywC5T
         X0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301299; x=1784906099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ns/s8X4FLGsUS48lb8y5zK7Xq5THvoJSYI6z68H4XAE=;
        b=gX1KH7oJDKmLLuL/TMyFz0/kTcMP7Oz5RsiWidgYrPuqPhcteIN+tONbg+cCNzE8gW
         FcNrEMjnvON1FRquR9LolbPCN4V0KLeIPoOX6pAQLnjuYay0C2J1gtz9xHP80Qfj9KMZ
         eTZPmq5UE2J2lDJgcVnsI4qdjtw29C93jxJhNe0iibCG6YOOiLAzAD7csguW2Zwbjlmq
         eFcxCp20eioMYNiEYKEbCrtjXfn9u4ehYpwqoRJY8tLbH/IpTJPJD1QSNn9XqrsmoJWg
         5UFfvM9w8LgdZMagoBHhHZkcyVBKft2epqj4NJpjDOLypdPM3SZ8Ob4nuMg3WvG5rxym
         ibng==
X-Forwarded-Encrypted: i=1; AHgh+RrgpLr8NV+mS5un+cOjYqHIKNraeORXus0Z2rj9WfO+vbRzqS/QBbeCY1GndngLxDDDQXIcUtRuPDykLc2o0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrlPAHVPswRPUAyRPYctIy/2X9/eIcnkciKtNkEp34hEzUDv75
	bYVU4PVdXmKiWFULFxbyx9N4q7hRoW/KDiwHleMfquAarQnTOvcLnr+b
X-Gm-Gg: AfdE7cnB6L7ksAXn8/mMnhNwl1BmnPBRlmz5gvtcAEcwrSwB/ulNNNSno6fy1iSZa7U
	hmAIUV1M70NU6Ose+gMZypstuXFn/+r76AjhOOUls6+Ad49HUXh+xbZV4ob/DDLgbdH1xU3/egI
	MI3gaO2p+DOoESudbam93d8lNWYdCemhE8C7YRP8pu50uw5BqdGQj4mU0gZTKXsUEHB7ZDNdCf4
	Sdw1yBpjwA6HUNj5oyLGCWQsjgq/SGOFVpAMcGf+ShtFKAxqEQuUcrTPbwMxenyrCYE3tBEioFw
	pZfJCVVQwhZi7SNLcD4LrVI3CKBlNnJ2SAWe7/D5ccAK0qyHw1oKeEGDjwEGuugqIQP61Ycz0FM
	W1b576RadgYao4Awh9lMLKIG2vKG7vFGyyKDMRMsaF/2Lz3P2GyGy+9WixoTJa0gYjbhhl2dHaw
	==
X-Received: by 2002:a17:907:987:b0:c12:979c:5a5e with SMTP id a640c23a62f3a-c16b434bccbmr156573466b.0.1784301298720;
        Fri, 17 Jul 2026 08:14:58 -0700 (PDT)
Received: from luca-vm.. ([109.52.116.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffbab34sm931684a12.14.2026.07.17.08.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:14:58 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
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
Subject: [PATCH 1/7] dt-bindings: reset: Add MT6589 toprgu reset IDs
Date: Fri, 17 Jul 2026 17:11:08 +0200
Message-ID: <20260717151134.678839-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717151134.678839-1-l.scorcia@gmail.com>
References: <20260717151134.678839-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add reset constants for the 12 MT6589 toprgu resets.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../reset/mediatek,mt6589-resets.h            | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 include/dt-bindings/reset/mediatek,mt6589-resets.h

diff --git a/include/dt-bindings/reset/mediatek,mt6589-resets.h b/include/dt-bindings/reset/mediatek,mt6589-resets.h
new file mode 100644
index 000000000000..ee08c39df513
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt6589-resets.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>
+ */
+
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT6589
+#define _DT_BINDINGS_RESET_CONTROLLER_MT6589
+
+/* TOPRGU resets */
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
+#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT6589 */
-- 
2.43.0

