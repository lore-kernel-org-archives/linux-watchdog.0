Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794835474;
	b=4ZWusJbWhlCHSXaskKoT3aoZ70dA0UfOJhjJdPFXsnx4+xcU9qKkg73aS+ey6483mOhU
	 qz3jdnqiZGEazJVlIGFaRJ59GMyFJpSdzShNiFABT5MFdkpROL/y/TpexfgFPc9h9gtWf
	 QqCrqMl1/14PoeNRQRs98lB0LC7MXiFxLNLgJCrhOvd/FjRa0uXUy5tVKPGQ/OI9ONHhe
	 fl/cqJdnJIKa17o4waqIbU2z0u9CCPjmGbOu7RPE5oyBAUGhDduIkfz0EhX2SzLGt0gfO
	 Aqg1Wob4SPnFVwSNwn4HC8soNKUe+hqK2mP77ZkwAt9YEqOkYhAmCqPgP0kzoDCPG+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835474;
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
	b=44GimotADW4TGK1i/1FMADqUnttwcAKZIL1x5aavP7R4RM7ezf9rvks9qWBg0goRXV51
	 zSUJmMCmkhFrkduRyeop0dMdxubsX+wbH/jNl06RbRl88cppYHQI3p6rEZF71jTJMoUU9
	 FJmZpqLU6XRd6BfIXCUFKPp42IGSoJz/ylgZoBu+CfPX1X5qqt7IFQIhyAjYj27ZG7eXY
	 GlQ/DGcIb0EtU2MLNnUAa5GU+Fnss7Y15rwD9KQREBkUVn0ijWQG/YSlTGAucY9eW8PqV
	 AW2RQRMUgqICp1TIP7McrYFQ/ELN/PJe7SX8lWFIMGC0wCgPpV5VLuLYbijq0R6tzcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=GIF8codQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.66
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82968606A335;
	Mon, 16 Nov 2026 13:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82968606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=GIF8codQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7rJz4dS01vI3jBpWj8O9CwP2Cv/S19T8++YrtuGyXD0LgNSTjlIW5dAn6uppYs8dYDtkeguVODeXI/eFFrQFmoOEcqMaJDJRpoHdwDSSZhhchLVZ7nXay6DnpQ2hJR35OrKOibupkCpJR6JczTs+O7fh4ajAFkGOCTsLsw+RC87RXEigwqlP2YGKtf5a4mh1iIIEMApuIJpCJdE7dpz5xIKtUFMT2w547fTYfd+UP15ekCcbT6A8CGA6br1g17eoJBuLdsQklXGCpRSeNWjxBNsfSAFq86oh15eV97twvx7m7PPDLyB8o2XSJZFxH/ofe1YGbBrtkHh4a/y0Z+InQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k128ZcR2Uar3siuYTAuf1rHHRp9uXYO9JcYIwAYL+FU=;
 b=vJnfeQXTupz2YdsIB4b7bkmlC9yh2Xk51aNkHj/wq0pg1FX3cKrB7BTfiudJSZLZwBPQmOqPFmaree1zTqmfV2x3g+umSHUZG8KcrQ+PzONTFcaM8X25xogtI6O0xc4vnpsKDxurVF7A3ZVjU0w3QZ8fZlET6evmu7u1iWjWHpvsbmiFoWxvVdyNR604i9jS2mnYvfOuOG5AnZfHkXhK2BylcINrn9+uHCTtLBdFeyKnup/aP24adlKe93eTa4ZyzttS1RQ4CkL9lUhEFge4yE3VlCAXp0Lyt4lcbJVU76eKYl0fBETipzLbtfCODgBQqPYZ62EA2OA9s3qBd48oiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k128ZcR2Uar3siuYTAuf1rHHRp9uXYO9JcYIwAYL+FU=;
 b=GIF8codQYF5evsdC2eewbj9BxCHIX39RQY9JLWEbbTdfTxh8Eip3DXsND6FwooJhfzYNsPM0J6peyo3D1MVHFCn1eVPQtSQnBs7mUxdU1ChKPjzER1W6V2dw2sb60IN9aN05tEfZdyDSbKWC09UAyCprJ9teaL0favBfDlGU0PijTGDnEtkDlEGGqwxvQqziXuwo6UxqPm1nOhtkYQNnE7hjh9LlK5ZSEN7MHxdC0JMwNd29s89fsaZUCfNSts2e0J7icsTzFXrFlbUYqzQATvfHagBC/pxm7tgiWtRLFEYKJKM/Lut13WVGcJfBQvNL+iqdDPnKt6QriZ6dz5kqUQ==
Received: from AS9PR06CA0222.eurprd06.prod.outlook.com (2603:10a6:20b:45e::32)
 by PAVPR10MB7162.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:314::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Mon, 16 Nov
 2026 13:24:28 +0000
Received: from CPH1EPF0000052D.eurprd05.prod.outlook.com
 (2603:10a6:20b:45e:cafe::75) by AS9PR06CA0222.outlook.office365.com
 (2603:10a6:20b:45e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 13:24:28 +0000
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
 2026 14:25:07 +0100
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
Subject: [PATCH v4 06/15] ARM: stm32: enable arm smc watchdog on stm32mp1xx
Date: Mon, 16 Nov 2026 14:24:07 +0100
Message-ID: <20261116132416.1184447-7-antonio.borneo@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: CPH1EPF0000052D:EE_|PAVPR10MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c5c8ec-b6d8-4ba9-f2ef-08df43e4f0c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|921020|10067099003|56012099006|11063799006|261026121527099003|261021135927099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NyqUWPRNm0Z5/6VVX7stYFEXmr5kv88aJ/5DxY3zHDuLG7p7yhM0CGzLgpNxwCg1qg/1XfcDxsO0xlklwXjpauMUR6xQND1JgSjCrwyOKnM96pah4HxVLUKkpl3K2e5mAjGdIzlZVUam4B9kz0MGHGVU/mhasILebzO70KPA83+jDpoHMsFomWWE5ixJ493tgbJZx0Za/ZQGwC55gjwSM5lN9aTBQVMf0ucDSNZSfE1cLg9vtCaxFI2R8TBtGFBNL7W1+SLaKrU8T2L8n58syHNatvKjFCsFFIIW/wHPR/ZhODdxLiB+cRhpPD+sAna2PTB0vPrGiRuJ9XalNRjXKZbN7hKRzgn0zeCctPTqXJx7Lx2/NIPBVCRyeZsX3RZ38SiAKVBnzsM6rBa7h0gMIwbDET5I/eBQDYa5I0lJ3Ao49eCH5cUiYFghTdymNsOVy/d38r58EiQEP9Jg7fivaIf7KwVAjlk5xY46HO9E7luyygh/7bhFopuuRkIAdKam3vD1A6cDKLh1tyJJGomr9RWV+fr6kqtt7wcZGzGey2CAN/TsAsrwElX1+dJmfiyqu8LUem3SfZ3uvk1464gBn/IuduNdD61S/bpL1xT96k5q0gMwI0pCPJ90RZNRlUD5iGL4Fk1tf8Jq1xXI9v+jQbn8LM6+XoPn9neR+GlcUWEenNjKXthEkRaofs6JZbGSR5H1i2+aglKDluwycJymhLz9K22e51XvNOFy8zUhRoqKPrZO0/Kk01HrEgIJzwTr
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(921020)(10067099003)(56012099006)(11063799006)(261026121527099003)(261021135927099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZTmdgFobm7yc3IX/lEhKfQsXadj24asEILmUEA1bL6jaa7IZL0XNlfPtPabEJzmgpmdLdqx/e8Wcr4v96PM3ZgPFFq12HYJF++X8x2bralytDuuvwVfQPUsWaQJRx7Gou1M/5AmucjPlgI7q8X4y3FMu3oiuT/071jJNuYKg8qz9zgXTfRN8IqGlssuBrqDmqoaIVDegIysZ/6Q7UeG46v6n5d26AUthDCM6H5Vtz5rghmP6nWmK0Adf7O1wUtpy05OfR/YdisZzpmLZ4cTz2BvaoZKlXJsiO2/h/EfLmON/CFziBlqqHjJ2MoZ9Zkuqu0xg7g+ZtsCjpIGN9xzVc1DpUx9TydqDhtD529Ss2C2LdtK2mKu1YhoZzXk4MKtzl+pcxtZMzZ2belR9wCVXju+8ZuJIWlH5A/eXAEXxzAG8smiFTy0xGA3AzhWaTdJX
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:24:27.9762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c5c8ec-b6d8-4ba9-f2ef-08df43e4f0c0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF0000052D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7162

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

