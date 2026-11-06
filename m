Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982888;
	b=wfkxj37GTD++OTvg8sxuvQHOEtkjXDrZcfXYbut1EH+I5IoLR65kYZiTCZMAF49tKWfn
	 c4cexdTQ0H1sQPUPH2goOFKYHmQJ1uHS0Uu/cJf8fNIiET9UL/Gn8hLAWuojuwu0Vg4Ea
	 kkvz+6L5MYrl4/dvICA1g9VnR/ZmGFOt4TmZSBozgKajPUZrnP+erpXHvSIHKM32iJMPB
	 H/MG1ikKMIAsNUS6X4+aC2tQ2CxQKKaQid7rQ5CDJ4a5gWDAdlIrXlYeKXu5Dre/uEXiO
	 5cROV2TLhq94FGxZnqrxc8O859+Itkx2qrr+ctAYuooNgsM4re/eDjIHsjU1XY9dAsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982888;
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
	bh=IqfGTdm5mOoPz1fnfQPLLftUXhpEKOf9t12BBN/aSTs=;
	b=eB8q9WDwzn9LXuuwUczBfWB41xnnYC674Kv1Qj081gJeH8zTNFKPLbr3iO/dP0i2XcwW
	 dAny4v9W1gntFR4Qj3l0isehbywrfvv5qsTvC37w0kcYYvmZTrJMCWTlnFu+zmKJlzy1t
	 1dxRi1t5L9kpUE66DVJZ9wSEdnpMpGLHJaU5Y+R8V+uWYy6ej3jCwpE4RP7VGx+OhyaQV
	 BMenpmHCfAseMaPqzw3K9EDg6Dj2MWcui1aoGdO0856Roxb2zGJzJWaUE2o4JWGZ6/2xD
	 z69y/Yk2Es8IDKAscal8fj2ty9Lz13/YtjJXrf0/uwIHb6TZ2oU57dWDa02gPWiEVlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Ggh7X2an;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.40
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329CD6082BF6;
	Fri,  6 Nov 2026 16:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 329CD6082BF6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Ggh7X2an
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1seSHOZmgcPrBNNyBfXz2ZFREx7bw43c3ZGDBqWM1fDnS8JLIYvMVZnNKdnFkJaOuJiY74TBRxpuOEUX/zdGHdmR9/21RlPcjKLm2FC2ApVCemXUJMI5Ajqa4K6fEuZ35SKXm9z1Txk6HVGJdfyQdamox/vz4yQUenPQxq6YLBLogT+YnOO2Wino+kon8bTxYW+jOU/6Rul2QcVWRBkkwCr02k9hdqi06zHomWdKVcKX6NwBVgvXs23IWndAC1EGtQFagxUHinq1bb2TNFxxtdNXjMCT9++F59TO+RvDpbJHLchzajmMTOlq98kQvyRjdQeWip99KD2YePpTrjeeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqfGTdm5mOoPz1fnfQPLLftUXhpEKOf9t12BBN/aSTs=;
 b=NY1TTg+cXZdJa1+9dPVcxAwLrz1ix3RJfeuJjBmgEyq6Ktf/FsXakc7Mdo4K2YJf02HOmGvOM5kOqkyH7v6+TzLZQ+BKAMuSih+0T/apx/jNzWcvIKVOwavt3xEkSzoiFeB1RhKSET/otLdi4hkOcau6EOf47jufhhgCw863bbbc0Wcw/wHoqtXVtOdfTo4vh87ZT+LwMf3FaYyM9H2lvbT8qf7OuTl6u11J9c7jMq2cTc0HSdN/4SZkjY1BJK6eAEps/+R2iIWf5vq8i/iBtsTDOXTcqLhiMGu95be61CKv4xn2mLb2iPgl1nVGhLeikGXGuOAsnWjVbVdY+RQkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqfGTdm5mOoPz1fnfQPLLftUXhpEKOf9t12BBN/aSTs=;
 b=Ggh7X2anFVHumQjIz1CM4VveicKURI0ZkSV7xHRcKkS3al4ai+i2+iYRJDHGHMe/0awwRlN6z+BlUCqAUJUuatz18l0vl4aGf0r7Ec6i3URl4dZRhtd1kT3gFwzVnjlyFNU1D8y9nNvSK8ER/PRgEt2ZgKrE6n12mi3VjjtAGnfCickPixILSNN0bBiV2/tRSiU6fbwAl0EruMstlrgfJsJ0YkE7X2vN7DSXbdH943ONBU7UxakkNCaHAdpO4QIO8lIwuRl0Y8SjKvB4qYngkbka36x8Y7uzDla7eTVez8ltP6AG5UOXkXZBCFVH5zKqkPeHVu3m2jo6963HR3B8Hg==
Received: from DUZP191CA0058.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::18)
 by DB9PR10MB6353.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 16:34:43 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::8c) by DUZP191CA0058.outlook.office365.com
 (2603:10a6:10:4fa::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 16:34:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 16:34:43 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 17:35:12 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 17:34:41 +0100
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
Subject: [PATCH v3 13/13] arm64: dts: st: enable iwdg2 on stm32mp2xx ST boards
Date: Fri, 6 Nov 2026 17:34:29 +0100
Message-ID: <20261106163429.618392-14-antonio.borneo@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|DB9PR10MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f94f7e1-02bf-44e5-d327-08df3c23dc9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|18002099003|22082099003|10067099003|921020|56012099006|11063799006|261028144727099003|261026121527099003|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	fo7lvSRail5pRoDYcKq5TeIQ24J9D/WdnksWhJWV6JXXhfUMLyHIEHpX1jYdwf4UpaB7ivaf1yiDk7O7sVMItsACad90vygOHCzrl6Glj/5lLpRWp3ED+Xzg72WlwSu5beaAyj1rqmVkTa06cFKteGdwrbm3MjCPtvFdWppJbhB+QQLpolNefIX1zfGWce01+K4O457wQn7ZPyB+cL5C/9C7YBMed6IzYK3lZpAcDwz+58msz7Au78GuqjxriEyMXB5ZbXiYgws7nZLmFIoHJbPZ4AREHikGwTB/YH0EM/0xxS2Mk5A2DmJwN0BdEFMEJ6FnSxez9+S35/frfsoCQcxrpXsqeiAQAOx7H8c9EjRZuQ+ICt4XJu9i9vnYj51AxWqJBSE1Bqi2P5N6EfZFoFQwqpPpVzkHQ+WMtkYVlKJW/+Sod2x5RQ8MJEQF7xtFIldUgEYI1O4EkAoIkVGkZA1Mj/SJA9C7jnAsssC+NFTbCt67qL2wugR2IS9BMkYPP8YO3hnUHxaRdcYWI1uu/o0U4CmVBBGpdH9MGGH8suRlBEpkzRKMGoNnBPim56GT7noMzMOJT+MUs/BFFu/GxH6FgKzCiuBc0+kVVKQAJz9zX+o34oBXx87QlrA6vIfvDgjOF8jJEKGqBXHOiPj8S7MuPMe8/anNdKNfw1maCo3+6Qjrw+GOox4/vPRKaJcSi7fMlJItFsv83en2lbyxjdXeQ06H0SFTJqvr3uub1I5qfAsGks63Ova0DEQmq5dK
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(10067099003)(921020)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iQ6oAfL1SqIDqpc5DWzqO9B3545A6oihHpYLCcsYG3o1TcVIFjAbDLRp44eiqf9z+F9Qd8WRadjgWaJiaZaKmbPACiico3SSNbVFF+5HGSRpBlRzY1PWv2sx2rfpEhi+RA9YwoU1OZXP7t0cMYyBpZ9B01yQm3kNV72NZsjIa43v7dxzJUU2M8h+tTuw/+fnyzZJIXxWqThGNer/5IAKJ6pK1fI3/7xzebfkaDuTxBKdGE0Q5FO9kzlUYW/C7vElYJco4cLLXoE2SXsBGtpxvBaCZVVyfnY/FKS7qDCAb1E4ttpouiZg+ewtSSrnutLu52yRLiI8BAwBa/h36rpbzyUDHvGOqk7MIcwGHPwu1aj8FsCZqoQpztP/9HxkSBDUv4kQ0oc2fgQlyiIoibmUDKALrhWlQNmLzIpTdifvJ0YhQxiLEsaRlJIaR0BSoE/s
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:34:43.1397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f94f7e1-02bf-44e5-d327-08df3c23dc9b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6353

Enable the node for IWDG2 in the STM32MP2xx ST boards to make the
watchdog available for userspace.

With two watchdogs now enabled on ST STM32MP2xx boards, assign the
watchdog0 alias to the ARM SMC watchdog that may have been started
by an earlier boot stage. This allows userspace to identify and
ping the appropriate watchdog.

While there, sort alphabetically the aliases.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp215f-dk.dts  | 6 ++++++
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts  | 6 ++++++
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts  | 8 +++++++-
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 6 ++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp215f-dk.dts b/arch/arm64/boot/dts/st/stm32mp215f-dk.dts
index a1285abc80ca5..c7ab340a7e4dc 100644
--- a/arch/arm64/boot/dts/st/stm32mp215f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp215f-dk.dts
@@ -15,6 +15,7 @@ / {
 
 	aliases {
 		serial0 = &usart2;
+		watchdog0 = &arm_wdt;
 	};
 
 	chosen {
@@ -48,6 +49,11 @@ &bsec {
 	bootph-all;
 };
 
+&iwdg2 {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
 &usart2 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
index f06b334dc9ce1..c71b914547308 100644
--- a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
@@ -22,6 +22,7 @@ / {
 	aliases {
 		ethernet0 = &ethernet1;
 		serial0 = &usart2;
+		watchdog0 = &arm_wdt;
 	};
 
 	chosen {
@@ -263,6 +264,11 @@ &i2c8 {
 	/delete-property/dma-names;
 };
 
+&iwdg2 {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
 &ltdc {
 	status = "okay";
 	port {
diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
index a8f18508db3e4..aa922abccdbc5 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
@@ -21,9 +21,10 @@ / {
 
 	aliases {
 		ethernet0 = &ethernet1;
-		serial0 = &usart2;
 		mmc0 = &sdmmc1;
 		mmc1 = &sdmmc2;
+		serial0 = &usart2;
+		watchdog0 = &arm_wdt;
 	};
 
 	chosen {
@@ -271,6 +272,11 @@ &i2c8 {
 	/delete-property/dma-names;
 };
 
+&iwdg2 {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
 &ltdc {
 	status = "okay";
 	port {
diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 782b4bb843eeb..dcfc29c620b02 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -24,6 +24,7 @@ aliases {
 		ethernet1 = &ethernet1;
 		serial0 = &usart2;
 		serial1 = &usart6;
+		watchdog0 = &arm_wdt;
 	};
 
 	chosen {
@@ -294,6 +295,11 @@ &i2c8 {
 	/delete-property/dma-names;
 };
 
+&iwdg2 {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
 /* use LPTIMER with tick broadcast for suspend mode */
 &lptimer3 {
 	status = "okay";
-- 
2.34.1

