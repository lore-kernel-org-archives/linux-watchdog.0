Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA1547057
	for <linux-watchdog@vger.kernel.org>; Sun, 27 Sep 2026 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521786; cv=none; b=oMU5dWhmNIda0o1ADx1w4/jAtmQAmSOlhxyKjbfdr1bSFi/rrtvSJ4Q90MHscqrSHTUK0MrlrwfdZTzOfRFG6ieYi762d2unMtean4+D//NNZEfYbNzJ2Ze/wjzC3Uslh7ofw33M+uLCBxkBcMtx/tLN1uVLtlgscOpke6vVvKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521786; c=relaxed/simple;
	bh=p2QziX6Yr9oJV15zZupHjp39yfCoWC7cAf82zLLrkq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=t3ZT8NRG+ckMekPZOESVOZLeO9W34ihG6R0aS+rcaOAZiv6ZmYSdPb8rIATjStH87eY9YtbPHVgyWAGRGQ8X/QRUR5neYs1Qo56Ya5myov1ZoPZErPDy/yFPeKnzBucW01uUsZKmnJnOH9pGCldKm+toYcm6SlQZCm9ax677aDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ReJH8wAH; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ReJH8wAH"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260927150941epoutp04ba7d9105b14048d243a8d123a74e8534~ZNhLh_XTH1959919599epoutp04r
	for <linux-watchdog@vger.kernel.org>; Sun, 27 Sep 2026 15:09:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260927150941epoutp04ba7d9105b14048d243a8d123a74e8534~ZNhLh_XTH1959919599epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1790521781;
	bh=Kq0uqHcRoNnQto0WFfv6vWxpkUwcedmqHSFRxchgAg0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ReJH8wAHFbUxVK5qWtrXhic8jmwE6i6OrzBoLA6hGgSFCd0dd5ptL/aF9yKShwRvH
	 bDdX9vT5IzDHf6k89BUVL+VJZK5vOVE4nfQjxQNdNMoej6nVCTzI2w3ybJIydgVz+6
	 04IUb6/ReJwjFR2uk1teNjTDl8A9dejPc5Mc9RkI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260927150940epcas5p23b41e21afcd67c2a282f4400c672b0b3~ZNhKMW-RS0467104671epcas5p26;
	Sun, 27 Sep 2026 15:09:40 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.91]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4ht7C71SZnz2SSKY; Sun, 27 Sep
	2026 15:09:39 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260927150938epcas5p33b7d0495f8d9a8e84bf5f09c66e757fb~ZNhIvRgCp0736707367epcas5p3l;
	Sun, 27 Sep 2026 15:09:38 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260927150936epsmtip1fc634794beae369a5d211402f6f841ad~ZNhHGK8KU2057020570epsmtip1v;
	Sun, 27 Sep 2026 15:09:36 +0000 (GMT)
From: Alim Akhtar <alim.akhtar@samsung.com>
To: krzk@kernel.org, peter.griffin@linaro.org, robh@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux@roeck-us.net, hajun.sung@samsung.com, wim@linux-watchdog.org, Alim
	Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v2 1/2] dt-bindings: watchdog: Add Exynos8855 watchdog
 compatible string
Date: Sun, 27 Sep 2026 20:57:37 +0530
Message-Id: <20260927152738.3673504-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260927150938epcas5p33b7d0495f8d9a8e84bf5f09c66e757fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260927150938epcas5p33b7d0495f8d9a8e84bf5f09c66e757fb
References: <CGME20260927150938epcas5p33b7d0495f8d9a8e84bf5f09c66e757fb@epcas5p3.samsung.com>

Add the 'samsung,exynos8855-wdt' compatible string to the Samsung
watchdog device tree binding documentation. The Exynos8855 watchdog
nodes use two clocks (bus clock and source clock), require
samsung,cluster-index and samsung,syscon-phandle properties, similar
to Exynos850 watchdog implementation.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
* Changes in V2:
 - Fixed Sashiko review comment
	- [Low] dt-bindings: watchdog: missing comma in samsung,syscon-phandle description 

 Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
index a32c47831577..3f8c3e56ea07 100644
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
+      Exynos5420, Exynos5515, Exynos7, Exynos850, Exynos8855, Exynos990 and gs101).
 
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

