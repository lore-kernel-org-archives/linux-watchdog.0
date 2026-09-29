Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F54151CF60
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679063; cv=none; b=ocin2J04Pbz5XMko7qNhmamDd1mqIiil62LdVwsvaFJcMmCKcH1heGN6sWMB9e3vB1kft7quMxfkn3oy2hX+Qql/xccA3KuTb/US0KmJ3T0XywZt5hi034OWq1ZSrc/Fkob4rcv7ksqbolnQEwSVia6BobAEpDmQ6ZrJ2RDMXiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679063; c=relaxed/simple;
	bh=TOovBp7AJBZftG0dksjLHjN9+gQXUXQNB4O63AGk+ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdT8TN0VDX+Gvv5fwObgBTGLujJUZ2wU85Ce6bx8B+B8rBdkeEE4wb3M7HQVHDKx0gRZOOoK1v0Ue/wUi2DsipQwyVf+yGerSJ5OtiwPtzr1qm0NORzuvHkvS46Iu7zra1rHF7/n3VDeb0byAs27+s+AWcQPYHks+RSv7sZvyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fy5Z9o1+; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy5Z9o1+"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a006bb267eso9830035e9.0
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 03:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790679046; x=1791283846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZeymYWRbDO3OTFfGWiJn5j86DHN1mxMvxZVS6ZWxjik=;
        b=Fy5Z9o1+6rFj/DLN5HPvef30XCjxQw8YdkdmsVgTljsFa8YSVTW4s8OaIyKKA/LCCU
         K217Q4NoQglY4O4T+DbJA+BZAs1Sa3+nta761vifETRk7P40b7tZOSyVlzecwlIdRU+j
         xHFetuSDWUJ3JVi5gOlfcBZtt7tPoA2qHbt8sax1a7CWiv0v0b+1paUawzmjvWtuvQnG
         FModt5W7Imw7nzlKa50hQ5QVexPTxmENbkw85PGc7ZuNR0iBgKcODwOSZzcHyeQXp2QM
         Qofa+MWsuNJh7vwStLC4QkK31YcY51PaGXGD5wvgJbpbmgBp0Htv81ilKHTBC8/iAOlt
         mGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790679046; x=1791283846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZeymYWRbDO3OTFfGWiJn5j86DHN1mxMvxZVS6ZWxjik=;
        b=1KwZy6t5r4KJEkIY7YDYdrVqP1NUTu/CzW5j50+R0K1Om0etcflbFpRLp7LveoUcEG
         C2UT69aFwczq2+GaN5Apq4m3fQPVTmD3WKsIbE+ChxT38iiKoNvitvGJ59juUFW1W1aJ
         wMnVW0/p8basGqtWFJX1yznTVqiHey45BhREuu3nZ9zvvIWRMqGZz6iKZ/muB1/oeXTs
         3Ol444nMM3GAwhulqn5L/DEG2tK2vZy7gFVjrqm3VUeRjMT89eC/LuMdiDWBwpPx4eHV
         /SFvBrIT4GLD/v2m8y9Mxcx81K3PnhLw9tMm4WXQ/DY9WRhNLLHL3FOVcSj0tGC5OdWf
         RzBw==
X-Forwarded-Encrypted: i=1; AKwUvByEoUKHc8EHCUlJ/p4IliapGuUu9EeVvZISCh6fd1/RG9qkzukGryg1HFUoDb8bO2+fqtlcZssVmp0HRhbV8w==@vger.kernel.org
X-Gm-Message-State: AFuF++n3ULZcxRj02BVPTVXxOCAAev3VZEf0+A1TCyhs+Mcq+6rmkmpD
	HBH3XPQ5r7SfmLucuHBH+UEA2UqhbaHqzohYNQ4cPC5WkjBotAV0jSod
X-Gm-Gg: AYBFou2mArCkY/vl0i+BwppMzLgYQCOjeigkD/g33rTR+BHgSwaYLRy1jETF/N8smQ5
	2nPxH3vaWs3q1lKrmHrtt8oKRZanePmLgLq4+BeLwhtroiR4RqEu1MRjsIA4qTTUn/Ll15uM/g7
	22564zl6m12riziH8U14YQZBchcc3RZA430KVVx/eWpeVjYXiUglvV70zDcJ6KDr/AaD0sqXdL0
	GDC5JRS3+MdVkNPRAueztg7414KeszgaDIrhyFlQjvx3eD+4uSKxtRZgcRmF/azwEVxM1xV6ZYd
	7DyxzfkxnSrQPs73/sjDZwWPDAqXn8yVYGMap6MMEZCZzx7ilURUip0uu6XUFt6pTvoiQt4PEU8
	sng3ovgwyiEQpMDT7/nCGa5JDZqI8P8yaJ639UAX/uw54Yp1Nk/Iu8smIY/6TQ9qgPutfece7pb
	qDCryQviA0LndCunyfo+rcmMfQ7+fqMtjijSbIXblClrr/e7H/yc35eOQ7+7FXWnNu9OlCV56aW
	mgndh4cm5WirrmJ80FCtRTCM/4YbWtxNFxGBQwDgE6Ki46WNur9KFxWXdLkjXnn/cpzWvp50f9x
	3bYQkKYgrvqztMBqBV4Eug3kDw0J
X-Received: by 2002:a05:600c:c48f:b0:499:bf8c:cfd1 with SMTP id 5b1f17b1804b1-49fe66bdfdbmr282392825e9.2.1790679046003;
        Tue, 29 Sep 2026 03:50:46 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:10d5:21e1:1aae:c9d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af5058c52sm3516303f8f.19.2026.09.29.03.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:50:45 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v7 8/8] arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access
Date: Tue, 29 Sep 2026 11:50:21 +0100
Message-ID: <20260929105021.542730-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929105021.542730-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260929105021.542730-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v6->v7:
- No change

v5->v6:
- No change

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
index 68c8daed557b..abca7aa89458 100644
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

