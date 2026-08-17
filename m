Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D23F39E5;
	Mon, 17 Aug 2026 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786962200; cv=none; b=LWcMawU+72IqUL0JACrh/FUopGdfD/6pdZQ4dRGrS6E9H7iZMKEc5FcoX9NmgxZ1+xdV6jTVn5cgOFtw32wPxXzcz0kI0lZYmgoAjXEmyM0eJdg6X6FcjpMfK3fdD5hODbugtnEWuGkqSFVcO9QzW0E6sc5XEqZvXmPzGfURgFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786962200; c=relaxed/simple;
	bh=MoKFjfCjj7eH3YeKB15VObhOrHj5g0TnVGxnPcj2obA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KgstiRvqHGLDQtBnHn2lfFDUYtaYxxFYL6kuMN5iTD5TzZeRbFR45XhZvtkOy0PxYFpdSMzk/QW+984Gp9OC76CFPvKuxnaxlr9+9p9RW1cPx/oXmx0ZoqLAxqSJp6g512Dqqpf9hpQEiK1+l4v4ndsEN6AmNw8QosmUbFilhsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijOTYxql; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijOTYxql"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46384C2BCFA;
	Mon, 17 Aug 2026 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786962200;
	bh=MoKFjfCjj7eH3YeKB15VObhOrHj5g0TnVGxnPcj2obA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ijOTYxqlES7CyiGN/UDG4YOfRgjY8xfTe4FhTNnmCi5HYwhpHpZy6zaJeLGHRCKKf
	 XU4krsu9NAKKj8+AFmOmfz/oFpxzdTSYcCSJs21NrjAqjrMAynvyHZ3oLLxI8o5sBC
	 d2lbJFwzjQVol+djC9S2XnrGkKd1mwFYpl6l5p9oooqWEVNuNC5VhjaOrkbSdZHOXv
	 13SBQvir4dvEjmU5FWU0RVgILxNz7G23nREKM4Fp0pTIHvFmpRPMn8XnrK+DQa6CGA
	 QAOP1qMvIoHE/4itOSPg7fFuqoJ+5kLFduv03l/ICQlvOTAvKtvZfJGMdNY2E1bqTA
	 Gkv4eRN+nKuyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECC1C5DF66;
	Mon, 17 Aug 2026 10:23:20 +0000 (UTC)
From: Aiden Isik via B4 Relay <devnull+aidenisik.member.fsf.org@kernel.org>
Date: Mon, 17 Aug 2026 11:22:53 +0100
Subject: [PATCH 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt compatible
 data
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-for-next-lucky7-watchdog-v1-2-a14370e20b92@member.fsf.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522;
 i=aidenisik@member.fsf.org; h=from:subject:message-id;
 bh=+9Y7AuNFAzHe4t85GeL0qqpJDKPFW2rCnQvCFhFMQMk=;
 b=owEBbQKS/ZANAwAIAUknAbLEetfrAcsmYgBqguEV5hCTkiYzCAuAqaEysF9HeVHLS/kYrXCkl
 wC0Z2JJs3mJAjMEAAEIAB0WIQSDy8UkXGpc3JNbEaVJJwGyxHrX6wUCaoLhFQAKCRBJJwGyxHrX
 6z0CEADqZKi0kxBZdzOSE+sR3Syr4VfVM8atvSQmljPNeD1lGwMeks1nUAbpZZCzC4cPbU5rS6O
 oQ/3Xq6FOqQPczocNa6ZI6zap4k+ZN7TPV+qtqXBj+urWUxdN3j7YBbCoYReqRc2CpEiadY9M3d
 XUIu3zxPiR/709eAYCd/A7bn5LWMF5XKXrXOXIVAhDF2fTMfUtrzucC5Gi0m1QkG3hBdzdO6CJ1
 qPeJEGiwrnaoXGtxLbwgg6PDFCziZLf7ocbYRPhOu8pF0G8eD+9zDwDi0TK6h8zOJqcebRFaVpa
 nAZnjfjKoH74wsQ4ShxGeYh9kQFIK8Ni0xs25pP4gwQEvg89bPt2IA0vNaFYA8/Zp82FsqyZOvu
 4RChbcxj7seuLR2ahHJa2xnFzPsIyVq612kLwUu9OcUQe8nibHKIQasT6eRUH9B9M0AUKpR7B67
 QzZ56LffaQAW6t/eREhMez+MkH63FiiaQ/43o85xy0vEpZWbqULqCbTWkK50vjFtjJumZo+5fJI
 38txH6RHoa65HHWPNVNsf3gIcYAo9Rn1wWQyVIbkCBVToULAqPYWhdR5MNH4sZAwNNkAs1C+17Q
 8i9yzt0jZmiwnXkGNjE+0kzruON2kWHPjgPO1YtzcHMRBFZkfRtpqset3Sluz0fPiM0FEXoxL3I
 sP6B6OPmKqE4+7Q==
X-Developer-Key: i=aidenisik@member.fsf.org; a=openpgp;
 fpr=83CBC5245C6A5CDC935B11A5492701B2C47AD7EB
X-Endpoint-Received: by B4 Relay for aidenisik@member.fsf.org/default with
 auth_id=956
X-Original-From: Aiden Isik <aidenisik@member.fsf.org>
Reply-To: aidenisik@member.fsf.org

From: Aiden Isik <aidenisik@member.fsf.org>

Add driver data for the Exynos5515 SoC's watchdog timer.

Signed-off-by: Aiden Isik <aidenisik+git@member.fsf.org>
---
 drivers/watchdog/s3c2410_wdt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index e31f93db0509..7299dfdb0c09 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -232,6 +232,16 @@ static const struct s3c2410_wdt_variant drv_data_exynos5420 = {
 		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE,
 };
 
+static const struct s3c2410_wdt_variant drv_data_exynos5515 = {
+	.mask_reset_reg = EXYNOSAUTOV920_CLUSTER0_NONCPU_INT_EN,
+	.mask_bit = 2,
+	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
+	.rst_stat_bit = 24,
+	.quirks = QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET | \
+		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE | \
+		  QUIRK_HAS_DBGACK_BIT,
+};
+
 static const struct s3c2410_wdt_variant drv_data_exynos7 = {
 	.disable_reg = EXYNOS5_WDT_DISABLE_REG_OFFSET,
 	.mask_reset_reg = EXYNOS5_WDT_MASK_RESET_REG_OFFSET,
@@ -379,6 +389,8 @@ static const struct of_device_id s3c2410_wdt_match[] = {
 	  .data = &drv_data_exynos5250 },
 	{ .compatible = "samsung,exynos5420-wdt",
 	  .data = &drv_data_exynos5420 },
+	{ .compatible = "samsung,exynos5515-wdt",
+	  .data = &drv_data_exynos5515 },
 	{ .compatible = "samsung,exynos7-wdt",
 	  .data = &drv_data_exynos7 },
 	{ .compatible = "samsung,exynos850-wdt",

-- 
2.54.0


