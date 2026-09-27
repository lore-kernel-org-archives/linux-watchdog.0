Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2203EDAB8
	for <linux-watchdog@vger.kernel.org>; Sun, 27 Sep 2026 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790518388; cv=none; b=dcuA3wDu9yp+ZgGcHnlf7XRdMRdQ0kOkefyL3DNA8LRSqv7GtjpgdwZ6wEQ2IG2DCXDAB0Ttjw3GFo58QVNJz/1YIWe/cVF6TuWRj2NC1AAq5PBMr4VRcSq3h8N6jeA41yZMgVeyDY9lac6iEqIgiebAl+/qhbffvVMGxocKIDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790518388; c=relaxed/simple;
	bh=n1oTma4CHJHlr07UFERPMOUAKaqITTbrYwG7n0Bg834=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=RFtpy8YsxqprUNREkIsp/q7vSS7d0PNHglr9Skiw5wR14puf940fbOELgOE8UiQ+dLabZHlE/iIrfo5x1yiGxL6mMcAwMnN2lUaKvGyFHCmwoDIIfs1V3Zfyi0osMtwQMUVLs4fjNZEjMVM0A/WlC+EQT9w/iFpN3xckr789y7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=c8dRyYEy; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c8dRyYEy"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260927141256epoutp0307956655b54206c694762d2dd43612fd~ZMvoUcfD-2337823378epoutp03V
	for <linux-watchdog@vger.kernel.org>; Sun, 27 Sep 2026 14:12:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260927141256epoutp0307956655b54206c694762d2dd43612fd~ZMvoUcfD-2337823378epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1790518376;
	bh=PS6eCa2NZNuq64ET4dYTcNZjHyvP/yRqiPXWx2KBgcw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=c8dRyYEyZ3Gz1uoMZxEELjLuvUHz/AnRJFAWALBPnPQidlDKYl06LT6mSYCMAXdWc
	 BUF9zaVPdcd12ZTGFU/xwW1OwuMbhJzsYndaL9umcEAbCf7TikBc0lts6t1A4BcXOm
	 D+2Ap0Jidl38SLKP95MHAYKLOCSjXvFIfu5krDRs=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260927141255epcas5p1088d4a50e979e74a6b018b4bdf8c00d2~ZMvnHMNIk2230922309epcas5p1W;
	Sun, 27 Sep 2026 14:12:55 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.88]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4ht5xf1xqgz6B9m7; Sun, 27 Sep
	2026 14:12:54 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260927141253epcas5p371d497edc6756f13ce2215af4f380fb4~ZMvlfjE8w1569815698epcas5p3E;
	Sun, 27 Sep 2026 14:12:53 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260927141251epsmtip176f4593c5d43b70bc2326ba33f240016~ZMvj2IvIW2206322063epsmtip1K;
	Sun, 27 Sep 2026 14:12:51 +0000 (GMT)
From: Alim Akhtar <alim.akhtar@samsung.com>
To: krzk@kernel.org, peter.griffin@linaro.org, robh@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux@roeck-us.net, hajun.sung@samsung.com, wim@linux-watchdog.org, Alim
	Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH 1/2] dt-bindings: watchdog: Add Exynos8855 watchdog
 compatible string
Date: Sun, 27 Sep 2026 20:00:59 +0530
Message-Id: <20260927143100.3576195-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260927141253epcas5p371d497edc6756f13ce2215af4f380fb4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260927141253epcas5p371d497edc6756f13ce2215af4f380fb4
References: <CGME20260927141253epcas5p371d497edc6756f13ce2215af4f380fb4@epcas5p3.samsung.com>

Add the 'samsung,exynos8855-wdt' compatible string to watchdog DT
binding documentation. The Exynos8855 watchdog nodes use two
clocks (bus clock and source clock), require samsung,cluster-index
and samsung,syscon-phandle properties, similar to Exynos850 watchdog.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
index a32c47831577..517c0e1cd78b 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
@@ -25,6 +25,7 @@ properties:
           - samsung,exynos5515-wdt
           - samsung,exynos7-wdt                   # for Exynos7
           - samsung,exynos850-wdt                 # for Exynos850
+          - samsung,exynos8855-wdt                # for Exynos8855
           - samsung,exynos990-wdt                 # for Exynos990
           - samsung,exynosautov9-wdt              # for Exynosautov9
           - samsung,exynosautov920-wdt            # for Exynosautov920
@@ -52,13 +53,13 @@ properties:
     enum: [0, 1, 2]
     description:
       Index of CPU cluster on which watchdog is running (in case of Exynos850,
-      Exynos990 or Google gs101).
+      Exynos8855, Exynos990 or Google gs101).
 
   samsung,syscon-phandle:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
       Phandle to the PMU system controller node (in case of Exynos5250,
-      Exynos5420, Exynos5515, Exynos7, Exynos850, Exynos990 and gs101).
+      Exynos5420, Exynos5515, Exynos7, Exynos850, Exynos8855 Exynos990 and gs101).
 
 required:
   - compatible
@@ -76,6 +77,7 @@ allOf:
             enum:
               - google,gs101-wdt
               - samsung,exynos850-wdt
+              - samsung,exynos8855-wdt
               - samsung,exynosautov9-wdt
               - samsung,exynosautov920-wdt
     then:

base-commit: 4c253ac4b29b8c6cc6fdef8f92d4facde62e63b9
-- 
2.34.1

