Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD703D1A81
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995497; cv=none; b=LnZI1D2ezDxJRn4rd7RFvkIGdZtg2pMmiTcEriIVEWhYbv58g+4l7O1/iIhAM5ALV6qWqTc+qqLmbdhBfTWDWLLRDFxfAKasUjXer10RLJtbKZoRJY7lPkveVYr7xcjhG8gMxTA71AEm9BRi1evfNIcxBmoeQtCkWjRmk/yDBCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995497; c=relaxed/simple;
	bh=UzE1TRKwehJAZlNkapkZ7z4b5Yc503wNlGsoLYPnPAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLN6h63zcNS4cYJgf7d6WsSVY1DqwHgxaa9K48Ark4ET4NL69deB8FRkG5EyhGWglvMWfzdyiGTIPF+Y1k3HsWHUOoNISmRStXPB/0x34r1kcmDJHjdWtrhlq/REtqAr4ACOS0h/k4Q5U8vMSvqz2bDh1KUr/ysiDrZIamaLfRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1cUvoBQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1cUvoBQ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-472326ca506so1281128f8f.2
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2026 05:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782995489; x=1783600289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PW0IVejhflePMMHQrOFWvkpZ6B6V9/DHbdAKT2t+clM=;
        b=O1cUvoBQ7xh3i6A7eZKns/c68nvlClmPmIOs4i8Ua59MJHnIiHldLR29xbXmLf81y2
         qGpKsxDexBQ75U192gLsOuwCdDvhIzFOMGRdshVzQMKW6Gb4PJvBmwzsDHzkpreKArg3
         5YZ3Wcn/bA6Erj0gpTZq5BJrqDZm7jsbAYG1aB/DUvWJlo3saBgfpYH2OXSo5mh+PQCA
         5sdNSlIFyzBk9kzb92O7rmDAzESbkLGnFf9pN2YyOnLpeNG/Op9VdF2KLr7So4d3ILSX
         y8S3LXg2tOp4mpafuZGgSiQ4SMDstR1k4Ulrm/HXnwjqOU9du/sP7bKOhvuS77lALdAT
         mN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782995489; x=1783600289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PW0IVejhflePMMHQrOFWvkpZ6B6V9/DHbdAKT2t+clM=;
        b=c6P8tLFXbMK8hrveuOBCxc9WSalLIRJ21mkRvlJsn3BguvA9bpPJ82GyyeLlLfmtw8
         9A/8EHcrdSU6GHZ/vkRHlQeLXDyFaSEKi2Ve+yzl3mThTmknuUKizmqJLVQBJUrT1M6R
         aTwdsnfHg1Y3dvTtK/w36Hu5V0W57RsJ3JsLSaS/F/O1DVj3kzQqb90MJQdog5FBuFY9
         wiIA3ktfuF2FOutxeF1/gMUnhaDdMJlGh5Y3AGYKY80IBBtrkU0OHiCwKt9CzU51xXvZ
         LkzanZCZp46s0n9dSt5J76KwU8KUfHM/N9QUJiwNUBqy36aX2pj1aBvlY72fSwU3YsIx
         6IgQ==
X-Forwarded-Encrypted: i=1; AHgh+RralG8SN3ir2esbw3uwjzeRDXpK/0B5roGDfMfWxGLvSdWN+Eq6EfsK82OLs9K0iWKUV0mFatd0y58JXgKstw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkO8wKzWNr5oNCMCNw2aOcJ3Dj1nT9dAqmgi8fx8Cvy68Ef9si
	VWPNGwQjEMGup+FnVOhJBiYmRJAEkAS7gWeE7g3qN0c9TezFn3w1FC7y
X-Gm-Gg: AfdE7clSOP75FuqEZo65UTAthC2lFoVm/b5nA52OxEshk2c1u498TLicYjcMA0tWA2l
	UUEmEVAdZGl/r7f5OohJB3c9Eq8la69dnYkuc/nw27m2AIMQDC+PyMe1khrxkQUYaEWCuXkT6Uv
	r76Jc6VJ6VLcnWpY7aKhNitg2t0ZPDvbaqTyoX09ZM9UMzyB8J+Nyuw8jlrQwVWK04yz0G0FN/n
	L+Cm7V1/sBKgLU+0XDcSFwwYZkY/axlS9bf89kBoJHM6ouNJimk2ngoDHBKmhPLPpXVxslaRM0x
	m2afP/81GIKdbFDUbzozd0ayl9jfvjzSHGGF8iDCYB/bMHfCVZy5xVp8Ud6lmQHsf9/vnrZt0S8
	gvWymZQl1cLPST3uK7mwSbG7bPpvkxVQuG7Ldf4WiF5y6YSJoGhFIAoMqe3v98dXPJb5AebFVVB
	CktqbdU7XDpbwkpgEPQp5sHEAjm99xbjDkquiT6CZtLleKCkF1oOB+99bhQmLHp8vmgXOBZSOOS
	7G0FbrP+eyxdeUNTsO+LND59YHVkC7fjHzeSA==
X-Received: by 2002:a5d:5d82:0:b0:475:f0f0:9ef8 with SMTP id ffacd0b85a97d-4775b930513mr9177821f8f.61.1782995488349;
        Thu, 02 Jul 2026 05:31:28 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:7a4b:58b4:175e:8c2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477ddf0f433sm9772923f8f.32.2026.07.02.05.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:31:28 -0700 (PDT)
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
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC v2 4/9] arm64: dts: renesas: r9a09g087: Add system controller child nodes
Date: Thu,  2 Jul 2026 13:31:07 +0100
Message-ID: <20260702123112.161160-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ/N2H SoC contains system controller (SYSC) blocks for low-power
management and access control within the CPG/MSSR address space.

Represent these SYSC blocks as child nodes of the CPG/MSSR controller.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- No change.
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 1f995d636dc3..165c404dfd36 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -1058,6 +1058,20 @@ cpg: clock-controller@80280000 {
 			#clock-cells = <2>;
 			#reset-cells = <1>;
 			#power-domain-cells = <0>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			sys0: system-controller@80290000 {
+				reg = <0 0x80290000 0 0x10000>;
+				renesas,sys-block = <0>;
+			};
+
+			sys1: system-controller@81290000 {
+				reg = <0 0x81290000 0 0x10000>;
+				renesas,sys-block = <1>;
+			};
 		};
 
 		icu: interrupt-controller@802a0000 {
-- 
2.54.0

