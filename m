Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F3937FF67
	for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218801; cv=none; b=Dx7+WGj6kG6vFujFr4gnAvWjXss5NfUgHS9qfuYcJv5ee+RT6LHtlNo9Ezv1/wjdoh1FP41iR0AWiyYtu1ryX3eXUY4mDjw3Eeoyo2SRBKohCofoTSTa1Fuqos8p/ypvcYe5C01qyyXLufvr1pkZOkuLjiV4zbh149nfTNU2YD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218801; c=relaxed/simple;
	bh=Ap42d1f7fIua8rQzkYfJjJNGXZgBoc6E04vAq/26COg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feMshbwCoPYu3u/YLhvy8mhtLbM0Lov6p27rTpTS5s0qYekrLHdNXFjYNnlUC/k2uhtwy4DbF9hVWWV7r4qrv85WrPCBgiGe5FwWy1qMh4NjhTYqp5XAn+ZrnEYWNLS/CgJToxKuxe8NDPh1mv0RlaCv+zAvvQjZij8BRQm48/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiX7siZ5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiX7siZ5"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-848882fdb18so3759929b3a.0
        for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784218792; x=1784823592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M0OTlWMyIHhFgUGrQUvQVfi6lsrfSqB/SXlDo2R7iDY=;
        b=CiX7siZ5WqLh1d+cH2whUdG3F2cTStHh0WwMa2yW0jUILFStFX0nfRRt4TjiJqSd16
         R336cpR9fYe2jsKhq/Ufxj6gkOMRyfR7ViWyQV45L9v+Q7EwtFtIbAotLaVe9LSiPaXU
         TLiKG/I+XipI58CSQTzPh1+81+Md2UjH3tfGKEA10vPw5FqSRHTEVjOsgyTNoLs+E6s0
         nLTjafs2LI0xhe9IUnqD9tAgCzouVHOH/giUz4REGvnPdlrbiIafkxW9Q0qYb7low1QJ
         +HO/ex1nx+2mqeq1/YklDzXg60hwJv12P/ISV+svBObqeoUNLX0BKWTBY3KNZTWEGDBj
         2lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218792; x=1784823592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M0OTlWMyIHhFgUGrQUvQVfi6lsrfSqB/SXlDo2R7iDY=;
        b=VuXodzfcBnaVkFJVGrzcyJbR/49xKGzb1S1yn54DmhRSpjXSJyk593wDZvN6cxROj7
         U6sdkE7gEJFcgLKfJG+KFvfwB1Nl0n00coUZKm8eV2j+Atdlg2myEXEzTn2dNxAoduQt
         Yfwra7mjV6z2kIh4rbALzlPZdlevL+W4SeVf9f/oeUQZdjWawXAh+nrvVGdaCxrriupc
         wxHGxo6exlu0S3aE+MQllcvnYOb0+kAzzx2Aie7vr3opKAgHCVM8V45tKYx5mlyLFZi2
         Itazs/nUjnTjopTdsBt7/c2Osmsl8oxH9KjfMML+EnvHwgecyoGhK+Gdopkxdku4EQ0E
         QOJA==
X-Gm-Message-State: AOJu0YwYpSwp5NJd5xgxHuJgXK1goOCuBLYF4d3ytG2BO7E94WImslII
	gSvrcrGZzcQ3DyxuNYj3X5skKmPEWx+QzwBpJeyQiF9EyZGsf7hzccyZ
X-Gm-Gg: AfdE7cnfaDk0JXMJ7MPdVJdllHUV8buO6FcwXsBGNABWQ+WI4slHygVRivLXsLm2Mv1
	paZss3ES6ujNSILLLmc3WRlBZwV3FUJyL9xf+uPGlXZ1syD/R2CpEPNHXU/e6tWU7WV9OqQNnKw
	lf/R89sjQGo/A+ZxhzZvaVMXmQKArBv1csHOvoCqv90CwQKfXe9c74eZN1lpyu36mKrX8DW8bc0
	48v4FwZf6ArCMG0BEZYfIH1p5wrqzOEAZ/Wls0g+rljhyGxxeDfH3LFLrHYLRwE0hjeEscXFG/g
	W4Zk5aPNva3SuO09k3C8LECAb/blZAsRit0YS+zg7byYpA2hobQRgVuyoq6dx6FMXxzhDzMEgnY
	aUx/LqPeU+cSZU4327Q1WRJKS7rnVfuQrzAoYGvN6L6zMeaakmiX+W8Sz4lbmpUyJAj+hA8phKK
	/NSzqNgUZeGr1zDkXfxB0h2aYQeCXFH3kfyT6Mcq60BV6p
X-Received: by 2002:a05:6a00:240b:b0:847:973b:3d04 with SMTP id d2e1a72fcca58-84a6723fbc9mr7209157b3a.10.1784218792451;
        Thu, 16 Jul 2026 09:19:52 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f23a600sm5092661b3a.6.2026.07.16.09.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:19:52 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	Roman Vivchar <rva333@protonmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>
Subject: [PATCH 3/7] arm/arm64: dts: mediatek: drop mt6589 fallback from watchdog
Date: Fri, 17 Jul 2026 01:19:19 +0900
Message-ID: <20260716161923.266315-4-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716161923.266315-1-akkun11.open@gmail.com>
References: <20260716161923.266315-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the "mediatek,mt6589-wdt" fallback string from all in-tree
device trees. Use only the SoC-specific compatible.

No functional change.
Affected SoCs: mt2701, mt6572, mt6582, mt6797, mt7622, mt7623,
mt7629, mt8173, mt8365, mt8516.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 arch/arm/boot/dts/mediatek/mt2701.dtsi   | 3 +--
 arch/arm/boot/dts/mediatek/mt6572.dtsi   | 2 +-
 arch/arm/boot/dts/mediatek/mt6582.dtsi   | 2 +-
 arch/arm/boot/dts/mediatek/mt7623.dtsi   | 3 +--
 arch/arm/boot/dts/mediatek/mt7629.dtsi   | 3 +--
 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 2 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 3 +--
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 3 +--
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 2 +-
 arch/arm64/boot/dts/mediatek/mt8516.dtsi | 3 +--
 10 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/mediatek/mt2701.dtsi b/arch/arm/boot/dts/mediatek/mt2701.dtsi
index 128b87229f3d..f23a6d860a53 100644
--- a/arch/arm/boot/dts/mediatek/mt2701.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt2701.dtsi
@@ -160,8 +160,7 @@ scpsys: power-controller@10006000 {
 	};
 
 	watchdog: watchdog@10007000 {
-		compatible = "mediatek,mt2701-wdt",
-			     "mediatek,mt6589-wdt";
+		compatible = "mediatek,mt2701-wdt";
 		reg = <0 0x10007000 0 0x100>;
 	};
 
diff --git a/arch/arm/boot/dts/mediatek/mt6572.dtsi b/arch/arm/boot/dts/mediatek/mt6572.dtsi
index ac70f266d698..5a6c9763bd6c 100644
--- a/arch/arm/boot/dts/mediatek/mt6572.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6572.dtsi
@@ -53,7 +53,7 @@ soc {
 		ranges;
 
 		watchdog: watchdog@10007000 {
-			compatible = "mediatek,mt6572-wdt", "mediatek,mt6589-wdt";
+			compatible = "mediatek,mt6572-wdt";
 			reg = <0x10007000 0x100>;
 			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_LOW>;
 			timeout-sec = <15>;
diff --git a/arch/arm/boot/dts/mediatek/mt6582.dtsi b/arch/arm/boot/dts/mediatek/mt6582.dtsi
index f941ea44898a..501aeb3a2848 100644
--- a/arch/arm/boot/dts/mediatek/mt6582.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6582.dtsi
@@ -63,7 +63,7 @@ soc {
 		ranges;
 
 		watchdog: watchdog@10007000 {
-			compatible = "mediatek,mt6582-wdt", "mediatek,mt6589-wdt";
+			compatible = "mediatek,mt6582-wdt";
 			reg = <0x10007000 0x100>;
 		};
 
diff --git a/arch/arm/boot/dts/mediatek/mt7623.dtsi b/arch/arm/boot/dts/mediatek/mt7623.dtsi
index aa42377b47da..48d6c348f667 100644
--- a/arch/arm/boot/dts/mediatek/mt7623.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt7623.dtsi
@@ -281,8 +281,7 @@ scpsys: power-controller@10006000 {
 	};
 
 	watchdog: watchdog@10007000 {
-		compatible = "mediatek,mt7623-wdt",
-			     "mediatek,mt6589-wdt";
+		compatible = "mediatek,mt7623-wdt";
 		reg = <0 0x10007000 0 0x100>;
 	};
 
diff --git a/arch/arm/boot/dts/mediatek/mt7629.dtsi b/arch/arm/boot/dts/mediatek/mt7629.dtsi
index acab0883a3bb..b034e9ab5af1 100644
--- a/arch/arm/boot/dts/mediatek/mt7629.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt7629.dtsi
@@ -141,8 +141,7 @@ topckgen: syscon@10210000 {
 		};
 
 		watchdog: watchdog@10212000 {
-			compatible = "mediatek,mt7629-wdt",
-				     "mediatek,mt6589-wdt";
+			compatible = "mediatek,mt7629-wdt";
 			reg = <0x10212000 0x100>;
 		};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 8ac98a378fd6..fe81faee0b0c 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -218,7 +218,7 @@ scpsys: power-controller@10006000 {
 	};
 
 	watchdog: watchdog@10007000 {
-		compatible = "mediatek,mt6797-wdt", "mediatek,mt6589-wdt";
+		compatible = "mediatek,mt6797-wdt";
 		reg = <0 0x10007000 0 0x100>;
 	};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 158bd9a305d7..0b5ffe9fa806 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -322,8 +322,7 @@ pio: pinctrl@10211000 {
 	};
 
 	watchdog: watchdog@10212000 {
-		compatible = "mediatek,mt7622-wdt",
-			     "mediatek,mt6589-wdt";
+		compatible = "mediatek,mt7622-wdt";
 		reg = <0 0x10212000 0 0x800>;
 	};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 78c2ccd5be13..04b91b751853 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -528,8 +528,7 @@ power-domain@MT8173_POWER_DOMAIN_MFG {
 		};
 
 		watchdog: watchdog@10007000 {
-			compatible = "mediatek,mt8173-wdt",
-				     "mediatek,mt6589-wdt";
+			compatible = "mediatek,mt8173-wdt";
 			reg = <0 0x10007000 0 0x100>;
 		};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 2e782558fb77..2b5b761b92c8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -469,7 +469,7 @@ power-domain@MT8365_POWER_DOMAIN_DSP {
 		};
 
 		watchdog: watchdog@10007000 {
-			compatible = "mediatek,mt8365-wdt", "mediatek,mt6589-wdt";
+			compatible = "mediatek,mt8365-wdt";
 			reg = <0 0x10007000 0 0x100>;
 			#reset-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
index b5e753759465..515eed0bee21 100644
--- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
@@ -203,8 +203,7 @@ apmixedsys: apmixedsys@10018000 {
 		};
 
 		watchdog@10007000 {
-			compatible = "mediatek,mt8516-wdt",
-				     "mediatek,mt6589-wdt";
+			compatible = "mediatek,mt8516-wdt";
 			reg = <0 0x10007000 0 0x1000>;
 			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>;
 			#reset-cells = <1>;
-- 
2.54.0

