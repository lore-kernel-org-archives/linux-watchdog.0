Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794835537;
	b=YfPtW7YxQvypKBZAyTVxgPgcMEnIw6J7EDSTVG79acdr8wclatPQ8e+ccafz1pBHhM28
	 bM1YMOOzr0lm7uP0/j5EKXHCtgnlzW8L+SAi3V8XRu2pTn5TPd+FIMubDwg/z9HxXxsnz
	 jWgod8yfUg7R8DHupXqzGrd7pCIEiQxKUx1gqaoMOUd28xlMGV45DSxB7G0ytuhujJyqu
	 iylawW11gC6P8QfUFhajHph+dX+8yzunSn2FVURkN1v58oK1BlY2l+88y2Zh5jMtU9jSz
	 DDSiWHC7u5DzrdGIazC8oM7IOF4xJsJIVUGh7UI51PLZJ+Dn67a7WXb59vnU5U/Fkyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835537;
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
	bh=q+/gec9r2ZJmpyyMFZq83DwOKyMMmYRBpAoxQ80Zi0s=;
	b=e++SRySi/Cqea9iWKmQekFyTupBlJqHqIEw0aYmv82tylR39xkRiLuOXdSe3Y6RIl9Fp
	 C6HRmpqdPF72Ob+Ak32ocsO8+KZ8nQC/hk1j1zbwb3Rzt+w2FMMr3nNLV4AyXVM5hjtSj
	 Qd4wgEireSedFrqm9tQEkZimVJuKmc5qJTINJSeoqwHlRaXidhDH9/2G7ZEXKBuqmzjfV
	 3pNzCEG+mxVGv8sdmJV3Nqxl9bkWZ9rtvHNUy8mjoueRepw1xjHD5BL7DaO5FjWVLF7Uu
	 fEdWh99EEqlA5zkP0eUJSXMTxCxyRTRNy5yFC4QaJ14+M0Y7RpIZ6Y5r9+NfTbbNV4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=a37HBoBl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.11
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195B606A323;
	Mon, 16 Nov 2026 13:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9195B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=a37HBoBl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5a4Xx5sFjAf09tJLPe/bYgJANgN/G0CJV7lZYDme0Y1VsPZP1KbISDqkmaROCR/r8ryKsgxLmpk+g1S3QKZ7tdn59LWcOcWjBahfTViuNYxsc30zcJhPofkSUGv+5YMqPmJAybN12vc99bZmEZNA7NsqOjKiiodTH4ewBY+JxlMCWH2a8ST1f4vhwyLlFX8pmT8XJVTlXC3qBOI6iNknDhZZsPfsCbBUJqVEkf8utfnR0OH13+sKOKrmJie/z4JeDxDJrrZmbc4QuTWDYiY6OF5r+KqYT/yCTMT5GyqfUwP+9JPfL5lTP2ME5g8KchPsjMsYzVgysO62To27CsCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+/gec9r2ZJmpyyMFZq83DwOKyMMmYRBpAoxQ80Zi0s=;
 b=hffANxZyvoT0G1ge5eMhOBdjw8yQ5SAMTSFoJ06ZAwo9ExIjqWjcDbsZI4AfLTK5gavpYjppkV6+UT0Bt6SQvPJ9PZP2wm8xvlD4zmhmoUMfX2YSkiQ2FZG2jNhdUjGYhypoawSvg6hLkFfosXCIHDCUWwjnS0hWe7eEAbpfX8DovMeM6UdPt+KZuB+Fd19Vs733mrOLfIHPXQ6nueQCxR5HMp8H/z9mSUZzG6WZ+6vqeg6OQi0OYVkO89VxYWZn4OAT7q9bual1/1aEbpBpeSCTOaw67IUhN+i2Jk838uBc5Q+y0ij6IJJgapwcnWVq/bV3CKziXkTzUW92GbClGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+/gec9r2ZJmpyyMFZq83DwOKyMMmYRBpAoxQ80Zi0s=;
 b=a37HBoBlMnx3fw8SzRd1MVXWrnWgVFKJVLacQ8a4FZhDg/ayFkAttKXhu75aBCzY+f89vipoBtdiTPpTYsR3Uuc5A+18v2BYNFwe7iNgVqkG7m02X9ZLMakh03vpCliAjW5YovkIc8id/jNmKR6EHUtOr3392U9J27M7e3xUU5drCwLH4F/uRiYg/QqDPdiE89WUU4zbN9yrknDfpKfMHyqzN0ISEetdBjr/wHR20UyoDVlxZqZU+caB4ncJgX5aeffjiTvJ2UBDQA8aoK0STTB//ADI4ORkylRNNbKdNw4SwYjcpRyHHMLXuh9Sr6BgMuEhsvy0wzb5F+loTE7Q2g==
Received: from PAZP264CA0106.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fb::15)
 by PR3PR10MB3962.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 13:25:29 +0000
Received: from MI3PEPF00008558.eurprd05.prod.outlook.com
 (2603:10a6:102:1fb:cafe::86) by PAZP264CA0106.outlook.office365.com
 (2603:10a6:102:1fb::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 13:25:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008558.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 13:25:26 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 14:25:26 +0100
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
Subject: [PATCH v4 11/15] ARM: dts: stm32: enable arm smc watchdog on stm32mp15x scmi boards
Date: Mon, 16 Nov 2026 14:24:12 +0100
Message-ID: <20261116132416.1184447-12-antonio.borneo@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF00008558:EE_|PR3PR10MB3962:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a56087-42e6-4e43-9479-08df43e5137a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|921020|10067099003|11063799006|56012099006|261021135927099003|261021123027099003|261021121427099003|261009223027099003|261026121527099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qwkOXsU9q9s3lhDgNurQRPeBvuXzft/5Vgz7KmN1oc3AIPm2Lx8VRy1Dlk5YkW9HEtEElopjtX5/AzQPr/kutZKlMpEN8hXNXF1UD9Uz9zmFhEL4efu6UQ1Z1ULvKyt48vSeS3JGLluhezgTvN86JmBVch0As3059nAcuEGn3faTvz410k94F2uVVb9oLhXvOwDuX6kxToQVxP6rMupBVZGPDmLdbzY1HUIK88toYV70ni0x/OOFyUREPMP5wgxcMFEA1BwrYPLr6V4JQ3x9DgEwqro6QZO8pHndNOjyQ7D5O+VH1j2aSb2cUDFOU1BvQRnF+6xW+6lsRaPMPI8rZ1jGdBp1qZeUOPPIFODiKssQhkpmVmNd8TpJbyBabRDigrJ1tUwHResQSaw/ekoDgVxp/g+G1Sz8wMFnmy3RtQuv1Otke95Zv6vKdVgDxhlHFHEbQoOQreOw26wiSL8Zw7vGO8Rzin+S2IqVmjAD7wAKJYz1F2TGft/MXldXRHKh0mhsO3Y13l/sTLTC+ucIHvO3JLR5SFpoFGnJIJ27cyEuG3KouZzh+AxwsEL4lkYNhDx7nyhDHio5Xx6D3ZI6ifj0zy7OsXbCtzedbK6uyFQ+rk/0yEdh79GEd1YV9zH1KtUv5O8DjuPoFeVypqR5GRjlF6dhS377bctPDXH6hmHJUGoDJCNtnANQAkftYC9v3Kgbo8XnwaFEL8gxNnBc7blINoRcSJDVBPdzBy1jVhjg0+fFicj8XZTJYEXxSbre
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(921020)(10067099003)(11063799006)(56012099006)(261021135927099003)(261021123027099003)(261021121427099003)(261009223027099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uG/uIvZ2gpXc65CDflFKbO2cComXwhT9SeNrQq/rb2LMnWuUth1Fv/7B1B3DfcsOoFwmiVyMZWp7QGtmiYZjfaTaawl8f/U26K1F8HCKSgR8VI+FMOK4088KQtOLBx6lpVucnhpvz1ezPYv9Gn6oc0ihHoY2+OwZQMsz262ixqSiTPTryIxd67h3hMgCII6lPPSXEfZ/UyoRPdvdUsPu8zJtEvpyLlfmgvaE//vNjNrZTQKLB46CrbF62mvyEkit0zR88v8WISjuqyhevAJx4KKgymBaLgfV3cY0cMLsUHo5LwHvBlJ3CQDtNh7fL2mM11SO0r6WC5eS/Mk2jvvLm3U8fRsrvuARWxhmwYzPLlyy7fqoUmAR+tFieIA/pqtfoQd0okgy7tkf1ULNZhWlA8p4i6bc20pVlajOKfOZsrnNH0TY5Unk+OqEE7SmKTk3
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:25:26.2874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a56087-42e6-4e43-9479-08df43e5137a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008558.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3962

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

On STM32MP15x SCMI boards, IWDG1 is secure and monitored by OP-TEE.

Enable the arm,smc-wdt node on ST SCMI board variants so that
Linux can control the secure watchdog through SMC calls.

With two watchdogs now enabled on ST STM32MP1xx boards, assign the
watchdog0 alias to the ARM SMC watchdog that may have been started
by an earlier boot stage. This allows userspace to identify and
ping the appropriate watchdog.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts | 9 +++++++++
 arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts | 9 +++++++++
 arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts | 9 +++++++++
 arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts | 9 +++++++++
 4 files changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
index 53e40e2f776b7..2f4d212de3e9c 100644
--- a/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
+++ b/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
@@ -13,6 +13,10 @@ / {
 	model = "STMicroelectronics STM32MP157A-DK1 SCMI Discovery Board";
 	compatible = "st,stm32mp157a-dk1-scmi", "st,stm32mp157";
 
+	aliases {
+		watchdog0 = &arm_wdt;
+	};
+
 	reserved-memory {
 		optee@de000000 {
 			reg = <0xde000000 0x2000000>;
@@ -21,6 +25,11 @@ optee@de000000 {
 	};
 };
 
+&arm_wdt {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
 &cpu0 {
 	clocks = <&scmi_clk CK_SCMI_MPU>;
 };
diff --git a/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts
index 0790ed426ebc0..41ba8a5b756b1 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts
@@ -13,6 +13,10 @@ / {
 	model = "STMicroelectronics STM32MP157C-DK2 SCMI Discovery Board";
 	compatible = "st,stm32mp157c-dk2-scmi", "st,stm32mp157";
 
+	aliases {
+		watchdog0 = &arm_wdt;
+	};
+
 	reserved-memory {
 		optee@de000000 {
 			reg = <0xde000000 0x2000000>;
@@ -21,6 +25,11 @@ optee@de000000 {
 	};
 };
 
+&arm_wdt {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
 &cpu0 {
 	clocks = <&scmi_clk CK_SCMI_MPU>;
 };
diff --git a/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
index 0a3894aff4aea..2fad04ed60161 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
@@ -13,6 +13,10 @@ / {
 	model = "STMicroelectronics STM32MP157C-ED1 SCMI eval daughter";
 	compatible = "st,stm32mp157c-ed1-scmi", "st,stm32mp157";
 
+	aliases {
+		watchdog0 = &arm_wdt;
+	};
+
 	reserved-memory {
 		optee@fe000000 {
 			reg = <0xfe000000 0x2000000>;
@@ -21,6 +25,11 @@ optee@fe000000 {
 	};
 };
 
+&arm_wdt {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
 &cpu0 {
 	clocks = <&scmi_clk CK_SCMI_MPU>;
 };
diff --git a/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
index c2b6efb1cbb74..d14506e9b6f0e 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
@@ -13,6 +13,10 @@ / {
 	model = "STMicroelectronics STM32MP157C-EV1 SCMI eval daughter on eval mother";
 	compatible = "st,stm32mp157c-ev1-scmi", "st,stm32mp157c-ed1", "st,stm32mp157";
 
+	aliases {
+		watchdog0 = &arm_wdt;
+	};
+
 	reserved-memory {
 		optee@fe000000 {
 			reg = <0xfe000000 0x2000000>;
@@ -21,6 +25,11 @@ optee@fe000000 {
 	};
 };
 
+&arm_wdt {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
 &cpu0 {
 	clocks = <&scmi_clk CK_SCMI_MPU>;
 };
-- 
2.34.1

