Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906FA3CAE86
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288841; cv=none; b=r2exaCeKdiRjm2bFnTNIQ4b4L9uJBLV5XadDeSZGO/0uT0JLJUKCToGJFPL5YA6238i507ecTjUjWO2Z0hlVdbDCNXRAappjqxuUEX4D1Kl01i5vBWrS5Z5ayH6MuN02cAceR8LbnIyL+Jvc/CMO49VLhYsF7HF7MA+TJs4kcy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288841; c=relaxed/simple;
	bh=bmimCA8H2hEtE2aKOouwiZmcnAiFz588K3Xf0CNXDqM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSWY+hdjjZWg+ICChB4jNEsh4Sn5CwhPg5iFeUOxxxVu1Xvc2jOss2j2nT0bQ/21EQqA8d56s68d0UhyC3x2v8Jf4I+uSBFatUnxKDjafmMBAtgqAs0jFN055gA+tNteiIyMToAwbHnA/118D49v0LsybJkonhH4/OyzaRCwn+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifubeeJE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifubeeJE"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so29370655e9.2
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Mar 2026 11:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774288838; x=1774893638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QzNDirO+Pun9y4cnI/mvQSADsIoA51wg/5R1jcim0I=;
        b=ifubeeJEbejQYPtlgAPfX5ugl9JjldHzwAVaX1XlKxaE9+UWthRYtu0CKqzVtF5nr1
         fbXg02qsAecnqvIkMxNKocXqMkE5KrP5+wg0oTkOIO776V8eDW+8Te7WRUQUFRJdcRIQ
         bqyj4GN3xK1mOYpEQK2uNmfYeAbY7qvy1hwvxBEQ3rS78nTdSgtGLxdXAgHN42kkM5LN
         N7ZM/QTgTAkOiv7HbXJN28XCedHQcrToSYJzciRr8zFAqaNI+XuNhtJa5+dX2o/YxY5z
         qBmMkCoUKwVoOxe5Sj/ZGrtcQPpXKKCAFCvgzpTntHBMGDKTcNchuW6hfT0MZ5zTTJLN
         qQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774288838; x=1774893638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+QzNDirO+Pun9y4cnI/mvQSADsIoA51wg/5R1jcim0I=;
        b=hXwX5/z2eYA+viWfmUvB0leLCWAGl7T1IPZ6ZBYzBQ6rg95t0xn9rpz5kt1QzCApa3
         Dd9Jmc2/gzvHpSJ6LLzapds9G3k1WWRzm9DfxORcr93q4hXXJBfbgXGkTAS5CYabzydq
         C/AV8EcgD000k5SyR2AvZlux+x0hnDhQ7ziLbSTsxGAinyUrflEnAjLj/b17pwH1uvHp
         DvRnNVfeNGT3wJafIDbmXr8pV0HmI6lW+pxmGfZ5iOBvmnWJw3vUU3F1ONOOvpfVo5uS
         bmVXWy3wy0YvvybE6mAZXFED39U2Sf5zwYbfrxuntUxgDLpxejPShBncSjdeqiYvkg+F
         kzCg==
X-Forwarded-Encrypted: i=1; AJvYcCW1QOG5EPROdWokyWTEFEHsj4GsGVKVqJzMCXWvQ2UDkX6vyaSrmQ5jQynHKixlTwn1AztVYBk0UWq/H73wjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YypLwmHpy3DXSjLDqmREtLqdSpR4Xma++QXttpOMZY6/zpJiatp
	DU3Rj9bNa57oXXUBRXY5eMUEXwqhJqRNx6cOFawPBk9dMftnU0xVRD5D
X-Gm-Gg: ATEYQzzW0bNhDwyi8v3mNwt9hKHKdkhn6HHEp+I3/TWb7e+VOi9iocea8TRosq5Hs42
	hNUBOws3ozMzatoySjQ2VknHEY0ra0Tm/ym961uJbH1QsodbfTnBTVnlCk6PlV+EkspSW86/LyS
	gS4vvjWc1ySlTsU27qZIdv1MyR6LPm4XI74FiTnet6WaCuv/mSn+SMkhujFhyng9pkYjrCrpRGt
	CEaNpJP/UR72CjFIV1GRxd5yrncWE0zMvIlzs7e3puEGyPB2jMTGAS8fYSTQrjW7qG6T59Ng7on
	ckfZT0xfxALuIZ20+4uVWGa0JCZY+hC7hcAl1DsM7OaviwS3Wu26YMkwKQ0U7OKyKQVUnYOPnN1
	l4WL88aVRmgv7XNjdTM6poAfdPFFhUb/DISn+IjY3PKbfAZaSTmk9A3m+zL+gt9A8c4/uhumnab
	BlyoP5pN0hHPQp
X-Received: by 2002:a05:600c:8b24:b0:485:3dfc:57c with SMTP id 5b1f17b1804b1-486fee0fcf6mr185652555e9.21.1774288835808;
        Mon, 23 Mar 2026 11:00:35 -0700 (PDT)
Received: from fedora ([82.77.79.23])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-486ff1d3befsm84419925e9.32.2026.03.23.11.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:00:35 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	egbostina@gmail.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] ARM: dts: nxp: imx51-ts4800: Rename wdt node to watchdog
Date: Mon, 23 Mar 2026 19:59:45 +0200
Message-ID: <20260323175948.302441-3-egbostina@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323175948.302441-1-egbostina@gmail.com>
References: <20260323175948.302441-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Technologic Systems TS-4800 watchdog node was previously named 'wdt',
which violates the core watchdog.yaml schema expecting generic node names.

Rename the node to 'watchdog' to fix the following dtbs_check warning:
'wdt' does not match '^(pmic|timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$'

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
Note:
* This patch is part of the GSoC2026 application process for device tree bindings conversions
* https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings

 arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts b/arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts
index 5118a68db..3610ce395 100644
--- a/arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts
@@ -155,7 +155,7 @@ syscon: syscon@10000 {
 			reg = <0x10000 0x3d>;
 			reg-io-width = <2>;
 
-			wdt {
+			watchdog {
 				compatible = "technologic,ts4800-wdt";
 				syscon = <&syscon 0xe>;
 			};
-- 
2.53.0

