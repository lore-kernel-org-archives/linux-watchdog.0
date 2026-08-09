Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FD73D45FA
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2026 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786291635; cv=none; b=JugQ4L2X2erp3ySbfkbxJwjB/JIig0hYBVKeLyDy1rfr5dlSynNEgewsBSd4jUxinrBEQy1oD5lWTxccAcW3ESMe1TdFAgjwU1Hi9lAAUwXJrcqBWFUhQaK++f5JlnANhJsCOXE6lwr6CDMVcnB+0JgOQapf7rdYyh6BFONmcdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786291635; c=relaxed/simple;
	bh=tW9XEYPkRLJJiOTaVjuVTwHydeZR9DbwvyRR6aSkAbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5nHDYFOy1WoYb252ix1SsWJX6c94l545pUp0dnP6Sg9Vt8f4Ox4EY9RdDSpb99axVCmsLKPIipUITaWBXQdmEvXMOfXkWxCKP/M2QT8VUrw4AN2vAZ49GDIHtWbck0sa+Z7islnaCWCsJPFJ+jD7N+R6D9QDaM8qTbyFY09WhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOL9fePS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOL9fePS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493b966dd74so6473445e9.3
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786291632; x=1786896432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xUHnKBUv58Kqq5PRHzJhB8jsL9UTHk6ZnI77mqbe5zM=;
        b=bOL9fePSIN1ofGxNTBsLp/J9JYZIezkDGWMrItRtaEcBkJMujYXldv1WbCvD1XWHN0
         LXbUU/sMGvkhVT+aR9wkzbEaBvZZIqNUuBuil8tnZmOBrQGoyQqSElytkppaibLV6bkR
         SdoiiX3kHrWvySoHjVaHy5mtHyVoX61Xdik36PbsCMP6oy42efjmpb/6vdfkDX+K4LLo
         JwqfApRF81cT9qOlYHkNEsPukPDceqXqOMTNaZTY8I0vnAnRApgBNzmP4HhZFNucsxPr
         vPWpghJmVZ/YSSDuxq4NjRugunVFIxW/hbOEywGHwIICcnbtdZHAn+yYfm/wpdZqyxAD
         3Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786291632; x=1786896432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xUHnKBUv58Kqq5PRHzJhB8jsL9UTHk6ZnI77mqbe5zM=;
        b=e5I+tvHuKjncpGaOVwqC3aC99Aqmou7dBFh81Jq1LadClpMTQlnLCx1Cuh1x9cFgrF
         kEhz0gSWCxLEcvCL6Q0/CXOsiT1hwS6EDPdSh5hf9r7lHHDiJ18wFEgaHmqwZbObm3Sz
         0tr8wtm2cIX3gVSNpARPuPzMsVehbxlCEN7mRW6Ioa5B4ubgn56btxE20tFTaqJDcRMG
         vWGKBC5pKW7ICSSIS9wt0K2lfGlzu2v3PIdC2vSt4N5FYuqsqt+d6cQTGfIVT6WWpAY1
         ygaJ+B8LRtSrneEg9qxXXPm6DPU6CuFTuSjQotc7/qVDfwVkzZWzue7n6VQ37gqwnwLf
         VmxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqq79Mb12fj24Qg9eAxXhVBMvcqEPh2mpf3O2uxrJmufAB8uKPvnAF4WSh8Lu203XQCbpjquIk3iOpyaVK99A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT2mr3676bjAZn72RUdRZycw4joKZiyeeHADZ8XCx8l72xB+HI
	YP1s9bgqwpRXFheehmqx199pykLPK03I/bPZwXaYPsTjegiIppWmcG6+
X-Gm-Gg: AR+sD10s5+JTpp2zxBy2l3wEDEaosdooY5zrKvWdTwLGMIj7bPdNoitQ4G0qj7szlrb
	ZRXnezwcgtEp9Wjbh20bo7W2hnvJ37kWzqkuMEQuMlmG1ZUWsend+Pq5sJZzgVA0WAK/UxD5urP
	I3FLcXuKvwCrDkAni8/pb3SRN9G6kd9FQY/ltCzkB3MpvA0oQtJDXjucdMEZEIUvm1lwq7ZFxWE
	0WVd5EuNgMpESvJvc3tEKPpgLy4lxRoadu/4V470SKf9myuZN038juFbiY+RLzsPcRH7l/MFNGZ
	7V+61CAzSnQ5ySygMiK7pjmPfd3u5m6A16lfSPDeyzkZpzsViMvrr9OE18FmZNGqAXzKoAjnZGu
	NyHaLVth1ODrZK4ADmpz0urKtdBj5HhLbwUrCZMc6hqBJ8G+4sNpPMS4gWBIUb4sOsA2N+zxyPM
	U3EunIPsZZvY3b1KqeIGMgSoGllwXHX45mIWI8xtNMP2TP2j0KWWAYJQ==
X-Received: by 2002:a05:600c:1c21:b0:493:e460:1f6 with SMTP id 5b1f17b1804b1-4994e6fe377mr488271375e9.0.1786291632103;
        Sun, 09 Aug 2026 09:07:12 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b2b68sm209832495e9.4.2026.08.09.09.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 09:07:11 -0700 (PDT)
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
Subject: [PATCH v3 4/8] dt-bindings: watchdog: Add compatible for MediaTek mt8167
Date: Sun,  9 Aug 2026 18:03:28 +0200
Message-ID: <20260809160643.33991-5-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809160643.33991-1-l.scorcia@gmail.com>
References: <20260809160643.33991-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mt8167 inherits its watchdog from the included mt8516 dtsi,
which in turn falls back on mt6589-wdt. However according to the data
sheet mt8167 has 15 sw resets instead of 12, and the systems to which
each reset bit corresponds are different from mt6589, so the reset bit
constants are different too.

If the number of resets varies between SoCs, the watchdog driver becomes
incompatible. Update the wdt binding to add a dedicated compatible for
mt8167.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index 953629cb9558..f514be8a5851 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -26,6 +26,7 @@ properties:
           - mediatek,mt6795-wdt
           - mediatek,mt7986-wdt
           - mediatek,mt7988-wdt
+          - mediatek,mt8167-wdt
           - mediatek,mt8183-wdt
           - mediatek,mt8186-wdt
           - mediatek,mt8188-wdt
-- 
2.43.0

