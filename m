Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E37380FC1
	for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218810; cv=none; b=dEhlm0dejibdwn3EBFt2zd+l0LMIVG8FOBvJYyb+EZsVK5xL3HmPOnM04F/NH4KfzAdRWWHO5luXxgWcF9utzbYi6C1WMhCQnlks8iYyqMz9/uInIdkfsr2QZ0DdPhNNEWtEQQTq45xgNFUAFfClIkUi8U3YJ90fBt/KrwXtd7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218810; c=relaxed/simple;
	bh=CClZ1DQD375LN3NkdB6GfVSSlLOVs2NSqQ360o4BoTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZttjMxsAic3G2FSiHfv1ysbRhDum1BQNNxQO9qNCY393OYWbnsbC850vPcf1BcrJ/csCfbW0lBQ506AbWZQ1tAedX12kFPixHmKxsplm7zzpB7o3etO77hyZCgXA7OWl2dxMqC10ZC7EGYG4QAcbqZDDksHEL9hOTEEQ0Wp0Wlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCgKZfWZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCgKZfWZ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8453427d3f4so6204692b3a.3
        for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784218802; x=1784823602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kRF0ZOAvB4ErXLTfeB88x2r9MQSH6nK3/ZT9LGhKsEM=;
        b=tCgKZfWZTz5EaMe6ZRjK1TB8o/z97W7iBaOEQrGoCxdx2czbUfdfmq5r/PhH/qHMOG
         wgTU08Df9Clj+lCqYINH324EoUnuT+tCgL8+0DDV7z3SxbpTsipb5DmTZMnNyfR2h4qu
         7a+/LvXUq0nK8JoFLpRz22YpQdJeVD1CAWh8u3ZJOpEEyrH784hPP4BsE3mrNT4CgKIQ
         /hv9x73h2nLPxA4Ps6U2QD3x9RMCR2lQpP/mQ82J8EVLEHrBH5X6QAo+9NOe4nCSz6fk
         ydOIlvxu560gEfEk7ZTvo73B8YT/HhvPLq345IXV/lLakBJRVVXeManjdXHE/xZcfLIi
         s2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218802; x=1784823602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kRF0ZOAvB4ErXLTfeB88x2r9MQSH6nK3/ZT9LGhKsEM=;
        b=MLYg2gtu/MRBL3RCQ+ydaPZfDvX8cW2TL9DRFf7sZFZ2o1nEBykHTKKY4dqrxNfMtJ
         Dd1zJZGMo4JzuFaMHIpkKDmStOuAdhx4U7IxOP0PGKnDiW0uzQID4EmA3Ljbho3BHcdb
         ROJ1YMHiwmyvYJ2e9wwWHHqiUlQFbQ5KQzYw0e/fbYMYhG5f6y1x4z8PnQ38IdQuIcAY
         1Z79qkyuREYJI2C7kBtmcwe9aTiswwS0lOtyjf2BPRfOAWkAROTn+MkGCIG7Ez1VgME/
         7DdsCAuqbx3+RtNWQXysmEvnCgcnuvxHNuDj1cXj2WSKWaFiWxmmo9TLNxVMkhYGm+Rk
         LntQ==
X-Gm-Message-State: AOJu0Yy62vM4KOe9hZGWjMRck4/YiXhMfF5yA6qI5VhwGacTx7eeMgLT
	UeG3/N9+0hvM1zV8fZXECkrxkKSeMeCF19lnMW4NSrWfu+wj9tw8+tTG
X-Gm-Gg: AfdE7ckWNup4gIBkq+vNYhwM0UWeI4c++kndwtA0T4yxdYaD1BHYjaSKr+wWzqwmbpI
	x67exZH3cjBM5jkxnY5A173usa1WgTEbuD3hzD397dENt5vMRVe/2CULyCvMpuucJHKhIGRKGUG
	4nnss60rj13I2/A3rxnal7gKpPLe7EDqZYfMH4OcQuoMbNOv0DMwqW0gXnLHTniwzwF9aab6wmT
	0Wu8C3owNIrlC16F/cC08vB7z1h60Zk8rMOixE84L1Y3N5CaSNiraYPM48vNkVBuVNwj4y3wZcF
	dcpYJXZNDBoxFw8Kxy2w4PUhwR1rijHw/UY+zIOG74PqFpMKjuxZ5XX978Kx+jhINeVKe8d7qj9
	V+K8mwGtWqTEwMYAnSOwAPQlQXrk2uGV7uwl9q5o9gLb6Z+hZN6O+aW/qipDDGc97J2Ll4qrOU+
	VL7QArRKwT9qvb/HC2L48p+RkdGu+fOvLeug==
X-Received: by 2002:a05:6a00:c83:b0:845:e8b9:347 with SMTP id d2e1a72fcca58-84a671da754mr7414224b3a.13.1784218802301;
        Thu, 16 Jul 2026 09:20:02 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f23a600sm5092661b3a.6.2026.07.16.09.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:20:02 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	Roman Vivchar <rva333@protonmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>
Subject: [PATCH 7/7] arm: dts: mediatek: mt6589: add reset support for wdt
Date: Fri, 17 Jul 2026 01:19:23 +0900
Message-ID: <20260716161923.266315-8-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716161923.266315-1-akkun11.open@gmail.com>
References: <20260716161923.266315-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the MediaTek watchdog driver supports MT6589 TOPRGU resets.
Add #reset-cells = <1>; to enable it.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 arch/arm/boot/dts/mediatek/mt6589.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/mediatek/mt6589.dtsi b/arch/arm/boot/dts/mediatek/mt6589.dtsi
index 46dea445742b..2645054a4a61 100644
--- a/arch/arm/boot/dts/mediatek/mt6589.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6589.dtsi
@@ -147,6 +147,7 @@ uart3: serial@11009000 {
 		wdt: watchdog@10000000 {
 			compatible = "mediatek,mt6589-wdt";
 			reg = <0x10000000 0x44>;
+			#reset-cells = <1>;
 		};
 	};
 };
-- 
2.54.0

