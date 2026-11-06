Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982884;
	b=GW2+fof3lY2GfEc+GEr7zn/l4or0y25s6Q1A6/FpZ75nqabDuqihG9QX5CwdoKAbAcYa
	 4ZGE5kWob6p+TbPpOg+Cj7XGcuHnBORWTKgwjUnfQ7CJQ/Yo7OFMqoY6iY5+bUdGsH5Cm
	 6HIJhZoKU4+x+Tt9QhE3Q3of2HUfPygl2Pn+5ZTkDgCRatJ+Ugq6YdpNeyeUUujR65ueg
	 9gSMh9F6ACEyImLo/Tsq3KQlgRwq44ffdbszMFwsHOu9Jmbsh1E99oqjPtczuP2JaCP1D
	 n6zyOiNa6FQrAej/XXf5GwLQ5NPQFYDzdTpP9+WGM+NYaNVTSWOHR5p1CIk3aAy7clg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982884;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
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
	bh=j36H8eIjAcdTVt3McVEhhRSbneLOVTOSlrbwV0whZgc=;
	b=5oJdeO3mdHNuhaPwrn3GIPWm7lXZ9CDqKGCDQbl0yMMFiRBwsezsFzu7jOUSIN8EcFNX
	 GpK11EeghzIpry6gKQcgKjBFmvF0i9uN/Ixx9wTs4EffrGfeJXr4xK4GL9FgC9T7q/ziP
	 uavM4V+8X+iMg11ObYwQ3ZUw+qjPIuG2pwrsh705gn4DU65M9CVpCb7EyXnmzd3w+4kVN
	 3bSs067FJH9gINnvE7Sb42F21TFx2RR1K2jbN1wfluEndN609GIwdXlHSYnXviumnSY+Q
	 mLBJvmULdrGnvDG4/FJxGA8EFhAZ7ZXy0RjfVOvsjh2mggXHHCm3PLosFymolKLfy8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=j7WP3pAI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.34
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB759606EE84;
	Fri,  6 Nov 2026 16:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB759606EE84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=j7WP3pAI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHSdHfgm1OQzdOpJZkytb9kMtJZ6dQ236xQAX7ZJN1t9Q9CXWdaezsakwyHb6P0TMyxD5YLHaGWiRPCEndJldf2K6rrIUjorZGFIBGqR7Le1/2BnpYOkHRBTMfIHOWK0aByqs6f2ysTCUj77iOOo9MzgovaE139efLnFcA6ncnHyG+AtDD2c4OuXxBc0htTAzkxeSnx40Brt/nhERa61NA1A5EiZgTisX/KT+x5N/psQj8obLVPpNm7hGycsmdYGxZ4/IsIgWQJHFkMmnYwDdKQ3xy0rcd+e/3ajinwpTh8Z//iolQnGluv3Jqq5z2xp1KFYRXKo+H0KMTmCE/SpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j36H8eIjAcdTVt3McVEhhRSbneLOVTOSlrbwV0whZgc=;
 b=d6LaY6eu0ghDHlTi5oZ7YhlqDy8p2DwxNLWZ4Ll3f7bg2UUCFYRYUvlzivlFG3HmeUapaNZOasle6qdWBuZ0rLTR9HljV71b5wCH3SS5QKYA9CpzTXafISea3s7JgEEZFAgNIhN77xuCKaefH+4hcLRJpYdTXEylaaA02KTT5sZV/T9CK8biv2Hb3NV1hmoo4U2URF8K+jcgNx2gKScCOidqNb9sAmxJGFALh9twzWVFPs2Lj1hAUo4NtWyDQ4VM4rjuYcBgVoEzPdoqe/HF527Sg7ZcpnI3Z9WPw7RQRIrLqd+Y7UutnE2FQ5Gcn5hakDlzfPsj4QWCiFP5KEvbVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j36H8eIjAcdTVt3McVEhhRSbneLOVTOSlrbwV0whZgc=;
 b=j7WP3pAIj6qJp1ijQSMsBjO6ykewAZisIqxxCBTscLxxWcFvqkGV1qCq+lUuh6k8bG4tVZCHjew7NYXT8fGOQpKr29eDjU9AD7eByth8u5P3a34NHh0NbAgW1D6zOwx8rXLwBzHuH0B4vDZ1LEiEaPEBGJl6chpKWjAyiYc7SxSd2DpdN0TXz+Rgng007/8v1QBpu84RAX5GU8PcSEjGEkBfKbqDtTwi2fFK7CS3bWJj//Tk2IsaRl7Xgo6hC+Hg07v5nnAnX9ofdMemy+FMW0OCv77TaueyJSIjlnGB6hD42mlbZ4PMyzjC9czarBFV+I9+2HY6FBARhe3yCbZy3g==
Received: from DU2PR04CA0228.eurprd04.prod.outlook.com (2603:10a6:10:2b1::23)
 by AS8PR10MB7449.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 16:34:36 +0000
Received: from DB1PEPF000509FE.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::a2) by DU2PR04CA0228.outlook.office365.com
 (2603:10a6:10:2b1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 16:34:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FE.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 16:34:36 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 17:35:06 +0100
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
Subject: [PATCH v3 03/13] watchdog: stm32_iwdg: add pretimeout support for iwdg v4.0
Date: Fri, 6 Nov 2026 17:34:19 +0100
Message-ID: <20261106163429.618392-4-antonio.borneo@foss.st.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FE:EE_|AS8PR10MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: f2356634-c36c-4802-17cd-08df3c23d896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|921020|11063799006|261021121427099003|56012099006|261021123027099003|261102123227099003|261026121527099003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xlQ8qQOSYnnuGPjJYiJ9YlFQItJruufgbr3Jwx04gynKMMRDiehgGEIAmtdubuvNw/uQ5yw9WRyKhVBir/TFGOw6UBk21qNqWUJqIYJ8lMGkfSnDU53iZ/C6MO+tY/j60qL2e0XDu17bD0raFRqq8Yj6QYn2Sx8t4V8TKZ5pLn8+6dqio3ANeIduZiqK1IITiq2ISFcBPdl/TJBW+5UR4yxsfDcd1i7Ai3/0nRYo5vV9qyDZfcQrRTN0mjEfJW6e+JxYS59PJEN3iabeNmAmY1Dq0KwVCWR6iXv3PtyNBaXTp+rkP5IMxKVAWCNGwQxdSv4NCpM/mHSAkSZ5gkrMzD3+RgHzZDlbOfwPzWaDz81nRQ69FdyYGXdAX5nN+HwslcAGjr9jFhPEbgp+XC5xCMwKfH2b7F0VKP4JX3V223teKHcJSBRDiMCL+IQ3BE89jeEK1DcY27oOKZ3rY6dutkY3ASv6xi/uRhkH1vpp0mTowhRpRNHmk8z34GdfP+Kfx+997keBGnhXcdfAzvWwpEqg4Ir4Cusb6eU9sfhEyMFcXzLDx5HYTO6+G14xXi8Q4c9SX4Y41caWgU9oRiYs+objyMLHWfk9hB+y01G7YnivKvGAw3s2GnGEnAszdEbQxnBI06ezMPykeOlcvZf5LBKU9pi5QgdziYNQy+CkH3onJW3E1zCraWXbihjHTtQsUygssXVk/m9Rms/wPRBMJQLp0i3wpLAWLq+DjBX6XN8OZRogTKRYpLE2mYMEEuF4
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(921020)(11063799006)(261021121427099003)(56012099006)(261021123027099003)(261102123227099003)(261026121527099003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Kxq++An019reYHpyOX1RjGq99kqb36sdJmz+NSGZ2bioB7SMcYquT6nfVzTKoUvidtDJhrOOc7H1dGRkysAlRs0zMptbv0Mi+PNsHWDJ58Q9FJ+j8V/Tk86XeY1vL+P48STZQt/fgpfbd5OW3FJJM7od/0enLgsdfohTPJdzJhcCDn8Mv1KceSn6vLTdEh1SzxlD4oNGQVKkDplZNi7L+htU/hSPxHaWTVClFEjPnIIUEVKWhtFpQcWaYjls8J9G2UNALtdAIoWphYWPlZFgRV1/WtPMsGb3Dmcti7JbhVxQgHOdpli9gZVVNs/gysuD6IOEA696RH69hHycA9PgLApGrSKKKyh2MyhhcN3kE6TR/INgqiQ/pLFoxlWKe9/RrpEWZZ26Cs8k+ndHVO6SQ+8vTOHDzJ/n0prE1zc2F3+7JLc+WNolwUtZ0K8vRrpD
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:34:36.3950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2356634-c36c-4802-17cd-08df3c23d896
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7449

IWDG hardware version 4.0, used on STM32MP2xx platforms, has a
different register layout for acknowledging pretimeout interrupts.

Use the interrupt clear register (ICR) to acknowledge pretimeout
interrupts on hardware version 4.0 and later.
Add a reg_set() helper to improve code readability.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/watchdog/stm32_iwdg.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index ce3e1f96ef50a..6121c23889655 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -30,6 +30,7 @@
 #define IWDG_SR		0x0C /* Status Register */
 #define IWDG_WINR	0x10 /* Windows Register */
 #define IWDG_EWCR	0x14 /* Early Wake-up Register */
+#define IWDG_ICR	0x18 /* Interrupt Clear Register */
 #define IWDG_VERR	0x3F4 /* Version Register */
 
 /* IWDG_KR register bit mask */
@@ -55,11 +56,14 @@
 #define EWCR_EWIC	BIT(14) /* Watchdog early interrupt acknowledge */
 #define EWCR_EWIE	BIT(15) /* Watchdog early interrupt enable */
 
+#define ICR_EWIC	BIT(15) /* Watchdog early interrupt acknowledge */
+
 /* IWDG_VERR register mask */
 #define VERR_MASK	GENMASK(7, 0)
 
 /* IWDG Compatibility */
 #define ONF_MIN_VER	0x31
+#define ICR_MIN_VER	0x40
 
 /* set timeout to 100000 us */
 #define TIMEOUT_US	100000
@@ -103,6 +107,15 @@ static inline void reg_write(void __iomem *base, u32 reg, u32 val)
 	writel_relaxed(val, base + reg);
 }
 
+static inline void reg_set(void __iomem *base, u32 reg, u32 set)
+{
+	u32 val;
+
+	val = readl_relaxed(base + reg);
+	val |= set;
+	writel_relaxed(val, base + reg);
+}
+
 static int stm32_iwdg_start(struct watchdog_device *wdd)
 {
 	struct stm32_iwdg *wdt = watchdog_get_drvdata(wdd);
@@ -194,11 +207,11 @@ static irqreturn_t stm32_iwdg_isr(int irq, void *wdog_arg)
 {
 	struct watchdog_device *wdd = wdog_arg;
 	struct stm32_iwdg *wdt = watchdog_get_drvdata(wdd);
-	u32 reg;
 
-	reg = reg_read(wdt->regs, IWDG_EWCR);
-	reg |= EWCR_EWIC;
-	reg_write(wdt->regs, IWDG_EWCR, reg);
+	if (wdt->hw_version >= ICR_MIN_VER)
+		reg_write(wdt->regs, IWDG_ICR, ICR_EWIC);
+	else
+		reg_set(wdt->regs, IWDG_EWCR, EWCR_EWIC);
 
 	watchdog_notify_pretimeout(wdd);
 
-- 
2.34.1

