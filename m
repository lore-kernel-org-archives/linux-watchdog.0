Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAEF4C955F
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525472; cv=none; b=Xft0mOYnx+DTrg73MpXU/zyLgnaenjYDhIHLmchf1Crj3hcEA85yQZjJkz+mDEPeFzuZ4SrwG9a+I5ieT5BMYvce8ivF+tphMsG66ED3wT0chr+Y/fU4b9Zbhppzjqxe3wR6NqkiLNx9rJZcgU4vXVghIGzhfFo9mfT2dW28FOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525472; c=relaxed/simple;
	bh=6cAz0Exq66CMI0Sw4hFCa7WyDA2HTF+LQZywIWIj8QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TE2isk8fFE8HkSehY6ZUiqGluu05AR3p2p6F5nJWch3xfoPAMBfsv1qrsGZob8iJVxeq9jOTkoE3xsOM4bxzqM4bf348PaE4rQ+nEwbfqwL1IWA3uU/Y9hNxFV+WzkZQxYMcDc8UXK7qNWX5v71azX33qrLeBk1HuIHBXJ06Vpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rbeIf+eR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbeIf+eR"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso26884825e9.3
        for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 11:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778525469; x=1779130269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+XpErByE04HSy3HLws+NzAyVqid8HMXCiA4YA83SgI=;
        b=rbeIf+eRbKFaLRC2cc/JMnQlTxyM6E94vkEz0Zh7QpBDmpK3kNXLrThH2cNJCadIKL
         QvFM5kkf+lESX28/z6meJ3BxL9lNV/O3h9CByqIjgeOyWXTA4ALbf3KlX9OMMU/cvvq7
         jPsF7V2OcRFBfHj3gV1ZLyILevtJV8SbCvffP/WAGLQCfo1SdAawoi5wV+lB0q2saVfd
         pqWpJB6/KK+XfzSN76dGu/cvY2ocJUvTEMPuFhuaXLY2bQJAxWUQaD6YqTd+6pHQMFfM
         dJo9JOl3PRMag4fcZWArtOr0H2V9XBm1YGVB8ZmfYcQee1VvBNaQHj1FoCrcyo4Ve8+y
         FuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778525469; x=1779130269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q+XpErByE04HSy3HLws+NzAyVqid8HMXCiA4YA83SgI=;
        b=Q9dsoBlyInOANwaytC7gmteye72JeaSHUf4wF3Jl4u4E/V38XJ3pobZYHPxTlXP+WX
         tUY3UVrliZ2eE7QlwrvDPzAK6TIxAa0Qe7HuMOKwgYfmut6C1W/FfJqOMflAAU/b3/pw
         7D6NvxvGAVp4ay5HJSuc4QVYlY7LSDS7WJ3cOMZHkVAbgJ1sFSYv/XjQfPwLDmWa/B9E
         FEP5Lyq6c5JURcgSl35/T+zIRMVxuTw8gi2He8j3q7oUJ5JhYJcfSr5sAuzTfNhKQvq8
         LkbSjMTI06GWZ+3l42vEMBsQP86/47ADrXvBjbw0aPho2diRx2w3huaEyRPDphXHgEfZ
         3thQ==
X-Forwarded-Encrypted: i=1; AFNElJ8wMjkUTq1mVXQFqk2HpzpK16eWerr5QxvGawa2lw1nqwderQuawRgk39GAxppf5IFHHikdDilNtv6i2diAIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxB4iu3Vf8XRqUtsizoaA3n6gf22dvIwsiHvENMKptEbFs5aIDi
	cLorH9OZt8w4SOeh5r2xeBFhb2R6jQjdMRC8/ZOrQS1dcE6ft3d+ucIK
X-Gm-Gg: Acq92OFyYHd7kJnsHTcMY/ydh5Wf8cunrJMfefturQNeWogwip88MRWuGSNWyhQ/JyR
	PGB+iHdSeABpYnQO3l4eeTwuGg19+VVIME3oTj6mLFxan6FiIo8p4u4aQZfyUXkpDW0cGPKgWf8
	ZSR2z0fJ7t+4jhYZFi68Xp9X8WhFICjOld1UpbiVp330yBZIoGgpEXvYdO5tcFrSABTsRnkd/cp
	4j6E/udMGmSFMymlYnggFpOdvH4ErZlRSikS8IJC6RpuF5tLhDPEyYXfQEBX/2dloZpq1EEmZsR
	hxbkmVWZxQbeW2Big3HpJp34bT5NxyPMlvom7rG94Bez76/LisHEm6rt6i2rXy7ekUtrhu4x1U1
	NFgb91gFjwanDzITiOWxT6ZFDzpZWtnFaLQM58rQ0pMyyDWhteLf9m/eFLmAXZa4licKszrmgYq
	mAvapGwr0VS2oRAKl9a6KSX98NV6nVaTfILMI0iuOIyRlAr5BwNJRjt++h1wiryFuPQoVFiUbJP
	0Nt9YFEOvEbZ8q7XIU1ERfy3//yEWgfYr8u13Khmv14+9OUNKxIDMyP1Z4=
X-Received: by 2002:a05:600c:4e0c:b0:48a:54fd:54ea with SMTP id 5b1f17b1804b1-48e51e21378mr421235775e9.12.1778525468549;
        Mon, 11 May 2026 11:51:08 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:e687:6094:b849:9886])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3cf0cdsm854775e9.2.2026.05.11.11.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:51:08 -0700 (PDT)
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
Subject: [RFC PATCH 4/9] arm64: dts: renesas: r9a09g087: Add system controller child nodes
Date: Mon, 11 May 2026 19:50:53 +0100
Message-ID: <20260511185058.1926869-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

The RZ/N2H SoC contains system controller (SYSC) blocks for low-power
management and access control within the CPG/MSSR address space.

Represent these SYSC blocks as child nodes of the CPG/MSSR controller.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index f697e9698ed3..170d033dcdb3 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -1018,6 +1018,20 @@ cpg: clock-controller@80280000 {
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

