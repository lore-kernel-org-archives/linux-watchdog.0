Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5388942D766
	for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301317; cv=none; b=CP/b9fcZbBpNyRfHPO03/AGHJHJqRbU5EMAywRcg05/TM47l34zZp8hRCRH8Ay4P3n4jZyezan7ZdAuPmSP6speLehLw200wBzi+6KKBzAwW25oga0ewbdEScSWAi+Yo5DXUeczoprJ+qLZENibXsMJL0nzAsfak2rkV7OL0uIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301317; c=relaxed/simple;
	bh=3f9fi8llMSWN7QxaGs6wFgdfcIwE1sEh+eTmD56RMJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJPf6OZBgZ8lKsZHcrh4I1+ittFENzdT/Xwkg2TELvt7rBkIzRAsCWYsRmP4D7AV4wOS4VpbwvXLQUiSKfoA+ZOu71scAD9OoaCIhHBUrXxYfCxqIS9YkfYY4M21z6WPVkFW5bOO5IrlZ9UWYdxpoaRUzeP2n+7vSb18joirb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntjM8gwA; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntjM8gwA"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-698beff7178so5271716a12.3
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784301314; x=1784906114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0PhIH7OMtSrBrW8tfsrhy4p4sqtuf0aJ5TBc9tXNybE=;
        b=ntjM8gwAszgUP9LXmUNo/iF3cII6v5tdV9i84Iomzuj2EvKNLzedV+HrPFH0rUEuAQ
         39CN751MfK2qDNa9LedgmEaxqr/kKqyzX7WGByNxBVXf42SRoDk56bfXR2/Z1dGu4jhO
         8AAEM2kLmLCvnLCVgcK5GdOqdu9J6myVat+Vcm2E04Dd4b27QmJr2HB0tik06Nmhpqr0
         f858PVWH39epfxX1/m+8/nP0SRQtJS0X+Q3cMTZ6Zv+djqEZq92fU1DrCeQX2BedFkbE
         XVcfgfjT+x9wGZSHB13g7KHo9MhazFO4KB1c36USCg7DoqkvfU5lXlqf7YMIXGQad64Z
         ENrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301314; x=1784906114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0PhIH7OMtSrBrW8tfsrhy4p4sqtuf0aJ5TBc9tXNybE=;
        b=Pky2BfElftTO2BrR+QQDeapkulUV9GUHzVmvYGgks6l5QIddzyUBdUSk724+EJdY/W
         ZU9RomqM8pamYlTkbdIWMwev7LRbRzrUN+rCWWxVQdqGGfIVw9gviBWYwBCQiUJ4FYoc
         q652KzDAv0lAahhUoSd+zARpwkHqDIsIRu1VEpPwhVz3OEjZmi4bbRATc3aQ52tZiObd
         CNcfk5Xbn8DGcds7yBJyvQPyQM7wXyYYnvsrjEd93u6YEqXB7eWKjl5u2uNllhZZdZtm
         1wlCCJM1/jWw0DzBCkvf7NfIdeUq2YRLGSfYnyw0OhQfntuxFL+BWMK9YTyg1sZhNdgp
         VBmg==
X-Forwarded-Encrypted: i=1; AHgh+RqGktv8UFo9fvfpNdkBnI+OFpBKuRAvNEGAgFOz88WiTgVZ7zMKacATDh+kOr3psuq45EfG9AJMc/92GR+40A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGx0Hh6k7FQui9lmqJyGNb1SYG28aYvW35s4DYoxvF0mHHh2El
	zSZnYIS/6V8YbuHiRwAG3AN5oQl+iM6dbAQwzduM5ZjlvDq5U8+kAh6M
X-Gm-Gg: AfdE7cnqhcyILCCRINFweZutB9HEUf1xKJzpFeDm7OOMKGqFjPqlWrb72soxS+PdktF
	t/gpnScIKpB/ATMAzVJ78JQ5GmkvRUkauhPTX0RyhXhG3bbrkgyMNf4dz6LK6GFBGbg75GV+QyX
	WMJWm5c0wx/bG/udXmHtBcDT8LXQrpnP1/Cj3wt/FP3Vv3lghRcmBhrMT66n4pY7f/EkG0CmluN
	9sRhArigCPyXM/JxUv4neBi/9i2PIBY+VqOmR6HXtqKDURUkP+SekWQ9OhzwKL8rv+IEYHB0VTq
	2g+XxgsSNse654dmOM0pGp5VALuuZdK/bZcUZorcCQyR1pFeodrJL+9Cc4oXm25RchW4hvBtuou
	pNz2t6j0LwLp+NDPJ8i5I2QbD7Wu20wco2g4EjR+OH3pq/4VkKJh4bQTC/J0y9ly1QLNpg4mxFA
	==
X-Received: by 2002:a05:6402:42c4:b0:69a:50f9:6048 with SMTP id 4fb4d7f45d1cf-69e652ee9eamr1278651a12.28.1784301313577;
        Fri, 17 Jul 2026 08:15:13 -0700 (PDT)
Received: from luca-vm.. ([109.52.116.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffbab34sm931684a12.14.2026.07.17.08.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:15:13 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/7] arm64: dts: mt8167: Properly describe the SoC watchdog
Date: Fri, 17 Jul 2026 17:11:13 +0200
Message-ID: <20260717151134.678839-7-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717151134.678839-1-l.scorcia@gmail.com>
References: <20260717151134.678839-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mt8167 inherits its watchdog from the included mt8516 dtsi,
which in turn falls back on mt6589-wdt. However according to the data
sheet mt8167 has 15 sw resets instead of 12, and the reset bits are
different from mt6589.

Use the dedicated mediatek,mt8167-wdt compatible for the watchdog driver,
as it correctly describes the SoC resets.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt8167.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index 27cf32d7ae35..4ebf305c10fe 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -95,6 +95,13 @@ power-domain@MT8167_POWER_DOMAIN_CONN {
 			};
 		};
 
+		watchdog: watchdog@10007000 {
+			compatible = "mediatek,mt8167-wdt";
+			reg = <0 0x10007000 0 0x1000>;
+			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>;
+			#reset-cells = <1>;
+		};
+
 		pio: pinctrl@1000b000 {
 			compatible = "mediatek,mt8167-pinctrl";
 			reg = <0 0x1000b000 0 0x1000>;
-- 
2.43.0

