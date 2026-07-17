Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF6D3EB0FE
	for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306528; cv=none; b=e8wyFKu75cfGhBAXatiQz3CVDmQkt4LIwQ9vaQ3PtEZAuN74QUzjpWONp0ACYlFAkxAfWcWOxClWbU+pVnj9DXEMJb1eZDIyR91ft7/27CxynRqxjaAZJAHUh/As6JUulInsYSHWxw9kEX4Sjc2ZVarVjrmDCZTTQ7GXDAavpw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306528; c=relaxed/simple;
	bh=3f9fi8llMSWN7QxaGs6wFgdfcIwE1sEh+eTmD56RMJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdRs9Xic2DV+EgR59/JOeWJCv0K/QWJUthEcUF4QIhGnpgz0tOWQVY0clybgfKs0N/nvTFRbIjnSBFjk+tIiU6EH8KaXTG3Get5hhJqNTvLFAZUJx9OeCT+KFqSfU0onLdGpxofSCvd0l00USLtFnKwRtgwfPaFiyXAmTk7nOyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQeGozRQ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQeGozRQ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so1407134766b.0
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Jul 2026 09:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784306525; x=1784911325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0PhIH7OMtSrBrW8tfsrhy4p4sqtuf0aJ5TBc9tXNybE=;
        b=bQeGozRQo6Gg9e4m48dZ3jUvW6w/Wc6xbLaiLMl1Tqxz2+s/SiZmAv6hsSgzFe78d7
         ibB2JcyHr37VmR37v6+geZJg+WWNyHGdGRxFQ5JwZogFJU0DBU+dFRaBzQNNHrRzyArC
         rpXg1Z02xcik+mCxlXN++DS4JSK5z3/NYEL0212vR67ZZL44HakAn4N8VOJ2BsNfNNPM
         ON4nIEi7+qas2Cp/LlsceRbj6LFTUqVGsNw1Fj2Sfxr0xEpN2XwrgHS9UfjwfIuSjmlA
         jrZ3ypO0zwlw6O/ygkEvTvyQ69Xk3TqEau46EnUczMITQfAzpr1lRGcVZjXpdUAeiINo
         Rqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784306525; x=1784911325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0PhIH7OMtSrBrW8tfsrhy4p4sqtuf0aJ5TBc9tXNybE=;
        b=qqdN6AmuEYJn5BN8e9pao64v8E8Ia0DuH60zoXnVN1Bf1Du2r5Y6i03ByPsL6U2uo1
         X3NE2mj8TADVlnaGMjB4TDuN5koL8cGgPHcyfrJP9mU4MWuuo20vTQz/8/Vgcwrz8ccL
         fiBeYKQsOeheX3qbGOG+YBYNy/h25qpTnzE1gbcYlmNcUcy78s+/j5QELLjfYqdai/us
         AosUgurQ0JthqzFWounhSX36WYfDwfLVXx+BnFo4JsucgpVB787v/4NkbxRFLUj895Nf
         cehWDGA+pBoE3Iq8q5EXc2PLz4Ozx4d5qDTP/UuJE3owVSpigzvl3v1OPs/yJ61lu6dX
         qoyA==
X-Forwarded-Encrypted: i=1; AHgh+RpYWMlC7CUpHurtLZoOZksNMRgklt4C8WWcD68sN2g6TAepdJUY9pvs1hG6OHePicOtqqg+aGgw6w/slMWHHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1b+4VtcC9JH4q8Ou7OIj6Y0iAi+0dBr7awWVr0Ns/KYjZsDZU
	mWWiuxsLdgT1j9N/dU5Kc2O7+6lSLxMnyzoMrnr3mPQHIsZKu5nrLe51
X-Gm-Gg: AfdE7cnYmpXcVPVObufp6u8LoqyMZnOaL9NNx345DInkl1+x8QxhbTuh+YOzSbFJiQZ
	KH1Cp5V9dGi0TgIrCs37CssLJnN5msGnI+3ZfeMjjBhpOY7teg9gL1P3ZX9Bcgm39TymYqRKFmu
	9R6Sg+Ucd8shNt2LytdMIYhfL3Wo8OaSkmZCWgRU6c+3+5gt+WjwIo1d1yVfLPPjsFylSL0qLJ2
	QQCT//Eo3HsXKTDt3j/D/M4jLeYWANE2re/ZxOcb9toaGXoJmNXlyLcIXdfRdgoYo0DbumeDaJl
	OTt0X0h3MQnVfNecJLtqf9C9R97jI9RiqMLvgzBEkyqvj9fT3ZvZBKr2payJJCBpnk5rAegKI1j
	j/Syc4PBYdp9+3VcVC1wuM24KjDxkYC2yKwx8mrY3UsRPDvn6iOEXPG9vxZ238A6VK+o2h6nwQw
	==
X-Received: by 2002:a17:907:a4c:b0:bec:64d4:3872 with SMTP id a640c23a62f3a-c16b46f75f9mr157226166b.24.1784306525446;
        Fri, 17 Jul 2026 09:42:05 -0700 (PDT)
Received: from luca-vm.. ([109.52.116.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1705912972sm105880366b.14.2026.07.17.09.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:42:05 -0700 (PDT)
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
Subject: [PATCH v2 6/7] arm64: dts: mt8167: Properly describe the SoC watchdog
Date: Fri, 17 Jul 2026 18:39:17 +0200
Message-ID: <20260717163959.714561-7-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717163959.714561-1-l.scorcia@gmail.com>
References: <20260717163959.714561-1-l.scorcia@gmail.com>
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

