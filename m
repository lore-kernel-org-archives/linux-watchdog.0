Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3BB47988D;
	Tue, 18 Aug 2026 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067896; cv=none; b=KfQJ/1bCtpMPO4mpNLhYN1mDnZlogG+nknhlWACVt1Ssbpk1KCqYWZ4SC2ginbk0YAr/a4/gXOuziY2eCH9QmXiwoJ27CnWv13b7rY02wxbiTeMF6X09IeKxgV6ldfzBOzurMm3L4W5PVbrpCaVeQZGFoO5KWIYxkQ8YlLz7Fsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067896; c=relaxed/simple;
	bh=NxlBY+QLfLmAZPcARcDdEqlxKsH4KI7HO6myhnvxzaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xw7slpL97pIRUZEDlSYBhnMcK1ylJ/Yg2s6CWK9SIa0caTuBvdQZYmfE0rgW1YoT8DzgEGFfXfoxwesxNi/aRYl00DLPO9JF3UJHDrmAUo+gCry6utqS5v2AOXaGlpSkB6S68qZ8RRnn9pw2oJ043GkysO9CfqsCxm1KAlNfmfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdUlHv4u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdUlHv4u"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E87ACC2BCF7;
	Tue, 18 Aug 2026 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787067896;
	bh=NxlBY+QLfLmAZPcARcDdEqlxKsH4KI7HO6myhnvxzaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PdUlHv4uquiOhsiTUhKvvvKADDwsgc0F5/GoS2wf7fGkCjcvuKF8xk1sC731RrysR
	 AI4/a4mJW+AzuXhLMbsUfKJxu48jldBiwS4vP4JmMM5YghIq+okJWkvs43RzAM+F/q
	 LwLtilHzDm7e+wnVq5lg8k75FqfP7LeDlnh4olaRG5/WpA4P9raq2+w1JqrvtvmZgH
	 EzXage6nG13+XT+mE7mB7TrF98NeORbzUrm0pPLGCogvE6RyD/qj7ZO/q3HLSfQY9b
	 5wFZu0ctwIaHEs4yzFYKlJQR+e89zrhCEhxHvr6Dcq+DIYaBkwBdnNp/HNs75A1+wv
	 QymBvauYCIIKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF028C5DF81;
	Tue, 18 Aug 2026 15:44:55 +0000 (UTC)
From: Aiden Isik via B4 Relay <devnull+aidenisik.member.fsf.org@kernel.org>
Date: Tue, 18 Aug 2026 16:44:47 +0100
Subject: [PATCH v2 1/2] dt-bindings: watchdog: samsung-wdt: Add
 exynos5515-wdt compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-for-next-lucky7-watchdog-v2-1-6743f479a47f@member.fsf.org>
References: <20260818-for-next-lucky7-watchdog-v2-0-6743f479a47f@member.fsf.org>
In-Reply-To: <20260818-for-next-lucky7-watchdog-v2-0-6743f479a47f@member.fsf.org>
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
 b=owEBbQKS/ZANAwAIAUknAbLEetfrAcsmYgBqhH31JLwniVYQYJiusy88srmX03d1ZEI5EiFcy
 drdqDU/Ae6JAjMEAAEIAB0WIQSDy8UkXGpc3JNbEaVJJwGyxHrX6wUCaoR99QAKCRBJJwGyxHrX
 60pjD/965EhbSgagts5oHkKpOq55r60UzFH4lLyavLkasfRAioVkqV3yKU4akdPZDShFXOKK7pD
 pPu3sHfuOfxFltqSTFV3hc3z6LmQwhsdyUHEHY3G+Ra6kYweLdrzpGYYsFrOGPY26BTIF+cZ61Y
 kI0hIDYkHfEuRuJRHyCN94UJfhy9F3wD3fB5eLrPgsgIBFJg3GOasW8r8+55qWyNaQKO8vzFNRX
 X+UCddjQLNUuE6Pgb/KsjY8X6u5y+dZu4/OucpBkHSaph2zVsOvds8H1AGXzNeWMrlm8dR/8KdZ
 7iUTJBSL7udi7j39pyRpVdMBYUuCT87e+lgyY2NrUUBiLVSLXHAcPwY7NLid5FsrP56km8bTChW
 YlL5D8PHK9mtYeapuFTCDp0B/F6vU0gm4+u47S9rEj/ft1MCAFoOsqUTtLV68POx2+h4a7qq9In
 S8Ze6iAE9MBIuuo70oMseLDuiJpIU1MFs46HZ+rPPErYoBspQSSBIcGubUme40tYqHDCf+1sYtY
 t09NnRBvNvbzhxTDLS5FRcZaudvNG9WnNHCvtbjBHPlGxZi3RPMmdKYTmBWHwukgtRGgXdj5itq
 x74gUia0ZrUl5vQcpNJnKcNuvIm0Ol/qBU+RjOaWGHhzbO7zh1hCR2g5JRpqhc7gu2eGjGo9WHn
 mRUWpXVUpzM0pIA==
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


