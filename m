Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459363C3453
	for <linux-watchdog@vger.kernel.org>; Tue, 12 May 2026 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618947; cv=none; b=rHSCaoPoL5ohY6cM1WKsBnj+E7uTCUEZLVq0/YFGmw0quKDhcM8GJ8HM8ppdsbUmjArtGVtEGXvRKOwrHjvdmXz7FDtZ7tfRNL7cJOw3K85EY6vylrgXY418ZO/Y/3KuwanE/inRfoos7EiXlm4EO1J1X72YFkGUIc7H85QmcvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618947; c=relaxed/simple;
	bh=4VGZCM4DJurdGAv5vaJfO19NBUWPXOMgsmX3cLWyJyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cItOkEbxVFSlnrhNjg8xPlq7bGsRac1z2eWfuSiMqBHF7kBYkxuBwyywKXuqeyqR7Q+flqKbStENKdz2KNTZYz8VDhqyAwQ74qJfBzTCHtVRdXQse/bDBbSqnOGW2WmQ444GM/LiR1mJUSAFU92tz5FNuSkjpT1R/w/ARxvNmn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=7LLjVDTh; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="7LLjVDTh"
Received: from terra.vega.svanheule.net (2a02-1812-162d-3d00-c381-7255-a866-916d.ip6.access.telenet.be [IPv6:2a02:1812:162d:3d00:c381:7255:a866:916d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 81A4A77E464;
	Tue, 12 May 2026 22:49:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1778618942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZtyMSal9DIJfnTOP3Afrd4QkZ1hA7TOe+7/Ar2ZMuk=;
	b=7LLjVDThzfT47p3cCXgzuv22u/JE9ZLR/GtIWoCL6Q+I5y2j7MrKmJLlRms5puiAtWFFdl
	1lunHB/xXUOKSL3BO4vv8Bhs4vSclm6JckmXgOf/xs3quQoTah/UpYGisFeKYsy3psPp7E
	gI7DCEEUYy1wd3w8FljS7AbmsX2dESzY19kWoWtNBCaazwKlSkdgsEJunKIJq1PXNTGANy
	m4Wh8076zZOFP2vtlXDdu88NXYpjjJoC6hWrFBEO9+jZK88TkmvqudQGJSS9Crkp1OwpSx
	uOaJFcXN+4iyRGGEiplXJ3kJ5nQZEU4bpIxo/u1xRJ7mfOscJfXQ8NrXc7YK5Q==
From: Sander Vanheule <sander@svanheule.net>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Rustam Adilov <adilov@disroot.org>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v2 1/2] dt-bindings: watchdog: realtek,otto-wdt: Add fallback compatible
Date: Tue, 12 May 2026 22:48:53 +0200
Message-ID: <20260512204854.8931-2-sander@svanheule.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512204854.8931-1-sander@svanheule.net>
References: <20260512204854.8931-1-sander@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As all known hardware instantiations of this watchdog behave the same, a
fallback compatible can be added.

To remain compatible with existing single-compatible bindings, the
current compatibles are duplicated. New compatibles should only be added
to the list with fallback.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
Changes since v1:
- Fix indendations
- Add deprecated property to old compatible
- Use two-part compatible in example
---
 .../bindings/watchdog/realtek,otto-wdt.yaml   | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
index 1f5390a67cdb..e470e0fcbb2a 100644
--- a/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/realtek,otto-wdt.yaml
@@ -25,11 +25,21 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - realtek,rtl8380-wdt
-      - realtek,rtl8390-wdt
-      - realtek,rtl9300-wdt
-      - realtek,rtl9310-wdt
+    oneOf:
+      - items:
+          - enum:
+              - realtek,rtl8380-wdt
+              - realtek,rtl8390-wdt
+              - realtek,rtl9300-wdt
+              - realtek,rtl9310-wdt
+          - const: realtek,otto-wdt
+      # Legacy without fallback, do not extend
+      - deprecated: true
+        enum:
+          - realtek,rtl8380-wdt
+          - realtek,rtl8390-wdt
+          - realtek,rtl9300-wdt
+          - realtek,rtl9310-wdt
 
   reg:
     maxItems: 1
@@ -74,7 +84,7 @@ unevaluatedProperties: false
 examples:
   - |
     watchdog: watchdog@3150 {
-        compatible = "realtek,rtl8380-wdt";
+        compatible = "realtek,rtl8380-wdt", "realtek,otto-wdt";
         reg = <0x3150 0xc>;
 
         realtek,reset-mode = "soc";
-- 
2.54.0

