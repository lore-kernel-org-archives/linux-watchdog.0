Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013052.outbound.protection.outlook.com [40.107.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4F441B344;
	Thu,  7 May 2026 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168822; cv=fail; b=ucUi+QBa9lI0cXuD8sVIf59XQzQY5tvfXcdYdTG4hcQVzBkFAPhJLJcAL1seBm9AG325EObaFTR7CHBlzrBDCFdYa2obRsTaEjMB31gySVHKmINR+dkyiFGs6v9/HGD/AhqtEe8TvlxQP9/aP3LmFqVJc9u+x+ydEYK+FUz1vsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168822; c=relaxed/simple;
	bh=e48QN2mKd+UY2QfbRkdFoWWXjT4Efq91VMOMIJ6dJ2c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTkvZDYK5JiFZgnBHefBYWu4wfhJYu929w2ZE9JS5Zn7K3aH9sdEF8ZMlqOorah74S5/NbegEx/tyCcwojtEXnjdu/VtANsTaneUieGA0NoOc38SDjAuVKbkepL9tidwI+Vygdm3oxHE30GANaL14VfecGArAQgX+41isAcrrIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Usn72fYp; arc=fail smtp.client-ip=40.107.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Usn72fYp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIK7vjJ0MAY4MlOys8yO1vuOmDUEoHqxRaAMeQSJ3edbNFn4N1kTgmYXWd/MlixF6zjQh/GzFDUgrO/tjGzySR9vgYZNMIjc+4UsLBv6KP0uSeK7EUIhsVNIHqQWgGSk72I0kEiW6IrJM2PjvDdZb1sTjYCdTAT7/ChjiYUzA7j6QuD+DP6EpLkKbCjoBnmK94gyMaLQbzXv+ymITHvJz2T7V0GP+iOzzkHGSmXFctXgKSwQIA8K50dZ1auFP/oFbyO4rbT/VGoDADV6Tua7LSQfOioNrz+to3WLqrpYCveltu1bJxtUDgeOBHxIKPmcC6jQD7CajE47Y7G0zXQBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjB8csys2Dg9c7fRaG6x0ecHAyTQ1wC9WWzyJt5DgyU=;
 b=NDX9TAYdpc7jFSKgAMsk60SHaR6KR3XvI94Sp7u8uQPmzmoeqU0A9QD4TQJZ1oZBmAJyEdAXoMHOjkj0Kk2+9teEDa8fUquZ75daWm2DypsGZ4lJxa27aG7y3urrTgChcZUfycNYWM0yiZK6JaGGFt46hOo9+zrJ6T+n3nn1H5dWhwuLUZB8Cx+85M1hILo6Av6CJsx3aiKcebmoBqBlgJTxjXAnQZltuW02BRbgfyXeWVALe8VJNmhyEUm5izRyDRpWQp/m8hGDzUb6WrYIKgiA0gK1leY7oq4pwkW0L1g2RrtkV7Z/O9iEBmI1GgiCvbALbkznGFlhjQaJOTS15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjB8csys2Dg9c7fRaG6x0ecHAyTQ1wC9WWzyJt5DgyU=;
 b=Usn72fYpEscM9S0aGUT1osKZjCTDXgngnqNbjtceUCK3Ml5Tdbrkrc38gQn0MDu7PI05mIBe78S59RolS0RhOaxSdnRKW01VN74Y1BshzIMVWzGj2GjdTkVX7y/AWO8waJiWQogRBlSDkV5gnDkzhUVb35pbxZMMBGn2LfNcnoXCSqXn+/f1r79jJ2pdEfTKt2fl9tWY6x8TaTJUr7IGqGxnBpBZ6EcPqZO/jNWuxkOcZoX63CyLw8xaDB/N7iznenX6nmXsuiwxtE2Ch8sYCQu6e36+ViYSOrJxkwjHkw7Jh3zjxb7XtSg83wPCZFWzWq7cRsVuudGTtB/+AY4oRQ==
Received: from CH0PR13CA0031.namprd13.prod.outlook.com (2603:10b6:610:b2::6)
 by SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Thu, 7 May
 2026 15:46:47 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::4e) by CH0PR13CA0031.outlook.office365.com
 (2603:10b6:610:b2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.11 via Frontend Transport; Thu, 7
 May 2026 15:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 15:46:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 08:46:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 08:46:28 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 7 May 2026 08:46:25 -0700
From: Kartik Rajput <kkartik@nvidia.com>
To: <daniel.lezcano@kernel.org>, <tglx@kernel.org>, <wim@linux-watchdog.org>,
	<linux@roeck-us.net>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kkartik@nvidia.com>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH 3/4] clocksource/drivers/timer-tegra186: Register all accessible watchdog timers
Date: Thu, 7 May 2026 21:15:56 +0530
Message-ID: <20260507154557.2082697-4-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|SJ0PR12MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b34cdac-b0fd-41e7-9cba-08deac4fd88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	CX6l4f2oua/bAHPYI07SIu4Krf6crHyNmu86KptexAJRuuInlCaYVNxvwLEAJT+eGgq6p1CCRTQpJ/Fglmwedjj3ljey1WnvQe6tu+t/En8Hxwqm5zlwxrQUfnnKUmNPKFgzLoFns4aFEjH+PwWZDCNRmmErpVDzXMDGNFW8KAVhNsAQ4vghOMwLzS4vzdupu6SzupxnYQdxCT+piI27Z+F2KvvI0tUBxf1YntW3xrYlkydxeQ4S6U2m4/BHwVQK4XoCt644CdyB1YQA9VKIcJZyux+RtWRVQPnLmnbFsIWooetAEJcCI3opKAjQq9FSRiRB6frRu/GaO2yDNGak763op4duajr7n7jpc+ciHlfOms5lM46OR4W85DoW0ONB+A4coGwCRcE0upKnfrDJ4s+kGc2HR3q6EC0Pf/5J6qa8MuZdKxAhygKnyprgn6mzOHrqe5TtaI6dpO7cG2ErtI5BklDB4G/WjVb5plPA3xaYX8Pow1/ABS0yi+fPz90PPRNaenzuCJAeKqNO/fhTn5HswjrzftfPnt1Ucm9lixbjarKZS0R6v9RjFJNLgH1v4J8Yj5fYe+tmJ/qPW7r7zCyNYItAQsiWYAgVpBpbhdjEm9O4zyrxq5qGfCEgmEtibGxH2aLmZWFPvcy2vFoXoJdcXEAOTKvogWRQA0H3bXdNIQJGiawojeur/jKMVSZJ6f50caCxNpMJa1DZjocDbXdXPFzTHAq6QKSSC7m8QagCubz0zCS9gofH9vI8kXsZqqsAX7OyBxzI5vRzt/9Y4Q==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wuPkPpOVZNLe3gbn47IcmBMb3p76xi2hMSklNtxF+vL3q94iTkjDQdWT2FEoUM+sZAIhRicsgqPPoo6oxafm3EmSbS9vnCUNsAnIFJ741T65jg/0NrsaAHwHhq5GLr8VQtcpfACuqCCGQiEgHejhpR9QX/8S8JUFwVQP2To2LsU1HIYiDHDaGYKim8EQQBJXnLEVMNw4sxvkGBF6haLyTVXJ4O7Ici079nUEKk8SGThhmLh7rPpc8y0tugXlyJ5Z0TrN1v3QzM6OeqOYbrKbGsq5L+pPTUPBE3omboxMD2ffbTdOES6cC45PgSz9p4JeTF5rP6s2EcgSl/etSrEK3LQ/b/8EFxHb/Rx44ko16au0Vjc4IIH30xqefjdRLToNY/3MqmhPMDldY0nSwHKkBJqkpRUE+hJYq5VUnCllkHTUFBXpI3nlZ5SwWXGnqCCe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:46:46.7523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b34cdac-b0fd-41e7-9cba-08deac4fd88c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676

Tegra186+ SoCs expose multiple watchdog timers, but the driver only
registers WDT(0).

Iterate over num_wdts and, for each WDT, check the SCR (firewall) registers
in the TKE block to determine whether Linux has read and write access.
Register the watchdogs that are accessible.

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
 drivers/clocksource/timer-tegra186.c | 61 +++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index fd82a73ab2d2..dd1d1a0dd63e 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -57,6 +57,13 @@
 #define WDTUR 0x00c
 #define  WDTUR_UNLOCK_PATTERN 0x0000c45a
 
+/* WDT security configuration registers */
+#define WDTSCR(x)		(0xf02c + (x) * 4)
+#define  WDTSCR_SEC_WEN		BIT(28)
+#define  WDTSCR_SEC_REN		BIT(27)
+#define  WDTSCR_SEC_G1W		BIT(9)
+#define  WDTSCR_SEC_G1R		BIT(1)
+
 struct tegra186_timer_soc {
 	unsigned int num_timers;
 	unsigned int num_wdts;
@@ -89,7 +96,7 @@ struct tegra186_timer {
 	struct device *dev;
 	void __iomem *regs;
 
-	struct tegra186_wdt *wdt;
+	struct tegra186_wdt **wdts;
 	struct clocksource usec;
 	struct clocksource tsc;
 	struct clocksource osc;
@@ -298,6 +305,23 @@ static const struct watchdog_ops tegra186_wdt_ops = {
 	.get_timeleft = tegra186_wdt_get_timeleft,
 };
 
+static bool tegra186_wdt_is_accessible(struct tegra186_timer *tegra, unsigned int index)
+{
+	u32 value;
+
+	value = readl_relaxed(tegra->regs + WDTSCR(index));
+
+	/* Check OS write access if write blocking is enabled. */
+	if ((value & WDTSCR_SEC_WEN) && !(value & WDTSCR_SEC_G1W))
+		return false;
+
+	/* Check OS read access if read blocking is enabled. */
+	if ((value & WDTSCR_SEC_REN) && !(value & WDTSCR_SEC_G1R))
+		return false;
+
+	return true;
+}
+
 static struct tegra186_wdt *tegra186_wdt_create(struct tegra186_timer *tegra,
 						unsigned int index)
 {
@@ -424,6 +448,7 @@ static int tegra186_timer_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct tegra186_timer *tegra;
+	unsigned int i;
 	int err;
 
 	tegra = devm_kzalloc(dev, sizeof(*tegra), GFP_KERNEL);
@@ -442,12 +467,20 @@ static int tegra186_timer_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	/* create a watchdog using a preconfigured timer */
-	tegra->wdt = tegra186_wdt_create(tegra, 0);
-	if (IS_ERR(tegra->wdt)) {
-		err = PTR_ERR(tegra->wdt);
-		dev_err(dev, "failed to create WDT: %d\n", err);
-		return err;
+	tegra->wdts = devm_kcalloc(dev, tegra->soc->num_wdts, sizeof(*tegra->wdts), GFP_KERNEL);
+	if (!tegra->wdts)
+		return -ENOMEM;
+
+	for (i = 0; i < tegra->soc->num_wdts; i++) {
+		if (!tegra186_wdt_is_accessible(tegra, i)) {
+			dev_warn(dev, "WDT%u is not accessible\n", i);
+			continue;
+		}
+
+		tegra->wdts[i] = tegra186_wdt_create(tegra, i);
+		if (IS_ERR(tegra->wdts[i]))
+			return dev_err_probe(dev, PTR_ERR(tegra->wdts[i]),
+					     "failed to create WDT%u\n", i);
 	}
 
 	err = tegra186_timer_tsc_init(tegra);
@@ -489,9 +522,12 @@ static void tegra186_timer_remove(struct platform_device *pdev)
 static int __maybe_unused tegra186_timer_suspend(struct device *dev)
 {
 	struct tegra186_timer *tegra = dev_get_drvdata(dev);
+	unsigned int i;
 
-	if (watchdog_active(&tegra->wdt->base))
-		tegra186_wdt_disable(tegra->wdt);
+	for (i = 0; i < tegra->soc->num_wdts; i++) {
+		if (tegra->wdts[i] && watchdog_active(&tegra->wdts[i]->base))
+			tegra186_wdt_disable(tegra->wdts[i]);
+	}
 
 	return 0;
 }
@@ -499,9 +535,12 @@ static int __maybe_unused tegra186_timer_suspend(struct device *dev)
 static int __maybe_unused tegra186_timer_resume(struct device *dev)
 {
 	struct tegra186_timer *tegra = dev_get_drvdata(dev);
+	unsigned int i;
 
-	if (watchdog_active(&tegra->wdt->base))
-		tegra186_wdt_enable(tegra->wdt);
+	for (i = 0; i < tegra->soc->num_wdts; i++) {
+		if (tegra->wdts[i] && watchdog_active(&tegra->wdts[i]->base))
+			tegra186_wdt_enable(tegra->wdts[i]);
+	}
 
 	return 0;
 }
-- 
2.43.0

