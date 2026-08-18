Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A5147A891;
	Tue, 18 Aug 2026 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067896; cv=none; b=rS/HmwelddU0lh0UPTKPEV8gvQBzfvbkjucTC4joJFr8H792JlC8eYOhBo4ECgstI12Pq1n71v1TpNZwXAjCNU2/9Ut3j4s0PsFbXevRNXiCz97L6u14w2nCCn8d0/B/eB2C38ZO0y9A+TdF4WE9hlbS+j0O2omIQTzy9+gLh/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067896; c=relaxed/simple;
	bh=B1MSr263hFpzFu1HrE+5wS7gmEE6LU7r7AbgVYf50Ik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIb9twGxKbPT+E9pTlQlKfrK4P1WGpsD/dCFZYSwkVtoDCCb8Xa17FzuQCeYWVB8jbgjdz8pmyi3J/L9nLcwxzKHLETZX7pjc+3VBnbPVZnJH8YfphsvcbXOSCX+E06VADMQAS6XVn1QUgtErdnwjShTNpekJYrm2OyU5M4gnZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJiYx9ax; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJiYx9ax"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2017C2BCFB;
	Tue, 18 Aug 2026 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787067896;
	bh=B1MSr263hFpzFu1HrE+5wS7gmEE6LU7r7AbgVYf50Ik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FJiYx9ax7JRQohDmP1HecCxBoujaPymV6j6txfc8//QfH8MTue28UeFpURHbJBhoO
	 vtItt1rxcSD8IN3jTjDA3mTbdNoERRRHUinSjFOQLzfiVAh2kVwlmM62/GBnlTdg4y
	 4k+RlfA1ybm1wiVn4F5pI/2UuGWQRU22eHDeK2wVVBtiYxHmCG30gjjH6vLCY8b9rz
	 FPnNKyi7MLVTfgGpf1RoNCezPUM8X9x3J4mQVJJ7MRdxROHycKSpyEYWYBrIKM+KNW
	 pq7LJhpu8SH1ncFj/VEn2Fp8NbQpm5S8CQ681RARgmRqhGKObhzm4VFpiNImI+3FTs
	 bd9tkO71r2WzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5DAC5DF7D;
	Tue, 18 Aug 2026 15:44:55 +0000 (UTC)
From: Aiden Isik via B4 Relay <devnull+aidenisik.member.fsf.org@kernel.org>
Date: Tue, 18 Aug 2026 16:44:48 +0100
Subject: [PATCH v2 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt
 compatible data
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-for-next-lucky7-watchdog-v2-2-6743f479a47f@member.fsf.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518;
 i=aidenisik@member.fsf.org; h=from:subject:message-id;
 bh=C5r2bV9nYfxOIJNnwxYrMhWREb+Zhh0VM+xx1N3wI6g=;
 b=owEBbQKS/ZANAwAIAUknAbLEetfrAcsmYgBqhH315BAAGOJEjlp4J5rR3Yo9RyUegV+hrjWJ8
 HG6X6/iKn2JAjMEAAEIAB0WIQSDy8UkXGpc3JNbEaVJJwGyxHrX6wUCaoR99QAKCRBJJwGyxHrX
 6ws6EACwRp3RhFcTaoItfWoc9PNEejm0Hh+aNlLnAZWaYaPV87RYE/yjBb6TPPhP2IMq3Mo8+K+
 5JU4MnoO4FMDdfxQ4NWug+RgSyoTYNo4qr9uh3Rl1qWv+v6BJN7MdoFYxX9g202Ag08B3NlxfyB
 OJmjTq2mfbZ/HHyc6xv0mGC7grqB+OuFHdC3Qt9uAfNXtXpGrSvBI+HPzjrWAm6Gsp96rhg2LQL
 28CyaCDNu0WcmEmflQNf53tfSDegt/M5RJ18VdVBh7TzxQnORsQsuoWYA2v94/c3DuUfVpH5lhL
 ASm65HXaKN2mPx/ErOTgv1SehFGxBiBR8oopAR5TK/1Nu952gUW0Jcwqo/jP1IGq3injEAShv6h
 2cX6iwGGt8SU55hTbo7FASV9wkoV0Tn3rs0yn05Wdq6FVfuheaNoNtDYdvMjdEFOQb5AAgliLvK
 GBxhALdW5frgLwTJYJR7UaAGpoI0jf27oPE6NYpTF0UslijiwF56KPSELTIzw0wuESjDuUlMYgr
 QrAdg4Vz63gm9P4RoEz0rU/LvYfT9WaiWOmp/QpahX0jm3Reyc6kT79k6zFjsnp+9aJ92InPPkl
 lon462/vrn+e8ejxaCBUGbixwaFz1EXDh91I/JBKERGyrvyRNwkAJKaBnd4jBAdi+HeYDW2FxB0
 3W7qQcego3c2eYQ==
X-Developer-Key: i=aidenisik@member.fsf.org; a=openpgp;
 fpr=83CBC5245C6A5CDC935B11A5492701B2C47AD7EB
X-Endpoint-Received: by B4 Relay for aidenisik@member.fsf.org/default with
 auth_id=956
X-Original-From: Aiden Isik <aidenisik@member.fsf.org>
Reply-To: aidenisik@member.fsf.org

From: Aiden Isik <aidenisik@member.fsf.org>

Add driver data for the Exynos5515 SoC's watchdog timer.

Signed-off-by: Aiden Isik <aidenisik@member.fsf.org>
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


