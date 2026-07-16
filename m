Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8EA41F35F
	for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205288; cv=none; b=WYziBY1yE4nAMqg0miS39noX1s+ZLcplNXzQXvitZl5QZJ1Frb5JlhEEZL9f6NXrgMJG+Ox9ihUY16vu2n+I7b0Fjy6laAS5vFbpaF0UzqKacqheOHYDyLV88UzpPxkbk6k9bi8sJLpcPOSTRGjPTqDKIyHz/cE9z9CAGqyEi48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205288; c=relaxed/simple;
	bh=Wa1AIz8mfbhk05oN15ZEbX3zyGwLprV0HUb4+AWMGuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDlKU0EHKvGNF24wzlLwoSB+0N6KvjoCT0xL6gXqexDUnf1nyYrRVeG4g81guqsgKnCmH6JpVmvgVob5re0lznFxNxNcSJLftl1va5BU65EAcf6uDyUqgNxmZyBgzdXqesIuT5l0vCTESj4QbRhBgKEbPRWPILKXRTzLlc2gg1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lm4r0CS6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm4r0CS6"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47d6c634f45so3737978f8f.3
        for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 05:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784205284; x=1784810084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56txH24bSU5dTrYzqbX8viqwb9q+gnv6llw5mdYhsk4=;
        b=Lm4r0CS6MzLgoOLNEmfL6oyWrcyf6m4W/mqffuLZu4mwSxt5p98Yh43ergf1pK0ahZ
         3gnK75Vks6cWv/houGNAMSDrI9xOa7JcL83LnKigUATyFnaxsAXEoBdouKCK59PSoYce
         A6RChHxCZb5SgFrsWnNxkZXRz5HWut0f54xeR2rVt0adtworvI1wEJ+MyCzWUvukxLQd
         yGbX/MhRGu4mcANpmPL/tauDeoXoXeQp8UEHtrlxVS9mfe/yWz7iCZaviG6Fus4r78L+
         83imvlGxh5ly+Hw4rlAtbmOS9S4NLrX3D9ch4GDmNaS/DBaa0DRB2Wg/sPedteXd5v44
         ldJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205284; x=1784810084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=56txH24bSU5dTrYzqbX8viqwb9q+gnv6llw5mdYhsk4=;
        b=F00WCie27w9elEQCDDOLykP2z6Y1m1X/VJ2S9eUDkRHBt62O99nPI29wg+Tq2Iuagp
         EsgEI7RzuP2bTzUrp8Lf/9zBUNczqbajPRty2JsA3rTkd4QIp8Y9pzsm+uUqea7WS7FL
         +VXlJi7quf/78dwD9ZX+uSVwcUI4sYPliESWrz7/ly+ZNH3ZjtfSMlX0EyCQ/X5p29qr
         v0Z4B70RlQ6IlT9EP9wkBJ/Tr897/M7YdCVWrlcdXkkydcmZwzwDhMgx5L9VTimm7sSo
         yaE6o6OOgsHo8LGql03gOrWSHn8orlhe+m25fIv/HsfavRmnX99rJ2PXsNnT1tRWYkgR
         Wz/Q==
X-Forwarded-Encrypted: i=1; AHgh+RrdHWzdPgqZDvnPCIizZWfhVmokZyuwYVgW1t4FhOvGNt6b9e+JXl/8JZMzgjBq8JmXe6Ah543unxweJRFokQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRfEpSRbtoonFbfTr3XgImpYSdhAngX2laXhzb+7r0fq9c2Rwt
	1pdxo8nB4jNI9/a65z/L+luN9W78FufkGU9o+OtagfxnrnepXgnKkW2L
X-Gm-Gg: AfdE7ckJsCzBj0HmgHIXkPnWYcqz3ZDbsyiVAlj5E+Q1IcvUbjfF7d+7oPeE2Gy2q+1
	+nzg7dfGuz2ZzhZhO/EBTS0ecL9Mgo8oFnmgX3HCN/ZBS9L2mVKDGZFZOAOR2Y8+wqPiiDl745b
	3+hACTh7FvOEOMo7/C8okMbWXW2HvaJjScAXGmnPRn7OgfYJ4dvmwgPm6HcUgp+Z90n+yaZojRB
	Pd6iUXyDxd8UpRoDd4JabR+jnNEFuexTGX/f5zaXEKWpxm5bNBvO2CClqFzFcUldYGV97yWkfwh
	FhdFiN2iU5ZON1fpYxqszwXH6TOuchyoyGNRwWMpsXo8Lhu0EAlNNWrhnMEnY8uw9telu0MDB7/
	jDqgdoa/bBNB9vkUk8zzKVdklqbgioZpgQz0Y9sdkF2odGkMiRQQtr2sxTLzoFebwVb6Lz8AoVp
	3vBfeD16gFkLIfPErTDN8SaHR3A2P39luQlnezHc6NbHDicmenXACXjwFWUS86kiUHw+oDWW6Jm
	p95jamHPbNfMfGp
X-Received: by 2002:a05:600c:354e:b0:493:c194:4e7a with SMTP id 5b1f17b1804b1-49538992ceamr112755955e9.3.1784205284363;
        Thu, 16 Jul 2026 05:34:44 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:4150:a2d7:2b6b:840e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e83d05sm48582645e9.6.2026.07.16.05.34.43
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
Subject: [PATCH v3 3/8] arm64: dts: renesas: r9a09g077: Adjust CPG register region sizes
Date: Thu, 16 Jul 2026 13:34:29 +0100
Message-ID: <20260716123434.2576253-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On the RZ/T2H SoC, the CPG/MSSR block is a multi-function block where,
apart from clock and reset handling, it supports other features including
clock monitoring, write protection, and peripheral configuration registers.
Expand the mapped register regions to cover the entire register space of
this block so these additional features can be utilized.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- new patch
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index bc109035fbac..9c45266ea595 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -1048,8 +1048,8 @@ xspi1: spi@801c1000 {
 
 		cpg: clock-controller@80280000 {
 			compatible = "renesas,r9a09g077-cpg-mssr";
-			reg = <0 0x80280000 0 0x10000>,
-			      <0 0x81280000 0 0x10000>;
+			reg = <0 0x80280000 0 0x20000>,
+			      <0 0x81280000 0 0x20000>;
 			clocks = <&extal_clk>;
 			clock-names = "extal";
 			#clock-cells = <2>;
-- 
2.54.0

