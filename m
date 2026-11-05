Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912862;
	b=HAb9Et5Icuxh2IHbyRZuoy66TzexlN+f/xGI0u9iZjd35TwgoJm1aGxs5EX7aFPL06a6
	 l4tyG1k6CRbJh55cBLDVia6qHK+GyP15a3igjypHo5i8cO6ApqHDw2EfIiuxNolgTHisw
	 NdasL/clW2/ceIHqjRp4s68yGz9u3kYKuJkZvlQb95V+/mOGZ5AEy2ieHI8cfwrWQghRZ
	 2dHt4nECT8Xib7YxSYUiQHgQ62WltwQvFNR50rVcgtm+gt8hqvtn1bxDCDPXyJXbDHbSu
	 adyMyr6P4hyqqzAAU/MP1LZuOLzzVfotN8YJVZyIRtcjU+weOgAJn30eh/fJE1eTq/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RhSdthgY4lzWyxqScK60PBXNBhT02yTKoURJd/H/bvo=;
	b=czh/TeYCmHlz392fPmfEnZdA5Ac4ms5qVlzbmuVb+DQftJOrBCl6W9VXlYGbWAAT3yr9
	 4QzPVGa/1AaDZoLvQECXuOspLigtjK5WJ7I7cOD9qGQtpgQUO+xcy8YrmL4/db6IyeAz3
	 9xppEfmabHyYK+NFsXnG1bHDbv1PGspi49liJ/4TVomDaIZ7CgnBV05XKJWXO2t4RUZiL
	 y9PVu0jmnjA4k6ZweC1pOoEu2n5yGyEbK1Kw2JEG/6jEgD1YwFRB2b7LtQw5OP9H+boxQ
	 7LT31N5RW0ZvUF5iw1Q2Qx4fXAZdFgmbmLdTL0XBDgo3vNF7XSHyGulcY7dVKEhWEDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lBLiPogx;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D3606EE81
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 21:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 402D3606EE81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lBLiPogx
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b547d6c07bso107548a12.1
        for <linux-watchdog@vger.kernel.org>; Thu, 05 Nov 2026 13:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793912861; x=1794517661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RhSdthgY4lzWyxqScK60PBXNBhT02yTKoURJd/H/bvo=;
        b=lBLiPogx1HagL7iJ7wlCKBNbjtZOWQYJSYWopyI3EcLhp5+tDMsSb1VypBbCqJI7Es
         FtGrSTadlBFXArfHaKP96K9I/OHUrjU6CjAUlpXwKmB1BPA0jy4H/1vNhQBJix866N82
         z5TYyoTe2YCK0LYgFhqBDXXiwxi12kgntXz8rU3DKCvBn3khzFj1+OgPUD9lWMOlYVXI
         o4XddsNk7LnJvCxTMiDSz41RW5AKxHIhjBjgW4sAGEhe2kPXWqIiWRONxdQk0eb/4NkU
         iKVLVs3onVQgBhXFg2Mt2UikWLw3YzkyuBCvtJI/gPkWjEMTiJy+qDZMiLthBfI/pQAd
         f8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793912861; x=1794517661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RhSdthgY4lzWyxqScK60PBXNBhT02yTKoURJd/H/bvo=;
        b=CuFjqxdeVAqInPkdlC07a/m7RaIDzZdezuuG9Z45AGCw9wUYpv0//2dpQyx1Mb+fli
         t9jtSgxl3v5eAL+uSAcEZq7baw/PYTtFH7qTOeV/RKGVkLBEKOJxhPoJcQyBe7n07+Lo
         2+9D9MOk3E7oipXFsuU9eWmYUD/Mb+x/XYPbW2o82f68f7embAgUlVjszdSNraiEq/7c
         xgC7ZWsJKoJPniSuc+44OsWgNfWnNLsNiYsJyE9lY7eDjdmrFxhcfaw08mRsluRekpdK
         e650MBcUob6gjg5PkoDGlkaL6iayR3O6FN3aAJEhmuYcj7EFMH9ubSKD8HFaASLY0nYl
         20gA==
X-Forwarded-Encrypted: i=1; AKwUvBwDEERvI4sn4Y1DtTZq+QAekIJFQDaYK9TIOwUI4EdoZVHNJfMiX8kcwwiIG1xtbKdcvb5A5Rsr+LFiEJsLtA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/7XZ4j5bvQsa5ptXHGWuenttulzLM1nVaLegu/5t65+HXOizZ8
	96WGzAh5wq33UuoRDTZavqfp2L60DtgizB86mV1c9hAY7B29LWlCpJNe
X-Gm-Gg: AYBFou1J1ZPst6rWHVToYCMbeCXjui/zIcM2qkn09is+afn8FXHCNk0Tjd2Ht9HxV4M
	FGOuSH3nO4QYlBAT/rSt5ScxL4tlxbXR5DlfDKViyXnGstprLibLsQHMWS1i5V6QeIPuMAdea56
	SSHOzdk2V3HNFliUtpJz8hTAtIReGwX+Z3t3YWJuD0xB+pZStKDCLalKuaAN4GshoJ+83mTPga9
	PAo/mBc9LjP1JdDsjJsP+WDO5k7OgJburm0B0VJIf9iDnLKCTrJ4NLD2BMwmSzzEJxMght+RtMF
	qUTreZVOr38m91N/TGy/mLaeUttRnsw7vVeTDmVqqpAFv2N1aB5V78yIKiZY5BPyVi76uyvdKmM
	ogLD1SbTGPC2DB6HFJ7fASm/ivV1Es4O/BYScSnJmX35U+hvRRkYl5EhhG9ell+Dcm1+D5Z/Pga
	hxZjQO7ddIWRhO418wCQY3Ip8bXe5dhL0TL6Gq66WXuKBNqXfxheoAvOuWbPsZ7ZF6AtJWN03yx
	B7vU1ERW7QL/6ZG3zB3bP+l8/8UnIM5E1jHKuKJkHERdEjdywE8fwiZQwT7y8yIuX2hFVS1ahA3
	xnGiNc4I+3pVhyeogn7SetZRIpt5IaTWl1H0L+SOQaR6DpYI+w==
X-Received: by 2002:a05:6402:1d55:b0:6b3:d0a0:3a2d with SMTP id 4fb4d7f45d1cf-6b5975296a1mr338144a12.1.1793912860655;
        Thu, 05 Nov 2026 13:07:40 -0800 (PST)
Received: from letov ([62.41.24.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b55ac6d032sm1966949a12.25.2026.11.05.13.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 13:07:40 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
To: devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	Alexander Letuchiy <asalde.le1@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] dt-bindings: watchdog: mediatek,mtk-wdt: Add compatible for MT6895
Date: Fri,  6 Nov 2026 00:06:01 +0300
Message-ID: <20261105210622.523747-4-asalde.le1@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105210622.523747-1-asalde.le1@gmail.com>
References: <20261105210622.523747-1-asalde.le1@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible string for the watchdog of the MediaTek MT6895
(Dimensity 8100) SoC, which uses mediatek,mt6589-wdt as its fallback.

Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index f9b725592c27..cac7d9ae98dd 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -38,6 +38,7 @@ properties:
               - mediatek,mt6572-wdt
               - mediatek,mt6582-wdt
               - mediatek,mt6797-wdt
+              - mediatek,mt6895-wdt
               - mediatek,mt7622-wdt
               - mediatek,mt7623-wdt
               - mediatek,mt7629-wdt
-- 
2.56.0

