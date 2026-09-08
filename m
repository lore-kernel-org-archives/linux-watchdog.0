Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B2598BFD
	for <linux-watchdog@vger.kernel.org>; Tue,  8 Sep 2026 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889470; cv=none; b=U4Zl7OloQZFKvoBuI7+QZqFkfyjYeKnDsKMKGFOzW4/o3xm/EQXJvSehIp4abHXM8KpYULlKmXS4QXZwGyFJUXtbGJRIZ4WiAFMjE3Z1ttpF0VEWehR5euIk0R8no4vjO6Thjqb8BjshDvQ3bgrmcVggCsIwSul9eU5uAMPqjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889470; c=relaxed/simple;
	bh=lpSyEnjJKtBgxDyeC2nu9mnqwL1Wz57d/D2C6M7WDPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBedCOlBvrDCb8/fDSOzdfEL+VKtZjcAqS9VlwDQwrGWj4PbYz1FxtSaq4oEQhnkJz/0Nx2NviX3iAEvvFiqfEkMCyA75Mv/XHoxj3Tbjm2P5Z0oPY+nFW//AhrcWPWzQMyp83L/4gBkLioSczBWH0m9I6e/HzVONRIj7RrRcmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ag1uyLGF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ag1uyLGF"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49d05d51553so27595175e9.2
        for <linux-watchdog@vger.kernel.org>; Tue, 08 Sep 2026 10:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788889467; x=1789494267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P7X+5DAft/iGazDSb7XtX+r5mhhxFu84ghIc52Wrj0I=;
        b=Ag1uyLGFHp1tZcc1JuP31PbOLxXPPRrBhQxK4O6darDZamAK1x5k5n4jpLA3wE4bMT
         S+8gYsK8MbtyVIC9zSc7S317iFwJ0pcnPdEjL/5dJ5m38ygxz4DEhwCdoxEsNTw8HjAn
         bzD9Ub06+u6se7mJWr3DcFfGbHhe+wrB3dvftiZ2FVDE2GfZorxKw4TjCj08qKDewXTO
         INz1FLzylZEW51LBhaiYvOUKAsFbRKxO4rbH5gKqB06I3JaBi/8vgA2GSf821FT+sD2J
         vejxrQY8Cq1YwVMaxHMjW++pU+Yp1UWF3lDuYMfpihW6lCMCbM7LWOcE6qKWWXJ1FFsx
         OjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788889467; x=1789494267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P7X+5DAft/iGazDSb7XtX+r5mhhxFu84ghIc52Wrj0I=;
        b=pczP+ZDv3o4nWtafjPQBKsOuDL4y9ZHPPxsCzN1kTAmplBaeTUSHlfgk0+4lfdzCpf
         q8IbM4gWmJZSTZiCGU9I0jOxXxIzg2N5yF73yr9Qr+jRXc0TYMds4Sazjtt34sp3IpjT
         af7jXYYQv8iOybPfOPjVI9+O18MFsQKDT4Q+qhbP24V5v6CM9hkKAzwUYSsl34LMlSjC
         br71UJPCCRCXtQJoX9rvwYMK79JCCRV5sYjN9Rjfbfgtrlja2f6u8BLoLwZPqAPlhZc7
         FfuKIadwKcpXUP3hKDpyDKhVlUMijVW0wM6KtPb1EqZBdeubKoQPl/l14SowutPuQaC3
         m3sw==
X-Forwarded-Encrypted: i=1; AKwUvBwg58c7VrF9biOx+Aiftj0VlsoNO6Sy2gnGJ/F6rQJSXSzpNOoc0Xtsphn/90DS7hUKzJ0bAskfjFoQMOsi/Q==@vger.kernel.org
X-Gm-Message-State: AFuF++l9zfAG+99JGAF/w2KWssQv32O4ceTH/2rA67JVSQixgR08P0Xa
	i3muBSE+PmKwZXxbJDjvSphZvzc6ek5noreecG5cnvCMX22jkuX39vvE
X-Gm-Gg: AYBFou0EFK5SlTzmiCG7MvxUmuhlbofdZG9uN/2zdi+nPU1t6DGVO2L7UzZue2mJCZw
	KgG/mhDO9GC2inxxjX1uVwsxY29FeQqwa5u6B1cVbctIn05DC+4JsKewJ+IGwCeXJHHOJIWu34F
	BMc1Lqb/rGxjyCXCPH9PloJUwKr3/y9vzc1Sagm0PPDyA2KMgqs9wcPBBQprHES5AgMHvFyyMP/
	Ec8iOWdvqLrqSj8PGB2yVYOhnBE9VRuySOhugGROYZVlM9+XYMTEb08qikZs/oyf1p/s1/YVcMx
	hEBKbmhKPtPVBcwahQqACtWgHF+CnV2PA2k9A8DOqzuQO9Q/1NDhYI3MZphW+GiJchRX044Rk16
	4o6llel03GNprqPQ1zpcfzXG1uDASFfaaJixhllbLvYWMM3HGQZVvJ9FJyMj6lgc9eZXqrAMxjI
	I5L1Yy0cZ0hTwkNiS1UVbnOywtoJfXtF91BV2wMA6GEl+EtRL/3K78RQ9u
X-Received: by 2002:a05:600c:4e0e:b0:499:bf8c:cfd1 with SMTP id 5b1f17b1804b1-49cf81e6063mr290969905e9.2.1788889466528;
        Tue, 08 Sep 2026 10:44:26 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm487081105e9.15.2026.09.08.10.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:44:26 -0700 (PDT)
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
Subject: [PATCH v5 2/8] arm: dts: mediatek: mt6589: Enable toprgu reset controller
Date: Tue,  8 Sep 2026 19:38:29 +0200
Message-ID: <20260908174259.9009-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908174259.9009-1-l.scorcia@gmail.com>
References: <20260908174259.9009-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the toprgu reset controller feature for the mt6589 SoC. This
allows generating reset signals for the 12 subsystems managed by its
top reset generation unit.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
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
2.43.0

