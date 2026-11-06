Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982887;
	b=d7fsiOky/eEN6PFtDGUEK8RgaDV0+N7oDAM8SBfQnwYdi84gzPvV2clReY/hTEZp+dNM
	 A0qyeBNyauIsmQDtKJdHwjsyCJ1chVYg++5Qm98zs/EuM8lBkY5LqUJv8hROJgGCVmyk6
	 kN8lFrIjmQ7U1T3oCXmOSixVdHGeCyFCR4i1VCXM9nYmb+Kr3tJSqY+r9Gd9p+LepShRn
	 CI95LiDpI7gJ39eKn73du+J5GtdiYDDU1OFqCsJHfKH0bGxmDk6e9vZpv+IdVppGr+izA
	 KxMpaItaxl4gShKsWlYAFohn00M508IhxN1vi93ITg2JDhuvSWp2wGUenFKroc4/ksQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982887;
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
	bh=tvHvFSBlrhl/un9dHKexf1eB1p1PyxYzF/0GBOgNslw=;
	b=S1DFtxtJHaHsKKZVJexqWkBCyWoMvMxWNrRbU7ZQeMUD/e2Cs20g4j9DJN9QuDQWI7wR
	 ZwPldx9vwWcRM1BytxFt2qyPEpCgaKDfUf7eO52jGSZxOKGw6ATS4O0JjNgyvYWK1a68P
	 ETT0974jCg1kU/EDis5la1SadeXY5bSSlstInUeMcdbBrLxg5MRpLmO+t534EV8S7XMVa
	 re3QbmdqBtmVolEhpAOlFhcPpzDW3VlKom+2ZjgpqXrNcxN4gWQysv47KvKhRhPapOiyP
	 fNe9S33Vp/jJBM7Qlg8OvKlBzwzhwkEPM+bE+Scylgnv1GXxFsKJetGaQoKQovDF2Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=QbTRfGRz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.59
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946066082BC9;
	Fri,  6 Nov 2026 16:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 946066082BC9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=QbTRfGRz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaqD8qCpIRcbP/Nb+f84t6nzzp5KKbnU1Sz8qjzkZkmJOzfuDTFeGE99kmnQpsoSY2OyT1/HlhpxACQdiY6UwI6ZBs5CeU5zFLM+7E0OotQuSrtQBCqE3YitIZ7ZnFKVUnTrxgqQb1boMbgFNHgOZkFSzjwXY1bsfAfwFaRD/c0LqpywCu615OH41E8IxhAdEYD2gfGZzxSDwbqk+kz48StoahwKuyX8/D0TWuF5rULzWd1SXH7OtOtHnDiZgbdmSb40CkKUCwsT8LDhiK/KcdH+gLbvnvia1vUoJbSqg4+/KpF7PBx3SQa67asSo7B0OQD2l5d8kAncOOGElIiPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvHvFSBlrhl/un9dHKexf1eB1p1PyxYzF/0GBOgNslw=;
 b=BXXQCCj7/yTl9svhmgqoZkCIhPvDVnjPpugnX/RWPyDHoA61784Ary8Wxmqdze3mih7bPf4qo97qebXeT6ubVTbrjivHuuhmKk3y0gvNjmk6ps2mb5fqwSCPAgMsAHvAaGX5T7tEcXzqSf6oQQmgR+DYv31T2AaAnmmV4OcAv1x0WkTFRYUpq7tNrkAGlD93w9Iyq7kwfcbZ4owavt2HmR2pc3zHlspyfgL/vgVxr4dd/1T9lLPE6URCsAIzBzaj29e+aJ9/cOgdTVDs0kM76n55/432R7D7SXxeqvcXrZ8YW/yRPDndaC8AnyVKOZ2iWbs/ULvZxbzyEHT9ZlnlgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvHvFSBlrhl/un9dHKexf1eB1p1PyxYzF/0GBOgNslw=;
 b=QbTRfGRz3kSHnJv4pVO3sulzPnIqYcHahpmZu+7BEKHtpg3RXIBlydgzSSOdOdmXgJsBHSsIF73k09mYPMxm53GOO88o/gq5IrZ5MDoNhm7TyQ5utq0LeSOdgsbLxGUQohg3MxiBCDPUCBxlW2pi7BvIF2CkCYZWp1tpQefX1m+UAV3+lT9BZ/uCi712LY9UjM0wV5jGsYpJ73Jecw04xtGevIuuCYNtCfmkQYfrsBDqnDmUjnqJDO33MSbZCmQxuycWAddqbVYdxwFJUSkUZwor9cMdUfHMfU1QGnVu9zhabcIm0evHzoTz9zELJ4ITo67jz3dONxS5aIgA26nMlg==
Received: from DUZP191CA0058.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::18)
 by WA4PR10MB866235.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:1d0:30::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 16:34:41 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::9) by DUZP191CA0058.outlook.office365.com
 (2603:10a6:10:4fa::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 16:34:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 16:34:41 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 17:35:10 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 17:34:40 +0100
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
Subject: [PATCH v3 11/13] arm64: dts: st: add iwdg1 and iwdg2 support to stm32mp231
Date: Fri, 6 Nov 2026 17:34:27 +0100
Message-ID: <20261106163429.618392-12-antonio.borneo@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|WA4PR10MB866235:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a74efaa-c526-4148-f648-08df3c23db59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|36860700016|82310400026|921020|11063799006|56012099006|261021121427099003|261009223027099003|261026121527099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mdM69HFUF7+9bdy3UlC/GqaBojhoyJYuTUQ46un16w+SQA5DMBG/eDB2BU9bwVh/+XmJYVf2oY35t2cvf2Ox6xFRiV6CBnvFDcJyV/P+707ii05TQEZ2ONYih1g3wSv9IBR9S6kAA0/f7VCPPV4ZcYlaHNLaKODbiGCcjX10Z9t0p7go+f5qulGrlT0iOODd+V2MhPD6Pz36mrzsjw+8/kg+16SWKXj/vbgiCx9g+KNVS3fwAvPpeeURNXZgAjgtIkQzWP9bpr1ZxnazjpNXZyHp8pONIXRirEHjpIVgoYk6s5CQvOzGv8++0goILfcuTyRw5p2nbTLd0f1H95zY1lO9D42/OZQJMPYyeYddUOtAVZH4htBpkB9f7Moa4BLL2GybVNzrbMObteuLEQruOQZou9d44AEQIH2zqgh+u9WDucqtne3Ow+ViKpk+CNXcLdlje75U7Vvg/5oCD/Q5heTcLc08r8Me4WwkAcIITB5iGyXXL+V53ABNQ7I/iAtQxbXgTYI/L5cSMQJQ0Q+ZGarcxpE+5AlE7fPv02d1wxvaMeA572uCEuh6B3VeMfxy+g1gwX58d1ecZ1DkTc1GWcfKUm2ltyssCsQDR+tnFFUbSHLDdVJ2Hpk2KgC0PT36HJ3CEUeymQPOOiUBg4UppmyTNiN0DXxkoGpYSryC+A4upye/QFT+iUBfqZkqCKa+GRNMjEYU/EoZClkDOk2gkDQXe197dAl/wcqX0p3XICGgmCP11j2lnBU3ZwOAQJV5
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(36860700016)(82310400026)(921020)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261026121527099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aYhh6fv71JRnNkN9mXVoimDan5cywRigxNiiuKFjYzeLhLXUVFIYfvVqRZMYMbiNGgf4lXuNoyWNXtDTY8+TMdNir3ExE0Gm+3iB9D4o+W1mqVNNsy+TUsTEBIff3jzbA55khlgyw7svyLtdoYiFDWFjQx0MmIwVDQoyuYZSnNXz8riD91KPWS2scPNzA95ixZxEmyIYDMfHai/WvNgnZEBr6HwcDY6ZHb9sA7G3BbDlzQ69k7SbbBDDwq6uWDliR8XhRUKSuFB6RPa5q/ZF2usPVaHUsYaTO0LU+Tzf4ZhZZ/8XR9q8qxgYjiEL2ZqwVZU1fGVOz8CR/gI7eNWluNFI355MslyNL0wdvsmZjSThlh9591xd1oOF3FVBTQu4RET8hFvwlVSrT5raop0/3HdGqDKvN01pV9TKEwx8CVHd1PSZdcfO7NR3FyCZLErY
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:34:41.0426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a74efaa-c526-4148-f648-08df3c23db59
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA4PR10MB866235

Add the watchdog nodes to the SoC device tree.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp231.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp231.dtsi b/arch/arm64/boot/dts/st/stm32mp231.dtsi
index fefbf6f4f1537..db19429896eb3 100644
--- a/arch/arm64/boot/dts/st/stm32mp231.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp231.dtsi
@@ -724,6 +724,26 @@ rng: rng@42020000 {
 				status = "disabled";
 			};
 
+			iwdg1: watchdog@44010000 {
+				compatible = "st,stm32mp1-iwdg";
+				reg = <0x44010000 0x400>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_BUS_IWDG1>, <&scmi_clk CK_SCMI_LSI>;
+				clock-names = "pclk", "lsi";
+				access-controllers = <&rifsc 98>;
+				status = "disabled";
+			};
+
+			iwdg2: watchdog@44020000 {
+				compatible = "st,stm32mp1-iwdg";
+				reg = <0x44020000 0x400>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_BUS_IWDG2>, <&scmi_clk CK_SCMI_LSI>;
+				clock-names = "pclk", "lsi";
+				access-controllers = <&rifsc 99>;
+				status = "disabled";
+			};
+
 			spi8: spi@46020000 {
 				compatible = "st,stm32mp25-spi";
 				reg = <0x46020000 0x400>;
-- 
2.34.1

