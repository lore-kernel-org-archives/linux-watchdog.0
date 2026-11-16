Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794835476;
	b=L9x3WCRczC+JPcyhm1fF1zWU78kkJONqdP9PBxpAmLo1DphmHxfDI9swH1iiH/62Ywhg
	 wKWloLC+M/Z8v/bNdvWuEHtR6ZLJMzn3IrNpoDAj731PdKNhAH4EZWIt1naekrKXrEYlG
	 CRjjPj0lXGRSPR/Oy+tIfjybhu0A8A3UlOzOzTLFFZ8kTfID5SftxYjMpnQ4GQriQRvR6
	 l3HMxk7fA7mGmY4BhYo11NXT0dFiVnIIfKyMfkrwDZ6wm9CuaHur3jqO85sQBCCRDrDfP
	 biWqZOlI5i6HqVdpj+jSkaurv6uYURXQsU8fxjppl+6dR3hGVyIOod+FPeCRtDJn6cQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835476;
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
	b=sK2CBWChQsnn7l0TvN0i9L5EAazh9TeRJvn3q3ES5vADYHmqVDvttszG7gATnySG/+ST
	 AJRvIZ7g0w4hm5mk+Peih0FvJlxZRbFZapKhn8hMCcLUum45CZHVUhZoB3XR9DmEYbMW/
	 6KN/FcYU/q3rQS1PvHdl0Rd8hO17vOzitoPsAS5eSRvPUCy4EwaekdxwfNM9B9EW1ah33
	 VL5aELBm9rX1+JH+4kB1dBLl3ov4ct0KaxFEmI0IFAnsyvmnJPiBuEmNXNc+RrOpusqMg
	 1L79COvwfROk8V9dV0HkTOaYM2choD5QbnQ/fC9DY+ZBclFqEgqCSImns5vr4l/JEtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=MHFucbnZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.38
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013038.outbound.protection.outlook.com [52.101.72.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E49606A33D;
	Mon, 16 Nov 2026 13:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6E49606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=MHFucbnZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoEKO8tbYw6H77wcob4gPXtwY5BT33oiF4N5m+Kwfl5+7UqpYYuv+yYMmkpbgsc/395w9YOI1TsfRKv0cWbaKkcYr0HdYgb1CtF2b5GbaCNmur6CCKbLSh74a8XHO6ghaS05eQB/DhTy096n/pK5Fk1wFpGU1gfH39BLtGxskJv5+QPwwuf2id1c1QEiF1LIbrGgQuCbujbsAEXOl+bMWzc/wqzaDZZHNHucnTgpCu9E62bIn/m+0n08HXxMx7FpjI740eSJFiiJjb0ufaQ+zIkoL+QrpnTG6HubNQYWDX2klOQFj614bnVqsCwxNklu2xHjWDv4bzEtuXsD6WZ+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nBpALRsQlZCFGiQmudvQWp8O6EnPwll/TnrcSWHZXs=;
 b=DDYlJW1rllsKMP4qBYucLWfP0wMht4OPAsSgb5WtMa8kaYqPZOCzmhmxULRImM+kZ51y9oO0h110VTBPDl/N+BA+hcnHiMWmgK24skUlDUa8n5yIu4T/FpIjTyFWppKP32culqWrxR1eKbhfTq+xtEy3VPuuEeqrtWasXAmKANEl85Xp07KSdmP508eceeA7EBJMZXk754BnlnD3FL5pE0vP0LhSHEV15ahZ3+8yKWnYIcxGAOKVq+A13uWG+LGIzSu17zHNFW9jZug03hUIaD54uL7ttSH+dXxwn8qjanCdllkdYctap+kKt3XAOpcQm40UETWaBr+xSAO6DZgS4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nBpALRsQlZCFGiQmudvQWp8O6EnPwll/TnrcSWHZXs=;
 b=MHFucbnZZuwWiKQabUKzsOGAH/JsEyPuJ6EFX1EuA6EdnV228hK2/TAozvly1iBIUBOgbtch2pbAHaPl1KPwjrLyMPLnXJwAKkaYTh81u64uEABwZCg/01/WVogy6fo0BjYn+UpoE3lulydiYyiS/kB5vWzqRLmwcvJ9LLm2/VzW/kTeuUUS3TrCiqkDFCyprad6gmxgJb/4pOeMzc1pazJLbubbq39WVTusMtE2kAKcEq2TeJr0tkeBw6CLcD/Pv4LM2TM3h96nBqQ7M3cGhqSnpuoDJZAfMFwFGbtGgPcBil3RYWPrY7ywOdD55695fnt+si9t6I2r65mLzx8yLQ==
Received: from AS9PR06CA0240.eurprd06.prod.outlook.com (2603:10a6:20b:45e::9)
 by PA1PR10MB9516.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:556::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 13:24:30 +0000
Received: from CPH1EPF0000052D.eurprd05.prod.outlook.com
 (2603:10a6:20b:45e:cafe::9a) by AS9PR06CA0240.outlook.office365.com
 (2603:10a6:20b:45e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 13:24:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 CPH1EPF0000052D.mail.protection.outlook.com (10.167.241.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 13:24:30 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 14:25:08 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 14:24:24 +0100
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
Subject: [PATCH v4 08/15] ARM: dts: stm32: add iwdg1 node on stm32mp151 SoC
Date: Mon, 16 Nov 2026 14:24:09 +0100
Message-ID: <20261116132416.1184447-9-antonio.borneo@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: CPH1EPF0000052D:EE_|PA1PR10MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c32b774-c8d1-49ef-d049-08df43e4f24c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|921020|10067099003|11063799006|56012099006|261026121527099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	88s+VnDyn2IwgC7yiAs56ErmziGNRQLEIUoo44a8305jy9EPz+Eli1xqFc4ZtAn15Oh4/Rmud7K7lnHDnooUR2NoZ1UOz2Hcb3t2ZNIlpj4V0gCdHC+ieWC2JfMGQP2FmgRbaoqLtFfidmNiCGpyqystemow+0uIhR5QKTB9st5OR1mdupoNy6vAsn3iSDq3qnhvCVd7q62KhUTZWJNQ8jpsxF1Q6jBQRUXOBTxvWkBQjalxQB+USlyZs2B+tzWAVGj+QLsq0J2Xhsge8Db6Avt2SHF0FYvLTpcEf77lLK/D83iWR7WbxfRkpXEq9yLI2Kd1DXQCjJQNCuaji2NJ9Y3Sjoh0INBAawpxOsk6F49kbrFuCasVPQPZ4/fscTNtPMgZJaha6W/LRK5Z9Rxuk9kBHU+/yBHyZkK+a9RN/t9RT18tugYGGR7njjjLJs0jsxmYG8FjAYeyjlmHyxUzIskaswI9EouzZ5xWiH4npx4W3xUUvwORsWhGwVIepn/j4IDzor4mnQdHQskPOF6T18WpadFdLIUoVJlNAFSIoFN9TFLOiWEiR+qKbz1gs4x/FWyUNeg3bc1EDaVtG51MytPIQOp7F3ELhkjZRo5DjsNN9RWHoea06WyGvjFDhOcyu8iI1Rl0/CCtRMJNpHWmpo9ca57stYWCI80fvVw7QdxR33upa182sJ96Qr82LCjksvw+EfBBmKZ1V+Lddnmb5btLpfdLa0dMMkgHKhPV9fvGewfYgvdnNvBaN0ZksIbb
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(921020)(10067099003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MDraR/NQ8PFpSgpIgA4NsOIMItbOWxbKMzViwzsd4nzhqjJ76nJHXu03nF19HRDuZCZRLmkdSiaUjXPKUvNwTfBSPSirZ3p2jDPegPiWtn+2sj7euKWzViWYKlhj5dyIWCbz3iBHWL1brsudZs98mPZz5HhEUhXdrt3PG+0vklnaWSsrJcbX4cbBs/34HOpwxU1aVcf4Q7ma20cPhX7myyee95voAwc0y84WDJYf9c2xoLFE43pHHydGNahXdUHXXEWTo6qbsa3EC6ix4pMZwJzMLSI01Vj+U3TBw0/Op/P2zSzVzVsZFNoe1YVbdILKHhTEmK2kDkutGYSsHAfyeuWylMLlmajxl6PYjvNj8+OyDIls8i2sDINr3dOlABzLunwjjpYHv67Jtgi1sW875pIGxmf+0k7igashjjxqrhnsq/4ISd33e5vRAyHbZ8XH
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:24:30.5617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c32b774-c8d1-49ef-d049-08df43e4f24c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF0000052D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9516

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

