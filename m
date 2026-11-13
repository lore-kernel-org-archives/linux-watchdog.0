Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596866;
	b=e8D80KHWWc+AZ1+kULyGNyAVRZU8rCYjXTrJUZOyuL96G+JJDLx3j5e3vLl8ORvsz4oH
	 AZBus4IJZ7HZ9Y1sv+K8YduH6X74NDj0eqAPhzzAjDVawuJrSrmR7GczEGDqeqgN9qlb4
	 skgMoo+d0TJ1yS5ozZi0va8OtSRTNW4/PveLdgyhDvnCAH/DaMqSmCa21FgbZjhpvy9DE
	 Ob4oCBqFDcHHxBWtBjiFqVEpbt8E3E2IFgN6m+qbVuAc7W1PFaTdP4cI26ocrhRGdu6Un
	 TIUUpqDJ70ua+oOqMjcNU2L84cR1i0rcVdEFAXfWdQ3ZmfCf7dU2zCzFkBj47EiIXxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=X0kISij2dA5dG+ZLDMffjTugHXeo/ScalkLGjjtZzlg=;
	b=Ie2xI4grYSwjboKeXaxQPYNjig8XeFUH0hmiWCyczaMgnsI2rdGM/ne03PCzFsnlLgix
	 0ASSG76KO7CAJZguIoxBQ6Sw65ayII9PI7fdBlSMnJ2VGBaajWpnYqRSM1t4M7LHbdZSy
	 ZFZT/smZHzr0gzqaOvRbcFan8gQH7vAfr3BMLb+T0nxz3cvBCOsYiRK3fhZE6aj4bH2GS
	 gUH46Wee6ikpUsTpsEbfM9aecKpp/Ybiu7WcsSodJp0dT57oyeLJgdARoV3Hq2NrEYw1v
	 mwYYT0GTd/yKHZgjKO71I9youHFldSC9/ggodF8dc4wPxZNUe5tJuyP0fJ2tuSSkk/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vm6v1RTE;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CB3606A8A2
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 19:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5CB3606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vm6v1RTE
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d30639709so246594566b.0
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 11:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596864; x=1795201664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X0kISij2dA5dG+ZLDMffjTugHXeo/ScalkLGjjtZzlg=;
        b=Vm6v1RTEA4FWJq25ASY1lb5MR5BgXMe4qoAyAKawSq9cDnRLqH/msUZtMegpu8mO31
         3alveRSeEqOlea3xa03rZSdDRmVsFWBqx0LvtXUYw2yHjLyfgd/DRtnPA2Kv33PBvdzq
         6/D04/Ychb3xeD7h2lFwdXVW9kehjlwqs6tQqZ6ir45YeFHjeC9p+tqjQCCzhCBM80Gc
         dDUSPmVKWoIld4xsa0FObxQKQoUQqEjgaxbgyLvcnnwHmjG7pd8skw7SxHTHjtYmY7Vu
         m8wlHEZ/BrlQKb0qUoRYpWhitGlL0IDd03p5YchHAQXI015wKWpYldCg/LZsRoMg6eGb
         Q1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596864; x=1795201664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X0kISij2dA5dG+ZLDMffjTugHXeo/ScalkLGjjtZzlg=;
        b=ZYg+MZc+Er2NtSt+WnX9P/yt7zWQjEwXcZWQJWEpjWTRxYLJQ9lV8L7h/Ey3LnysvY
         4sr9oSyq4YLkffN1UPkmUACnBmHbi0hQqZ3p/wuVhi0FG5MorkBKUxcEg9nFzYEqRg5F
         VeRwSyWal97YWj9J0PPJh3F8RWbFq7jz/S0U4nvn0FT/vK1A3APaY270tC6IpwFkhUwc
         803ThxYsnyV7h3t4dPgJTE4Z4KptMkNMvBTHvvjasB5C7RWrSlWFmZ7EJuMN1DQd5Gq2
         vk2Mgn3qBGiGBsWjQfarZqHjcTlWPsmQLPXSQqN+A4Mf1whUfve5KWjrKFoeyUvmSoV/
         scsQ==
X-Forwarded-Encrypted: i=1; AL+hErFv+FbQI5Hf+ZIsTV008B5btR10mgOCWLHCXGdd/GOeyaDM9gr59t7bBQfnyh7zNO6T7jNJTfR0Z/KTGi23fQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8URcOfsTqLbdokSYOngJjf+oxyQMpJM8Fsyj23E6gJUxBfOCCK
	+5HfdQ5VcMS2bKpOn/uLEOJju2BbnsnsbZN4YQI2Rf+RCa1ga/JTTINfl54d+ejCpYMokg==
X-Gm-Gg: AYBFou3zMz/xf3UTl0Cl6tGLSshbkI8BR1z8HB74Gf039gn0WF/+kQh+tGTsANeKLDu
	fLQPlK+pCRhffs0wwxXojUA3n2BAok56AUeMTMgOiuBHbCq7fLfGZ9vp4KgiZkp7SCmgoyc0COh
	2zLineGjXcgyu+kv2YsoD7lPN+Umiw5EwSQYX4J40pcf9oY52/NKJL8SH5JQlOXoWyhI54anBCf
	hw7M0f7dQWZQ9IEG33LhloU9LLvhr1bvGvPNKwOmz0viYYAo8QqE7tOApLLfKC7ZXVBukKKpQ2v
	4tR7IWrOkKSAxS06W1lVIX9OaPxnAvc/TvVgXSps1vgQgarcNOs7ur3lp99s86fjr/VXASAHV6q
	wKH68LblXHqFgtKa21T8qHjRKsZqglTr6XS31Mqx+BYRMvWSASYDRgcQ2g2YyBoME/gypYV7mJR
	eo95yKiqVW19E0mafeBDZ/86zMBmB8vmBn/ikmiZbJnJ4re750OYGibMouppRawzRld8q9bDt2i
	X1mNEGwXPoSCdqXw78mFqMnZ6FEJeUtShhSqfJb3/fGLr/7g1FqfxAJt7lXni63MlJb+GWY36Op
	0qa2rDICFPNMbtda5CHzEheRI6TWIgnD+ed+wXqRi5GkWQb5bDD0iJuNpFvmOJSp
X-Received: by 2002:a17:907:9305:b0:c2e:4e08:19ab with SMTP id a640c23a62f3a-c50963d50e5mr310340266b.16.1794596864130;
        Fri, 13 Nov 2026 11:07:44 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:43 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:04:57 +0300
Subject: [PATCH v2 1/9] dt-bindings: arm: mediatek: Add MT6895 and Xiaomi
 Poco X4 GT
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-initial-mt6895-v2-1-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
In-Reply-To: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-input@vger.kernel.org, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add the compatible for the MediaTek MT6895 (Dimensity 8000/8100) SoC,
along with the Xiaomi xaga board based on it, which is sold as Xiaomi
Poco X4 GT, Redmi Note 11T Pro/Pro+ and Redmi K50i.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 180e6e4948e7..28180ed0e815 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -72,6 +72,10 @@ properties:
               - archermind,mt6797-x20-dev
               - mediatek,mt6797-evb
           - const: mediatek,mt6797
+      - items:
+          - enum:
+              - xiaomi,xaga
+          - const: mediatek,mt6895
       - items:
           - enum:
               - bananapi,bpi-r64

-- 
2.56.0

