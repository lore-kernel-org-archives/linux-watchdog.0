Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794835477;
	b=bkrpM4eTNCym7hw1nECKsbxp/fKN92Pp9amhYtV5lVgfIQY3BEcNb5upbwTcTf+BkxRw
	 8ZQQIrgn1NDgNVGj3e3VnvNE32Nm25GWd2mJz30s36uFM6Q0/XH6jpz6Dw5lSKQ21jc9j
	 IvAq2rUVy78oNxvr7OIdneMX9US+k38A7OV6CHQYHSuMI9MQV2IR0yce6iAR9CmS37L4L
	 emrNgejhT/AGiS/klwBifEFAyOPnGXK21DU+h1JC9xNu4lW+hNxc2y4amexekOWuKKm4b
	 bCKtALGTaUBMSOfB41wKWe7a/UmCDteJGDJttdPCAzXdJ9PF183vCakqLf9RVtj243g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835477;
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
	bh=7ZWMd8kjUCmJagmx0GxgP086SxqVdswLklhILoXspFw=;
	b=KXfFlq4941GipiV5oM/sLw4FxCYZleHuKpCE990AD1GpPZOoj9bwScgXpRGvjLtpzBrE
	 i87yIgo9wblqr1hjh/+fukplvJ3h148Vvx/7aCxR9/Ff/Rjhe23xavKMeFISeI1b8gTbC
	 UCwIIgKPQ5Imt6M0aZllrz8lthH1+mBuXnRkLowM3uNbkNIvCk49xRWnMnKT5Ouko6al0
	 lEbVKXdhe7Jiex42ooNlzku1Zar4NXvX/joET0EH4oB/A1i+jYaLxBHEnr4zatbnfh0Bb
	 KCDz/qsSE14uRj+5WBkpXf6hivSb0grFTZ2bw8Tr+WLh1hn5eZw2IRB+k5+JlcGdhAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=jbEjV88P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.22
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013022.outbound.protection.outlook.com [52.101.72.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70C606A33A;
	Mon, 16 Nov 2026 13:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD70C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=jbEjV88P
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bnjj2azBuoPpCKVraxsr2lkuKBtwUaO/FEfQnY/mbHSfWM07b6sS32iuYTtYP22oSbXvT6K0x0V6o/cVNzDsl/QkUyIwua99K848W6Fdq9uMsMvPXIljWMVWvMTBlElDivXlfox8H6uKhv+92lyqcI9TM9ooowUv2oX4IPTszega2CkyY+eMbcmlcFt8em21/deg8q30c+hWKT8coqpwr+8o6mQqK4AxsyOSzfI3CVcLSRIu6UxxQSpxCVfl9Kv51KVb2DTYug1M0C7kq3G2VHnWmZC6goJXYQ86N2Nxmy/6xo58TLlw/9r3TBTijzLoeWhCOIqdHDKMWLBbyjs1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZWMd8kjUCmJagmx0GxgP086SxqVdswLklhILoXspFw=;
 b=j8k6XOsOEPSEeclqFpSuKj9kHV/AIPrF4lGfTbo+AWVvteZ4E+km7p6mgVOxwLS0/78XbzjBDMIgrHD0BciezgcWez7VkwclusNcW7R6aizqf4R2m+pZJ/yLZFwcvraNo7hfcEhey88CIkxSDXiNNPjs68GXl++BhZ5jqhfAXPb7IBverKfoJFIcGvc+97mLqtIMLZ852LL/1QGbLy4QFwJbljoLpQ7oz8MPkl3xHQzPawSxIFcC3mW+PJh39QtX+E0MK91rEU+6A/6ollH7aBzKiEIQpMrcEutd/CnGBEXTupXY0lfNHZ51R0ZCa7IFsj+ZEnsXZq0d8QfC+Xit+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZWMd8kjUCmJagmx0GxgP086SxqVdswLklhILoXspFw=;
 b=jbEjV88PPcB2JRL2AW3wcOqBGcbCnzaurPmglYVkD9jTTatn69bZO2ejpRCvrWIq6E209ToE9zfQSNag7epeuD5/50PVUD5Pc8UmO3RVv8T39P51B497oETu5Z21e+1zqcoQBSKA2qssjZkuF0a4weqHpeIfVzrUF5l12+lxTQSq62jlYlpM7EYKgdJ2NJzTzOp+ypnSXzQBKZDNwF6Wv88AJdr4UZ2TRvDi8LOd7QiWmBc3eZK8STgdF6msijq+9ID3ZV/RAb6nEZCOS02CsTS4Yq3C51OQxfBPfUyM0X6LrXvlYWPBRJ6VIto6uauRQ2ulMvAbGav1h3K/bezXBA==
Received: from AS9PR06CA0235.eurprd06.prod.outlook.com (2603:10a6:20b:45e::34)
 by AS2PR10MB7740.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:648::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Mon, 16 Nov
 2026 13:24:31 +0000
Received: from CPH1EPF0000052D.eurprd05.prod.outlook.com
 (2603:10a6:20b:45e:cafe::79) by AS9PR06CA0235.outlook.office365.com
 (2603:10a6:20b:45e::34) with Microsoft SMTP Server (version=TLS1_3,
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
 2026 14:25:10 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 14:24:26 +0100
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
Subject: [PATCH v4 12/15] ARM: dts: stm32: add watchdog0 alias on ST stm32mp1xx boards
Date: Mon, 16 Nov 2026 14:24:13 +0100
Message-ID: <20261116132416.1184447-13-antonio.borneo@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: CPH1EPF0000052D:EE_|AS2PR10MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 51458735-f2d5-460d-6d1e-08df43e4f2f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|82310400026|36860700016|921020|10067099003|11063799006|56012099006|261026121527099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yZIbkM+sZZ7QmEeQrZ5drqq34aMyBr4Qtl9ofPezv+oSX+My37kpx0m2YKx4ZpMdhMGv6VGqtI9nT2C42TxLMRXnilhaotzEAboc8l4+HHzYQGEZi9S3PfkfzE1PA76x8P+1IUUj20hYU632icQ6G/B4eIzX/KVXc+cSlm/QYZ3MFArgP8xyJpylXskw+lMnx+DtymxdwWZSUBwkxLjdHVJqYd4IrYvSxqXyEhPLEbQtLMIBLos3WfskaPRgQTcp/vo4zkc/hua44Dm95zxeut2OHP6VWYGVusq8BnHAKg1/FBbpSqVxBxvu0XgmcpWqDghL3m/6SCF4uyGKzlE0IULMrH2472mNikF2vhaVYIaHjKgxZZopZkCBs77yAXSrhUxHzyILYY7/fLGWTdbL0Ehl33x7sCEin2Dm8daK1ruihd8o9xHYOMf8onSjQAzW/EBqlkk/LWZQd0LLI+XxcOA9i806Wg64PL17IB0elzxsGL2yuntLVtLRlN4dOWbS8aNcLMGPJQhrCu/6Oc5ikv3LvPRINEzFYsLeGx1mHHQtpNyVU8y1OyZ73hAtMjpNgAiIeezXkC8uAfFCBhWUyrHoa9S1tU+HrfXNP6LK/CcECTbq23MvTXYo5TLmS4MzbYsjqkhaxLTjlF3yTPP71hL75+R5oS2nJlZdtGkpZhaKHQiXf/sTu5vMgzQJvBpd2i5k+nE4/Sp5ng/gSoX+sCfYqs0v+sbqAbv0CrnClv1gIKHJUrApjczqba2jBCO3
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(921020)(10067099003)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Oir6DeBLeTf5l4wZ8AszPrIl4DqeP4hjszqo/ar0zdJb73HgXiAbdcRJx0QfqFpHadBlhiaEgUOUvEg6eNzkIYwyWU9CXMYC/w2TGPTnlBZYon996v0N7kBSF5JHVe1/fJmTNdepoPRBV5ecWZz/IPVO64HhY37vT7niYRiakjseJwJ6IrIiKE8ggO4Px/6YZIpJ3BWtQPz4IVpWpjj7/x+h+owWGuRUY61EaSbceSTF4lUxOQRw8d/0zg1f//jdE86B6H8gnHjbW3KyrNIQH/OjGhU4A6r51D9WU3x/3WkUGshfJ2zepxlnwav/wBukJ4a3UCcSkARghPlvIwza41vJmiumZXsLuksnKjJWYUfZimeqzvBYxIMEzv9JFxVjkBnziPDUweP0lzcRZMC8tfrFuZl7CARDeQfWHUoWP9Aqk5tQRDckxfEvtMYZpNet
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:24:31.6576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51458735-f2d5-460d-6d1e-08df43e4f2f3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF0000052D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7740

With two watchdogs enabled on ST STM32MP1xx boards, assign the
watchdog0 alias to the watchdog that may have been started by an
earlier boot stage.

This allows userspace to identify and ping the appropriate
watchdog.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts  | 1 +
 arch/arm/boot/dts/st/stm32mp157f-dk2.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index 2d6c5af7e4816..bd403acb1577f 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -24,6 +24,7 @@ aliases {
 		serial1 = &usart1;
 		serial2 = &uart8;
 		serial3 = &usart2;
+		watchdog0 = &arm_wdt;
 	};
 
 	chosen {
diff --git a/arch/arm/boot/dts/st/stm32mp157f-dk2.dts b/arch/arm/boot/dts/st/stm32mp157f-dk2.dts
index 8fa61e54d0261..02697c41a2f6c 100644
--- a/arch/arm/boot/dts/st/stm32mp157f-dk2.dts
+++ b/arch/arm/boot/dts/st/stm32mp157f-dk2.dts
@@ -20,6 +20,7 @@ / {
 	aliases {
 		ethernet0 = &ethernet0;
 		serial3 = &usart2;
+		watchdog0 = &arm_wdt;
 	};
 
 	chosen {
-- 
2.34.1

