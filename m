Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794835475;
	b=Saco+DC78M1jhvI5ZIvAXQLkJ/mS5w+QSfAjHhRiHQ7q9jAHm5M/vAyNZQbAU768ph3S
	 rfOUn7FePZmPsxA3mjnhUquyVfSKyLtPB8Y6BnQiISSVFBLgQGmCMZoieEWMSwJS0F1eM
	 1rpL+Xsi4hCo7DaiOuoD0rTQSL/x/OFcTbGKt+xLcjs6T3CP+bVb5vidkBtbtLNu5Aps0
	 VW9OnQvkSDmIACc/E1g1+DTH8C9L/SLNLmhTlvwgE3+bQAOxsvAEBZLLpgoz876aRjJPA
	 +M0F33pauWQWEsnsJAUZC0D/NpIQ3eWRGWSkxXs359393MkEZi1UCKtChgiA094NwGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835475;
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
	bh=TlSeaH9WciPV+BKuEAwTbEyKm5yMt12ZS68ISvgeS8M=;
	b=W7bJ6tIcbKh1mTPTjIpHMrwgDRx4xBq+/IlQnUALQEkEuDeskvVXZY6saLRNErPbeeqw
	 vIfaavx06UX/RuUTzScD0UMR/rS+KjGGLOYfw89575dEs+xh6fDhkvOYA9ZIpZLJpP4aa
	 ofqZaHehxEC17Y0FssRplSPlT2tINBpZCPFJaDxeR6ksd8aru4lWHThbxusgxp4xG7sXh
	 ti3kHJ18gDVLnH+e2HhykLutDEBKh3gu4mu99Gd468ikewFcRy/Hk75fxBKKh0FU0caqu
	 MdYYL7OdGdsLVvEi6qT87bUbKhne19b+CTqjypD/wDBW3O6mdSPWTCqeIvBk401B1Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=IsJbW1+D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.15
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013015.outbound.protection.outlook.com [52.101.83.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC39606A337;
	Mon, 16 Nov 2026 13:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDC39606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=IsJbW1+D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4PdLHoJzEiTRP9zFUzI7jNSiApVooQnrOB3cEN8T1kMoaZXaf2jRaHWimIi7y/afUF+Fx4NzOE0MB8cQoE1upLEH+4dJwh+OZf4u33JKkxafHUNcbpPay1aGQ+H9FuJsdco/WK3K8lvwDhvTyLDpTS2yZ0Ivvq/RHAtDYH1z+ff6tU3QWL5OXlg0NviYsX3SOM46UrlLnYSuyZ6Wf0uEimUlT/PCDmTpz7Ml4K6pabveBeT8Gx2McSqxJYEtrvykUvX5UP/xHl1a5I5dRZ1DmhzLAIfu9rRzArVEhNMBQp0zH2U39slSQI5HIn/bTUCG86Ly2qDBBSm5Vvi/hFRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlSeaH9WciPV+BKuEAwTbEyKm5yMt12ZS68ISvgeS8M=;
 b=KjqFsTjhBr7gYOe8yUM4SjYLhul82CLUcd/D5ZUKlb2kqYd6s5I7lFRPZGusP+7td87Yc+LDqilITxhgB1VSE0DdjUxA0NWC+kMrYFWbNI3TX5OhzTHi87Q6vlIcXeAJghaAmLjZOCFqbwJhzohlVoXDASE/8VrmjdK2QJEGBOyX6+jWgiLqmqkpxCZeg2cfbs5E07aWh7OBebmPAe+s9O3VJJMyTw/5KW2Dy8QXFDWPzjRuOLy1DBG+AvFcXu9w/wePbnn7FsetSdhzeSqRks0RiyLwo7CO5SwTMalq6j6HMD++uWweN8vJXcTN9RPll6eEmmyiqYP5jDkAJcGqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlSeaH9WciPV+BKuEAwTbEyKm5yMt12ZS68ISvgeS8M=;
 b=IsJbW1+DCNppw5YT36uMpuVtc8ToSvC3a7Zr82Oo47+FZvfK8anmPBzo32XrFWG2x1oL8b6Br0ALXnvkhtCmF42G7/E8I1FcTC1arnofClhRKdyS+nttB79PgWZQXmACF28jT2qfGD4ctUi6VvIMiz8ia/rjB5Y10+RIP0CaeiYO5hbZvz4XZ0wp4ibhUuTByWjHNoge8JcJ/jHt4+1fzP7sf9WmubWEO41k992YaCRWLJNxreEUh9KMhQc2VbDDdT1vYMzt+CpuxxJ18vXCQQuv7lVceSPzuY6Ys6z3fWv3CARa8Pxt4AXePtEnq/rixcOcGPbeVMq2wgZjoLDuGg==
Received: from AS9PR06CA0216.eurprd06.prod.outlook.com (2603:10a6:20b:45e::30)
 by PAWPR10MB810818.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:3b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 13:24:31 +0000
Received: from CPH1EPF0000052D.eurprd05.prod.outlook.com
 (2603:10a6:20b:45e:cafe::47) by AS9PR06CA0216.outlook.office365.com
 (2603:10a6:20b:45e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 13:24:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 CPH1EPF0000052D.mail.protection.outlook.com (10.167.241.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 13:24:31 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 14:25:09 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 14:24:25 +0100
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
Subject: [PATCH v4 10/15] ARM: dts: stm32: move arm smc watchdog to stm32mp151 SoC
Date: Mon, 16 Nov 2026 14:24:11 +0100
Message-ID: <20261116132416.1184447-11-antonio.borneo@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: CPH1EPF0000052D:EE_|PAWPR10MB810818:EE_
X-MS-Office365-Filtering-Correlation-Id: d69da2ef-b7a4-427b-22ec-08df43e4f294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|82310400026|1800799024|921020|10067099003|11063799006|56012099006|261026121527099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WTQZpO21hn2myqwdZwUdHpSQO4HQABi5Y9zE5iFwxilMTV6a+ZH6SFq4ObT8pBLPJZXJKw4tPCT+9Ox4Nlb/nXpvQv5xomCCadNfzDuDKHr2BE27f+86+6yG+DnYoh9/aT2Oi6lzEQ9g7Kpj1C9qAbNcO7yAK+bYUudLGVyHRYOFYL4ioGt+peoT0Y0A45c1Y7WN/7eSv2C0KkoIe5OjK8mDcmgugL2FpcZhfSluKKyx76bm7MJdVe0RW++aaS/O2SnBjX/H2RshVSB7GoKRpruTC6WcD8sNZ10IzrZBVBUZOupTkzQix0ABbNidkWcSVgcyCwlmRYGM6qWZWpJjcnyU0ADP2Xd6derEbKpp440fe9FnM/V4jS4FgqYGm/QWsHa3z18gtBAGOI/uGRQ2gao+xqYMMU5CQotw4eK5YSLV2TgFuEfnjo0Fmb+3UWYPGJOLBrmvC/tthtQ+UDsHawSRqDD6vwopACv5VFpdwJ/W9Fxn+C21uVQh59WC5U2eOwCAAxx3TrYurHB6f32L22Lqg2V3UZ9YP1WcJ7Jau54239Aj4lMzlCHuSZYKZkjlq4eAfkZ/2l0MoLUmhUfbBcFNZQHn4Qzc++bsA0UNMN+46r1h9dJCkcF3xvrCRITd2oWu+6XICa3YoqzmPhU/3HpHmUvKneNwruu2PG6GBhBmfV06ZZ5Mxaebyo2ALIRszFqoMVsUp74kvfhUEudQM9cVIxozFCGmHslZQmjLugX/QGuOegW9n9eRcHYkA3AE
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(82310400026)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lk76jTZ2+Yg5IisHXZ8MvLbHhcuOW6mh+HjcE/pnMRfXnnXE+huI9geth0CJ32xk5MJZqCl1h8EAlH6KdMQaNXW0xNxa5mykQaouLGGrBtO8OWQbuEaCl7Xd9evSorogDWnH+9PSTK+A/VtF3vFxr24Ksa35RtSoAl3J1+wcR5GDK5hmh0X6dCYe+8i/TMJswuU7WnmWTw15snQpS8OzD8uU4NRzl2a/iCmk6/w0c4Ji5UDllMWDIgWXIC+DcgEe+Y0ZDZUBS+EsMRqseahAALxOie23YIEcKaV6fisuzH61F20IId5FMBYdODoi/0LqWbYhs5gmNHbA1yocHTGjbz8EIhf43E13EbFiTi8+xdhrjzaTJ0Auve61ZIpCtzPTXUxEQm8TjA5giLoydYOc04yL+7uWQxkKCV6h7wcTYvbUI3p3r6elIrrF3oS6djey
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:24:31.0406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d69da2ef-b7a4-427b-22ec-08df43e4f294
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF0000052D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB810818

On boards where IWDG1 is secure and monitored by OP-TEE, Linux
must control the watchdog through SMC calls.

Move the arm,smc-wdt node to the STM32MP151 SoC device tree so
that board device trees can enable it as needed.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp151.dtsi           | 6 ++++++
 arch/arm/boot/dts/st/stm32mp157f-dk2-scmi.dtsi | 7 -------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp151.dtsi b/arch/arm/boot/dts/st/stm32mp151.dtsi
index e71b2ab58aa54..d00a36a8c93ba 100644
--- a/arch/arm/boot/dts/st/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp151.dtsi
@@ -31,6 +31,12 @@ arm-pmu {
 		interrupt-parent = <&intc>;
 	};
 
+	arm_wdt: watchdog {
+		compatible = "arm,smc-wdt";
+		arm,smc-id = <0xbc000000>;
+		status = "disabled";
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
diff --git a/arch/arm/boot/dts/st/stm32mp157f-dk2-scmi.dtsi b/arch/arm/boot/dts/st/stm32mp157f-dk2-scmi.dtsi
index 172347769e025..27ea5e79efc66 100644
--- a/arch/arm/boot/dts/st/stm32mp157f-dk2-scmi.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp157f-dk2-scmi.dtsi
@@ -13,13 +13,6 @@ optee@de000000 {
 			no-map;
 		};
 	};
-
-	arm_wdt: watchdog {
-		compatible = "arm,smc-wdt";
-		arm,smc-id = <0xbc000000>;
-		status = "disabled";
-	};
-
 };
 
 &adc {
-- 
2.34.1

