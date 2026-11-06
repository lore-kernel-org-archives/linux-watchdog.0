Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982886;
	b=jb7Q34EB6RvnBiavjHjcd8NuiTJ/QtiHgfOKyX9JNRAa1VE1fJRSKsL0L0f2vuTAQhEW
	 fmJa7DFfHlV65S96+PLHuu8uVJhHbamFzyKike8H7uMVLo9pT4bXdkDHE6Ji428Ovc5oo
	 YTTgLmxW2P2fTPW78AH4LMh22qUcRqbfMFehx1Ft0ZnjEZVBR7nigqwid6/jrPFCTl4Cp
	 jbYBddtW7/u/62iU+N+lbvbbmgJgRvuc/CI64Mu2fNvlxtJjq9I5gRHDdbs+nDawIrHig
	 c2G+c3tYzdr4+5JW6Jy4hyEoxPrROdgLWRT+NDHSzrPcokaXoOTDximWkCBmhxCs+tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982886;
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
	bh=7tSslt/nVb/d0+kZfpVHzA22JJuS65eht3UjODLax/A=;
	b=hEKNb8QUtmiKaUIA6nPmEqPwED/c5ocRsvqXG4E1NxVcZ1AEfajJjQSFigqassjZB40n
	 4pTqce3zok/HRJLCvFi6Vny+Yinrd1miz7kCOPwdhg7pMmoXOyz8PWuaRmC6uiFFnN+cn
	 Q8Zw24aHTag5G7gXnqw1pB8NJXMsQKOgzA7BiIacc68jHeE9Mo5JAO4/RSi+RSzNHqtPn
	 bQDsUvIuobJMfFDNj6oRxD15q6Ht3yJxUKkvKz+Cx4xrNE7hcOxtK1BfX+ZILdvfGEknE
	 uVTihYw1NxuXQgXh+kfaVTHlyR6xEPK7TMFpYI44fmFmfLY7AERpQe+uZrIMHAqND6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=hIHXtZRx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.7
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281B66082BC0;
	Fri,  6 Nov 2026 16:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 281B66082BC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=hIHXtZRx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTqkXtE2TYu4Lnt1CcrErpkxxXLfLu++zRscQfYx3Re8Q0jw2nwWn7THMhHHbA4yOELc/XQTtCU7kCjWajRJbd3iSzsCzC2S6WzJ0VTPy+9vhLFMr6Ha95G6UazINbqrQzdvEGSag74U3cY7NbZHaweChRiDuMllN+Y+KzFPQtNKHivaF2W0WUXGSOBB/oN2Wei0ULUXQ5mHVsOSoyBLsHm7wJWLnkNewmRdN4Md8LuRP4ZfZv+FGzAABTZfg0xSZeKOB0ckBqLKg3HQdAugJQkmFtFNZuQqkmOJh1nBq9wEM11CpwGKnj+TsbpR8mWki9y2YGLc2InF/vJbU1m5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tSslt/nVb/d0+kZfpVHzA22JJuS65eht3UjODLax/A=;
 b=wVQpI2LOq0h4PDbNvAfaAEcMSTv2AfULgj2UqIj635B51ey3rVrAhlwlAIkcmV4k2pOWVN5bTqPU8RSzG6GlFdt0f4UnA/PQgvXL7K7S6ifWbBywtHLP9wQCP7dQ6o4EyAdoHlGG4poJ4H5WVzuE1g8YGDIMG9c2U9UnkGfUbkmaU1Ai1DcddllABkzN+pltji8g6I9I1YeKvKGACNqY05uhWhcTf7lziH6oVnxpp+9h5RLjLln8yJs/lWCihv1RDT7nwUBUFDcDal7kBC16kF42kIAuRAsnnysz6dUbETv3RYNSeRxWDDxsgayBtrSNjZjeRNjHhsezmJZA5lt9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tSslt/nVb/d0+kZfpVHzA22JJuS65eht3UjODLax/A=;
 b=hIHXtZRxAPgXzHKKo27+qf1kbbdBHWAtayZtM0+rGLxlx38a8bmRB5UfeGAo/PCoiGK43KmeCM+H1rgIrGl8RIn7Nn3+PqsDoo+0WVW07piQRC9/jqmnV21fwaHbxKmoEVpE6He5NfcGVmd2qbSQBbpLZ+1tIzfyd37L2dW6JVqan1Tojf8gyn0u/uv4UvldqzHFF3fcZ8CVFq9dWO5YtQ7ezFd0ibdQ3NJvIanMsmopxtH9h3+cd+1Nx3QUm578sdACvpov7eHnWUb94CbOVQ6mNfA54pRotFxt9AYg4tJd1lHSvVfXkkAvFiI5zP3mgDt2uT+6yLk8xb8UeZOuKA==
Received: from FR4P281CA0189.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:ca::14)
 by MI9PR10MB992209.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:8a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 16:34:41 +0000
Received: from MI3PEPF0000847F.eurprd02.prod.outlook.com
 (2603:10a6:d10:ca:cafe::a9) by FR4P281CA0189.outlook.office365.com
 (2603:10a6:d10:ca::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.5 via Frontend Transport; Fri, 6
 Nov 2026 16:34:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF0000847F.mail.protection.outlook.com (10.167.240.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 16:34:41 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 17:35:26 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 17:34:39 +0100
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
Subject: [PATCH v3 10/13] arm64: dts: st: add iwdg1 and iwdg2 support to stm32mp211
Date: Fri, 6 Nov 2026 17:34:26 +0100
Message-ID: <20261106163429.618392-11-antonio.borneo@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF0000847F:EE_|MI9PR10MB992209:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b500422-65e0-4562-59be-08df3c23db75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|23010399003|1800799024|22082099003|18002099003|921020|11063799006|56012099006|10067099003|261102123227099003|261021121427099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	R1KInjWE/iBraI7tTlgb7XWgB0iOdoVY46AXQGPCn4r3Fn6Iyq716oXCcTdENsquL5ztl93pM6ixw8pTJ1WO4EGQUsOLtiFis2X6JUp94JqMcovC77RzV6X5n3YgKUSgeYbe0LQU2kKgZ1hMqcTU+ZwmsGzbF5cbIsFe7+Q90/1JtNpJxO7PCCwoZMHJ7+jJ7CaNSWVVUEAiAHYb55OOwnJ8mpam2p3rF4PtGi9Yxz/uoFlJRrXTd0hT8kKC5mc2astJYivSmVN+d/GDUIFZ9eciABj/yEKZNhpk+aZNCYdL8DW8y885Ol+m41yruy2LBMPX4lHvRkevWtPKxhGJvO5YQAMrOIBeBoH+YX77NoHsmjJBmUYc0cssXel1AWyyGiWdsvo7y8n3wgEhxdTlkH/LzHQN4J9rNbypwJqrClNAPxXuGS08udZy6PrdfXI7AQP5PU1ejQP+xtAk9/c5xRZneDNKAEkknS0UvxI4YDCKWI3TEu35sFLptAawoejAoChshKfJUim41b7XbkUI6lmCuK9GogGPv6GbjEH5KewOpxHtTkW/KeNfnH+rfVwcg/pKBk6s9KEx+q1gNeiBAloaeCKhuuyRwYvW0ILFibnzNqPXFAL+xr0P9XmsG/Ud/u4PULtjwxWeZA5mVDgaEf4iLT0gC5wua8yZgcELvgnjkwssap13Iv+5aI1gb4++uJQTBvba21PE/NxJhvBMen1qwBnrqfKnrwMvtzq8QT1VAvH9xLEo/f1H0UzJDKVf
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(921020)(11063799006)(56012099006)(10067099003)(261102123227099003)(261021121427099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T3BOyIY4dzmow+okBaIppcanQA7ybyUDPkKlH+ZEq5JSqUJtpLeQbVzTyPiKsvR7qP3SQnyN9USbG1gHHEHYVVbMx9I0uxCDGO+vZx4P72zfiaVt7NpF7BGbjW6MSVwo7IGBa4icsLUwyTnnSurZMrJ67E8DJnudp61+NXshX8O28iJxk2t8RUXsIMD2R6tSvzQrfx6Ig3zwm0GunUBcUaNGSHBtVkr7GN91e//wTdhXciydKoRfP07aKPtK2yYxWF3xfnCYH6T5+A7rWr7cK3ZOai4dMS7Ff0KE629xtBG+4aex6PFnQjWB5vHJI0DbkFv3bL0rXj+/O5ubUgxGskHm/ytiYVvilXUrDMbg0YurKtUhP9HKBund+qDAXZao8jBlqkZ90W9o1IbrAa/WfMGNuSgYPq0ZMlzKC8tCPVPdT+doYfUJ3581A5hwCGy/
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:34:41.2999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b500422-65e0-4562-59be-08df3c23db75
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000847F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR10MB992209

From: Clément Le Goffic <clement.legoffic@foss.st.com>

Add the watchdog nodes to the SoC device tree.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp211.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp211.dtsi b/arch/arm64/boot/dts/st/stm32mp211.dtsi
index 4bfd58b26b51b..7ad1c3c304dea 100644
--- a/arch/arm64/boot/dts/st/stm32mp211.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp211.dtsi
@@ -110,6 +110,26 @@ usart2: serial@400e0000 {
 				access-controllers = <&rifsc 32>;
 				status = "disabled";
 			};
+
+			iwdg1: watchdog@44010000 {
+				compatible = "st,stm32mp1-iwdg";
+				reg = <0x44010000 0x0 0x400>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_BUS_IWDG1>, <&scmi_clk CK_SCMI_LSI>;
+				clock-names = "pclk", "lsi";
+				access-controllers = <&rifsc 100>;
+				status = "disabled";
+			};
+
+			iwdg2: watchdog@44020000 {
+				compatible = "st,stm32mp1-iwdg";
+				reg = <0x44020000 0x0 0x400>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_BUS_IWDG2>, <&scmi_clk CK_SCMI_LSI>;
+				clock-names = "pclk", "lsi";
+				access-controllers = <&rifsc 101>;
+				status = "disabled";
+			};
 		};
 
 		bsec: efuse@44000000 {
-- 
2.34.1

