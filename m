Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E2442885E;
	Tue, 18 Aug 2026 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076210; cv=none; b=ApgMRusvLU3nYv7gMAFDYF7fywHo36+eQB7eCT8OcOLgLrblzEVbgqKyZo7s71JM0/4RZbOL9kZu5J/Bmc8ykwzIsMLCuzGVlnmlGvhGME/bknUwCuPSPq47l0bDH3tqXqu0COnKbfpHf8XzQqYyAzT0u4hEu0D7H1PozkvXxTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076210; c=relaxed/simple;
	bh=NxlBY+QLfLmAZPcARcDdEqlxKsH4KI7HO6myhnvxzaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QBLAe/a41IRI+2f13ow/Mzou3Xz6ZR9Bumfi3jJIzNVbskTYGD5rOkH53lmmI0iD6Z9GLqgjSMs+xv5CrItNCFdgdIA28y+qWXsdb05UHksEo6982DKBdsn9Mv5zx0dov0erHaA+W4VaHY7WosIe8Cjr5xdNEyrbPzJddQk/XjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d34bXk6K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d34bXk6K"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21619C2BCF4;
	Tue, 18 Aug 2026 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787076210;
	bh=NxlBY+QLfLmAZPcARcDdEqlxKsH4KI7HO6myhnvxzaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=d34bXk6KwNGdq6rG43dgNtKUqITOpvwpSkVCfOS0II63bZPtuKq4veEB3rxi6NK3J
	 2FyeyaGkyvPMBld7CJPdx5RQHaxybk44twYEF2X0ByHR9WZV59GJhZxT6PWZbnfrpY
	 zMZWpBNWskJfw+jW0YB/9kKKfAKM0eEmWboynjmpoK7ESFC4PVs644TIxGDMCG4C9I
	 /UEc6hG/f0z0/YmpReSKOSi2r2E4M5cDMibDvfM6mzeTRZT2Foi04krskBiYBzHAWQ
	 Dcoshuyif8GiDeG/onh8k5NCxUWHFzhgmNcQbVDIp6Safnq0pMOZ7QeaBU/bJCd2un
	 vxsWUgMZjOvWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9F1C5DF82;
	Tue, 18 Aug 2026 18:03:29 +0000 (UTC)
From: Aiden Isik via B4 Relay <devnull+aidenisik.member.fsf.org@kernel.org>
Date: Tue, 18 Aug 2026 19:03:17 +0100
Subject: [PATCH v3 1/2] dt-bindings: watchdog: samsung-wdt: Add
 exynos5515-wdt compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-for-next-lucky7-watchdog-v3-1-2912bd122c57@member.fsf.org>
References: <20260818-for-next-lucky7-watchdog-v3-0-2912bd122c57@member.fsf.org>
In-Reply-To: <20260818-for-next-lucky7-watchdog-v3-0-2912bd122c57@member.fsf.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-watchdog@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Aiden Isik <aidenisik@member.fsf.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2313;
 i=aidenisik@member.fsf.org; h=from:subject:message-id;
 bh=FomCRWunoZv/FcOKS7xgccqo7tYm7xEPkwn4AZZPbfA=;
 b=owEBbQKS/ZANAwAIAUknAbLEetfrAcsmYgBqhJ5q6l1KKMnV2P6Cn1UsoP5ufTSgNjAGWZlvj
 kdMw6exdGqJAjMEAAEIAB0WIQSDy8UkXGpc3JNbEaVJJwGyxHrX6wUCaoSeagAKCRBJJwGyxHrX
 6z0vD/4siUbFB5yUoK3t5gXuJmAWUELGYDCgBLixa04YZ3IswaQCav8Q+HRyPs+OZgKo0jDWkhn
 cv2lz1y4w0m5sPwMHoAYEINCli+6HtswcLh0+BrYG313/EiVEG1p0bgxoyAjr8a38/rjqwxoxBn
 p1zZtKVJdmo65fcyKiNP+Dx3cAccWVAnrGC+dosL+J44yZbCeH4HJEZ/i9jEnHz2Pq6eayKrYcj
 HShAsP9V5Fscoszpq4UmH4MncD7o08zQzWdVjPHqZYkEPGtDiL7xlJWBDVbST13cyNZIld1JF2i
 tBviRwVewVTmCV0fXTlxAn2lxqqSCXqHRrP5emJExFgfZzYOWTNPTA2+AMEp40wOZsPQlZH2zqj
 TcJ1NWL6jLsczyorAA093zt4iNVvo1u6idPASS/9fDXnKbypp+gNlqm35SnebCr8Q35rNWBn/uX
 48g6kIT9y5bIvLWKZofF/ClgtITvpLFSTgAwvmTebmGXDRkjG5P/3F/xAXNa2tthr+QIwCFGi7W
 b3E1RCD/wONwoQG+oe66tDtGfqt1hLRqMOLGwquUldPR54B3P1GrO9YqNJy+gwGFJuzDSR8t1sx
 obx7dI11j+uuHYk6PXq+gz4TNpp+5DNEGyaLvRA5jELVymtFStiJUNinOtoUjWi4bJS94JM0MiY
 Evvy7h8v1B46gKA==
X-Developer-Key: i=aidenisik@member.fsf.org; a=openpgp;
 fpr=83CBC5245C6A5CDC935B11A5492701B2C47AD7EB
X-Endpoint-Received: by B4 Relay for aidenisik@member.fsf.org/default with
 auth_id=956
X-Original-From: Aiden Isik <aidenisik@member.fsf.org>
Reply-To: aidenisik@member.fsf.org

From: Aiden Isik <aidenisik@member.fsf.org>

Add a dt-binding compatible for the Exynos5515 watchdog timer.

This watchdog requires a syscon phandle, and the cluster index should
*not* be specified, as that does not make sense on the Exynos5515 SoC
(due to it only having a single core cluster).

Signed-off-by: Aiden Isik <aidenisik@member.fsf.org>
---
 .../devicetree/bindings/watchdog/samsung-wdt.yaml  | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
index 41aee1655b0c..a32c47831577 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
@@ -22,6 +22,7 @@ properties:
           - samsung,s3c6410-wdt                   # for S3C6410, S5PV210 and Exynos4
           - samsung,exynos5250-wdt                # for Exynos5250
           - samsung,exynos5420-wdt                # for Exynos5420
+          - samsung,exynos5515-wdt
           - samsung,exynos7-wdt                   # for Exynos7
           - samsung,exynos850-wdt                 # for Exynos850
           - samsung,exynos990-wdt                 # for Exynos990
@@ -57,7 +58,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
       Phandle to the PMU system controller node (in case of Exynos5250,
-      Exynos5420, Exynos7, Exynos850, Exynos990 and gs101).
+      Exynos5420, Exynos5515, Exynos7, Exynos850, Exynos990 and gs101).
 
 required:
   - compatible
@@ -93,6 +94,26 @@ allOf:
         - samsung,cluster-index
         - samsung,syscon-phandle
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos5515-wdt
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Bus clock, used for register interface
+            - description: Source clock (driving watchdog counter)
+        clock-names:
+          items:
+            - const: watchdog
+            - const: watchdog_src
+        samsung,cluster-index: false
+      required:
+        - samsung,syscon-phandle
+
   - if:
       properties:
         compatible:

-- 
2.54.0


