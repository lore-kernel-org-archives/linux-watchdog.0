Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732871F09AD
	for <linux-watchdog@vger.kernel.org>; Tue, 10 Mar 2026 00:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773102052; cv=none; b=jhFSXpTax9AWp4uvvMd+tFHTF7EEXUA5SacSXOQj0UPfw1B6YKeEYeJhPdC2v1q1PfC/bgEG8esWnfBOS30nJP62qh9osg8igTf2J8nM5U6gvx1oRTEaYlcth9BYNB+j27/xMdmKrw/mWD0KCQgZ4BtlBiej56ijzex0VjmB2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773102052; c=relaxed/simple;
	bh=Y9PRrFLu7d08JWoBE3phrh5eFQ0D+N072CPAq0RCxh8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=POVhX6C+9D+plpXDG/f+yKzvIzl31JyRlG1+kgzIxAiOOSUurD/aFQJ2eDJmaNpqOlug9WxOrsUU2MubzCwyn/e5HxV4h95wv8vlGfd0Ri4MjZ6WEMlNRPdNTUM4HlTzpDVyUBzaBRRiKo6dIj5vmRVtx7TMhTSPFEgKAnOJoak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kxav+a4J; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kxav+a4J"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso12128455eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 09 Mar 2026 17:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773102051; x=1773706851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XTxiBTQPBxIEDJ+EdVXtbyWx7niATlKQS7MVfuG6I3M=;
        b=Kxav+a4JLnsfw2VEFbI34BiDfV8UIlJeC6DV90wGP+gGorPPMkMMvE6D2Mv2wm0kAl
         b5lS06oiZCSsNaGBD4LmLi/0oZqGrR66GQXQuq6MW8zrWSk0K5NEfvaRslH0NVcpeQjB
         4LYFcr3o6F7+aZsj1MCrJq2GToqKbF+Wb1kleZ1u2zxOCPwcKolUllV26QL0NWjv8F4K
         OptVyTZ27eyX31Joz7IXUEZEiiVFJjhhyCiHC3JePlxsG21VqVWsfVBO/45k9CtNDZKy
         0LF3sF3rFn52/7hEM6AbT6J7I7Bj+C0quVyrX7cBNquEQwlklu7D5DeMMaElr8y/G8QH
         40nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773102051; x=1773706851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTxiBTQPBxIEDJ+EdVXtbyWx7niATlKQS7MVfuG6I3M=;
        b=HtBlLJqRCxcOHrQZmfYv9JZQp8jQjOo2lsedMAYyapwmhT6lDaKr3GuahzBr6pzBuW
         nhLrEXd1IVFaEKa+/YnC8d3j12x9vNT4PoXVxh/GEamOCYMXpDg0WDJwYIn5U6A0F8kL
         wjeg0FJqALv3GWVeDGuqJxwmn7SytKXeGBeLWMLX1zT7uJvYwN1F8yxXb0e0OfZqjaFV
         JGAyiyry3l8vsVbKGvT2d+pMOl8V3f6e2f8/wPrtNCiPfnGWpoOGzvQ55hmjghz7cCni
         ck6PGSQn022gA9FJZ6eXVOocSs2JN5R7TVj1fWKE4fejsy55rROEn/iTvTOvPTVZDZ1F
         P4wg==
X-Forwarded-Encrypted: i=1; AJvYcCXFhY1YdOR5gvQrV/5L8hfSD+wohjQchntZaNgvqjgtxdy08BfG6XleFeUZ5BipG1M04Mm42ABSsmv99j2vFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYT/LmFrGhhivLsKhu7R9zsxhAUETZnvn1m53ZhmkvPBqxWB2
	LzGQKJx4yYuO6Um2R8q/NOLTidnLleWfrr/R0AY0OgNkhrDryO3ffpWq
X-Gm-Gg: ATEYQzzKPOjLZwAIKo1/igSTDZZeOBxZeff8DIJ2Io8VaPRQl/w+zueWoqKMpM4tk2B
	EJsSlvInGdtwH3YB6f0kEgs5Hbce5K7M2qJjhVlJuJrnDm3mJbiaT+cfthNO5X4VdLeI0dYe2XR
	ZPTVqYebuxChk9iytBZuPbXnyZNmkWPTEq762OTxhaGskJqfnyC6TdjzGB2K6rSvudOv4jgYKKC
	nO0QL3aOgl5bedNEGk4dWplwlC78Mqp9p58lzuV/tTxA0310FHtPk7hOI7ydCg70sfIha9p6KYp
	ojp0sgdPXm8ryo7BgBZpCjwPP6kTOaxTlo71PAusgMgrWBynkD76jsFaQzupaVpIT18bj2q8WEW
	egpGSA5/nNFMSwhw/TwTE4TIqTeW1pqNPrxXd8Uq9SiBUQHlLR9vMw2xRj+dpL4DwfI7VrckB20
	KJyOSiLW0Mr+RkVn2U7sBXdmGLn8MxfMh3gD66xEySs9PeIXkoFxTtZ7krOkxQSEKJWWMM
X-Received: by 2002:a05:7300:dc91:b0:2bd:b325:8d91 with SMTP id 5a478bee46e88-2be4e0ac410mr4697894eec.29.1773102050467;
        Mon, 09 Mar 2026 17:20:50 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a802:e566:5060:45a8:d0c9:5e8d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f82b1d3sm11214357eec.11.2026.03.09.17.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:20:50 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: linux@roeck-us.net
Cc: wim@linux-watchdog.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de,
	Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2] dt-bindings: watchdog: rockchip: Add RV1103B compatible
Date: Mon,  9 Mar 2026 21:20:40 -0300
Message-Id: <20260310002040.417424-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@nabladev.com>

The RV1103B watchdog is compatible with the existing DesignWare Watchdog
binding. Add the rockchip,rv1103b-wdt compatible string.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- Fixed a typo in the devicetree mailing list address.

 Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
index 609e98cdaaff..141c72909b15 100644
--- a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
@@ -33,6 +33,7 @@ properties:
               - rockchip,rk3568-wdt
               - rockchip,rk3576-wdt
               - rockchip,rk3588-wdt
+              - rockchip,rv1103b-wdt
               - rockchip,rv1108-wdt
               - rockchip,rv1126-wdt
           - const: snps,dw-wdt
-- 
2.34.1

