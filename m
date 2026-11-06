Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982881;
	b=1daEQJNs6wlxmE/BqvQ+1zMaQ41ox3gXjAjYlkDv4hP/6YFkw/c2EysvDCkBL2YZO1wT
	 qoQntMKdOYO6Ce10QthvzVx/iJA59k5orMZb8OO+zap21jEsmYAx4bIgllt2nb44Pgmci
	 PccdrFT3R6DwgQtegJ6GzuyyBol4OLMkPKX0rJhjy4WM68Qoio/E8bRRZx2ZNcha+adOV
	 VsGIrWKOSC3EfmHdqkxwjPhHsSrcB/1yqMDxDflnE6ihlZ3SEAAAG7/0+TIPY64k9Ppjb
	 kj11Aq9oc7+hGuv0xiDw/9bmfdR55wBmzbk1/Hv1q8HAEraC7peGWlsBtf1hgTO4eMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982881;
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
	bh=k128ZcR2Uar3siuYTAuf1rHHRp9uXYO9JcYIwAYL+FU=;
	b=kWeBU+pKUlMA0vq3eEeJ1tNOhiqZ74Y4bzqtQhh9MqiPjreD37V1u5OOPi0rmIhNnvH7
	 zu21JKc4lGU+U4REgjQiQkZ4bIXZom9xxOCpgM3z5KXUCyz5bj4Vx1nIFTzZRUWGXpTBF
	 ZdH9rBgHSATNFiQsfGvZn/KB/imnlK11dR23rGUEawErrVHDcGHF/CuWRUG5klfBDa4Wa
	 aPHBIfJ109BqcLL2qkkUhIUqACeWSYnQxj1NPPr5iLNkmcYKXCakGHRvxp4zg9i92JgUW
	 KyThl5ZL1cZ/vEBNocq7xnB5nyYd67Wdz8hSmCUJ4Ai6zvhWWPRnp6b0tfE4+c8dPqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=VACtzfEt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.49
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013049.outbound.protection.outlook.com [52.101.83.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9B1606D803;
	Fri,  6 Nov 2026 16:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F9B1606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=VACtzfEt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUYbcig9o83UKYIikwWoRQC4gII7VfdFQZxaKyqPDvAZ3CBtDiTYY0Yru0/9RJCL+ZNtbR25bAkn/8HVIdm3sUa5frLYIwtql/XrTpoDoEztaxIv1a8evHaP1SOSllVJIq9OoVYgCCG2+NlIX4XDzIyQBfbIFmUoB5JIke0bQOBLtbh3Vdg2M/dTIiUE7LQ9KDwaEs1rV0dgwzT3VgZn3mco3/qAOw7B2vd1X70m8Vf2qg1UvF69juGoX3sGdFhH1QHGWlguGlhAgld0gW40D2GXXohzDRHWiK4dMXxMuDtJ/wYGKkpZJCVAUn7fX+pa2XM1oDrkiYaJvFuVOf1tEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k128ZcR2Uar3siuYTAuf1rHHRp9uXYO9JcYIwAYL+FU=;
 b=wTWc2P+qNtXtGcdHfB+Uci4Ee7RR+P6br3leS/INKLuMyd/t7kdJviV2ovBURbiZLRhZW+gZC56TX1x0H/USNLmAJkxcnSXKu4Yq7+le7w5lTYG0sBWJ9t/1BUq6VNSPK5hbtikgK1ApP5/PikURvJGgr0YctL0dSIxxMv3mMXRmW15DiozT9DYXf8omMFu6+kCBrrdDLog3yYlSUhnzk9riF0t5rT1kDlK/hzks/3TIh/ZbZezFkOcH4nsHVf/mth6yzxyIzY0ycl97OqB+3IvIevK28mjoD93LHWy+jTTpBa5rP7of6DfyrnQT+8SRHbaI8auJYxDW8CkfLcEvLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k128ZcR2Uar3siuYTAuf1rHHRp9uXYO9JcYIwAYL+FU=;
 b=VACtzfEtkWptkpcW9V7i6yCu/AuPdYRWaEEqQhkH3WU658PhaOheaiXhmJYKDw5bR1K+kTxQB86E8G89dan/owp9T9Ic2etnWL7wptRmxazfSuMPbR9FPbFiy1xHwD05TAnD6cynKdG4Bic1eL/eSeaNbuaqRhqzrf3hl+GJ6fA4Nib4grYpdK6MYrU6ZwBjVxuHsB4zeGhFa2xHLnQTh8xl8toQmIvqTJMczehIIbcG9jA+PslGbbsxFBE1QhNp/s8BtUfVQxAugrtuQsn7gbfM+47maP61v8dFpCtzNlbhbcNYmXTYX+1RVtFPxBEIDJNJZZNk3ORTWfMeJA2kDA==
Received: from MI1P293CA0019.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::16) by
 GV1PR10MB7572.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4; Fri, 6 Nov 2026 16:34:36 +0000
Received: from MI3PEPF00008483.eurprd02.prod.outlook.com
 (2603:10a6:290:3:cafe::56) by MI1P293CA0019.outlook.office365.com
 (2603:10a6:290:3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 16:34:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008483.mail.protection.outlook.com (10.167.240.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 16:34:36 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 17:35:22 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 17:34:36 +0100
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
Subject: [PATCH v3 04/13] ARM: stm32: enable arm smc watchdog on stm32mp1xx
Date: Fri, 6 Nov 2026 17:34:20 +0100
Message-ID: <20261106163429.618392-5-antonio.borneo@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF00008483:EE_|GV1PR10MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3bdb44-07d8-4c2b-bb59-08df3c23d8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|7416014|36860700016|921020|56012099006|11063799006|261009223027099003|261026121527099003|261102123227099003|261021135927099003|261021121427099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	GPfvLJ7hvRQDYJ+yV0rowqXWnBfzgrIucNm9qjDz1zCKgHMnQohAg7jpuy5EqjxbT1MlVZhSLjk2iCN1qmyHUIk+eLCbNil2RCBv6DaJfDcp5ZW4ACmuNR6NlQAGeZFWRPyOBFiJbKv3O1/2IxF1fdNLMQMO/CsKKosXc3c0KnWQMcjMY63noAMJpnpbieoCRBnLQ1PRU8h99DEF4G6uXfEmkIBToXK/leHmWFImIzShtjUr1PQy6zRhBxdOhnDGRFfm7C7lZYO94iJB+iKJScBhzTEY3nZFVWaNlQmHyTTO9k6gNM33jTwQH176xJgsT2IDuN3g+UOO8S1S4o1FpL/vAR1PyVEc+lTBcabSO8k5yJxk9tOuOzT1Tm+hb6N4xBS6mCxKbcQ+pRQXDXWWd4pQpeQuBbptK52W4cb1wMTPfZsgbaHzLP/jRman3GR6xx9fGJewnExRuYu6Ebze2zCel5d2zU/MjgsJHz2hMK5ZRW3rouF8UiQZ58Xm45KB0otD7GJBy1hzFsGyTW0IVvpJ50y69xqkoTssFYVXnOoXHJyjxMBKNoa9tnNqDr1k1WsvAEy3TWrYah8dUT3WYNnm+y2Y9hgUgUgSZlF9pYKFGg4/KkCZD0AjKrw6wdsydTMiHEpvOI32tLJJf4vDrafHiN3XmKuRAnaNpdjSF7XUHfwxajBBem8c2dcsFe15FlYVkxC+U3vo4CsHxXqX1WgcRWOGn5Y9V25k033MqFOHBDkSLlsolQiI7TKKGGbT
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(7416014)(36860700016)(921020)(56012099006)(11063799006)(261009223027099003)(261026121527099003)(261102123227099003)(261021135927099003)(261021121427099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iuX0y6HysvwsnuIOcZADyWIA7Wpb65UQEyKBjgQfHsf0iXgi9tRpL+08JyJXkdMibzH0HTYQNoi4nsRbSapCbHCmg6wv2xrQf6zzKG7UnLjeGTGXUDjMsIwG9WU1mEtktG+Jqhj6EoDz0JHpCYgTJDeR0WT4wSsZtenqxcCL+7GyX3QPjlpHJ2FGfIMDBNZNkmPEFqqpaYJ0p+RNt/qJcobF1KePpAK+pvV+uZUJhyhu5yx2jXwnIgrwHjmw9C0EsXDXZgEHV2eduBkWNWsLmqWRo6LFeDrQjvZO8mUZUsjA5cYmk7OBsjvCNU66V2aagF6TPvhnFFbxzdeE7v6RjXIaK6gywUFTi2QIdQ492UeUoMksufvAnMATMZm1yY4ocrsvW9V4fBW2mZBxmcWuRX2edNlm721r7xrzQdQZVJ65wa1UgHyN9cRlzgPWS6Bd
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:34:36.6985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3bdb44-07d8-4c2b-bb59-08df3c23d8b8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008483.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7572

The watchdog IWDG1 is secure by default on STM32MP1xx SoCs.
On boards that keep it secure, Linux must use the arm,smc-wdt
driver to ping it.

Enable the driver for mach-stm32 when ARCH_MULTI_V7 is enabled.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm/mach-stm32/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 4ac3384e397aa..de09b2afa0f2e 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -13,6 +13,8 @@ menuconfig ARCH_STM32
 	select RESET_CONTROLLER
 	select STM32_EXTI if ARM_SINGLE_ARMV7M
 	select STM32_FIREWALL
+	select WATCHDOG if ARCH_MULTI_V7
+	select ARM_SMC_WATCHDOG if ARCH_MULTI_V7
 	help
 	  Support for STMicroelectronics STM32MP1 processors using Cortex-A7
 	  cores. Note that support for the earlier Cortex-M based variants
-- 
2.34.1

