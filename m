Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1743D40DB59
	for <linux-watchdog@vger.kernel.org>; Fri, 24 Jul 2026 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884515; cv=none; b=RrDeyDNWlyy422qKjeS6kNlqhnouHmaDTkup/yG5UkGFy1mmga7PLEquj7irFjh5BlqtZqWTetq4yuoY/0RCvvfSRB+NG2xpy8nJHXarZicqecokdgRxlUn493/BJtzmpPZm7BTCAYt0ZkICGnsc6jSouGJ1BdXZZvszibygY00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884515; c=relaxed/simple;
	bh=yKkOBIWDLVzZbrFG3yiQLyXNfyi/iupP2ISmcl3yvxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UIdNWWb3QgRJNuUfNiz3CEqUnLw6XtW7V8dW0B5GLqRcKyP4GEPLaBVCZkCqLpFdcoSZ+Qo86lptrday36N+tBLFIqJtskDA0rA6/oYmi7tIQ7O5ftxOvjZVqJZ5hGC3FKeqhH7wOnySE7sOXFFbjnvGlHhmtVuZDkislOXLO2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAv6dcXe; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAv6dcXe"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84a652535dcso84185b3a.3
        for <linux-watchdog@vger.kernel.org>; Fri, 24 Jul 2026 02:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784884513; x=1785489313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aUz1mWBpB/XSD0ZgFsInGJUX8h9hfweN14oEZfYpX44=;
        b=jAv6dcXePrxt8FCLYrkVcjLb/PgvrIFQInCmW6JXs2MylATchqRHhOoIhkkHl4Aqwt
         9n/8MxA7sMX5fA4H9CXTWz2ehszK4rcuqM7r4tXyKn18ajibHKMVPdtd3ykzGX+yB3MK
         P0yPNp0HfL7tEpWFbNPOvgpYwRtyfduPdjJrAHjXmWwDw5p8bRg912pTZVfAjOUf4eUJ
         Q5fxUdhSwGuiwDep28rrhiHNBItk6y3w0bAOMYvrPnSLXcI9PCevKEdQO2nBCR4KHPkC
         UP3haOwM+O4iemClMxyMzWY81uAJR1vWJ3cDExBIXkC+Gz2uoSXWzwsrJ4+T8xPgsNgX
         nvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784884513; x=1785489313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aUz1mWBpB/XSD0ZgFsInGJUX8h9hfweN14oEZfYpX44=;
        b=Xj4YoKt8RfHldQyRLmh23BBnFKxCrj2SMMBU+WgJSQiMYJTnxg3d1BQiM6Be0kRLOE
         OMcQbtdQhETtMl/laqX7VWlvKc477CsLy2mkrzTgZVLQA3nVWtAotCDSPQ6SnxZbufs3
         HVq4mm/tfXAcfBjQyqynxoPGEcJT7ZLwe7xbZxMfsxlJhsNQr7naGKhK47I7qZL+Xr3S
         qXhz+W/TNFoOzlfXAiUTpe+zhzblXcoM2U0iu3NH65SUtOi4sFwFwjqX7Ru30ThodHzF
         bcG24Lb5Z9fbA2foBbVM+XVG5GnuGQLCwKRSU5+jICadS5rIXjkPfjishK/NyLEz4mh+
         g/3Q==
X-Forwarded-Encrypted: i=1; AHgh+RqRbQLkIC9GsTubHMfXz+iGPQkplOLg9xa/ZnAxNFvc+B3+hQzUwBueF9HcjlOnDTLoZq2ZBEnXoSo1zgjeZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3+fIL4CZLbJFrKKfnspasJVS+x5XCnlr8IJt0kWTBcoLqMfoH
	ZO5W1n5JQ/s+WhR3lCX6v6vBVD5+CB0YdR6s5qNx7RC4v13XH2BXjsxj
X-Gm-Gg: AR+sD13847KquCl8gO042vMFcQ6JExJ3vPvk0P8HAPKTIMdks5j8n4P2GfQdsj8VD5J
	BI2pvcad/I1P6JClgsAWuzUjJs+RNk+U0epiXbgdMZnE/OWWxTHH0d6/9xkBXWuR0cEMQ8DBuZT
	O+64K5d2yblNUMRgiKwDEuE5jxXQyLnJLDdQ1B5OcUWieSFJaqUuZdt05D7ynNB1wVn1yjJUrPC
	RMTTkxiOOWFCIgc7HlHrcD2qiNrCPkXnpu06nAQ6YP1BxLtOwy9nLP1yzaERn2ujyidrtoOko7S
	u23n9BVwm1zANouLsz74aY/iIsMG0DAWJHHKSdnGorU6xYLctqayPuWv/p2uchmmMsIagLf+5CL
	oGlabfgh56CAediPvH4N+9V5psqqz8GZUz23LI63h8dkpNhGqmD9cBkOZT/asZuL0uomVGbqt3G
	peQKURoULLmuqyKauqMWzelvyAWtRYZ4eeUaKKnyhG2JrrIPRgT0TNQ7zJN1s6
X-Received: by 2002:a05:6a00:180b:b0:847:973b:3d04 with SMTP id d2e1a72fcca58-84e2b7e7296mr7121012b3a.10.1784884513359;
        Fri, 24 Jul 2026 02:15:13 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17237c3fsm4410519b3a.9.2026.07.24.02.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:15:13 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: nuvoton: Add WDT node for MA35D1 SoC
Date: Fri, 24 Jul 2026 17:14:27 +0800
Message-Id: <20260724091427.1689980-4-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724091427.1689980-1-zychennvt@gmail.com>
References: <20260724091427.1689980-1-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Watchdog Timer (WDT) device node to ma35d1.dtsi.

Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
---
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index 7228ad4735b5..14fd17cfdc5a 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -82,6 +82,13 @@ soc {
 		#size-cells = <2>;
 		ranges;
 
+		wdt1: watchdog@40440000 {
+			compatible = "nuvoton,ma35d1-wdt";
+			reg = <0x0 0x40440000 0x0 0x100>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk WDT1_GATE>;
+		};
+
 		sys: system-management@40460000 {
 			compatible = "nuvoton,ma35d1-reset", "syscon";
 			reg = <0x0 0x40460000 0x0 0x200>;
-- 
2.34.1

