Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B951144BCB6;
	Thu,  7 May 2026 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168825; cv=fail; b=hpTLHZ73Gl4mZO2H9MCZsQGl00VAWiQt54j9+QsREy7bwN0Wij9onQylK0KPYPEIyc+LGd92pdGkXe6GP+86HbtEkQEYYqfkKqZNeQqmMR1Hfqub8Rz78MEHLHAQxqZf2cwHEOhqQ71EucPJRZ3j3nD83prPSi8/n8OasuXlPPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168825; c=relaxed/simple;
	bh=f448NaSCHtSWLDyqcB8yC7taW/HpLTwBPfBstUuNgzo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bzwy4WPqwSRcZIg2n4zufuBeFNdsxhMZuB4RQ5Q3csLAdeXOOCkXAT6Zeg5nTqB+VHcIbsX6cBb/YwW+yG8vhmayn2yzDiUwzYeGCFwisUG1ECDxb26pbwUKOEBtyfqxIlcj1FEE06D0XRZkP6Dk25EONAQPCDLt2SV8AhD03BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i6UD9stE; arc=fail smtp.client-ip=52.101.85.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i6UD9stE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qcu8+HNrbNcWzLYSJUjDJ+c/7xGB3y0YcbNdel7WJQ5eOs/mwEoTP1YYvVSLwR9tBQmqdIFfdE4yH6Qw3RwSVrLkLqWhnyCF/dRAddg8CjPDl5TKdFIQ2qN0trVZ1qx/ab6zu4SXC+QY8N/whqkwPbgXW7fju9JPFUqUACU1fEPaMsUkRMZK6Z+ERY3MYUDgX5TjTL4HjpM2Jvm73bI5NjFa8ir/srLaqXRSeuRWEZhRYhFg1r+E2+bzj0/IuRV4XkG8fqlJ5BBcPqPZv8TbyUD6GQBrCVHrTHta4/ET0NheVqW005xcxfhJZXPHgUDQJkjwnMWMhwG1SXLM9ARrXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cp87CucEDEMcKQOxo1YTtasFyJ91OR6sh0XMoWWIA/A=;
 b=CwvS/RyFbuOedciIGlWPJZ0RPdzqCESbYSsoWj4eQ/xiDrHlLeqj8D4WQ0r+VDxeXRISINXelsc/azfRZRcftFXHf//cmbQNGNWVD+NAZdO6Imv0C09MUf0QGpCrVIifpd8PsVO4wAmDtoDX2aScWNyMRF9S6NuNPEmELSa4zIl3MGzwk/PNONRkQ2+7JUvgvXsvQC1SZmJz1WMloWAJF66XnZycnW5JWY45rItoUBnPZuzOgE1OTN02Sl7+YhmVaiacgJdi3GitxA5ULNJI+IwqsUwRBmzvSil3/JnL5opSm5CpqePPnyO6opkRgcnzSVP3zYbSe7XuQhayvAdi3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cp87CucEDEMcKQOxo1YTtasFyJ91OR6sh0XMoWWIA/A=;
 b=i6UD9stEIEGC8DFFEp3P3rT8cXaHXoajKgWkC2+dqWsWH8KmTHyrbfO7ZLUbNoXKCej4sRw58j7ROcteh2D0hQHU1QNHoYAJ+XEcDTAUj71m4qkLsT8i0Oh30dJ7SmPzdtQ1HncsrX/He5tKnSUPv3Jfmqs7L5Yoq4n8nJJeTL9Er+MPCYH9Q4BYHPWdqaIKk3ScdYcSL3WM+VojlaTeKDQtn6NJZtR3Q+jQQ7GnziuGNVl8zbFRRoDJCTnO1Z3jH/fXIcjrfEgxKdGkbYuy46U/OWGV0XCdu2SVG1hwBQH/VP1Om7LUWIPQPhvmz2tEp1TuIXF/No/2qjUUP2IilA==
Received: from BN9PR03CA0796.namprd03.prod.outlook.com (2603:10b6:408:13f::21)
 by SAWPR12MB999139.namprd12.prod.outlook.com (2603:10b6:806:4e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 15:46:59 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:13f:cafe::c4) by BN9PR03CA0796.outlook.office365.com
 (2603:10b6:408:13f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Thu,
 7 May 2026 15:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 15:46:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 08:46:31 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 08:46:31 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 7 May 2026 08:46:28 -0700
From: Kartik Rajput <kkartik@nvidia.com>
To: <daniel.lezcano@kernel.org>, <tglx@kernel.org>, <wim@linux-watchdog.org>,
	<linux@roeck-us.net>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kkartik@nvidia.com>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH 4/4] clocksource/drivers/timer-tegra186: Reserve and service a kernel watchdog
Date: Thu, 7 May 2026 21:15:57 +0530
Message-ID: <20260507154557.2082697-5-kkartik@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507154557.2082697-1-kkartik@nvidia.com>
References: <20260507154557.2082697-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SAWPR12MB999139:EE_
X-MS-Office365-Filtering-Correlation-Id: b03db274-927e-4cfd-bb5b-08deac4fdfbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nn+9gQ9ogWvvnOk6E51wzQQ1etEtCP83scWwdM2lIrGjS3dbdHhgl948+IsiONkK4BuZg9jfXKpqRLfmSZvi8k0b8H7xXhvY+Zm3ZZqYdK53HzF2mlVmZaCa3XWpc1zZQZtDuYN8+Iyj5DeFiIk0gVqKdSiOw35nsWoQ0CfnYnhKibcIZNzRPxkrDZYw18YGllH9PtgRvw6ybvderaqxVYj61RA4ixiC9WujNzRV/Qzi6VvgQE1MaSpO97eDYpjWw9ODGKztd/ySMS5r8AAH9Cqay5aXOewS+oBsfkF7CqPFLScBykp6SMdGjXO3XC+0zHKm81AUbzQ6DF7NYzmQOrmieBAnR5iTau/TkfQuAz2pdlfPiUwT4OG8bjxj0Xx961m5AD63hgE/lWWELZmPtVVnmWmN13gqkSw/+N6xtwz5uqTiBxFTt6EURe6U+CFwpC71Xl2ifLooCiyb2YpZzLXiaRvQZo0orO72TPz7XjtsOXhBE2D37W8GO3ymTjGCB3iI96+lwK8RA3kTdRFcomQ5HwpsvdsdbkM1PDAAWkmVAgy24E3ztTy6LZIwBQCY+puYHAj6kAW0rBZm48/YU+8qTcJf6UeIkdudEBp5ZZo5XRh56zBd3u2pr/ewt0wRSe62eCMLEQEyhkTB1QNOre/KuU6khtdGGXTRheH+J4aFIH5gcV6EzhOkOqLPWa+RUtOZjku9YtK+R9gjzleUpWh4WI/fkpsZo1XtCqWlnQwmcZVX9SQ6+2jxqSKMJiRVYuEJJ8r5C1VSREup6AARyQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vC3z8jACN2sL5VwMrIazCOBq9Zb8fvk1wk99Rmci6XvUXgUjJWoxfqXD1Sd8JmPDrGqi3BMYPdzpammNhvQsp09DiFEMUllx7ne5PjfecN5QN20DAVckWcIXjMHSvtbuR1jd8I2vTa/2x7odSSmFuTx4NNcFhfGjZ1Wkopa+RtVO4HrpeDWHF5SGhCim58xN3qNKv07A6Lmmeciv9Uaq8/rzqRcHgUgJbWbYT2z0pcix6djWgHioG80Y0iRp4PKZ0SbqHCAIsIraAqkPWZf0ARaa/8nR6NZU4k7juuNsqBfDSmhjT5gCEVGAoNyOF9aoPbZx1zZY4H5qWtGJRBfCwSxycJzBlc+uQtRUbiPhLyJyHaKMnAE73RL+/RXEwA+ZkUrUBLM+V0wa4XpXXT6NhtBns4M3BnHU3FzBhZZ8dbu/qXJlaz15qdvuddpXx08Z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:46:58.7594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b03db274-927e-4cfd-bb5b-08deac4fdfbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999139

Tegra SoCs supports multiple watchdog timers. If the kernel crashes or
hangs before userspace enables a watchdog, the system cannot recover and
may remain bricked, e.g. after a failed OTA update. The driver currently
leaves all watchdogs disabled until userspace configures them.

Reserve first available watchdog as a kernel-only watchdog for Tegra186
and Tegra234. Arm it during probe (120s timeout) and keep it alive in
the driver IRQ handler. Do not register it to userspace. Other available
watchdogs remain exposed to userspace. This guarantees the system can
reset itself in case of a hang or crash even when userspace never starts.

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
 drivers/clocksource/timer-tegra186.c | 62 ++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index dd1d1a0dd63e..78600ddeb1c6 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -57,6 +57,8 @@
 #define WDTUR 0x00c
 #define  WDTUR_UNLOCK_PATTERN 0x0000c45a
 
+#define TEGRA186_KERNEL_WDT_TIMEOUT 120
+
 /* WDT security configuration registers */
 #define WDTSCR(x)		(0xf02c + (x) * 4)
 #define  WDTSCR_SEC_WEN		BIT(28)
@@ -82,6 +84,7 @@ struct tegra186_wdt {
 	void __iomem *regs;
 	unsigned int index;
 	bool locked;
+	bool is_kernel_wdt;
 
 	struct tegra186_tmr *tmr;
 };
@@ -182,6 +185,10 @@ static void tegra186_wdt_enable(struct tegra186_wdt *wdt)
 		value &= ~WDTCR_PERIOD_MASK;
 		value |= WDTCR_PERIOD(1);
 
+		/* enable local interrupt for kernel watchdog */
+		if (wdt->is_kernel_wdt)
+			value |= WDTCR_LOCAL_INT_ENABLE;
+
 		/* enable system POR reset */
 		value |= WDTCR_SYSTEM_POR_RESET_ENABLE;
 
@@ -219,6 +226,16 @@ static int tegra186_wdt_ping(struct watchdog_device *wdd)
 	return 0;
 }
 
+static irqreturn_t tegra186_wdt_irq(int irq, void *data)
+{
+	struct tegra186_wdt *wdt = data;
+
+	tegra186_wdt_disable(wdt);
+	tegra186_wdt_enable(wdt);
+
+	return IRQ_HANDLED;
+}
+
 static int tegra186_wdt_set_timeout(struct watchdog_device *wdd,
 				    unsigned int timeout)
 {
@@ -361,10 +378,6 @@ static struct tegra186_wdt *tegra186_wdt_create(struct tegra186_timer *tegra,
 	if (err < 0)
 		return ERR_PTR(err);
 
-	err = devm_watchdog_register_device(tegra->dev, &wdt->base);
-	if (err < 0)
-		return ERR_PTR(err);
-
 	return wdt;
 }
 
@@ -446,9 +459,11 @@ static int tegra186_timer_usec_init(struct tegra186_timer *tegra)
 
 static int tegra186_timer_probe(struct platform_device *pdev)
 {
+	struct tegra186_wdt *kernel_wdt = NULL;
 	struct device *dev = &pdev->dev;
 	struct tegra186_timer *tegra;
 	unsigned int i;
+	int irq;
 	int err;
 
 	tegra = devm_kzalloc(dev, sizeof(*tegra), GFP_KERNEL);
@@ -467,6 +482,8 @@ static int tegra186_timer_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
+	irq = err;
+
 	tegra->wdts = devm_kcalloc(dev, tegra->soc->num_wdts, sizeof(*tegra->wdts), GFP_KERNEL);
 	if (!tegra->wdts)
 		return -ENOMEM;
@@ -481,6 +498,17 @@ static int tegra186_timer_probe(struct platform_device *pdev)
 		if (IS_ERR(tegra->wdts[i]))
 			return dev_err_probe(dev, PTR_ERR(tegra->wdts[i]),
 					     "failed to create WDT%u\n", i);
+
+		/* Reserve the first accessible WDT for the Kernel. */
+		if (!kernel_wdt) {
+			kernel_wdt = tegra->wdts[i];
+			kernel_wdt->is_kernel_wdt = true;
+		} else {
+			err = devm_watchdog_register_device(dev, &tegra->wdts[i]->base);
+			if (err < 0)
+				return dev_err_probe(dev, err,
+						     "failed to register WDT%u\n", i);
+		}
 	}
 
 	err = tegra186_timer_tsc_init(tegra);
@@ -501,8 +529,22 @@ static int tegra186_timer_probe(struct platform_device *pdev)
 		goto unregister_osc;
 	}
 
+	if (kernel_wdt) {
+		err = devm_request_irq(dev, irq, tegra186_wdt_irq, 0,
+				       dev_name(dev), kernel_wdt);
+		if (err < 0) {
+			dev_err(dev, "failed to request kernel WDT IRQ: %d\n", err);
+			goto unregister_usec;
+		}
+
+		tegra186_wdt_set_timeout(&kernel_wdt->base, TEGRA186_KERNEL_WDT_TIMEOUT);
+		tegra186_wdt_enable(kernel_wdt);
+	}
+
 	return 0;
 
+unregister_usec:
+	clocksource_unregister(&tegra->usec);
 unregister_osc:
 	clocksource_unregister(&tegra->osc);
 unregister_tsc:
@@ -525,8 +567,10 @@ static int __maybe_unused tegra186_timer_suspend(struct device *dev)
 	unsigned int i;
 
 	for (i = 0; i < tegra->soc->num_wdts; i++) {
-		if (tegra->wdts[i] && watchdog_active(&tegra->wdts[i]->base))
-			tegra186_wdt_disable(tegra->wdts[i]);
+		struct tegra186_wdt *wdt = tegra->wdts[i];
+
+		if (wdt && (wdt->is_kernel_wdt || watchdog_active(&wdt->base)))
+			tegra186_wdt_disable(wdt);
 	}
 
 	return 0;
@@ -538,8 +582,10 @@ static int __maybe_unused tegra186_timer_resume(struct device *dev)
 	unsigned int i;
 
 	for (i = 0; i < tegra->soc->num_wdts; i++) {
-		if (tegra->wdts[i] && watchdog_active(&tegra->wdts[i]->base))
-			tegra186_wdt_enable(tegra->wdts[i]);
+		struct tegra186_wdt *wdt = tegra->wdts[i];
+
+		if (wdt && (wdt->is_kernel_wdt || watchdog_active(&wdt->base)))
+			tegra186_wdt_enable(wdt);
 	}
 
 	return 0;
-- 
2.43.0

