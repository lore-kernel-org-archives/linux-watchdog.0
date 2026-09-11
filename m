Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4574543DEB5
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125491; cv=none; b=kqFt3Aqa8L5vnGob0p+d/Xye5WuGEwjrRgb4KcoEY7bpJLo+g0xv4VkWioM+qtZSDwiI77NmRsXJuRucHcx5JFj0/3GR0WUREnETZy7THjdQstLw0dvoM7UWBKJfYKXc1jXR/0o3XkfIyAzIGKjgPkh722smq7eJPGZz04JI61I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125491; c=relaxed/simple;
	bh=mhbdJjLcWcQrWxoxCQqlUnOAIweP+fW4TKcbmVB9Eig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qesp5H1JY6vtSFHj1kCy8xRFIDsi1nEKZLcewB5s6EWWwAtsCzn6bMiOqi3mrLBicse1zxuJRqv95NEwQETlHubKeOiaOo2QObnl/lee1qoUYqZj3gFMxLB64DYIakQakSflWB+40YHf3vF6mR/yaNv5q7nlsJD9LJ95j6wI8+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErXaCt+k; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErXaCt+k"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-486f282cad5so199966f8f.0
        for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 04:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789125471; x=1789730271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W390DCGBG6P5p4/mz1YZbyKjCuVONBNojwF2gHmC2H8=;
        b=ErXaCt+kNp1vI8oYkkLEyUfI99AKypmjL7CftTqJl7kG1PXLRQ3C153MzSFyipEzdL
         AbcNz163gszA8czf8VqJp8zcWgDGQTrX3X3Yuej2xNQdwoS+T4HZl3PdLLhvEDHgw61H
         DxENJd51k7d616osbajPG51hlKDqfSoFzqAB7+/Vqqx1ouJJMYDA76WbcMPJwzQkxN9h
         48ZUKNiMRu/NyGzZEw2mIMnqBWtSHSezI607NrGLQSA05JUnUWgWhyDGCCpYm2SPZ6O+
         zaLak4tfq1KCgCGHRCRIIrt/eGhA+DVzhoVnmi8H47lx4Es5IGoAQ30FfH1fEanaS6GR
         NR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789125471; x=1789730271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W390DCGBG6P5p4/mz1YZbyKjCuVONBNojwF2gHmC2H8=;
        b=onJs0tT5TggxaQrrZoAXl3G70i4XmpzJEVffd3Te5B6buhLVMDS6jpfJarGVIKEaVG
         t98VFpODMXkNs67xbwEUR31H0RQu2BEdDnhLWX8OlSbLSRjsKQ1swEO/hvv/SMugOaTT
         LocxqGt2lihihIMxI+nIyRDZKfWtp9U3RbY4HhJWlLBoa20ta4+0lrRhIPEd6NXFgKUG
         ra14Ebj89vtfhHtf1GnIQe//H6SscnSulecl2GP+4ZtIbIerrWeydgwBcNd4WNlG5s2/
         2cFkBGuJyHaEw9ZKIVzCnejKVRNh0OzRJpbziAfj0IRJ08eYd3xkHyoLJCAalvYQjDHU
         /DlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzFMJShL1l1n8GiQHaZ7YP4CJaLJ/v1js7MFUvhz1iV51U5otB9UtThhIrfvS2FsX1xh9J+c4gGOMmI5e1d/Q==@vger.kernel.org
X-Gm-Message-State: AFuF++nUu6CHBq8v7U0zegVpwUmniSruaRkeSNaE+biPXpErQFkTSZd0
	THS+DNeFxweCot0mWZ3rCmM6DR4f3j87D+HK6zsvWCgmzTi05hn6DHrc
X-Gm-Gg: AYBFou0gSvbgwQ/ZG5iFSY+ExuXnz2RayPHuuczEk6rE//Bm83bB4GLp7BjPQPuuRAQ
	3RFP+iKK8dCF/ax2rH6pXNTmqqlWJthh2VR6cjEYivO+nIRSU/uZFU9g67QNSR/LpCBCmQMlLJn
	FZ3uAdKi26yAr3bQrFfFKmucYu4a8DvLC4vD/s5DnlvKbogf49eq+3IFXw/Mu0JbkBpApI/2fTb
	4nlQx+PSpY2IhMsTCMwZWRZViwEJHuElNU3q9zjIuxgRs/p1J93GVlr32GiBQmJVAkJndx4+YTP
	2pPKNFgrkdwXsLe8wqWR+kUXCd79Z3KF0ynLh+4wB5+nltTxDeq+oyRbV6uo5cJg0/xjPtsEjxX
	SaBfjU1P1AsyYrKQJezkeahkZgeqbSRjn5eGKgoKvQTG9RjwIO3G2HeX9pOYDl06X7jxqIlHgis
	CHjkeroSzudFdu87bsr5a+WDATFYgm7SfIrJEB0OBTuRg4tiNopn1U6+WfkCDN5Lh1qBHForLde
	+3fLU4+UjuSipnee4nZ367uFuz9YPgTK451N8TBFgS4p++WwUvm8vwITg9ZMN3mQP94oTyrHwNA
	QpONxI7SKTyJTcY9lF8=
X-Received: by 2002:a5d:4083:0:b0:486:e9b7:4868 with SMTP id ffacd0b85a97d-486eb2ee556mr3524487f8f.20.1789125471098;
        Fri, 11 Sep 2026 04:17:51 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:3de1:9f21:e874:3931])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf23sm5438182f8f.5.2026.09.11.04.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 04:17:50 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 8/8] arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access
Date: Fri, 11 Sep 2026 12:17:31 +0100
Message-ID: <20260911111731.3404308-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The WDTDCR registers for wdt0-wdt5 reside in the second register region of
the CPG/MSSR block. This multi-function block is now exposed via a unified
syscon regmap interface.

Replace the direct mapping of the individual WDTDCR registers with the
new "renesas,sysc" phandle property pointing to the CPG/MSSR block syscon
node.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4->v5:
- Added review-by tag.

v3->v4:
- No change

v2->v3:
- Renamed the "renesas,sys" property to "renesas,sysc"
- Updated commit message

v1->v2:
- No change.
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 813bb0cb021c..3ede2e89cf67 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -327,61 +327,61 @@ channel1 {
 
 		wdt0: watchdog@80082000 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80082000 0 0x400>,
-			      <0 0x81295100 0 0x04>;
+			reg = <0 0x80082000 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 0>;
 			status = "disabled";
 		};
 
 		wdt1: watchdog@80082400 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80082400 0 0x400>,
-			      <0 0x81295104 0 0x04>;
+			reg = <0 0x80082400 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 1>;
 			status = "disabled";
 		};
 
 		wdt2: watchdog@80082800 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80082800 0 0x400>,
-			      <0 0x81295108 0 0x04>;
+			reg = <0 0x80082800 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 2>;
 			status = "disabled";
 		};
 
 		wdt3: watchdog@80082c00 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80082c00 0 0x400>,
-			      <0 0x8129510c 0 0x04>;
+			reg = <0 0x80082c00 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 3>;
 			status = "disabled";
 		};
 
 		wdt4: watchdog@80083000 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80083000 0 0x400>,
-			      <0 0x81295110 0 0x04>;
+			reg = <0 0x80083000 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 4>;
 			status = "disabled";
 		};
 
 		wdt5: watchdog@80083400 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80083400 0 0x400>,
-			      <0 0x81295114 0 0x04>;
+			reg = <0 0x80083400 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 5>;
 			status = "disabled";
 		};
 
-- 
2.55.0

