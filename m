Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794835477;
	b=okm94N3Gmdh2rZv3lBFLwljfSAcsQfD0wx/umORKeEh2nclIXlJKXCIbH+6mt7hHEoWP
	 6RCHZ0ijagJligCrOfI7xzYSTd4JgYklA0pj253ZP/xX2S5A130j6yY8hFj2RaCdEPMPN
	 ty9fNeyRw0G7QXubblcwLbUrwRqnyyo4PvthevDqBT7glA7gljJFciMuH3teqDRkEOrcM
	 +lluFrOA6Kifr+jGUnuEE9VbOe1yQJNvNU4oI/iCXusVQZshooOpObfCMJvhd1eM2mCY7
	 fYrQCOXSjlWN+MUnZTUiSvk8z5++j9eFqpJAUUWnanjBaWioqC0JVJIivgpOYE277DA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835477;
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
	bh=GqX8d2KJvRlk7DtfALNlqGbsu5ECq/2ey26FvzAcPow=;
	b=ybNPAXeDqIOAKrLMI9ZQBskBvehOXa7LiQ5DItlzMrBxEerjstd0gM58Hjuu5d+ME3Gc
	 bL6bbI7pGWx/fV92YHka+88XlpWbhLu+XpH4wWLDCFQWzQaaHhAj6F4EKjOxLlmNLmZES
	 EwJpwquqOdmM+QYb39bqY/j/BYHZ3VoFnsAKHdd0TZM9A4Q5SDhYa2JmFb2eUHN5UoU7E
	 5AN4kxTyK+mhqKxEOi31kDHTd+h+3MffireVEv8/G5fF13Zo47jTwy8bjHBb0bYj+dJZk
	 ZGJzlhbKWka7sW5dKhjHeMHaWxzKfPQtbqw1c5o/frW3nm2mwY7nD090WmEWAauMnzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=RZa4+pOr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.43
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0E606A887;
	Mon, 16 Nov 2026 13:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13A0E606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=RZa4+pOr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDxV5iyT4vKE4lko4jTaK0LdHZ03xxkkimSK2iGCn5Uaosl7dHjJfGFcIobSjG+nqlzspRk4eHsKMiKnWPb1Iy3wpkCIJP3G/vqe6XDBHUqp0hKkrJFVHLPlJPjv2euzVaw2QSDuz/4i3Wddd4jjivWlgTNUUGSYkKpQcxY6/eS86wkwlZZcW8jmtpKslbdUfWcAdQwqnxBuJyUdogGJThsDc07wi6V6F42YnCbSHyPJiljQIwbrrUasB1HdeupaUgbttkiZTn+GTXj0rMPxoPwLatAwwLauzkTBrZL6XBHn+oPmQOvSte8nC3jAqsfuVa+QIF1JPKb/MItnA3qXnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqX8d2KJvRlk7DtfALNlqGbsu5ECq/2ey26FvzAcPow=;
 b=TtEtRE2bUb2q2SgFCrkm07ILzIQZ5lljCXuc4JOZYcAICe42lVRb1L0DAue+dcJe3/DuRWBKF0YN98nVtlrk2S/uB0AmqUWzMPgUnV7UpEdHmXCVPdNkl0y/ZZrZrb68xeWMN7tIyxfSDp4KvfmMwhVh+CpzBp3gU6xS7/V34C8l43qC396NP5Rt6V3+TAwmsRH7OX3uazy4RgQ8ZnrL/1ItONuaEfAf8C59+yAmP6nTdXf8Jqf5+Bx/vj01+E9wSDwbTQvu9JIFcLSGJHwLPNipOd2FD5fmXpDR90gcFFJNcwgHCgOuHdTC4zli1sGhf4KrvOWw9lRlk80vWaZ6bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqX8d2KJvRlk7DtfALNlqGbsu5ECq/2ey26FvzAcPow=;
 b=RZa4+pOrJIyNBlP5pK+Q//7Hj0Ktom7mgrkddqq77p9ApeIFoZmMCFCxrB0168KsIbPKrSiZN1fDFHvcH2oMNw2SKze+MpPapVVZM0JWJhiKxYqFKGKSfhr+R6FyVwnafCV6O0Bjken/UxFGj+xW9X15KCtnnToks6H85SyLFdmhSDNGF6k+04evQjxsvPCPAnxqVdBCv612ep20a58r8+3doo6rIwPhmF6wdWro98hg/1mAK7jpjVTZJf9DtSTo28D0HtLy5vZXH+B0uLrirE2eaHL2FPcDzvxC6dAOdSASXfCHMvyZyLKTp+LlC/sYLL3h0IzHAsmnNPYGzFS6nw==
Received: from AS9PR06CA0226.eurprd06.prod.outlook.com (2603:10a6:20b:45e::25)
 by GVXPR10MB8864.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 13:24:26 +0000
Received: from CPH1EPF0000052D.eurprd05.prod.outlook.com
 (2603:10a6:20b:45e:cafe::8a) by AS9PR06CA0226.outlook.office365.com
 (2603:10a6:20b:45e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 13:24:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 CPH1EPF0000052D.mail.protection.outlook.com (10.167.241.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 13:24:26 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 14:25:04 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 14:24:20 +0100
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
Subject: [PATCH v4 02/15] watchdog: stm32_iwdg: serialize accesses to EWCR register
Date: Mon, 16 Nov 2026 14:24:03 +0100
Message-ID: <20261116132416.1184447-3-antonio.borneo@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: CPH1EPF0000052D:EE_|GVXPR10MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: 84124f50-79ed-4396-2718-08df43e4efbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|23010399003|82310400026|921020|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261022105027099003|261026121527099003|261026140227099003|261022075727099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	+2FGBHx4ROnKC20km2TfaV74K6LLjp73Lwl5W+WjPw0GUV4T+GUikwz88n+8LbxtkxXzv4WNozMqZEMZm9JAYiiLyigKk659IPKjqI66/9v7KuoZIiQz1v36wx0pgmnDW/92uJc5Nm70rqY0IzNBiFIRZswJ5FQodGSLoPcQPk+peKxCdUY99YAMQvbIkPJL0FFvfuiyKrEkzMYRlo7NFQU9JZPwF4EohpGqe252D0uP6iUsjcdP8Jms1IYkxt+jCuelcoe3WKlg8+wRwAZ7WsfYU6T0ILKawe39HkC4/lnqYSVe1JpM2cZQ8mika4j1j/z9F3VARJLMowzBzi4xN8zyz+zUeFvGtdSPMwFv4C40dZ5MZbKPx5aJz+NoYl8j2qwUFeCX6FQNahxJET30ugWLu5SrmBLQNaXea/pvAuJsYpv1q+ZJe8t5Av4iQS70nhIWYIL+I+Y2o5YONIMYA25jp9eUvHNXJvHZgrpzJ0QiSROQrGb/1chm9YC1zDqjFrTFcqMxD4bKf0l146nyKac9bj4xyzoFN58F1q6Jyi/4deRqGg2GYqjWkpWXwoq1OjFUtlGJHVH089rjPR6FTSjy6fE4i5nW3yHD/s2WdS4fze7qnIGA4VsBkIHVhGKn4Onzma7EWmH2ER0zVx6LuT00tU2P5+xnxclBg0Cb1B2R0Z7GZ739MPv108r9+PlOM26XlQmVZkeBbPjGfdOtGGzjIQ1zyMcIM9CVdlOIUKimv+rv3357n5KoSeNLO75r
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022105027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2SheLsxw3QcG/09U3tGlHtVAuMhB7Ofu5uriBCTVMPDgwd7uct9EsdIhDyllN+Ji6qVYRypeiDVlhOzjkdOSweliK1XuHdyLjAb5myaYG+S6UufDuTunUeocZL9obNoHtkX0Mvhx5CrSYU8yIMdWXtApzu7U/oVG6wBhIEffBisvX9v0k8gX2ZKycOzdNlTzbFgHtfCKyzu9YB9UoS1hkmpkUqQyI2CX7Pqbm7R98+Folo3XdEMBg4PiiGDHcCET+EhyyYs/+H62nqUsXL3gnERTy5FkJWi2cvv+8XgwROKEdOxwTmK2aRGXdL508bl+75OFWCIwaPCJAAtKNteAi4U46xJ5Ts4KTdDb+npPhIBywfbSrwIuoLXTlcwBnFQv2DysSjc9ENyJsHtGTjnTBlkkNhyFCFPruMdO+2Owp/2vceu86weHCnrgxeYTiCs/
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:24:26.2649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84124f50-79ed-4396-2718-08df43e4efbd
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF0000052D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8864

On STM32MP1xx platforms, EWCR contains both the pretimeout
interrupt configuration and a write-only bit used to acknowledge
the interrupt.

On SMP systems, the read-modify-write operation in the pretimeout
IRQ handler can race with writes that update the pretimeout
configuration.

Protect these accesses with a spinlock to prevent concurrent
updates.
Don't use the helpers reg_read()/reg_write() in the critical
sections as they rely on relaxed memory access, which are not
ordered against locking.

Fixes: 3ab1663af6c1 ("watchdog: stm32_iwdg: Add pretimeout support")
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/watchdog/stm32_iwdg.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index 2bac4ce5ed3f8..487764b51667c 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_wakeirq.h>
+#include <linux/spinlock.h>
 #include <linux/watchdog.h>
 
 #define DEFAULT_TIMEOUT 10
@@ -82,6 +83,7 @@ struct stm32_iwdg {
 	struct clk		*clk_lsi;
 	struct clk		*clk_pclk;
 	unsigned int		rate;
+	spinlock_t		lock; /* serialize IWDG_EWCR register access */
 };
 
 static inline u32 reg_read(void __iomem *base, u32 reg)
@@ -98,6 +100,7 @@ static int stm32_iwdg_start(struct watchdog_device *wdd)
 {
 	struct stm32_iwdg *wdt = watchdog_get_drvdata(wdd);
 	u32 tout, ptot, presc, iwdg_rlr, iwdg_ewcr, iwdg_pr, iwdg_sr;
+	unsigned long flags;
 	int ret;
 
 	dev_dbg(wdd->parent, "%s\n", __func__);
@@ -124,8 +127,11 @@ static int stm32_iwdg_start(struct watchdog_device *wdd)
 	/* set prescaler & reload registers */
 	reg_write(wdt->regs, IWDG_PR, iwdg_pr);
 	reg_write(wdt->regs, IWDG_RLR, iwdg_rlr);
-	if (wdt->data->has_early_wakeup)
-		reg_write(wdt->regs, IWDG_EWCR, iwdg_ewcr | EWCR_EWIE);
+	if (wdt->data->has_early_wakeup) {
+		spin_lock_irqsave(&wdt->lock, flags);
+		writel(iwdg_ewcr | EWCR_EWIE, wdt->regs + IWDG_EWCR);
+		spin_unlock_irqrestore(&wdt->lock, flags);
+	}
 	reg_write(wdt->regs, IWDG_KR, KR_KEY_ENABLE);
 
 	/* wait for the registers to be updated (max 100ms) */
@@ -185,11 +191,16 @@ static irqreturn_t stm32_iwdg_isr(int irq, void *wdog_arg)
 {
 	struct watchdog_device *wdd = wdog_arg;
 	struct stm32_iwdg *wdt = watchdog_get_drvdata(wdd);
+	unsigned long flags;
 	u32 reg;
 
-	reg = reg_read(wdt->regs, IWDG_EWCR);
+	spin_lock_irqsave(&wdt->lock, flags);
+
+	reg = readl(wdt->regs + IWDG_EWCR);
 	reg |= EWCR_EWIC;
-	reg_write(wdt->regs, IWDG_EWCR, reg);
+	writel(reg, wdt->regs + IWDG_EWCR);
+
+	spin_unlock_irqrestore(&wdt->lock, flags);
 
 	watchdog_notify_pretimeout(wdd);
 
@@ -323,6 +334,8 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 	if (!wdt)
 		return -ENOMEM;
 
+	spin_lock_init(&wdt->lock);
+
 	wdt->data = of_device_get_match_data(&pdev->dev);
 	if (!wdt->data)
 		return -ENODEV;
-- 
2.34.1

