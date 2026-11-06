Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982881;
	b=daSi69U759gqBNUxN8Ylq274i2IMK3XuTUTJxVonxh+z3cHXTBcqVuTEp0fcDBzq9c1V
	 Ze9YLdni6wMeDxfbdVBxdN9KvaXf55EE//olUwwwu8ClNDnzukulSNxTu31gb4jAhTf0l
	 NYjrkA2ikoHCRqXKYqvPWAD5ElXDguF8swnK4cN+8h5iiCogB2593qlsm97PBGFVw8IWX
	 cxhLr2rFGR2Jm79eRiNVtJyZjjdzKuFd1UbeZ/b1t3f/M62tz19gA1lEVu1IW1/1+Ykuu
	 9xSE6v6sF9JZFIL9JObOLnvcOAi/6pYSXao89luffQ/a7tJwmygchnmh0SSXzIhA2HQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982881;
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
	bh=nVLYRgUGSvhbBlPZbbSFWtM9nrTZqhbIpC40fGrd50I=;
	b=bsTEmirui82QxcsWal4xHlJcMUwQHHowitlqa8zuLnRdjdMoHzv5CR1DXZ0ZTc2NzHLZ
	 xDSSTTg0cSXcaMDG9cr+f2nOU2tkp/cEgZEj4uo/XA/AbqM0IJFerLipv5qpvJprMes2h
	 xntyGjRRVIfxCI3UenKfa2jBTMs+2bVX0FB5dsGX5I/UI2RDY82xfY707Z5Hq97bNL6xO
	 Af9w3dGPRP5D432b7qrBBaP7HDnKfsZkYcQYpfJ5rDY7kuyb1iAkYnxw3HQlzLhNZyndR
	 MQFy9tXx83decaO0YZF0yVhX07AuGgon5c0A9nAFzQLpZafofgjt2ZDEk9gIGmzBFbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=VEjYXEMy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.48
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DEB606A33C;
	Fri,  6 Nov 2026 16:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6DEB606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=VEjYXEMy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6NAzZBgo8Q/85c9JdtUBHrWgWoUvN4dyoZLiahm9odViSHo2Tk4a8KIOw3uuuxaKUK4x1c//4lBAxprTo6J3r8OOvYfamXKaO8MV+V0X693xC2YykdAJqA3UD2wXc7jJohSaqU4Lar+z4gVORh/5DZHBCQUw0v7IVviM3WROHlm07430SAfb9skJtbci5V1v/6+jZVpf+RUopdetGkWbLtka29UPWt9YVzGUwmpCvUFTY/ANzSZ9U5lJcvHhz8cOSBPgMozv6pGiWwWsfgJI3DARu1mm9n+V+1CuOTkPqSL1rp5AxayOL8wDZQP70QVGbqJxMZAV6MX1rVF0Bkj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVLYRgUGSvhbBlPZbbSFWtM9nrTZqhbIpC40fGrd50I=;
 b=cerLUzEob3WINsei69x+1eZ3kNdarZllJUzsqirvsLxYKOZmf2pDAaoP77q18Zy/sK5AZPaXirD6YnB4zWGDrdtku4tL/NybdW6TgUgdU5RMLpggZewTIl/BBODPPzrxBIcRmtKbOIQt5W6BOyYFsSuBvSM0GzqoiqPgyRTccjHVH2RAaRavpwXLTWVORYWpUxrG9LSsvibwkck6im/5sX9WQ+k/W5E3VoRby3V/sPqkgbghxsutsE5UH4Raqjnmixq605s+JfU4luMG7Hb73HHyx1jE0te53rZ9ShMXGx/kgUJlvDYYXqn7sRsYUROAEIQfkmSa/opmelZs3Ep30Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVLYRgUGSvhbBlPZbbSFWtM9nrTZqhbIpC40fGrd50I=;
 b=VEjYXEMy/bm9FK+tlSkoLB+0dEtu3l5JgmXmsTPgeiJV5/Kfw/ckhEA6fuVsuQfScEXF0/oWhYjXocYlX0nS9i3zHgfueOuejTu8BjxOzo3MH8uUwEEQfxQFwFVOEGXsHVpLlM8SMfHnZDt+yITmMdmVTALgKXfMAQrx4ptqBNcq8dX/VHRo1DPU8pX1GTc/BSb5c94DS6N5uKqjl2zABeAfiTH5qz0VRIOpzqn7dMjp4wBI8oDXv47Dr56FordLn5JDeFXf+8sfaTYuF1S7bivUN0uSp800eTKHhr1dkTt/mAoyvZUC8oWF+pBWW/QQhtqikm9QD78ojeoWZdv6YA==
Received: from VI4PEPF00000146.AUTP296.PROD.OUTLOOK.COM (2603:10a6:808:1::890)
 by BR2PR10MB992286.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:2c8:17::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.5; Fri, 6 Nov 2026
 16:34:35 +0000
Received: from MI3PEPF00008482.eurprd02.prod.outlook.com (2603:10a6:298:1::69)
 by VI4PEPF00000146.outlook.office365.com (2603:10a6:808:1::890) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.592.11 via Frontend Transport; Fri, 6 Nov 2026 16:34:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008482.mail.protection.outlook.com (10.167.240.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 16:34:35 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 17:35:21 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 17:34:35 +0100
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, Wim Van Sebroeck
	<wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
	<linux-watchdog@vger.kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=
	<clement.legoffic@foss.st.com>, Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v3 02/13] watchdog: stm32_iwdg: detect whether the watchdog is running
Date: Fri, 6 Nov 2026 17:34:18 +0100
Message-ID: <20261106163429.618392-3-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106163429.618392-1-antonio.borneo@foss.st.com>
References: <20261106163429.618392-1-antonio.borneo@foss.st.com>
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
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008482:EE_|BR2PR10MB992286:EE_
X-MS-Office365-Filtering-Correlation-Id: b38780d9-3559-4d16-6a12-08df3c23d816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|22082099003|18002099003|10067099003|921020|11063799006|261028144727099003|261026140227099003|261026121527099003|261102123227099003|261022115727099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	y4X2d3SP/YrvQQq47L9dG304WHjQjCw9GAP8rpw5QD3yD48sBnNmdNhDB4J4SWlXy5l6fYKhHvbAx1/pob3wSI0pPql+Q9KJ+wxdEXWLYeNlrd71MMU7U5pTRBFkIz1P2iy+CBCs8LC1fxk57ortkgGlIetpIT9jcyNCtOo1+c2m3EceYImbjpPX66tqTqN2e5pl/3g9pm6B57Igaa4cKRe0aO9qCcp99RsQtkQAXwAxEhC8MHQqe/bnGQvE0L/Mk/P0BAH3SxxM/Zie+PD1H4nT1Hr04oPd/4BpLoxGjRWYfOxVBWSEGhE0lPKVXA3re7OLx+GRye4Ly4NgjKaOI7T75oF5WgBSY5jtyUNMh9duyV4V85GglCiu0gMNS4G25Is/O55W7ZbTtVxQsjyO7EhF3sYTWDLQ0zDF6D9SQhuNtjDpewxnmMbNK+ySI7Ihy/nBBFuygBxCbpT6T1ok14QSm5X+wf+GLJDq8DCVjBG9myPguUkewx260VYkwJtQaBkei+Ad1ylqiePtbjmCYWePgEaQKYO14eZZY3DIu53Zu8V9bYcOdb0oPj+XjL5BYVNaH1uYjarwMQZWafN7nNBwAnYO2xucmOAdIoHdacQ7LTdh6YZ37163ozQ92cXPxoe/UcQC7YuIisjRMaed3JGzUcM7ifHV7+JeulDN0HYz19EV0quYAK714I/t5LiWWKVP8beax4e0N+KEiavSt0rNEHIBhiva/xOjUqBOMhGsYr2sHt4U7NIDpgcngVdq
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(921020)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(261022115727099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tx5lRcijuiiKoSraXr3/aBOiUWtHCOOXdlXnvKFL1WNfCEQFISzvp7frNr7tiloqUGuwGJ9QR42P9Wxqp72QHImIY1lSOStnUOzK96Z7tX887Z97Yg3Ds9F7cToZDjNIo5qu87GtQIMFXczjnOQ38l5KKnT7yptD0/6W3pUbkEivEsK/rdWWi/Jl2V975Uzxc4F8C3FdkEJ4swYnyu9lSrk1U2u/h+tifUg6e6w4oaZO6KP9rBLOc7hiLIce+G3dUMe2EkHTX646KtiUc3WNBGNfHspz+iUQ4POeW6ymLcf3yy0c4v/3B+xGeGWQ8YVNMI/xR0gr8Tvmv+qjCu06Mo5U5XTgIMtmdcVU6w/mIUagZd2IlODmsDU09QkstbWaef4oooWEuK7K+FdgD/NkJyfim+i+9Rm7EAfURNqAeJQ5QWeC3ELCVMXT61++E9KX
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:34:35.6380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b38780d9-3559-4d16-6a12-08df3c23d816
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR10MB992286

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
 drivers/watchdog/stm32_iwdg.c | 45 +++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index 30b4cbf20afa9..ce3e1f96ef50a 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -49,6 +49,7 @@
 /* IWDG_SR register bit mask */
 #define SR_PVU	BIT(0) /* Watchdog prescaler value update */
 #define SR_RVU	BIT(1) /* Watchdog counter reload value update */
+#define SR_ONF	BIT(8) /* Watchdog enable status bit */
 
 #define EWCR_EWIT	GENMASK(11, 0) /* Watchdog counter window value */
 #define EWCR_EWIC	BIT(14) /* Watchdog early interrupt acknowledge */
@@ -57,6 +58,9 @@
 /* IWDG_VERR register mask */
 #define VERR_MASK	GENMASK(7, 0)
 
+/* IWDG Compatibility */
+#define ONF_MIN_VER	0x31
+
 /* set timeout to 100000 us */
 #define TIMEOUT_US	100000
 #define SLEEP_US	1000
@@ -250,6 +254,31 @@ static int stm32_iwdg_clk_init(struct platform_device *pdev,
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
@@ -362,23 +391,9 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(wdd, WATCHDOG_NOWAYOUT);
 	watchdog_init_timeout(wdd, 0, dev);
 
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
-		ret = stm32_iwdg_start(wdd);
-		if (ret)
-			return ret;
-
+	if (IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED) && stm32_iwdg_is_running(wdt))
 		/* Make sure the watchdog is serviced */
 		set_bit(WDOG_HW_RUNNING, &wdd->status);
-	}
 
 	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret)
-- 
2.34.1

