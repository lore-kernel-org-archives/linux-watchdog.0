Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986503F39CA;
	Mon, 17 Aug 2026 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786962200; cv=none; b=keullmMbJX44woj4t6lTdQcAUkVe1V1SojkCTtwTPNtUUXlkQRXtTpoJnDWzo819oEWFN9KLrkTbWxTcMtpUXV9lGME6KjcSoWrIid5s5Brj49P0vB4I8sLdOOzTb8pg7zmAL/yNVXwQQb2DxpNparBi6U6iLVri9QB8Cllvcc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786962200; c=relaxed/simple;
	bh=zbpNs5SzoNAXUxbDPjp0uaozQKr5i40j4+TUkEZPwcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xpifb9jXpjROjXpUNQSohSx5i1ajIwHLXIViwkqBo/Lt09FrVaXwSF1jgjxU9nbJhCPFRMqleaRYGbsPZFs4TUfcZHteaNrKy7Awv3s+QtFCErkJT4K9FEWc95e+j+w2SqlAk9XJPodXz+LTQmenZxbaMGWyZnhVaT5yCtpcBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuJn6DYa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuJn6DYa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31175C2BCB3;
	Mon, 17 Aug 2026 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786962200;
	bh=zbpNs5SzoNAXUxbDPjp0uaozQKr5i40j4+TUkEZPwcU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GuJn6DYaJLbt+Rhd+K7LJmh+RQK7jRQEyvKHxLzBVfh80oBNKo65mkgXmJ61/VzDf
	 OnMHpG/MNozm/eNb8xoEvXeUeN3IrcQQer6sOYmc5dIH8TZ5QUabJy1HiU4q0QML32
	 ZpRnNOB5COJSTaYvhRzF1NYdM/cL2JtBpZihtZxpK5QUOXuIm93HgPHWMg03D9fVXw
	 BrIr0FzUw/n7MyzQ4D78555sDOPoIytTAGe2qt6qVmDfg2vNaOWFdrkOrOCYHO1Dy5
	 /S8w4w5XB5IeYboe67AGUS0dZo07HJKzmG2Dv6KCFomezIvPFash1AVbohZHOvHy9D
	 4ykeJ1gnkOo3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067BCC5B572;
	Mon, 17 Aug 2026 10:23:20 +0000 (UTC)
From: Aiden Isik via B4 Relay <devnull+aidenisik.member.fsf.org@kernel.org>
Date: Mon, 17 Aug 2026 11:22:52 +0100
Subject: [PATCH 1/2] dt-bindings: watchdog: samsung-wdt: Add exynos5515-wdt
 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-for-next-lucky7-watchdog-v1-1-a14370e20b92@member.fsf.org>
References: <20260817-for-next-lucky7-watchdog-v1-0-a14370e20b92@member.fsf.org>
In-Reply-To: <20260817-for-next-lucky7-watchdog-v1-0-a14370e20b92@member.fsf.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-watchdog@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Aiden Isik <aidenisik+git@member.fsf.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2310;
 i=aidenisik@member.fsf.org; h=from:subject:message-id;
 bh=qmqcVgcTJyX2r6r452NiYreHT9JlZHTUJh1Zj91t7tY=;
 b=owEBbQKS/ZANAwAIAUknAbLEetfrAcsmYgBqguEVSqyad5mbh50KvxR6h8JL+fob6cbZzG81r
 m3KGiLBUjmJAjMEAAEIAB0WIQSDy8UkXGpc3JNbEaVJJwGyxHrX6wUCaoLhFQAKCRBJJwGyxHrX
 6yeID/9+fPUN80oI5yjbiuhjOdxKIKr4czeAw0blx24qTHegF/0nCcc5T4C12+GI6/S0WjoFqV2
 eU7LOT0M1b0b/zvgI5D0juUW0VQMjVHY5UKB+mP+pdsoAZhmzVYyF+UcwMZ5k8Ji3MoXH1W/iru
 cJYyzK3GnZJYtmJ12NweWOB44jEDagQzD/eRXJGO4wB08hQ8eZfeJyzQIS1Tj46S0HHyY/PGglJ
 jM35iy+sXfzj++Vzcg0alfj9zHhGe2gK3TkJhEjvFFZgTfishoanivImmJlbW67q+18pSHlcly2
 MxcW9gFSkpyKCOjW2WDr/qUyaoAT6j5Mrupe04JGxzDVT6jUow0iTnE0Vwz5L6p4Vc91ctJrJUI
 s16RB55tXadgxpguAjvlF8uXHaOJGlnp/XcgAdygrNuLZpWoy8Rf1YRqETJzluqsQuLTB6GmRwm
 GxEtIASUoj8BBG0/Zb0z3uMlgxeXC6wkRzQiC1zJwwuXoLU4SLCvG1Tlt2LpZ0NBXRiCZhPS+1h
 eioSVKwekmk3OzcqPFVT+FN+5LfQwBBKFQ0Z54Sx7T8cneR0bjPjRrKgHzz+uB+t5yjOlIG5P4m
 47GeA+u1rFWaK3CTLIWvZha5cFq2X57OT4BFc69PX+Ym1jdmH1W+Xt9sLjjJ07n5qsFBUAI7/m+
 05qAwcAZ1wr00Bg==
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

Signed-off-by: Aiden Isik <aidenisik+git@member.fsf.org>
---
 .../devicetree/bindings/watchdog/samsung-wdt.yaml  | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
index 41aee1655b0c..9e754404848b 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
@@ -22,6 +22,7 @@ properties:
           - samsung,s3c6410-wdt                   # for S3C6410, S5PV210 and Exynos4
           - samsung,exynos5250-wdt                # for Exynos5250
           - samsung,exynos5420-wdt                # for Exynos5420
+          - samsung,exynos5515-wdt                # for Exynos5515
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
@@ -93,6 +94,25 @@ allOf:
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
+      required:
+        - samsung,syscon-phandle
+
   - if:
       properties:
         compatible:

-- 
2.54.0


