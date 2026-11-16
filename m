Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794835473;
	b=RizpPcPlH5BBAgXdgf16NW+KS7XqHMwY4ut1RgA7JbVz4dVpgTb8rTmDcoo1yAdMdgN3
	 CY/n3zuEROCbbckepGPoe1TLLhIW7KS3135YqGXlETOTM6bVqYVyowACWWS+IsgZrKcth
	 rntTW4ChDDN/CLj9zb/sdv+VzS1l4Agf7zeXPmfRollxxzwNCaspwqmqQaOPKTr2cFrVy
	 JrLvU2TtALaPzATzZGBvEZ3ZcP5SkWeLK8SC3/lCp50kG+ECWJUWSOOaLDeN3A0j69e7S
	 OoMln33tfe2oEhX27AYRMMQ1KogECC6nYKv9neRj6WZxoo0S1RSiWKwaLJu9aKzYf6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835473;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3f7QSlnofrRCflb98elmk1jgK+OxDoPAB2NyRU56Zoo=;
	b=zQK7Lj3A4UskSMAfCX5njLqiTUatZphq7MtuHscqV5CQU3XE625s5USDgRWQTHx1qi4K
	 6azXriGKmAPs+ZzChFiCpU9BjnPUOj3i83pGl0r49dyMpqxN1kqcCE6JdVelFhptffXtR
	 q4483wdN+hmCDp8vEclQ2fa2/Jst7kHv50eGEFQf5GUiuWaRMaz8XPz9liACD4nn+qCjf
	 ikBxMs6zFaZXAeJlwWQSS523jb8oTnAO+gZvq8p8A/KyPn3l1oK7BjgZzOiI8M61OHpls
	 YbXXhoEbPPBdR1qw/p2zon6cD5pghS3JxmiSSnhYh+0ZUDyEPjzVaxs6d8kxqa9+9wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=nQVtYFlM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.43
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013043.outbound.protection.outlook.com [52.101.83.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A68606A32A;
	Mon, 16 Nov 2026 13:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2A68606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=nQVtYFlM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tw3VqQFMxZkzZARghtt08AVxWemfNjsnceNisLLGizuVTN1kyO5Gqc4aX+nPtaqZuOz/nQOhJzgb2DzEjoATVAbzc4boTccdpe2rM3NUy77fCnCP2lfaPelKA7RiEulMiDbZQTEpWYjt0QcU5NIj/3+ww6rnnf7Yrwt+j6KXNc9ixMy6gVlK0sBiNmdix+znrLJPfEI9DvHLLrpaa4wGysUm/Pei63kiweEOhz4kreZVA+4K681jeSngt0Jq3zXRlmRz7yd7OuauO90Hk4iugiQtpntzTAGMO20dPaTU66JLZ2Uf2BCvHgHpaKzovhLO3um5Tnb/v29NaoBrO7+oTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3f7QSlnofrRCflb98elmk1jgK+OxDoPAB2NyRU56Zoo=;
 b=JtluSXsisF+C9PgZamHjccVrKI8Enl/w3mdAEnkILj2R3R59iG2Mt5t1+M5SvpVPTp/4ZXWimj9+kgrcvYRbSL3E5d2UAWoHPg6vRnk4kkWktauW3vxJdkDRGguzC4gwvay+U2wnI6BWGvlPBvw7FDVZjBVNukNpsAeUkkhqCJ2MdFxjmZafoDS3iCs5lYHTGu4ZDKPDG+D3xFMOlnqk1eW0FejPjsmihsNGYaq8qn8N3lRHy/Erok6w8svYbtjzmyVqbVYJTHVvtRrSbayaLfFhHYSrtCHw3LqCcE230kgmGDZT2kzDLmQ24W/3mmG0mt5/m34e91XGe12+qEOlCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3f7QSlnofrRCflb98elmk1jgK+OxDoPAB2NyRU56Zoo=;
 b=nQVtYFlMYVJikBINI6j/b+luAIhKGkvrF0uSWa0wtyA/VoaRZAHcb8SwkItqz6IIvZOkCY5JyllSaE1AsoU24mVck85Zjgi2/eHoT8qbktwL04Cio54Q2Fok1piFIW3ovY7PEIDrZoCM71/xLK7kVKw74zYqsrBc4YNVyxtt+lzCZ99uDI9VIjzYLVXsrlmjJ4bJGQ7D76mXCDj1iRJK64MP/EhAv1hM8sN3gEFPUoyJpJUqeBe7JpnLBquSKxtuQVb2jXVKUVi/sy6QW6jR603cF1YyIdItk0DQ+ji9TOmD9LL21UqkdwNQug/evjb7AP4vCUt+dqcw/gAG/mXDOA==
Received: from AS9PR06CA0211.eurprd06.prod.outlook.com (2603:10a6:20b:45e::15)
 by DB4PR10MB7520.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.4; Mon, 16 Nov
 2026 13:24:27 +0000
Received: from CPH1EPF0000052D.eurprd05.prod.outlook.com
 (2603:10a6:20b:45e:cafe::1f) by AS9PR06CA0211.outlook.office365.com
 (2603:10a6:20b:45e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 13:24:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 CPH1EPF0000052D.mail.protection.outlook.com (10.167.241.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 13:24:27 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 14:25:06 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 14:24:21 +0100
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, Wim Van Sebroeck
	<wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Yannick Fertre
	<yannick.fertre@foss.st.com>, Christophe Roullier
	<christophe.roullier@foss.st.com>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
	<linux-watchdog@vger.kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=
	<clement.legoffic@foss.st.com>, Amelie Delaunay
	<amelie.delaunay@foss.st.com>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v4 04/15] watchdog: stm32_iwdg: detect whether the watchdog is running
Date: Mon, 16 Nov 2026 14:24:05 +0100
Message-ID: <20261116132416.1184447-5-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116132416.1184447-1-antonio.borneo@foss.st.com>
References: <20261116132416.1184447-1-antonio.borneo@foss.st.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF0000052D:EE_|DB4PR10MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d63e118-810f-4e11-d1da-08df43e4f068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|82310400026|36860700016|921020|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022115727099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1OR/6C6bfZkd37gObxSNseaGmWhya7AG+J76g6r5NZeW3COuf5YnC+b6DgfMTq+Sx5UjoFYL5lODPMgXuvuStY3G9y08gf6uX+CCXOzBdcyJuZ8SHQZd+Mi6MewwiIDIUiZELgIlL8i6HQmlmOhBWegXXcG1LRKUg1cnvkUufv/WKMAQ57wzVH3FbkZMAyFOab5VZukzPljsDEeaFuWWNQP6M2MjTxkx3m9aSNDG/Afh70SOIIQrFUzTYCioWW6xQD2fWNEQoPekrZML5gZNddLIjpu99SapCi6ilzQC/LxAfXe4RAG3PXn+lNY+t8MnJfD1JLRALFl9ZjZ/iJSwyQr0ta37Varl1c0hVfz0VlVQayLuXbQkPWD4rX4f1YqeG3cgkAD4s+khNqzO+DIEd7BpdjszFtLx9bJdl0IdyfOL8cKEidmDxoadCOSWZVLcsZZwfwm1p6DitiTwYBMU6caMBzHS0U56PpsQk50SED20/GftEh2kZBs1CajwLm/eryfXKKmJipAsRZVR/4duvBaQQ724PqMf+QKBTl2dHONXoQ5gmWp8aNk+qjHY84Nswtbjvum+j0uMUOOobeq1aTXAyWlflVYP2thfb3UWqRmA06Slz5sTZcL43DZCnXXWFD8UG7I+9qkeLUwIFOjZ/hjY9TQnxk4mpAkpVFtiQDGVRoOa9bXBTOmdPlDrW2zHUL/6G1tNetaDMR8aI9bibbEcJuO0Y0kYvVucKJn4/S0Yk0KTAuGcH5r0g/Otv/J0
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(921020)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022115727099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mgQgaAcnKqImDQ/ziB52c5uW3G7qNnujRhChAeDL1gDv3FK69kwAKtflenfuZUZ3B0xkG7GbFP7QG/hNCF7SCF3KX5LG6neBYDj0GeJvjvwrbrZpJC3pOkAeW1ZR6YF1nXzDeVjduKJ5TyPHO0KOCqhiGgzxs33hwGZcqE3DdcFT69OvvEwazg0/9XBWZc7a8MqHxqhos6hc8gxRFAhTAng/Ua8WRb/XQY4Qg05I3ipqFoA6XspV4qVM6j0xoeBDf6yu27F3W16ZLdrGU6bx3ZyqsQFvQn3mFYpT6NS+bJg3lQBSV0M8F19ontb7rU2h2He/XOn9BBD4M4GmzdFL+M8mz6B1pMobWvejUPSq68U6fNna46RcN59SR0Sp0pYG4uoPYiRb9aLCCVsk3Vt+dzVeb00NguV1TzBOW/E93XhqtDPtHDoQZ8bSkYbMPlaw
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:24:27.3931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d63e118-810f-4e11-d1da-08df43e4f068
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF0000052D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7520

From: Clément Le Goffic <clement.legoffic@foss.st.com>

On STM32MP13x and STM32MP2xx platforms, the ONF bit in the IWDG
status register indicates whether the watchdog is running. This
feature was introduced with IWDG hardware version 3.1 and is not
available on older versions, such as the one used on STM32MP15x.

On older hardware versions, determine the watchdog state by
writing the current reload value back to the reload register,
then checking the RVU (Reload Value Update) bit in the status
register. The update completes only if the watchdog is already
running.

Use this state information to service only watchdogs that were
started by earlier boot stages.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/watchdog/stm32_iwdg.c | 40 ++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index 9a0dc52a96bc7..1a5715ff9fab3 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -50,6 +50,7 @@
 /* IWDG_SR register bit mask */
 #define SR_PVU	BIT(0) /* Watchdog prescaler value update */
 #define SR_RVU	BIT(1) /* Watchdog counter reload value update */
+#define SR_ONF	BIT(8) /* Watchdog enable status bit */
 
 #define EWCR_EWIT	GENMASK(11, 0) /* Watchdog counter window value */
 #define EWCR_EWIC	BIT(14) /* Watchdog early interrupt acknowledge */
@@ -58,6 +59,9 @@
 /* IWDG_VERR register mask */
 #define VERR_MASK	GENMASK(7, 0)
 
+/* IWDG Compatibility */
+#define ONF_MIN_VER	0x31
+
 /* set timeout to 100000 us */
 #define TIMEOUT_US	100000
 #define SLEEP_US	1000
@@ -261,6 +265,31 @@ static int stm32_iwdg_clk_init(struct platform_device *pdev,
 	return 0;
 }
 
+static bool stm32_iwdg_is_running(struct stm32_iwdg *wdt)
+{
+	bool running;
+	u32 rlr, sr;
+	int ret;
+
+	if (wdt->hw_version >= ONF_MIN_VER)
+		return (reg_read(wdt->regs, IWDG_SR) & SR_ONF) != 0;
+
+	/*
+	 * Workaround for old versions without IWDG_SR_ONF bit:
+	 * - write in IWDG_RLR_OFFSET
+	 * - wait for sync
+	 * - if sync succeeds, then iwdg is running
+	 */
+	reg_write(wdt->regs, IWDG_KR, KR_KEY_EWA);
+	rlr = reg_read(wdt->regs, IWDG_RLR);
+	reg_write(wdt->regs, IWDG_RLR, rlr);
+	ret = readl_poll_timeout(wdt->regs + IWDG_SR, sr, !(sr & SR_RVU), SLEEP_US, TIMEOUT_US);
+	running = ret ? false : true;
+	reg_write(wdt->regs, IWDG_KR, KR_KEY_DWA);
+
+	return running;
+}
+
 static const struct watchdog_info stm32_iwdg_info = {
 	.options	= WDIOF_SETTIMEOUT |
 			  WDIOF_MAGICCLOSE |
@@ -375,16 +404,7 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/*
-	 * In case of CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is set
-	 * (Means U-Boot/bootloaders leaves the watchdog running)
-	 * When we get here we should make a decision to prevent
-	 * any side effects before user space daemon will take care of it.
-	 * The best option, taking into consideration that there is no
-	 * way to read values back from hardware, is to enforce watchdog
-	 * being run with deterministic values.
-	 */
-	if (IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)) {
+	if (stm32_iwdg_is_running(wdt)) {
 		ret = stm32_iwdg_start(wdd);
 		if (ret)
 			return ret;
-- 
2.34.1

