Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F4C4D2ECE
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525477; cv=none; b=rnC9M3TBRtRzGQf16d0H1jHwn0i4QoImrYn4r/mP6i/YLfmyE0lbfBU1ZbPrMoB9nslLX6QlmrfdrVqlagTBTlcVXGHzrvgJY+6wLJ7xyqq4cPxqprK/I0ORahIHNJrBuD/mBf5z1seO+oSFUVw6haLxvM2/b3BhWJKEAboR7zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525477; c=relaxed/simple;
	bh=+ZlNkR7spELdy5rta3MWuuuHKLZDU4cE9pIZ5fGaMXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3tKPjgzJ7SCS9fBNwWAR0Jt+v+rMhOx+K849bqtdNmTlSgTnLbl4MXOlbhIP3y2q6Bf/om03vSVYL59cLBKj4Hf+ybjxr0c3ZpHZr4CvHQBkomgk13hZ3/JmT+fQg5PaL7pBJ3ESpw4B/CCXpN5bIdy8ffj/LKR0xpG55mt3FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQ8UzaFG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQ8UzaFG"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so42650275e9.0
        for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778525473; x=1779130273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzCVEzCMrh09jteK/hP123LS90DexPwV52Bk8ftNMuw=;
        b=JQ8UzaFGtjsty3PDLpVYKzy1Vyoe0lEjnHekxQ2k8NyI/vuQh47Py0j44Ia9ET4RzX
         uG6wWxkoiKguBI/iu+6HRr00QjXek+HZGAHvX6ZGH/D5cQMnjFb1OP1w9Y+N262kXDVD
         w/wM7pqK80gvdNpgr/IX1x99B56wU9uWFa1xQA+UVqxPk7RWkyq2o6MhT42VGhCGij+g
         uj81ZcxSp7g4dLrz3pS7xGhPObFUadB56TW4R6uil6i33EqUJVXbJ8A0l6jPbxX4Vlok
         XAekIkoHMySiwHgONHFpAptpVyQQU9nopOkCUVDlrKP+ApbERr85WsHnGpfVFQdWx6d4
         sG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778525473; x=1779130273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vzCVEzCMrh09jteK/hP123LS90DexPwV52Bk8ftNMuw=;
        b=oD31Pybo8pXbVL0wdufqCLVQan61y2vtPUHDK24uG2aH0xQRtbxjhpCZupgFFubRYa
         ohCOF2seE2WHBzsm9WENys95q5Ng6JO0chXMwpvxQMMm0KTjrUgeqgIfcNbWUEDNewFi
         +jqj291d0WBc33o2PjnIkfy0wNuX4DAwzKG5O94sOo/hrQWGzdThj7QNq2QF32B+sG1z
         3gJv4aLJhsqAqMohMwmmwlliS04vfQaWX1nTI5O7rYvXZWITr4VpcUh3Qfc/gBpFvLso
         qCmxR5OaRUbF+HTtsUNHEkV79u/Mhovimt0sRe1vDHsXLOm2zlRELRv3J8QaF3nIOJNX
         LsCA==
X-Forwarded-Encrypted: i=1; AFNElJ8SdlfFZbK7kQ+7tRNU6JXQp44p28NopLI8KQYc09oKjCFDAIP4vQ/1JrQYYiKxW4fwKjulKbthyUiDF6yJCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmFqIDZ2JE1X4lsLX50LzzvC+whoE+5TgfeIajb/B3QxKGV6T/
	0dJSr9lLO2OBlV6i1EeyBMhsSWi/tqZBhfklFKhylnxajrsxYzkRtzgw
X-Gm-Gg: Acq92OHglLGPb9MgG3ac/qYahmvdJC54ZBxD7a67SLmCKZMvx+Hn8CZuzjkhk/p+ZQa
	ii8lRp3bSUrPhOomZxX5y91TaAJ5dS6/cn/bNS4o+sEvFszsF2ivJutTkur/Vz4xPOaprPuotI7
	6LSI937Z6RSE3bX3ZkJhIJOhHn1+ULHtpZje8D7fehvVsy4qhDMDI/tH5L49puxlxEhWmSrJDaG
	8NlhVlfphYkUvr8cMHH5fVDIhfUtY4gd8xNPra4GDJwZLedZCs6IHi0FQsIp1d44P262RQGOxrt
	5QFOxryaVIGMrHFeoHeq61GZ9ToA/xpqENZCdsFo9UfUWNuXm/GyGE5TKMXQ9GLF9fqTJN6fF1V
	J+VbG4M4Mj2KmDNS06HerQdYnrg4NC4DliobahZpiVgsMey3+O08zPfqf6MiT+4PqQrJYmX0mQ5
	z5ITCHedmMPTyLWsxpMXYIjBClnLZluxcOXT6wKAMvO6F3RLMzpXlwtZSMniSdjPKdmv1VHySgS
	UJRnlI4AHIFjsXgzKIBxx62FBjFC0Ivt2OwGXwGQjdanK1y
X-Received: by 2002:a05:600c:45c6:b0:48a:93f8:dd02 with SMTP id 5b1f17b1804b1-48e521e6090mr400063665e9.14.1778525473393;
        Mon, 11 May 2026 11:51:13 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:e687:6094:b849:9886])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3cf0cdsm854775e9.2.2026.05.11.11.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:51:12 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 9/9] arm64: dts: renesas: r9a09g087: Use SYS syscon for WDTDCR access
Date: Mon, 11 May 2026 19:50:58 +0100
Message-ID: <20260511185058.1926869-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511185058.1926869-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260511185058.1926869-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The WDTDCR registers for wdt0-wdt5 reside in the second region of the
System Controller (SYSC) block at 0x81290000, which is now managed by
the dedicated SYSC driver and exposed via a unified syscon regmap
interface.

Replace the direct mapping of the individual WDTDCR registers with the
new "renesas,sys" phandle property pointing to the SYS syscon
node.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 170d033dcdb3..c6597c8402d6 100644
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
+			renesas,sys = <&sys1 0>;
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
+			renesas,sys = <&sys1 1>;
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
+			renesas,sys = <&sys1 2>;
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
+			renesas,sys = <&sys1 3>;
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
+			renesas,sys = <&sys1 4>;
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
+			renesas,sys = <&sys1 5>;
 			status = "disabled";
 		};
 
-- 
2.54.0

