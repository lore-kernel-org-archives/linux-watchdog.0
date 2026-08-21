Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFC4C77A2;
	Fri, 21 Aug 2026 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325306; cv=none; b=IjWn+eIC1vL9BCAzYXbMb2rQaupaUWYXzAr8QnJBG+WU3/FYt4ej4UIs2qkKus2DcaVq0mRsMjWXxGHMIQuaTjC6aINZp6FnUoD7xxuyF9YFHHmnjQqtdcHw8YDZqS4nP9oOHnwo3QVdxyDBzflTh17ZHalcCQKXfWSL/zQzRpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325306; c=relaxed/simple;
	bh=k0zLHKLH68lpVPba9E7LUjEcjJ/gs624234l1bwj2uU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vx3lbDSzZDUFbS3Zh/ATgzKrly33uF2ZYuTjW05ZY1ZbINyEkyBT3bD34AQgJSV9IfmtHSU+oNyFK7y0TYxPJIL1QWB0fx5i2NZ8ft4W8Bp3uT22+q1TlEzVIGpsBc9bWZp+yQ7GabeooQ9xDHHb1RiohRIXcadWiVWVfXgljqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IO3d5jGZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IO3d5jGZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF0A7C2BCFC;
	Fri, 21 Aug 2026 15:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787325306;
	bh=k0zLHKLH68lpVPba9E7LUjEcjJ/gs624234l1bwj2uU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IO3d5jGZNG7af7lE2L9Wq4CpJe4zeO17L++VkxBWgvsrwXQN4BZqI4gjjXQzNCHTz
	 btUyd92Aqnxc2fgYCk8+4HjkwMSB8i8vg7x+itwr2A+tfKb0WHH3ymzP5ZJJfIXWSg
	 u9kfPb4kDbQ59RQbrlL4yOHSEqLayZztEh3I66jLehU7dEC5tG0sqBm/zqeavz6ugD
	 HOo1Y4C0QVGJkyyFAuRUr5JmIt117BW65FtpziGp62FXG6zJ9LDBEjowXYiBylEPj/
	 DsSMWLJFVcLptwjTluXVHn3u5mBQnb6haFMySTRyKUqr70L0Cy7OfMFQWhIqWS+s/H
	 YHSXguXowlhVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8248C5DF96;
	Fri, 21 Aug 2026 15:15:05 +0000 (UTC)
From: Aiden Isik via B4 Relay <devnull+aidenisik.member.fsf.org@kernel.org>
Date: Fri, 21 Aug 2026 16:14:50 +0100
Subject: [PATCH v4 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt
 compatible data
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-for-next-lucky7-watchdog-v4-2-d070cee5009f@member.fsf.org>
References: <20260821-for-next-lucky7-watchdog-v4-0-d070cee5009f@member.fsf.org>
In-Reply-To: <20260821-for-next-lucky7-watchdog-v4-0-d070cee5009f@member.fsf.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1808;
 i=aidenisik@member.fsf.org; h=from:subject:message-id;
 bh=QWYVk8sPa3JpVI2qehkdPPdXsdkAd9IZBVEvEfGjKrA=;
 b=owEBbQKS/ZANAwAIAUknAbLEetfrAcsmYgBqiGt3sDmRORR/fLqcaMqThVjJHZWLnAKsHoQ0V
 b8XQDOS8DWJAjMEAAEIAB0WIQSDy8UkXGpc3JNbEaVJJwGyxHrX6wUCaohrdwAKCRBJJwGyxHrX
 62M5EADqq638uNLyQAj0YtUWxeEU5/5rcG4wuWMzIdCJ/lJWPbpH127DRiigccTmvXSvB9a5CEZ
 jlR99X6ccqSHdv3qKIfV+3C1WXagZKmslOCwJrQ1KbQvmPAFtEmUhV3bhz2k/ZjTuxxzINCwlQo
 pD7Y8d/99GcLBtOXF2KQCUXYsKxwI20NHk5T6G014KxcwRiHadHlzCYulNdIRNh1P30Us7ulwhV
 7roCC6yZrL+Ug0fOhSd6l0h5tFfIKBva0IQfC6Pq8OecUvdcHSFn7WeQswrqDnKG9RdQIzorDhK
 chILIUE6Mc2AxgCyDF1ZQPvYQDO8gZjlCdwlXYB51amcYLorSW2adupeUzTzYMZslVg9FrUYDgG
 d26Dj+wSq+M2IfcokS0U8VFRaV+5+Cu+801EJQHw4eRicXz+0A/MboeJcVE2YK4TkF0jjDrznqW
 ahWGpqBrNtdV2XwldI8khaD6hsi0y+DI07+BP7dEQv1ltuFigkv7h1sPVVYHaIHeD7c0TnTISWD
 +/Dvbq0Lm+Ml4m7i7XX7SsdVh9q3goJ6LEcTWogJIDjweDbzKkE5FQht3+TRHDlAd4G4oj3Nk23
 Ucef8lM1TjBvLPNpobBDVjzlnFXaaPsl7wxqPJ5KLD9LOHHy58gowvXsoq+1S5nJt/JoCcas3tw
 D7iadSYtVPR/UCw==
X-Developer-Key: i=aidenisik@member.fsf.org; a=openpgp;
 fpr=83CBC5245C6A5CDC935B11A5492701B2C47AD7EB
X-Endpoint-Received: by B4 Relay for aidenisik@member.fsf.org/default with
 auth_id=956
X-Original-From: Aiden Isik <aidenisik@member.fsf.org>
Reply-To: aidenisik@member.fsf.org

From: Aiden Isik <aidenisik@member.fsf.org>

Add driver data for the Exynos5515 SoC's watchdog timer.

Unlike similar SoCs such as GS101 or Exynos990, Exynos5515's PMU does
not require explicit counter enablement for the watchdog to tick.

Signed-off-by: Aiden Isik <aidenisik@member.fsf.org>
---
 drivers/watchdog/s3c2410_wdt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index e31f93db0509..e61439a3f4b2 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -232,6 +232,20 @@ static const struct s3c2410_wdt_variant drv_data_exynos5420 = {
 		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE,
 };
 
+/*
+ * Unlike similar SoCs like GS101, Exynos5515's PMU does not require
+ * explicit counter enablement. Hence, QUIRK_HAS_PMU_CNT_EN is not set.
+ */
+static const struct s3c2410_wdt_variant drv_data_exynos5515 = {
+	.mask_reset_reg = EXYNOSAUTOV920_CLUSTER0_NONCPU_INT_EN,
+	.mask_bit = 2,
+	.mask_reset_inv = true,
+	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
+	.rst_stat_bit = 24,
+	.quirks = QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET | \
+		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_DBGACK_BIT,
+};
+
 static const struct s3c2410_wdt_variant drv_data_exynos7 = {
 	.disable_reg = EXYNOS5_WDT_DISABLE_REG_OFFSET,
 	.mask_reset_reg = EXYNOS5_WDT_MASK_RESET_REG_OFFSET,
@@ -379,6 +393,8 @@ static const struct of_device_id s3c2410_wdt_match[] = {
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


