Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82099DDC5
	for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205290; cv=none; b=ZfYAnQ7VSzqYoGzcntnxWclgzScND3xfPsLPwwePAZN3oCu4opUV1DoWN6x4uocwqaJSQyB3GQRQgyEftzEIBil/oS89BgZl3DglkPUYEzWaIzDU9Y+DWzFRNQ1o8cNhFDyYv3gtyNcGhrN/Zs6vP5bqOO9uDfaMk4mQIa9I0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205290; c=relaxed/simple;
	bh=/0p5Q0W3edFmMR0JKwMJPCO5SfDsNlcFcXuWBH5t3OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QonB/OfohCUUPktUCkX89JTlLXWKKWINdusuTKAbkk1U7Ua+EoeFc6Mm+8X4wWeK4XrCc+oFvJQzEKpX3E+a59jJuWEY5MJl7Ays4LTxGOEFyyifeR4DVPr289Su733XLkF8XbN6rWZRae0GS7WGqgfFXKVEa4NE1NO9hhcj3Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3/rc1Vg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3/rc1Vg"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c733f15aso58018525e9.0
        for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 05:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784205285; x=1784810085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ioMyijQQOZNtEM+SPBByFUPmrnpXCyySvgec/gk8ZJY=;
        b=j3/rc1Vg+PKv/i/+kT9ydO37rv38Xd0xcVT8cswXKnNapgL/cyl1oJix/ITnMxJqSM
         Ss4vzfpinKoUE3KmpdYORorG7+LALKydRAU7DgFVwGcGyhtuApJPTPynjDniDbXTtj7o
         Zmq4Yp6m2zAE1LngZVbZtUagD+luOdWqtAaTNSRw8OGaHU493xM5bti7v8nfGx38nNZu
         VINDaV6SNbc0MSFZgohdSZQnngoXrZZcrgcdMl8rGGoscFKAw2xXfh+d5zEIR1/AOofI
         2MKJZ84m7E3LAW/HMxtGNK3So9kDhNjC7ai0UwQkhZCK8yuaPuAMPhQlyAqVz+mFPr1I
         pt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205285; x=1784810085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ioMyijQQOZNtEM+SPBByFUPmrnpXCyySvgec/gk8ZJY=;
        b=SgDfQsSrbWT3m8oMh2jab3jAi6WEOzpKwyRPlb352UQb6qo7R7Kvhu8fgIlh6r4VNS
         tSVeld+mJuUBEchjvWTL5ga07U/Q+M1TEdovSl5dAIZObPqfB04k16XZj5Qp2RsF4Cs7
         RV07UkhGgvV7F2/qJxzf4Yb4OrfthDeK9cTPPYrOjzQIqlt6OLGuOM2Xw/HxPEnIDPqy
         t+2Zxzk2GjVkhnTEU55tqsTvlBvqeepPb69ob+5rhZ5gm5fql2ymT2sCL4DjbSYZYWPn
         ONQmFqbUimsNlKDXT6kJtcoYabumeOuEHojG+fE2BPCCTkVcL7RhnmxdUyDGR+PeELjN
         czng==
X-Forwarded-Encrypted: i=1; AHgh+RqlupR+a83cZ3q7QA5BloGRx66AAARsYr6mP2ySvL1XXIuEVTQgW0l8vSZYgtejRcWU+pNzFlyBSLOFWboV2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzazRR9USwl6QFtr/LBydDCoFkWHPkst1R4RWuETYBYqHAgxhhI
	jEcncG1TFDGAGma9clezI6j0gEbK7vdbFesbUJK+8aBKdhl6+WKiaZXt
X-Gm-Gg: AfdE7ckPM116/hDCKZUch0OsRSo2iUUkCGcDViSVXHRzNZHTT34h015xnCyL4V86ZvW
	f0yJmbWWZbRkhOxdcXNmttJIimuRf4KqZ5rnQqU8tkDW5SboNpXiT6/X8XhATfn3RRjW4gQUEso
	9pxtP2XEc0UMWqCqHoD86qn98bNwFx/Az4BnAfG0HMnMa5Iegc8JXyPlZI9v6zW00/DvSUG2bDc
	ua9YtPkja9/4lTJ0v11uly1Vvq2Q9j20gP1p6oOMoVUhtOuUol6nGclhGtt0MeqOHcVDXW1u3nE
	QJPrYUv3no77J/a4yUIR760/dxxsmKa8Ek4/j7pcBhiSUXuPEgcvSaLNL9ityfpryZlUyLoyCfl
	6bvG+67v0Oe9wd8k52gsJjYb+g//jb5efAAAKYvhpLE3pD1Q7TjINAL1F1FduAL9YnOxmu6e76J
	5AkA8V/GuVNY2n5D+SQBo4DM9YP/xwlu7S2FioWuPuzOchr05UwrHRoWLMj4LDWNwu2A+fqLHtI
	OXliy7X/ifYz5WYylOnDEsSoPQ=
X-Received: by 2002:a05:600c:1d16:b0:495:3b2f:df04 with SMTP id 5b1f17b1804b1-4953b2fe00emr83467695e9.34.1784205285272;
        Thu, 16 Jul 2026 05:34:45 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:4150:a2d7:2b6b:840e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e83d05sm48582645e9.6.2026.07.16.05.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:34:44 -0700 (PDT)
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
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 4/8] arm64: dts: renesas: r9a09g087: Adjust CPG register region sizes
Date: Thu, 16 Jul 2026 13:34:30 +0100
Message-ID: <20260716123434.2576253-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716123434.2576253-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260716123434.2576253-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Increase the size of both CPG register regions from 64 KiB to 128 KiB.

On the RZ/N2H SoC, the CPG/MSSR block is a multi-function block where,
apart from clock and reset handling, it supports other features including
clock monitoring, write protection, and peripheral configuration registers.
Expand the mapped register regions to cover the entire register space of
this block so these additional features can be utilized.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- new patch
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 1f995d636dc3..718e6c06b9ba 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -1051,8 +1051,8 @@ xspi1: spi@801c1000 {
 
 		cpg: clock-controller@80280000 {
 			compatible = "renesas,r9a09g087-cpg-mssr";
-			reg = <0 0x80280000 0 0x10000>,
-			      <0 0x81280000 0 0x10000>;
+			reg = <0 0x80280000 0 0x20000>,
+			      <0 0x81280000 0 0x20000>;
 			clocks = <&extal_clk>;
 			clock-names = "extal";
 			#clock-cells = <2>;
-- 
2.54.0

