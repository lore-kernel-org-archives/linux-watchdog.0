Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058A43F54B6;
	Wed, 15 Jul 2026 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106740; cv=none; b=j9Bgko/NEoyRBKQF1vBqYrI8R0/HEi1bPMNALTazDBhrptnsGnL1nYgH37LHe/pJNEq7U90KKmDEN4mJzQzvvtvuF3RCG9HqCvDv6IVmIrXaktMgIt1tkMX9IyVKDjBlL5FqXw/NDg5Z34d2w1vuyKX9FtQKc2bCwsZD2aI4FBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106740; c=relaxed/simple;
	bh=w+oFqPQZyO4mUC8Cq1D05yyJUaa6OXRaWufm8OBJuxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lv29WPsqn5wBEfDPTJl8xlFa8tmbSqAPPTXog4hDgcMtGuiQ5rFV43Hg8d5A66Xtcp5gwDUnZ0DofN4T4eTI0DtVJ3103XcC8pdJEOMaNzMeOOW2aypFJKPii+JZFzKkb4E0X8CoJxSbt1kirPfvgwy4UZysBJSlqm84QTJIo80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=KpIr//Fc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BbAnhkqq; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="KpIr//Fc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BbAnhkqq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A53A4EC01EA;
	Wed, 15 Jul 2026 05:12:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jul 2026 05:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784106734;
	 x=1784193134; bh=l5iJGCuDJqu0rB7KJB0ciLbI85LaXK0Thagu9DQ0mzk=; b=
	KpIr//Fc2K3H3eAFCjT/QhGb4umCLbu2k1G4vyU+1STAH+3JsFlOmBBfMc23xyCH
	WwYz4N9VEmM/A350SFp3qfrR+Wa4+k2aCmE6f5BmvHb5AJR1aKrd+yU4iyWEkNha
	xPeafVyP625XhX7x8gMcSb9R69eiyHWF2uP9LBKbT1N0sJuGuPo5MzOb+9jtIdxr
	C4rCGR7r1iGNwkghOR4MT5233+m9g4Rb7DulgM55SsCU+x4Qsyo/ZtFr5Bl0k7o+
	7hZI5jBFwy6JtxmLgzQ6BrdjGj5pnstpAZhhxx0wUPnPfBJt4n0hPpPsxMHd5ox/
	YdITKNCiQe+mt/e4/Sq9kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784106734; x=
	1784193134; bh=l5iJGCuDJqu0rB7KJB0ciLbI85LaXK0Thagu9DQ0mzk=; b=B
	bAnhkqq4SM/LwrXIfdoAAY7ZlrO1J00NHY7iHA92WxNphWNsCl2MpJ1+AEFsEXML
	RM6BcbMwzRlUU1KSzXj8kkf7HmvoYmX23Od9/Y5tW9ny90JMxP3/3U52I319LNzk
	dsC7P9KqMvw5TZPkMqM5ia3qC0SY1ijBteel8TxzRTd+570XwVZqCxSU7WwOCIaJ
	BxAIR791R97/jz5AofyyV3ZCQnocqLco3/r4SxtE1z9A5h+CvPoyapKAZV4vpfAB
	G48kIijolARzM+pzZ2dz0gSrN9bSrCrnmD/Ozy17iUjoRYiT1yl6BTpDcq3vZniA
	fDTHlDGxsp+ILnhNeI1uw==
X-ME-Sender: <xms:7k5Xau1ibRmYj5k7X-6Of7FsoVxzpGKbE2CvUGBQ48rt3QeQQUuRyg>
    <xme:7k5XahfB_pwr-AEzYdFTjysoJg0fDr4j4Cl0JeZaxxxu_bajqHl870CSXIFUMAsbM
    xnmgd-Qhmu0wQMxHBDe2qTLLlN8ZUDkm16iml8QdLn0VoLlHg4lEqs>
X-ME-Received: <xmr:7k5XaoDu4CtfJRoGcvqj_AsXxngAk3--vpouHC_tDSOeOSfQhVLmok77TMIuURMJ41EwIiIZ7RJqJUOnKUcib50OPUiDtvAlzALnmA>
X-ME-Proxy-Cause: dmFkZTFQ30NmwFVOxD18GR49RMUGPlt4wtzp6qHU+/Q42pWknwtU9lmQUE9J/cZRNpkV4h
    Oa1sghCZMC/sT0Wp9Ps62Q3CEBBPH+fXeRM2jIv/pxCbnWxTmCfjYxhLs6gUyptFQtahQg
    67IeBYoRdxli1SD565JS4xBQPDun3OvepuQ5bB9X1WasfmG2hVK8nPeLrIdzdnOOmmmA9f
    PIazLxjdR/wAjDHKdm/2ofcNrC3j+9neQwuzsXzGBE0ZobeFRdNyisZom1ah6GKNJU8Tv/
    W+zvxCnOsqb2dIlbPyff1onGFSTeckyn/bHUkdGMUwrZf5N2N3YlRAKwfrGfkUDwXQelEM
    oSZQzRU07pvbkiYJlvLTuHuY7IRM2Uy0xp1wBYaI3Wh7Y/LHZPn2k1GWlUiAlwvA4Vi7h/
    ADoL52IS/1t6KwL5LVrWQFNInGgDKM5VERyVuuL3p5ccaTY+43jzTZn8RXlG/u63MDeKXE
    miXNS9gD+f25mj6tN5qeZQa+Zb5LXC1mWGLyPf1IRlay/6PB0rmajPqhJ28Tzop7k5DtbC
    LesPr/zkqfB5VUcA8z8ecIN3oyaOvKB4oEb/W0m6YFn2n9V+MyEKqBHy3opP2YG5LUjPjv
    y0jCimxTB5kU61RAYx0LpeAbRkdROQ/gD0jFt8eMT20JJkzlZWP2gY5O3iVQ
X-ME-Proxy: <xmx:7k5Xar093kBpPJGnP7rxC2BTqz7HCO_vTAd7s1mVM2dja8q8XpH9wA>
    <xmx:7k5XagMcg7V1xU5R5J7q4856_NOAYiL1XWvzbA_Mkh9EwRsb3Hjh4Q>
    <xmx:7k5XahdHfSuJH_FxW6jt9kOJEqWGdzvRhOwgzDkRK1rI4HgA4v_kKg>
    <xmx:7k5XakOMj9P5INtix6OlXjZ0juf2aVesKQJA-HDLPezbp6U1iflsoQ>
    <xmx:7k5XarEo7l4uMxgQb1X4G7LPPZwjVYaguBvRu5xBPYHnnxFHpr1jjYKQ>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 05:12:14 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Wed, 15 Jul 2026 11:11:55 +0200
Subject: [PATCH v2 08/10] dt-bindings: pwm: apple,s5l-fpwm: Add t6030 and
 t6031 compatibles
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-apple-t603x-initial-devices-v2-8-df65b2485710@jannau.net>
References: <20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net>
In-Reply-To: <20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-pwm@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=j@jannau.net;
 h=from:subject:message-id; bh=w+oFqPQZyO4mUC8Cq1D05yyJUaa6OXRaWufm8OBJuxI=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxwv5tSUzpeaXmzxqbP0dmoJ/zZhSfb+dXMX4kRK8wud
 V04GXOwYyILgxgXg6WYIkuS9ssOhtU1ijG1D8Jg5rAygQyRFmlgAAIWBr7cxLxSIx0jPVNtQz1D
 Ix1jHSMGLk4BmOrJMYwMy2RYGs9Ozwg8M5/FWu1kcb+J5mLrQ7eKKm+uDhW3KNp4kuF/ri2H7dv
 Hn1+c91ies3bz1Br5R3/VitODvzcttpTVf+XFAwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

The PWM controller on Apple silicon M3 Pro, Max and Ultra SoCs is
compatible with the t8103 (M1) one. Add "apple,t6030-fpwm" for M3 Pro
and "apple,t6031-fpwm" for M3 Max and Ultra as per-SoC compatibles.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
index 25ef04b60ca1..dd95037ea5ee 100644
--- a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
@@ -21,6 +21,8 @@ properties:
           - apple,t8122-fpwm
           - apple,t6000-fpwm
           - apple,t6020-fpwm
+          - apple,t6030-fpwm
+          - apple,t6031-fpwm
       - const: apple,s5l-fpwm
 
   reg:

-- 
2.54.0

