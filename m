Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794835509;
	b=Wyplf2U1wx8D3l8Sq6uCv5LTheU2QxJt0LfG9u1g7HTK1AaJVZbfyJcVysbBlQyHZoRw
	 OryuFGHHoDoSUD/LtsvGcD5X8RDeWZFsW4qQcVR5V4AiM30ajucrpAzgxb4IBM4aM0yQ8
	 8FTxhZRO9fmQOCXkxRZodjUXK5U0N4n6zM/Hz/2+Y2ilajLsVQg1BikGCvl7KIAPtHE/e
	 79mV6B6U4OUKdrLhnU+uCQ6IFcn+tyXPyy4oCGeP8y2NLngdR+gZ0UnFxgm7pOThFyFMN
	 K5g17pwNj1Iq9Jhv/IYRmJMXhWHg5mUd0TO0RRH2XvRWDEl9UMCD+CUgVULeNE0b/cA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835509;
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
	bh=bSybTk4isOO774LIDtAhb54fNa/UQg6cs/Qo1zeAfjE=;
	b=Conbjyg3f8igNeTfJTc/+QQtzs2yMDUscDPbu+/WYRjVZCJpByOxI/laDV8ziKeQDRIY
	 7i9/xvLCw168QsN5guRqa1hqmjiCPWSGZLAlnM8o71y5wQPGZbQv8frikOr9kHJtdPZZP
	 l1cyoc89j89nRDrNzchbrbkrSQ4LbmQqLAf3qbpuNsHepulmEMQEYAR+WH1LSc0FBLUNo
	 f0VRXv1dAFT7ZjYAoi1mw8b8/pDQWOYNQewYlVz8eMsZA5tlhbm3G6D56AeXIy6ZxP2xJ
	 zw4Q5nCQIyqVdK2DoGWGBDs4mdJvzAIFfADO8B83feoxnZsiyJrtpBS8hqdbBC5bFWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=W+pivFK9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.31
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E92C606A323;
	Mon, 16 Nov 2026 13:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E92C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=W+pivFK9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZWJ+sXqE6QtS9MKL89VO2YNsmoTEYBGM/gvJMNzoqnNfAHX/maG+JGoCnP32M4bNmDyxyfi/Ry75n5QAwzuFmz8Nl2Z/r9P5XuwhQw/AFk6iY2TO5da0I4bCDAF61lLXJUxRvGIWmetqwgOXNTrgiwMeGwhGTII4AVM+JLi1rwFsFP0Fv9CuRahOuxhjQZuLCPAcbUt+OxnVF6DpD2Owp3B6WEbu0KaNzb3OzA40eXSZKZr3HVobpzyKqDq8XIUm6YJVlhF6RUq0t+FpUFTrTZm7YQdxCdrhJQoxjxTl66U0Sr7AG4sb6/WDWfzS2KXaJ0ecuD4G6UK5HyaypvfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSybTk4isOO774LIDtAhb54fNa/UQg6cs/Qo1zeAfjE=;
 b=HXtH1oT/CjHg1bMmKo6q1JAR1BY8OTzNCFj0ml51Q4wXFKrjlh9G9zLXwClQ3AuqAwLwovd/uAl0eEIxL1XKe01/MmX2zqOEvjP+Kug7lX4Hb/hwcxGsIFZfXUGx69nz4UhtS6mhfovYyc7ebc+agvOVN6ph5ewm+mnYMwufoypQdbL2jIjrUrApeRF4EI3iMpfNpe8Nst0a3YYxC0H3309SKJrqRyqWnskik0ZI1ZvsYAyAPt1kVcSwP7u3troYI1JafRb1iciguQahcuwUzaYyXTSloTpFQ4BNcoW+gSeWlDVu9s1CYNXb3T4b5eNdS5XAPUsGs4zUj8ymmQXIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSybTk4isOO774LIDtAhb54fNa/UQg6cs/Qo1zeAfjE=;
 b=W+pivFK9kqoNaI/fWSnexAfFCDZiAmZqz8J+McGodp3+iuI0B7XBw/0uzxk+jLAWMvHlXDTJqpMaAruDLVxzXW1jyt19jTnUNp5QM7D/F9YBQlRkKtUZ05nUfS7VXgQUdsST49Ci+CQCzgdPSVnbgOVR4D1wj0V7iIk4mmqcndPacRB4bn0Cpo+wuOzrRbc50uSFxx5tZHnQ2eqY9+yEZOa0JWIuRw0TPZySBzX1SN3ipFQnzuXELhA2oza2+VehBTL1DMW1zR29Zf/IVbXm+sTfgHaOqOi0vItck5t5EAgMjRSofIEApV/tZj0HG4sOo2283dz/u6xbbeROWOJxEA==
Received: from PAZP264CA0099.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fb::7)
 by PAVPR10MB6963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 13:25:03 +0000
Received: from MI3PEPF00008558.eurprd05.prod.outlook.com
 (2603:10a6:102:1fb:cafe::7) by PAZP264CA0099.outlook.office365.com
 (2603:10a6:102:1fb::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 13:25:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008558.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 13:24:59 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 14:25:22 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 14:24:22 +0100
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
Subject: [PATCH v4 05/15] watchdog: stm32_iwdg: add pretimeout support for iwdg v4.0
Date: Mon, 16 Nov 2026 14:24:06 +0100
Message-ID: <20261116132416.1184447-6-antonio.borneo@foss.st.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008558:EE_|PAVPR10MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9c37c9-ec80-4366-69ab-08df43e50355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|23010399003|82310400026|921020|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261022075727099003|261026121527099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	c1Rvig9yNuOeS5km5UulQAhe+YByYvXrVqLnS9y8pV/CjhZSPG2XhJr/8yYNduV9HkGKPUUqDoo9aSNpivMIZzUcgTgVaWYUf04S8if44jdwOv7FICY/Iji/Bhftekr0YmrsNdHlgnTOmbwCKWQLzp7/GXsOG3mre+80Lno4zIygD0jkiMDRgtutJvyC/rzeIszVKTLL3R3C3/jgTOAvG867lkmf/DmK5uDykkABWNQj1K3rp8bdwbaxM+cdfbs28I+ajauvPNs78sKk9ylsLCecZ/6/tp1FBb4fBJK0pt+OgcQBdKvr4MzI2mALs3MoCLdRP9T0VfA+alieW1t/HrL0scC32Tf3znrI0G/RNOKHhB1MkvpcLqY0CDkQ7C5e6Z9BSXpsB3j78T6YpbUizPx8+18AXfOpnPzPSO22tdGsBNmUQfRHbdnVBCoYHi0HJNdFPSs3x8/03Nt6kdfzHgoj5jgf3VMbGho27po4b6U9c6J53XGLd4oZZXT+yhh8I3TIiOEqtoGhUIi+S5Oir0jLU5WcOP0Eg4nPDozgXvR3Z2w3x8/XImZJOivpmV9S2vfFJ8TQrK71xzsxKFiXrq+lQHTknPxIfVseHjEjIyVEZGB3smMz6+laEUeR/r1KYAh7g3madmuNczApi8AUZHbkzCJydLE4lC+P8ygXwtn/Ff3z74XogEkhwtLdLSf0G3CwU1toVV5d9fSR4dJMb6WIhHc/tuixOBiObY94C2heoo+XNrC4BEdnDjEAzQta
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022075727099003)(261026121527099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Hi0Mg+fh7KPYqCoSPjvLjpDCmsHZPF2Jmymcp3Me/4udwAvDOpv2WAQyaf4PCHls8k1YQiSK6sbxgzmCt70BKnaqm8mHUrVKWtF8UpdX/fBgq2vzyGuTcDDP1cgMnZClL3fKb2Xn4Z/y/0O/Umjm//+y7okla6X4fPWAr7UI3pKeLvfebxg15hz1lg4tY+JJmHGlN1xunA3ilv/un1vxkwJI6ofoXhIrXsAkvs2lnlVB3wfmATRc93gME/2UdlkUpxwAcfxmLKzFovLyHxNZDzpNVACWv3izgHbKWhg4S9X2akAKOyXfoAAZ9ReiJ5RxpAqRZXZ67G8sEXJ7NtrXhIA+hZnl2HtS81/gI9ggTn1YRotlFe65dOW97Vs5HiisimzbwbPyUkS6KUO65xysEtl+P9x1i7Rsc53RkgiSJcrysHOP4ezdikHlWe1h11Su
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:24:59.1919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9c37c9-ec80-4366-69ab-08df43e50355
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008558.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6963

IWDG hardware version 4.0, used on STM32MP2xx platforms, has an
independent register ICR for acknowledging the pretimeout
interrupts.
This removes the need for serializing the accesses to the
EWCR register, used in previous versions.

Use the interrupt clear register (ICR) to acknowledge pretimeout
interrupts on hardware version 4.0 and later.

Don't check for HW version in stm32_iwdg_start() and always take
the lock. This makes the code simpler, avoiding the version check
and the duplicated write with and without lock, while adding the
negligible cost of the uncontended lock on HW v4.0.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/watchdog/stm32_iwdg.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index 1a5715ff9fab3..b3d39d916735f 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -31,6 +31,7 @@
 #define IWDG_SR		0x0C /* Status Register */
 #define IWDG_WINR	0x10 /* Windows Register */
 #define IWDG_EWCR	0x14 /* Early Wake-up Register */
+#define IWDG_ICR	0x18 /* Interrupt Clear Register */
 #define IWDG_VERR	0x3F4 /* Version Register */
 
 /* IWDG_KR register bit mask */
@@ -56,11 +57,14 @@
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
@@ -203,13 +207,17 @@ static irqreturn_t stm32_iwdg_isr(int irq, void *wdog_arg)
 	unsigned long flags;
 	u32 reg;
 
-	spin_lock_irqsave(&wdt->lock, flags);
+	if (wdt->hw_version >= ICR_MIN_VER) {
+		reg_write(wdt->regs, IWDG_ICR, ICR_EWIC);
+	} else {
+		spin_lock_irqsave(&wdt->lock, flags);
 
-	reg = readl(wdt->regs + IWDG_EWCR);
-	reg |= EWCR_EWIC;
-	writel(reg, wdt->regs + IWDG_EWCR);
+		reg = readl(wdt->regs + IWDG_EWCR);
+		reg |= EWCR_EWIC;
+		writel(reg, wdt->regs + IWDG_EWCR);
 
-	spin_unlock_irqrestore(&wdt->lock, flags);
+		spin_unlock_irqrestore(&wdt->lock, flags);
+	}
 
 	watchdog_notify_pretimeout(wdd);
 
-- 
2.34.1

