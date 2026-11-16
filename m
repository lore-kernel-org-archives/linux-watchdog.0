Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794855703;
	b=JNDKYXF6PBqEyqID5UlRUMO4YCu8iR+hr1HTv6Mj09y6alWbdwppg5jqk4CZqW+wVUJ4
	 hhtaaOhdMqvTVwjiNNxECS52F8O9fxN6wshlN0BHusADNvkVi/APaAQiJ2Y9Fd0abVcc7
	 fLAqcCMp9dncFsxMVvgMdz9+2Q3+FUBuQS6tadHdoVbufwTlGjX3GIZw1toRqBmI97pp4
	 DcKN6Cgkl0iiW28y3rOYqE5WiXM6crf5QcjtM/XWSEAv8siV6VPNnFG1wtG+BnUQR5v0z
	 /kHSjfwTRz5TQQX+CLeN6md8Qy+WOESSYuG446/pM9doWaNJRWh/sVqGa4lv8nk24HQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855703;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wEEmZjD0vKv79FlaKUDu+FMv5V2rsZ7LB2NoBC7xmrI=;
	b=pPsE1SvUHgSy3UQChYS0sA1lOoZdRodLRNE3RsVOrROtYAxMzi4lIBUYCnsWEZ8L5ZY2
	 iUKGQ2YgjveOeQfBHeo9/oK94W5pc1dtVsDZUciQsouhdCXy/C6lneukH/gUimW172kS/
	 dyOKmVUGSbvBd9Q6pPDcA+wI0FFf729tsgaGl5guN1oV7H+2/XOR+AoPANxBLM1DA8nnd
	 E0jAczJQzlE9HaudGqsmC9Z3APIoqZVMb+QETldG16tVhvUURKFSLKUztCQTvNNqgDZUz
	 PJMmPrV6HtM+iiWVeIG3WReLbl84ZiFr/nFBIrpiUgXaB/7u4UL459/EO9vR+aLlTPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=hHf+ZY18;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.19
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013019.outbound.protection.outlook.com [40.107.159.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA68606A31C;
	Mon, 16 Nov 2026 19:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AA68606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=hHf+ZY18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoD+ROPwD0u8Vol1616PCBapiDfOnU5WDFYeTPuVeo89hAdtxq5BeFN1LHk8uoLKk8LhRDxsMU+fQYHO5TKi55QkAR6838j6Yoz4/tvSdmOHJc2hNM+8OFV2J0vtcY48qH5c9l3ZPvEP2SkkH3GYsS6vTMtWqBTyEq4MJWTrnK5HSKK2wQXHe48ONy/06Zq2Qc+Kr9ipPrrwZNsXgH85QSBScLOUXzGBmMAqlHxH/4nf/tfyoHcVp8E2a9m7C3hZzOLVs9eryPSsRwk2a8qsnKb4Fd3uZbJN9Iezx9PAU/ztTvqwRmeVh/eb0uItopbLOcO0JWpm8iA3+K0vzQFK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEEmZjD0vKv79FlaKUDu+FMv5V2rsZ7LB2NoBC7xmrI=;
 b=nNqfbcGWleVWnK/QmhCCf+GRnmQ75dSoDSuwqe3Z6VrBO422iM0y3Ngin094QcC1bjohI6vd8EVaYhCdKnRv5BhR0JbIHQIayditRCELg4qlvjxDPyna9EZOrhEyqoaw3SmCZE5a8wF/JLS+7LD8XxO4jfcDtQVD9pUHSQsno5G1vQ18HKxDkI02B1g/kv5aFWEJhzmft0wHWNYIaQgVdMf9NqfpBNVF7fVKaLc3Brs4zyRmWMTb/afBA2c8FZC5v3CGowZvsxvtEF94MhCjBsRgIgHB6ePvSDvO2+i60gfwuvpmDD9zxwlAVAWVoZjI057a4zp/BijHyBHrudITmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEEmZjD0vKv79FlaKUDu+FMv5V2rsZ7LB2NoBC7xmrI=;
 b=hHf+ZY18mQ58hpF/gtxNu3Hs2xboUCtzA5coFskh4JI0FnDgmn1thZsxmeOPaFeR/hzfq4c+WQ+Ydjtm/bUwtDObn3b3zaFugBlTv3A6GxcvSBmeFv9h1R2kQw929tFCbE8RAqd4VXyU5zquFuCrONLjfxpN2GmQkgMH0r/vJy+RQmiCURGE19guSEuDUYmaWrvFNef8VAzWvZfWyjp6UHGwVqvCIhQMdFsj/vDiysnVFZho9fNEkDrwTAz7qF4iNgEX+jlkSQ2wMKBP507TaJgcs1XJlWWn5gx6bMaruLLAMEK/AfniKUhobsjR7tqikGNTvQMf7SWInvfwUB1/kg==
Received: from PR3PR09CA0026.eurprd09.prod.outlook.com (2603:10a6:102:b7::31)
 by VE1PR10MB3886.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 19:01:35 +0000
Received: from MI3PEPF0000847D.eurprd02.prod.outlook.com
 (2603:10a6:102:b7:cafe::ad) by PR3PR09CA0026.outlook.office365.com
 (2603:10a6:102:b7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 19:01:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF0000847D.mail.protection.outlook.com (10.167.240.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 19:01:35 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 20:02:18 +0100
Received: from localhost (10.252.15.73) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 20:01:33 +0100
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
	<linux@roeck-us.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Alexandre
 Torgue" <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clement.legoffic@foss.st.com>, Marek
 Vasut <marex@denx.de>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
	<linux-watchdog@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] watchdog: stm32_iwdg: use managed variant of dev_pm_set_wake_irq()
Date: Mon, 16 Nov 2026 20:01:30 +0100
Message-ID: <20261116190130.1191501-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MI3PEPF0000847D:EE_|VE1PR10MB3886:EE_
X-MS-Office365-Filtering-Correlation-Id: 202283bd-ab5d-40af-ea0d-08df4414090b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|6133799003|13003099007|11063799006|10067099003|56012099006|261026121527099003|261022105027099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	trZ+WQKHD9KK7P8KlygY0SopexucDKtCN0QCQS3/nAHyzomWiyASwb9Ei3Pqd00Nh1jl7ZYbnLDwhp4Zw4GBFli60hZrYnpmft9vhYNWserpOOGN5PMMzIzegBrG9cj1nYiVVfw/rzzxS5GQWciWHlCUHgdptXsrsFhiYnz3LwMjq11O4PPxwrCQdmYsUX4/xJcL2izjiKehWwBe2wCnkqJ7daAIrhUYWIbYWvq7piFvutm9SHiVU6ayJZ5g2cquw8ByfWRXOMFtfkR2ag7YCr8HGyvgazqkISZIR4TJKnbZZ4TCGlY3I+cAOSuax7Og6LCx9W4ZclV4eskOkJYwZ/imZhKFLDEKYmhwwFzbJWwlGdZ7D+DwJ92YoNsuCWdRH6cKlVhH5R9jwXoxRlRvSnXFXLqGpaqv1NzK8ZaOM4Ac17onMPsj7fs347UYz2ch6pXIooumrnAVxm61CFzLX4hZh5h9AMmBGowos6NlNzbrm2ITT2hBLqm6gWeGBWSRex7ep17vN8lppcly9QMNFLawwMurdmhh+ZtLmvfOmpULH9XHdRlmXRWlLdUKB8i5KGWLFjGXuidYcq0MUuBJVfhDxxnfFen3UHt2ilGBnrD2h5ORA7WZQL8s0wTrCKOXj9jrd7CtzoyaSowhsT8sHg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(6133799003)(13003099007)(11063799006)(10067099003)(56012099006)(261026121527099003)(261022105027099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kHMOZSrYRdZyV9nKMrY0Qnx3vfM3FJmSd7/N/9mZhQR4grVGUFW2ssdNbjz74TCWlJJBonzTyOKGQY+tLZel6c8thZzd1WspjhmLaYTat4eqwVIF3JpA0ssexKQeJCoq2ndZpHhv6zb8JdaRD5QsjM1DTXGkPa4xEhQPGANa8T5IetF8c7wbgHoGAVrwze1569rZcspFWj6LXIIZdkRysv1v9ehCw8QhGhRpKfzjVlJ2q7+OiJzsh/DIypuPc1N0NVx8wDs9hVFkjPl5fkIfRV9PQqzzGfPhzJGQoou+f1tLWamPQ2XI0e+UmYXmgctIBXYh2/v/X44UNQCajZ1ykOsiT09e+5KvE2QAJsdDRmX5V5oOlEDIRQDLLCpyucLKcTN1O5/cmCZBbJ2g3aGHcaLH/lcyCtGg1yKMf8ssm5/ScGzvIBZNGwYZ37mbkBvG
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:01:35.0905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 202283bd-ab5d-40af-ea0d-08df4414090b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000847D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3886

On probe failure after stm32_iwdg_irq_init() or on driver unbind,
the struct wake_irq allocated by dev_pm_set_wake_irq() is leaked
and dev->power.wakeirq remains attached to the device.
Any subsequent attempt to re-probe the device hits the
dev->power.wakeirq check in dev_pm_attach_wake_irq(), triggers a
dev_WARN_ONCE() splat, and fails probe with -EEXIST.

Use the managed version devm_pm_set_wake_irq().

This is reported by Sashiko inside the raw log of another commit
that touches the same driver.

Fixes: 3ab1663af6c1 ("watchdog: stm32_iwdg: Add pretimeout support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/message/20261116132416.1184447-3-antonio.borneo%40foss.st.com
Link: https://sashiko.dev/#/log/249869
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/watchdog/stm32_iwdg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index a8d2db2d3cf8b..f1056f8100cf0 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -298,7 +298,7 @@ static int stm32_iwdg_irq_init(struct platform_device *pdev,
 		if (ret)
 			return ret;
 
-		ret = dev_pm_set_wake_irq(dev, irq);
+		ret = devm_pm_set_wake_irq(dev, irq);
 		if (ret)
 			return ret;
 	}

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.34.1

