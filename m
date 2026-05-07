Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD833E8C5A
	for <linux-watchdog@vger.kernel.org>; Thu,  7 May 2026 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778149464; cv=none; b=Hatoh8DIc6m1Pwfe9a6bCZ1t1pQwA4MUNRYsCYrWToUEIQHelPZkkxEBNkYUR65MFfXx0cHcA4m6EJ12mo03fNv9NSTYY8ar+nEFEgIcDtceH74s3Snhu1E3DI6LGkkAQyCwSR/6JZ7RdU2YhT579rFZVmfulqay5JADtuvqhBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778149464; c=relaxed/simple;
	bh=xLItpHp5TBBqQSHKt1AyvZMI6BdB7ounnndiLRLnbDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brnbab0AlYCtTIgxOs3FgICWp2+ipyzs4fQmIb/wSc6VJbfQ5vcGfIrDiR7noJvgF0gjIAo9Cqd1sGJkbnXE8UH7su+T3MKb7/bHDVk1r/tpEBkQ+xJKpHORpYVRxCNczFkzxCiSv2Pt92bjNQplyhko6N8sLVj1fEvUZm+uRts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=PF/YFgVM; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="PF/YFgVM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=x204kEcNWD8l+gW3+BddW44FnBixr/W4KRcDG6+368o=; b=PF/YFg
	VMI9zfymicWCDKyvkXcHDgN5qfNSAjUfFChDw4MtwVYY139coRmmjV0GxfiBsDsW
	2hhnb9lsvtsh4d/YMfutjJST+GlP4gEMBkq9aOT9ZHt+weWF/U+WQl3pcUNYG/TH
	Q5+EV+ZMsD2ckA0i/TzVsVcX/4nmLA3m116By8m0fPfOBNEPwywJsX9sTWyp2FDn
	JR65JoqoIP4Xok51fUYNC+kjoUlQVCiYRWHvVRJoy5wfmToMo866ETqft9C39iYP
	DU763HTxb5THWGtretxq4jFnlCoXstGH9s6YbJyMSLHxhaRyBrQ0dk1FTTtxAt3l
	ZVV8RwGVSXej9hzQ==
Received: (qmail 1070506 invoked from network); 7 May 2026 12:24:16 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 May 2026 12:24:16 +0200
X-UD-Smtp-Session: l3s3148p1@o9CwrjdR1ucujnu4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 4/4] dt-bindings: watchdog: renesas,rzn1-wdt: interrupts are not required
Date: Thu,  7 May 2026 12:24:09 +0200
Message-ID: <20260507102410.43384-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260507102410.43384-1-wsa+renesas@sang-engineering.com>
References: <20260507102410.43384-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is now understood how the watchdog can do its job without the need of
an interrupt. So, it is not required anymore but optional.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml
index 7e3ee533cd56..0e4b5b529e9c 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,rzn1-wdt.yaml
@@ -29,7 +29,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
   - clocks
 
 allOf:
-- 
2.47.3

