Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982881;
	b=0e+0PLkLLFsLJXgd9YdztAdWeADtsZrEBuAW3N0WmcUePbBqc61ejhH49I+I0o1biRmO
	 mUXBx2rmd8ByD0a1awee30tFkgHgIO8gC5MAhqyhVTSzHbM0OhjZhyorWE/r8b3iNQqNh
	 WUO/YVFAY7WTARR5zBdZXZmh2N7jhg7oj/olLZ+WJKmDCGKekjr14HycK2M3CJra0/MpI
	 /b1447DOCfjWNKdj3Y/38XzlHx30cry7VokXLAocAYuzjnpVgSjXdZFtDXwCCNbB1XeZq
	 6LAO7YfcmeL7qFlbh97qaJu7NNjZIRoAGh5lObFYg16W9ddXuc6O4jzL1NPQQkUPaWQ==
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
	bh=0nBpALRsQlZCFGiQmudvQWp8O6EnPwll/TnrcSWHZXs=;
	b=jGgNoB2mgpiYy+pIlDiDB90tMkUFM7FkqbwEATU97gUnDbgTR34AmRtZvqajvsIhkZF5
	 zNQDrPmP9Ar5L80RjZA3VZoxGT9gwXgUAeETmSWwOWQcoq1TN+lu/WyJT5FizMss8sINF
	 S/BkTh0y92AAmPKWfiOXnwLuZj6maPsAclpkYLEJVXkzILXrY1mgd+44BZ3LNzTXcicLO
	 9mZRvu8b/c9YRoXKVp4ybcYBLMgzj7QOK6gwYKh5g0oQaLKXBAiF1JyFR1T0SVoPQ3Ml2
	 lIUuIfrbCkvvtVktLSI2tI3DAfNk1Y5zPBbdBZKBX2fCGApLcfB/nWAMhrfQLxDWkfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Ux7VXRjZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.37
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013037.outbound.protection.outlook.com [52.101.83.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB61606A33E;
	Fri,  6 Nov 2026 16:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFB61606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Ux7VXRjZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otvlIE//+Hg/rB6QLRqau2u2fb6h0yx7tCVfZA9wsNV3YoG+0TWHDlJ8pjvttua9gEDoGFprwEYqS9rDBOldvK+6mxI4nN9RiGpbSUz9AEYPHJCimdVZLSyu9tpOVrHLVFOYNZO2THLgWaYI71rL5WkPlduPOc6ytCONr4VPhYpFGbs/3Uee5D9gDthpgIC93lzwEAWEfTFVV8R37h6qh6KeLRBpNMnlzJenFYwyvsdKJmiZlooB0X7YgfCGHmiIl0NFyBG+/u6EMo2KG1N2aX6ihNypRLX30uqXstszrQGrXpVf1ixQfP/IDsGgv2u0M8JbMj/H9zN5+WGXD4BhDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nBpALRsQlZCFGiQmudvQWp8O6EnPwll/TnrcSWHZXs=;
 b=iQo5rPpVkFSqTZbz7YuTyugj+OvBg1tp1Vxmzxs1IzkPkIPQicGGrsc/0uHkbuvnrEQiMIwHc11IxDSmri1mTPgV9CPBxLTEa4w37+cQVGIxcc3pbkbB66zMlsL5VvFEBWMe3WTmFfax0XX7Y6ioVVu13/1EXt6tr9c0rUYb8+qVPXFxIdToA3eSFkHbD4PlKJ/MC1c/8kPFa9CU37U1Mtx2FSJ7aQBz2/cyuYnjo3PKS9jnhvikKFkdQfK6ZLVkiy9QJuUXpktzQosqZnZ/tIN1Sp4OUTHUrH6wkSi6FREqBokvi8zwgY7WnJAqSsHy0gwV1E/Wyr1yWWtha8l5mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nBpALRsQlZCFGiQmudvQWp8O6EnPwll/TnrcSWHZXs=;
 b=Ux7VXRjZa87GAIupnNjcNeUhAGGGDQXCi/7vwyGudu4lsHfMEuSkFi2RxI4We3L0ESVyqZ3oe+xtGrjUlEQ4BrAFINSr9slcOcxgAkYvCmkLsX+m8ky0ekB1eT6eUAvYxvFog+oQZGbcgaqLm6pdxuq4FoGhhMcvnqWNxdlOZ3pSzFJLyhz5cqsCoJhFK064wLD9kiLG/nLq86aybcR7ytNdy2+Yc9FI5YFpwEWuIjhx0LATKZo98UNYw+qQFaPVe4LPoe9KmlOM/IkGWNeF7gZd8bs9lTxJRAM2e9GbtuNKE9bd929P7OWENYeI5DhfPzvHDwyM76OqcCBnn3+DcQ==
Received: from DUZPR01CA0226.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::13) by DU4PR10MB8804.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:569::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 16:34:37 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::61) by DUZPR01CA0226.outlook.office365.com
 (2603:10a6:10:4b4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 16:34:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 16:34:37 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 17:35:07 +0100
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
Subject: [PATCH v3 05/13] ARM: dts: stm32: add iwdg1 node on stm32mp151 SoC
Date: Fri, 6 Nov 2026 17:34:21 +0100
Message-ID: <20261106163429.618392-6-antonio.borneo@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FB:EE_|DU4PR10MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d49baa-40fe-4f08-fba6-08df3c23d93c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|7416014|1800799024|6133799003|22082099003|18002099003|10067099003|921020|56012099006|11063799006|261009223027099003|261021121427099003|261026121527099003|261021123027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	Ns5LZkmdEAdLx2hh5MKZ/yRLHi/EgGzk3uDmaFTAgAJKE3rCINNg6RKiK79k/PwSRxHpF/Z37a78fI22X0ueJvQREpuVEDxG7DKS9G4CgrdzaECmHumrCOwGpayu1+3kD0mHq122nb4OpScYUf5NtT8L85O41giu6ngcTdpKY8Fz4PN+CNtgIVeV5tFx8S9koaVZY3X6EGBHU+/Z0rt/k3rijEf4IZkXvYs7Ko2aa1IHQqlRVmzk68q1ElHd1675TWfxqwqdP6oW3ooVnEO85UhbJ4C0O0beP55mLHdv0x5sMP8jrckk/rgKx5f46z8MzM9ga2RtwD5LYxO+rfRMJaa9YIgNXW96xDZAVAlLgtNN9ammuUs9Kl8GOJw95ODeP6ujkh7EhfltMgzMeuKeQ3cBOsZorncHbtJSK9royqzFxcOiRSwe6YHoLiyFmZ0BDUD+SXl7rjpglBBmnInsILUyyUtkLq68cE0fbyctkz73Y8CFOgP70Dxf32CaVYmbSP9TZgE7tpnJsNW4tlYqemo5pHqh6jkT+wNafqbfPBaNjVJgw7Y1vSMpSDsCrRbAaeXtIpLB5W0tzV5AxdSsUQS50/db72mG/oJvvdII70beaceZbifI+Ck/M70sHUgj6KVyi+rpcxkYhL3aPe2rpLrUgvRTSb9a4XVRLPaxPsBIsQG3uIK2hBaI3nTkx7zreh3Ruw3D8/WU17sU5tZcj0f6D1FihKbxdILZAIew2akyim3WkJXhxYECCsATztlL
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(7416014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(261026121527099003)(261021123027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z+7yhk+GJXMAaa5flIea60chXIo0hqkE36H0VR5dL3DsdiJePpoK6pAbyjpWW1q8e4KYuAa+54QOi1B2tRNDXUWGObPjxSmnj1x0KTTxjT4RRre3JRef8owU10r9wZyuoS2MUvVgwLMf6alCeMruMda7hrVxmDy/KXQqQEcMxdfpaMOVKbeHAk0QzcEH8pBuR5rQJmXvus0I14OLR1wL7qJ+IihsifHcr2zWXYP5Nv82iE6cMXYeQ9Hz764XE9xxNic3CKCy58BOIljcs9RcIitVrdKFcpJ2dZEo5MTJ+qNU1hm9D8heeTCRAX73ouIYa5RGT8RjlzPS7cv6J89C3HYBG8dvjBF4OFrIQfi2Ic0CdVc/3Q7JPLtTt1oWGP4TFTRW4rmIHUuuktvI5n40vq7Gsmo+c7McycauZvJfoJuxxvMd4Ibh/fKqZcxNAusy
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:34:37.4930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d49baa-40fe-4f08-fba6-08df3c23d93c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8804

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

On STM32MP15x boards where IWDG1 is exposed as a non-secure
watchdog, Linux must register and periodically ping it if it was
started by an earlier boot stage.

Add the IWDG1 node to the STM32MP151 SoC device tree as a child
of the ETZPC node.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp151.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp151.dtsi b/arch/arm/boot/dts/st/stm32mp151.dtsi
index ae31883732388..e71b2ab58aa54 100644
--- a/arch/arm/boot/dts/st/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp151.dtsi
@@ -2037,6 +2037,16 @@ i2c4: i2c@5c002000 {
 				status = "disabled";
 			};
 
+			iwdg1: watchdog@5c003000 {
+				compatible = "st,stm32mp1-iwdg";
+				reg = <0x5c003000 0x400>;
+				interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc IWDG1>, <&rcc CK_LSI>;
+				clock-names = "pclk", "lsi";
+				access-controllers = <&etzpc 2>;
+				status = "disabled";
+			};
+
 			i2c6: i2c@5c009000 {
 				compatible = "st,stm32mp15-i2c";
 				reg = <0x5c009000 0x400>;
-- 
2.34.1

