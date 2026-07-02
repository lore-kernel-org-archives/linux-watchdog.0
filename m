Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C3480DDB
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995496; cv=none; b=Y5ESE2uoeo+7uKjAuhL42wVUNBPD3qvmwNtM0nbqX738nog8pNwPnCTtvzy/5MgUxbEtgGeyTE08nIVLRTtKD16wkTD2Ly09Q4nOnRN+Nm0jeP6txTF7fhKo9JSZ5mC04QuC62lVyMlRUMz+ag7pw7FhekXOqt8FEHbbrQ5TSew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995496; c=relaxed/simple;
	bh=KlT+vAqF3fImgRh+vi1G/HlEXKdYDmQI0eT/ODYlQg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dn308BaBwjgkLwxQdapROqPJG38/ag34Meq//2rMAGf0NTajGQ276lhffxd8tOAL8zT1ogSU0lzphiN6tMGHcFnA993L/TMnbyeaKuD47pF3tmwMETXO8zcWNVuUOmXJNuSjXxZB+pyOAcDhiJf5XePNg/ZHAJghLBixsIm2hZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ice2rAme; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ice2rAme"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-470174001a0so1305431f8f.0
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2026 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782995488; x=1783600288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mht4rxb3FmKDNCITNNMglstOGe9jBi788HmIfrM2viw=;
        b=ice2rAmewA/0cKlxCDUKDKvdKv1h1+21KuCop0o38Q0McCyZhPPs4Tao41bKvUlh1Q
         RV2vfQNep18XHuZ5Uk3kOjZhK+K6tG9YroLfv7DJYHNaWiTICOe9hLP7EgheH9FoGEFN
         /+bUiETQTDwHKwookLXP63o9/mz0mvVJ/gWzoGmSIxuH/D6XqJFQfgyQhnMGDQ2R4xbf
         +N/ZTLVZt+bCR4dP+vwhcnk3avtSiWqdYN8dwMsYbPv7Q2zB9zVfiWRTG4KwQP0FiVeI
         fuOMNw98y2myMypsIufofeJR1bLCfKlejSQuss48UvQOR85OZCeiX+c+HQKkPnpoAqiy
         WVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782995488; x=1783600288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mht4rxb3FmKDNCITNNMglstOGe9jBi788HmIfrM2viw=;
        b=dG+ivgOfQCWjhPVABCqaTKNyKMbU+9Zs2TV7l3Pijr1Rr0XH4u2e/qkwcF4VrozUAo
         R3LbyIUtlSFsMBkpDt5LF81DRzLhqH7OlmXDIQEaCkSvKsXtynO63/By5kDpUccVvbNE
         s9lcz6FRq0pbjQ3RJqlKd55GMoEawkzcUBtQD4NYyASTo2rN33UDUtUTNzAXcey8SHlt
         Tw3orah7fuve+lwrVHGEswpz9Zs7pZ7fNCZ8nXv1IqZQwJVYZv9sw8TCSoxyOflE2WwJ
         mhBy2SU44x0RGxeBics76MOz8Kd/rUCF8enlhQ9TlLPuiQJL5YqFP16gvSTFPkm5BYzZ
         NIOA==
X-Forwarded-Encrypted: i=1; AHgh+Rr01j5IlQ3KQJ6BZ1gKHB9NAZslcn4CXmmZu2Jt2Edgx5mj5ccflZADTbISa2Fm+nGtvWajtXX3XpbpicG6bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6AhTI1/UrUqmYKKUDl52ymRGqpesDNVLUMVpVYKiO4EloeCEb
	ZnFlIiT+h0PXbNNdIy3eiNvCjwZ9THf7afrMMpPUV7y7stdWi2SmI5hW
X-Gm-Gg: AfdE7cnJLkA233r851TBGQ96CQ1c2nElNOmXUWqvzoijWh8cDW/V7y9dgdYFwuhr2II
	NOpVt4BQP+8ctqpIdIAacOBNDiVwAPJkaUTYx4Xd/Bw2QGorqdq2LNcpWpKjGggS21fJFuDKHRT
	OQb3bQ6PP8ZewjesqWhUrLevGPpwVYggCGpS2l//OZBdj5ZNdIypfJZTeDfMPk5g+1XPSpL7Aqr
	KjTF4P/WV0NSkAg3o99nz2ulcXAo9HldTavELxbpbN6RxNmZnQihbMBbHJnqSN1hcMuvNmB9e0f
	qgbwD7t7YFKjJ2B/QZGLqDwnWT/lnO6C8l6hpnM95eVfs+fQ271laDIuT4TE2c5SzQ9JfGq2Kuf
	aYeZFKFev9UflfyKV9HrTsBER7YpXhN/17ymbKMoNSc1SjMlXhEP4ShrkAkLPV45h6/AzdMR4Tw
	RNMTPL8CHUw56oWxi8iVog6UxLKYRUsaVDr2xqdAFGPfGDKL7PYEGe9vlDhzANF4S9ME8OLV4n3
	2ILYgGDXmB1ONWv/4pLbiMjnUM=
X-Received: by 2002:adf:ec49:0:b0:475:f0f0:9ecb with SMTP id ffacd0b85a97d-477b5d37949mr5581503f8f.54.1782995487566;
        Thu, 02 Jul 2026 05:31:27 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:7a4b:58b4:175e:8c2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477ddf0f433sm9772923f8f.32.2026.07.02.05.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:31:27 -0700 (PDT)
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
Subject: [PATCH RFC v2 3/9] arm64: dts: renesas: r9a09g077: Add system controller child nodes
Date: Thu,  2 Jul 2026 13:31:06 +0100
Message-ID: <20260702123112.161160-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

The RZ/T2H SoC contains system controller (SYSC) blocks for low-power
management and access control within the CPG/MSSR address space.

Represent these SYSC blocks as child nodes of the CPG/MSSR controller.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- No change.
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index bc109035fbac..6f4c1086afcd 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -1055,6 +1055,20 @@ cpg: clock-controller@80280000 {
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

