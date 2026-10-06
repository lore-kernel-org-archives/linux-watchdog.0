Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B702C358381
	for <linux-watchdog@vger.kernel.org>; Wed,  7 Oct 2026 02:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791340393; cv=none; b=desgCJo4BYK+WlmDzlAxWkH4mDumDf4MqvRbMrfQOc1OYRR1YPe40KTJG+3rP2PlAVl/h789R3TT6bs30jAJJywR2nqN8gSc5uiv0oZTcDT5QS+MJnkxjBQjduBb/aB9Q775IfNLs18idnFsfDz/xJdS8ErbdWyBhj/a18jmMko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791340393; c=relaxed/simple;
	bh=Jseu3J9Z9LRdwBu6sFpBltuwRbn0Jpwrpc/YutIarhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=AuNtdTetNZ7prBrjkIZllOAGSbQaG2IuZMqL7g0MkxCtKeYmWbjoedzoVdCaEW0zOZN6O3W6ug2k2MnwjQaCt9Yawha95z7QqUOgYWwai+k7pp1F7xw//JamtsQcj8NopDZw+huG1LMs+N8PkHFSxuMtTyu+3brXS4623d+TZc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GXGd1Q3e; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GXGd1Q3e"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20261007023303epoutp025db8049ec290392330e7a4460e9787c8~cHpZsbXDS2661226612epoutp02h
	for <linux-watchdog@vger.kernel.org>; Wed,  7 Oct 2026 02:33:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20261007023303epoutp025db8049ec290392330e7a4460e9787c8~cHpZsbXDS2661226612epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791340383;
	bh=jKwNwCkEkgSOYRtI1B18gjkqbvozWg4m6K9i9c8GMtw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=GXGd1Q3eFS+alBTzo3UWIjnjVaN6Ok6F65AP4JsoW6l+54dmT62BdB3Tk3GebbtPT
	 aE+sZT66vaX6cwRPqBtlovvhbc4JUlJ98aSZptv8NF1zLHKzGU+v2S9rch+NXEuS0u
	 gKc57y2bSeDewGJkdDGgdvPmbbhP1/v7kf64RALA=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20261007023302epcas5p149f10e5761d0b750c53f480729b0b0ee~cHpYt-8Bx2398723987epcas5p1O;
	Wed,  7 Oct 2026 02:33:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4hzxxV0mqlz2SSKZ; Wed,  7 Oct
	2026 02:33:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20261006160157epcas5p37b8a0053c489b051dfb415c9b72ba178~b-CYauej62920029200epcas5p3v;
	Tue,  6 Oct 2026 16:01:57 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261006160155epsmtip20867d11cb4070342c00cb9349c74d4f4~b-CWcOjBR1675416754epsmtip2Y;
	Tue,  6 Oct 2026 16:01:55 +0000 (GMT)
From: Alim Akhtar <alim.akhtar@samsung.com>
To: krzk@kernel.org, peter.griffin@linaro.org, robh@kernel.org,
	conor+dt@kernel.org, linusw@kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux@roeck-us.net, hajun.sung@samsung.com, wim@linux-watchdog.org, Alim
	Akhtar <alim.akhtar@samsung.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/2] dt-bindings: watchdog: Add Exynos8855 watchdog
 compatible string
Date: Tue,  6 Oct 2026 21:50:03 +0530
Message-Id: <360067785.01791340382096.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261006160157epcas5p37b8a0053c489b051dfb415c9b72ba178
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20261006160157epcas5p37b8a0053c489b051dfb415c9b72ba178
References: <CGME20261006160157epcas5p37b8a0053c489b051dfb415c9b72ba178@epcas5p3.samsung.com>

Add the 'samsung,exynos8855-wdt' compatible string to the Samsung
watchdog device tree binding documentation. The Exynos8855 watchdog
nodes use two clocks (bus clock and source clock), require
samsung,cluster-index and samsung,syscon-phandle properties, similar
to Exynos850 watchdog implementation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
* Changes in V3:
 - Removed comment "for exynos8855" as recommended by Krzysztof
 - Added Reviewed-by tag

* Changes in V2:
 - Fixed Sashiko review comment
	- [Low] dt-bindings: watchdog: missing comma in samsung,syscon-phandle description 
 Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
index a32c47831577..37d9fc9b68f4 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
@@ -25,6 +25,7 @@ properties:
           - samsung,exynos5515-wdt
           - samsung,exynos7-wdt                   # for Exynos7
           - samsung,exynos850-wdt                 # for Exynos850
+          - samsung,exynos8855-wdt
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

base-commit: bf1ee2bd5c2da8992f33c8950ef194aaff74ed6c
-- 
2.34.1


