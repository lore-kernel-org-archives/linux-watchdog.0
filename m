Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982883;
	b=1cNbPnv5JV9heTl6K1WO8SsNQe/P9HNiJl7Cf+9Lk5ybCMF2/1T7pmwgsYWLYbBnV18S
	 wiR7v6tpiod+bz0hxe50vUZtA2CT+LicthxCspAlA+W7M4L4tn3wKQdpkU7b0D/TyLL9u
	 TRkLqyFnUqKcrHS01Bys0Jk4WEyn5JDEe6vbMuG8NkOaR7mXjh8inIQi7FzONZC3ZKCfp
	 ozt/r6bv7/7yKyo1zs21Bm+3roIDMWpkEnTxzbW1B4hoTEtdzBpK/wwcdlVJt0L2b8NIb
	 bCw8fqMlBihEhBWegKNorG3Mtb4O9RWkwqREmySANfWaOuZEHrBXymBppxP5Lndw1Mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982883;
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
	b=uFnfNhvzfb+qIomejjrM0/MP7BF5Kso5N+aa4Bsm4t9CaG8tl+SJZ8+6SJjRbStPyWAy
	 4DXApLoqNL6/wN1rIwOp5kQu84wpMDJDXYCHVrUp3o/ppo4EmWJrg6lGOJz1Zv4+13E4w
	 fF2Vl9nstCypnEKuRKDMyf4n2AG+sL5ZXNWJBTJOxwFtJnMWoSMK1T/FZVjs25Ls8xEXy
	 44RF55bD1yRwgr8wXSUmgKoCG7qwoNkovjvpRpDMOwvsN8MzzYjSPhtMNaMYSlfgOQz6v
	 aJZqr5STT/LoXcGYua/2oML7cmTApmKJTmY8ndmMimlB0oBb8+qK4SvkOZSJfE3w7qA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=axHllk57;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.26
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B19606D835;
	Fri,  6 Nov 2026 16:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11B19606D835
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=axHllk57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ih8OdYiQk175yoiK15ASwxyOfyvOdZetKdVJOfjXm2O+SToq2ChbVC9yxofcwN8GruGap1A9fLg8wg2tF+3AKMBfwjRVxloX16cE7d6yzhQxfUky2Nu4PPbdfiGmzJj/7VMr9CZJYbWl1MyN5Aba6tCR7KpB4/vo7/Z/6/s4DwJEoFuBtTLT4qmsy4Qa2PxCXkqIP7iNGU6cWNV+//gpNAHLCuiBf2ldX14w+HZigXgKqD/5aPOp61ohmfeN2lk07zOjcxJ3HoW6H+TewZ00gi47AoDOGl28rbmUSIU9rK+U5z8hVqXEG+DI6Gdth5kTGCy/6MKvS2bB+cRIfEVaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlSeaH9WciPV+BKuEAwTbEyKm5yMt12ZS68ISvgeS8M=;
 b=oWPgrbu6FX+me7iYgqat9S6moVV4C6UNbpVxvDpIh02gA8a+e0uv1uxpT5CeFYfGbPr688QeAOV9C0cLjk7F0HVTZHPSAyhPdtyNNgusciCze7mORwFCFrleKSIxfWb1pw632ZbahdQPGpOfJwDoSLjEoeSQggefnYn7zypm0lkA7aqhyRRN9ySsaem4okOqzGEyh49FXM+ELqrWr1ov1mF+4WWbLIkUVF1KGPioqMsMrGfxuHuk2Ecg87niHgBakigt7OObyi/jz9vBW85s9dqns2INqeYTySKGjrsGJ6f/1GZg0+I4I19hpYjao4saBjDKfoUiREyqp40uXr3kbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlSeaH9WciPV+BKuEAwTbEyKm5yMt12ZS68ISvgeS8M=;
 b=axHllk57svgMRdOZYMulYbYNN6vh7QUW2rkwoq+L+/Wzl5v3n5JOiMjrWTMHP5WhWvC8SQRUdGZNDVZXL8sJDg3avoBqWGB/7O1v4y+AmEaeWP+bfGqZRixhaFj/uy/Y6GEIMMxPN9Bmlq3ZZauAqdklBvz0ZT13o1F2h9C8sf2COJhmnUUCR3OH9jE+Hww9iE6V+opIyYxizYVmhbHvnBk8+lKjJV1FrcUGfPXNVDecp8ZNwNKZpGGUEzAgNWmbUnXV03AnRO+R2jd5ujSnVVwGMMEpY2Xl3BKISPQV+4Ne6e5BXy+10ySxPaC2kcgh1SF63dDNpnZF6BhGFWXBWw==
Received: from DU7P190CA0011.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::28)
 by GV1PR10MB8754.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 16:34:39 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::4c) by DU7P190CA0011.outlook.office365.com
 (2603:10a6:10:550::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 16:34:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 16:34:38 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 17:35:08 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 17:34:37 +0100
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
Subject: [PATCH v3 07/13] ARM: dts: stm32: move arm smc watchdog to stm32mp151 SoC
Date: Fri, 6 Nov 2026 17:34:23 +0100
Message-ID: <20261106163429.618392-8-antonio.borneo@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A01:EE_|GV1PR10MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce1c26f-6cd1-494a-40dc-08df3c23d9da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|36860700016|82310400026|921020|56012099006|11063799006|261021123027099003|261021121427099003|261026121527099003|261102123227099003|261009223027099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	xYQTzRme2uJgGy5DUp21EfbkJ7uqd0i9E7harDuL5+ruyh7ozviRLEkBKifc7kmf5Uo1F8LapcNNGZfkRQnY78IVj+Oh2J8+HhiMCDgg0iWV5Lx3QMflzWETaVQJVMhFUq/w8B+6NXcifKdo8qS09vEaNJFR2t7lybvoCEutbxd5SAz9f+A02aZbosr1utXAvN3k2XxIcrKESBTGQz7U8nsje4/e4IqNGI5tF7TXoimfvqF1JkqwXEwM3GZKlE/8JbTP/RkMCyqHldsJKx9J1vsuOd8i+HlwbGn9EKmNHsAPAMb1R7M1M0nnApdt0l1AzIe2LynyGePQr5UcXNv0+h3CiuMcqEcP+YXHzfAo43HB4q/68ZC052yIsq9LEu1lneozDtBA+dI5H7xjSRTInQ4HduzrwMg/Y3VTUH/KhMOYn9g9cKJxQtcWmRMDFaGaWXTeQKG1rix9i5Meogj7wo+Xu1NNs/kPpsUcuXW02W8BcbpRVpOeAMPbw478EKDP+PP5/pkROXP1TgSjLk+1y1ehywYHmGvhGRid7ZE1Z/YpDRzEBkHX5/b/3L7YC1MlPRueSzciCL7Q3rp+Ro3PhH0U+VM5Vszw/whdIl5ixs8rGQrxowl/4WOb9IaVV2Lez0Hec8Bw7JvD2jcvY9kmXT02598OQ0xClmFbj1D5PGMoPJwCnor69EjWNnh5DTbCrHxzVuoLHXUhBEee5P1izZOAl8NNCAUVN7Q9OoAYty+96k+1r6xi95I6CVxoaLeE
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(36860700016)(82310400026)(921020)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261026121527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WGsYtnd3xEXjMgq/A2RyI1M9l3gfr0tDdFYvf8eBWCiTQAn8eIw5ifJUKICR0fzfsiJOhXTfoehaiX68GJVUWFiP/tYEWUnrQtjCym40VAb5ZR66XNXgVc98Mk9wbVaM65K3viKcCoCmWirB3ln6NERDmKFVHb/d/Peyt2YklQrFkqlY/2AZli20rP+IA58SgDKBh+MI++rXzQG8+nuFlb+OHfPrCHg0AD/ahXBBRgM6eckHTVFZy6PzUR3hJCNvF7KWM7NY7FCcK1TO8C0j+7ZGwC96iDslke/bxJ1Yz484q+fvcf0kTo0/Q3UVIDMlpZAr5j+f0F53/dFe0mEG8omtoGZ0YXwq4NQuBQKJSxya3d/1nNzzkYGlIH9fTXpgaZh3b16EWm3WfhFKpKXzIZJ+eceQ2Bhz+vRydYKPwSS5QJ3jjqL0quQYy8R5CmpS
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:34:38.5270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce1c26f-6cd1-494a-40dc-08df3c23d9da
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8754

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

