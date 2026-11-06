Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982886;
	b=5FChmR4B65sG7r8fHIOhVVffDVDDjbR5nizZG2PGD+TbTYpNw8vdIPNASKIN/z2dW1ms
	 RsqhEizG/L0cUzb9/dEZN1vYolbjJEgcTGzO8wYL2WapdTqEBbK45OFa5E+FqWFGbocLM
	 HXfydR3y/J+tcwTXCNeTiozzQmNUqwsdh9RXR9vGS1IpAkoykibwd61HKVCAeaO+u09r5
	 5DiTdRb2kNuBg0s7hRMWPPUyR0B/uv3J8DHfQDScdjLm9F9WIMB8yXWYkX9JvHQkR4nEQ
	 JX9PDUJcwsgmub9lV59dgM6X0iBMg9dmZJvG3faeIbTv4FBTjffne51evlmurj0bG3w==
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
	bh=gIMEJxCXc/2QUsjbE/IcYEwjWJwNOlAo2PDssgQyVH8=;
	b=fo0tCiuFSZMLD5hgteyABiPhugMkgnMFJRwH7/ksGDEosOs4bkTqQcZuj+VRu3viBllq
	 Y+kbmL88zzGrLhylvzotSpTqcWWX5jSZj3+aKNZCF2HvCHzMKiJWxwrxY6NL57PfTwgyQ
	 1Lwv122ec0mj//lsXPJ8riEx4M5o/dPlOW6uLqXKrNSp0J91V9j2/gYywJOjGD049Tjey
	 idbaf+r1AdE9X1DUR4rvmIMGGqWScF038pWaxrAFoe/E/1tjvVkvds2AEUObR9easOtlz
	 i4gqAO18ruuNwxTNXnVzFmEhHWM02SHB7Ebcz+pL6drt/DoeeDxo0bBoQ7Y2UNTo/zQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=RM1tiIQG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.35
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E72606EEB4;
	Fri,  6 Nov 2026 16:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93E72606EEB4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=RM1tiIQG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+YjjPhQ2goP1OrMx1LV0abaJbcW8alU1D/0Ff2M05iZx1/Pmyssh5yTG34M0QgLymeLwO0fYdPLM1kqHzmi/CZSKkl0JI8khaswas1t55fOJ6gXqRMR1AITP5M6U+Qga7W0G1RXxBoRm68nubrMmjVLoEuN6DQQtUfQNYEheENQLZ0DeKZQESxWLokZ6pRye795DwpkopLPKyNGl9qJyXmWKhv2bEfTp4VKNs+4HqRCbFNfpszWQCf6tKQJz0KnEo+xlLcGgVXrwjy3UY96GytVO2sT0RIvUdOk+RI3cwqeP1C5cGqwzXXeABqaNXxQTcMB1wCNzr/42c/D6He/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIMEJxCXc/2QUsjbE/IcYEwjWJwNOlAo2PDssgQyVH8=;
 b=dqgyEYjdgMLxBJPAfvmyJabxfryGVj411OSyVzzQjFw7hPmmGJ55uxxu6Ooj3CpXP2Y0sU8fbdW2PtQ9strQRtUIM1LuX9KUdfRWwHlsS/SEmOMRZ4E28cOMiPBs/yw251KkygE7l7H4oynWsH660SUiFHJ9hIa4/fOtIbPWYnTb9D9ez2BzpxolEweUugtyUSryVxY1FZGuaUUzal8lRGGBxkGP2KrHcWzGq2iL62qHNdhzzzBQGBG3VWZexeFYeM2V3IVgHo2ITp/OsdL2DLT4GHEIk5j+lmU2we7oH9GFyVKUGI7cWXuOO2ptVkQa1wpXQy0Iz4NUyun5i63SOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIMEJxCXc/2QUsjbE/IcYEwjWJwNOlAo2PDssgQyVH8=;
 b=RM1tiIQGDAJIs+GdvN/es2kwrsxp8YokCNak6LHShQ3buF+G38reLSRH9vI/DrMPbKKRNTr9F85O8jXmZHSeMFRs3urIN2k+UK0hmg3k4Ts7WIuqK6ygZcIA439rPWqWBmhF684Z7R+IXX1ry3WKWe7QY/PTyr9+zDI71Q26OprbbdTc6ZuD83tgwz7mrQeHlU9QuCpMp9IFOptWfB6unCGbt+nHv6MrzFBRGuvNmXnHDwDRT+1Dq43vQnpM1VM2lsCoC8wW8LMOP+X9ttTwL71Z/vCmk2KgFQDImgKDlZbNgj24v02Mol7TnceCdVa48WX8u7nYjGahq5t2eCedyg==
Received: from FR4P281CA0191.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:ca::11)
 by BESPR10MB9248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:b10:e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 16:34:41 +0000
Received: from MI3PEPF0000847F.eurprd02.prod.outlook.com
 (2603:10a6:d10:ca:cafe::1e) by FR4P281CA0191.outlook.office365.com
 (2603:10a6:d10:ca::11) with Microsoft SMTP Server (version=TLS1_3,
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
 2026 17:35:27 +0100
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
Subject: [PATCH v3 12/13] arm64: dts: st: add iwdg1 and iwdg2 support to stm32mp251
Date: Fri, 6 Nov 2026 17:34:28 +0100
Message-ID: <20261106163429.618392-13-antonio.borneo@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF0000847F:EE_|BESPR10MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 580d8039-7f3c-4910-0921-08df3c23dbb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|23010399003|36860700016|1800799024|10067099003|22082099003|18002099003|921020|56012099006|11063799006|261021121427099003|261102123227099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	aHj1MZgSAal2jg5Zf7pg0+hWp1QHH2DmaRfS6DAsrEqcDfzQa4+VTl6vAKYCTuQ1eSnnavbRasB8aq6DsoJZZmHD14CRNu7qRRuXnH8tzjBwboC/22QYkjBkzlBDPaFQPHnKqDKm2wwpzVCslBoQrahQst42RhrgfDHUdclvom9jW1JqmNO3uiGCBwHFcTS5GjOgICEX8BegQhKo8OlcrBNqZXVCgKaZNCJF2xy+49/zoQKzMOu39qsJk/B9z1bBV1xa22L/BPSCRtFzUuS7aje6ooFHWyi3hqiL1/Df046Dy3FtdDo0Uu/Iy3l7HHkAC6rNfqdEZKrKMRFgbJj0TRIRGJA7K2PO3nsbOUq3dkQf1oR/zeSS8/4IGkNKA1GuYxbaIYhOKg21KZACiD64c7KILMN9d670f2I5YFkqXzDrK41pWwPwJF8j3DY2aIEX6OvxxeeJSJ9btTGlEVNlu1m6ffChz6K1HMuMzjAoV3eJ6fBc/igI9jaHYH+zS7LcYrTBxr14qiF4Rl9sHm0ISn62lHbkdUbeExdKXddowcTYwxQemyM0io0WerOx1fWAtn0nDuiq3fGe5wBwT6+cUv0pJak/eSmbhE1YWqIdAkt28r66yeRfuMx7BChoSTXJT+iw/gt61HXD3Jfg1BvDPER6ScgHHDgb29gfimeoicPhnrXUhRhXTxdsxsY/IyiJ4QWf04Zb6VGoxBIqAt8sE3rTsZDwci6wL7lByaUzJnfDsHx5+eQFCu2S2KVxuxBP
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(23010399003)(36860700016)(1800799024)(10067099003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nXwVPZ3pO8ev/RAbKnCzrKuUXlBHwXVhvelN3Uo8S3txyWqLuqv2HzSCaDgj2v3zA//X9WarH4fNTyYQesFCyCIprBr/ZfOWK95e0a0Ws/vIfZCZqi69MfrNNg8he1IFlO0+B/x9cetd27fc8hS53ezlROorMgMbSIug5DZjA6zTUbHjbjT5/ziHyhaa34U9bvI5kw40gvVhPrQ/Fzcm9wBo+qnO7FLcrYXxSnZVdPZFX5BtyXxKTutaW4nxA+2s1GlqZ4aTgrTtEWtPlxjI6fEp0l9Lpn2toXmwpHX0Y2TgIFrSmP/exRxmkxQe6EiJwOwotNuzlS/BhG2dIq3/tt213JzD8KTDUt8lo5lXhzT5La3lqKIa9dUW7vFpeo2SIA3SJYJFHKAyN5sVToWtFvpIRqKuNuhxD2ENt9xxbvRsm2XH+fqzVRl1ZbjVYQUn
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:34:41.7333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 580d8039-7f3c-4910-0921-08df3c23dbb8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000847F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB9248

From: Clément Le Goffic <clement.legoffic@foss.st.com>

Add the watchdog nodes to the SoC device tree.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index dac3d2d23ff00..02064fd05a259 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -1474,6 +1474,26 @@ rng: rng@42020000 {
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
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.34.1

