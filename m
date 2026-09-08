Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E659B681
	for <linux-watchdog@vger.kernel.org>; Tue,  8 Sep 2026 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889486; cv=none; b=cmJNIfYrlHQqhnPFFD+uQWFZH8opW9lmKyR0cotlCTleg7buMSJKKc52erX7VD76SPfI16H/UXGWdpPfWY/xykm2r+QRHcXHJebnbTIxS1fNi5WDYJ2G61/L3dFlE2vm2JiU5/k8CCdZF5aj4bkAjfralMesjhMk35yJatIK03k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889486; c=relaxed/simple;
	bh=07ov/I/ldShm72hNuJQXaFMDAcMGOum0C8wl6iv0rIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWusBFu/aufV3/oJLYBNuEJQMIQv8fm3Fv1L0eCdf1UfdT76uEk9427EcEQ/ByT7T2LC6HqjDg7dCdATaRii9OuRNJdpTBg872vbqH+mAfyMid0tE9V6xVzXENaDvdcp6O3yqyIZo5/Fw2t/j74yJT+w1QtDZpRY/xfNroEBuw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkuZ/MIH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkuZ/MIH"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so39887455e9.3
        for <linux-watchdog@vger.kernel.org>; Tue, 08 Sep 2026 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788889482; x=1789494282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pzjiq1bNAWSar6CSSzfU0ZIGYB2L0BzVwz/Bd6duqAU=;
        b=kkuZ/MIHSK5yRaH2AR1RuW3PyD/IMk39SEKUnzMwGMxHAUJnt/IRHp77162XmjScMS
         6/W45zcdbLtF86HbUkyu1bJphc+BAbcVS0/FYMFcKjQavB+bgkT6gVwDp3Po0zbGxCGX
         EV2Px7S2mAA/ES4u2qhCzOOWJPir7JQAPKwy1i0uCspnllX0DgPdw9De1+ig/e2csye/
         AXuXj3fTrAGLSEcWFeVuTlogyxCp5CCxvFNtPAhlC9UAzSw1MrTsplZBh3hs12/dtWcq
         MwQZiV+HxBClnuwGSv51B8uApIdOS9tvPsO4bvX6HaPA8H7L4xqsdXDCK2D7oAdyytE1
         O+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788889482; x=1789494282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pzjiq1bNAWSar6CSSzfU0ZIGYB2L0BzVwz/Bd6duqAU=;
        b=JyEMnhXD7px3L3ZZxMbL6SrE6hK6Du6xMBZRrud0Xc+/S043EE51ecNkj9c33yeN2B
         m5aAFK+oehszy5epGVYPvwCqNTj7cRNvKtmgU0GdY6mo7fgq9txaf3s0D695rCuOJ92E
         jGCZWWFKLGHGuLV+hovhmSjIqvhkHZ29IUn9+hYqMqXQ/xFH0kWcJChJMliUPG3UMtJb
         IP7zIkYCv3IJ9perZPD/iumvCV/+OkDkL3ryBu1zEooLS4TfceI33lngM4heIo1w3KTC
         oG0GH9LsF4j+WGj7pDjd6TRj807pUFAwinS01j5b6Ho8/cc4iGC7J1Q5HNzASPi6qiQk
         7zvw==
X-Forwarded-Encrypted: i=1; AKwUvBxMWWA4oCQiQ7OkHT7MS5KDDVGsPTvWmadbNjrDwLHOv9JlNaBziFiytWwfGa8GmUVFAE10TSOY/juwEv7DCg==@vger.kernel.org
X-Gm-Message-State: AFuF++lWq8/tTvMWpGcoZW0oQLVuO8kO+npblCT0tJi4tNCMLPs22U8V
	IWaa4DSOWTypQdvjQSo/aXUlseuTrT1pr3O11DA2bRfheX+lRBj0xqjH
X-Gm-Gg: AYBFou06nNlOv5SYHmf1jKzvHvu0/wOxmBaQzDzFHQFfedwhS+TVX0RSRD1bFbG2jBp
	HFNGBk3/QVGHniicILNak0X9MzqgLGKw4cI0P1QLXyDzKycwAYC61d4GhF50wEYG6cmPzGjWR7w
	S6vBRphU7Um2nnuaA7qLRP/GO30QjQVGG/BkaeqZFchvZZK4V1Qh46U5LUFjkIXJ8smNN8IF/N+
	z0dYldMJilevTS52I5K2NKMHpSehIUcdd6GEukmOCeN6R7QLxgslgxg/xBiIUJ7IEXcFSN3fa36
	KdOl6pqvc4Qe2PirhlcWFwbvoVMcdfw56+cO1+2T68uZdsyxftAgdigRrXQfGg/ySo74whYku3+
	0ytylw2bmO1r6RCfIu2cf2shsUHyhzmrinzQz4bZtMsWERooAe8iVoGhNohwxfQwWw+PYX5U5Ez
	FfrnrkfMXV7G3Zrn9AKxp0VwyBCafDhJT2Ev6G8RN1UUs0JUZu1lHUITBC
X-Received: by 2002:a05:600c:4fc5:b0:49c:fe18:6dd5 with SMTP id 5b1f17b1804b1-49cfe186dfemr274872685e9.29.1788889481519;
        Tue, 08 Sep 2026 10:44:41 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm487081105e9.15.2026.09.08.10.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:44:40 -0700 (PDT)
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
Subject: [PATCH v5 8/8] arm64: dts: mt8167: Add support for mmsys resets
Date: Tue,  8 Sep 2026 19:38:35 +0200
Message-ID: <20260908174259.9009-9-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908174259.9009-1-l.scorcia@gmail.com>
References: <20260908174259.9009-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for mmsys resets by declaring the reset-cells property.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt8167.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index be215390730b..9eb24dc8715f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -132,6 +132,7 @@ mmsys: syscon@14000000 {
 			compatible = "mediatek,mt8167-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		larb0: larb@14016000 {
-- 
2.43.0

