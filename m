Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794835556;
	b=PYDnI0qj6SYBVzDAtZAAH2Bfe08Hy/15muVUohwvvBRLuhV3jv/V/yflhA4ab4CqVamC
	 +ceCXUtLRYMbtf2PgumWZWJMvAXlpsWP4lTKsx/tPkHrn0Qniic6WoFad9B74Qq+YNfed
	 7rujzK4nq9gi9wohj2plvowPECkGYf8BBSxsSFDPwgLN6OauccNo3LA31SQDxE+ldFGse
	 Jxab79z6/Mu32HKEgC8Wd3WipsQyPn9epskmuhoGn3dQYHKbpvoriYHU6ShVnAyYzXa24
	 rsWXcnW5R2/N7/nVaxo++LU44WNm4vIqFaSiPPnDcqwcm70VAA3S5eqXcehhV2MBrpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835556;
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
	bh=X9W2qeZI7XaN0ALZbFt2uJyhJ4nSOVgVfY1EGY8oXf8=;
	b=GQRXq6MVV8ftGlKqp9H38yISVL/AwdjDrl+PXr9HuxHystJtm/ubyWJVc2T2DFYYw0GW
	 yg30e0uNXsPqQ7x+Zm/glM9fpQw5zyNw8dgGJWI/AIdeqxuO7zowiILKjzrCoAVWd7ywA
	 nMxybmlfwTmIO07xv/6mxKx2DpsI1S8uSh6zl0PZmaM26Oc93JjMszNc4NaEyedzsWRix
	 i0SY0KoeV7D6QhVHyI/bkbHFeev8dCLS891Y1PZVzoZqYPnrZqVeWwL7ZREImQe4Wc4mP
	 9sapU6ivshH2zk6d2TUnXKb1OaHgrsY0YN/sm4r/5QiUrPPzNeCAGbpdbQY4v72jSvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=NziXik4C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.16
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013016.outbound.protection.outlook.com [52.101.83.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE62C606A329;
	Mon, 16 Nov 2026 13:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE62C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=NziXik4C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPjGmLxWAhS4SMsVVtSIZ/3ioAmEVi2uGxt1I5DF+uS58MalUGAMm1Q6GnXOlS2FtIj9dcigoWJ4rPMy9FUwiTtkMTomgaZMCp4RsM02yu6EN6Avj58b3JHCxLsAtocAxwZP9Wchce4kgv0hVE0LpUkNFhPZBaFqmNgsAhk+BnTBlDLkFPForCfHlxPNoJhK7wFQFev2TcCXBgeuYMInG8qC1CeAJ0EfqeJDpyWzjH4Cx1Hud8PyA8K4PotKMJS3Xd0FJNaQg+a/UwcygbpN67VPU1A5DJGAj0MRokfm5ZZJgYvXKlMO9VbDr54eyLQf1ZfRPd66LtmxON9Q5dEyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9W2qeZI7XaN0ALZbFt2uJyhJ4nSOVgVfY1EGY8oXf8=;
 b=J7UQjyWRw8KckKvRm54N47rc53KUuic3OJ2ugvYDCorDnFFld/+m3Vf2X4rgSidGmMDIydDBNWfZ66EUE2G7iECLZ+o5BuWfa5VlD36+jLfucE3186kgvzz+9hFZ0RMg4yAL56uYF/5eM8f8IP8rHAI8NKmtcxVtlWpi3ak2O/iBwsmSES38I39zuFd+nGr2/or8N7emMijTPjgqf27FBETLX6iBZI4Vm5duOr4Qf9y6NJAULFluwlogq0/5K3+urKeRqQdEtpicKFUuMETOAIyN7/a4IPKmy2zUr6qpohj4Z9euErSCX7+Ns4IVhX0dqUyb69i+4ilVZQ8coHhUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9W2qeZI7XaN0ALZbFt2uJyhJ4nSOVgVfY1EGY8oXf8=;
 b=NziXik4CpVO4xmY7mHyiDN5NWWwwmLKpHZa6jgx9mCI2KY4jTjXW4rw+ZACsbByL7lJ5JsQoM9pCtNjyJBH/MqgrnZmzc8WJfb4qsojj6l19mo8pHlsqlZVgzpZWdYK3Zl63qdFEcYjnkKseSamADBqBqUPeJq4X88Lyu0fOPP8pei40m2zRyXDmnSq035seJDyEY4wrJ7ko0/w4XW0+GKUOp7K/2XVikcc0Zy/nQItjSj+dKS/WL8qEFQnYMM31W1wrBtY1RjW9W/YBRQ6gJvj6pOCZqz8SZ0PthP/q7jQKvlqW4suLxK5/YmkH2aH07x2S+5SHAiGyvtgHruyrFA==
Received: from PAZP264CA0104.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fb::13)
 by DU0PR10MB7357.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:447::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Mon, 16 Nov
 2026 13:25:48 +0000
Received: from MI3PEPF00008558.eurprd05.prod.outlook.com
 (2603:10a6:102:1fb:cafe::53) by PAZP264CA0104.outlook.office365.com
 (2603:10a6:102:1fb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 13:25:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008558.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 13:25:45 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 14:25:29 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 14:24:28 +0100
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
Subject: [PATCH v4 15/15] arm64: dts: st: enable iwdg2 on stm32mp2xx ST boards
Date: Mon, 16 Nov 2026 14:24:16 +0100
Message-ID: <20261116132416.1184447-16-antonio.borneo@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF00008558:EE_|DU0PR10MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: becea57f-4235-4343-c264-08df43e51ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700016|23010399003|376014|921020|261021121427099003|261102123227099003|56012099006|11063799006|10067099003|261026121527099003|261021123027099003|261022105027099003|261026140227099003|261028144727099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	67Sa9ZicPa7CsPpllhJ7GqF/zxqIzh2NAZtSyqUWbtT+X99WQqKp+jZfrNpMd5yE9lXdl0sFhQPUnrzoTEsXmWYspUu8v6nz+RTGajz58JPMotbbR1+L+w/SgZ37v4+Yny7ByjetZu/CiLBXlKcgBaEpSvTCmLwo/rMWIFED0lcXYLoqlXv/yyPD/7uS0bnim7m/zGR5lRmgKyb6hbiDfEE57JsAY+MMxpafb4tJk/TKMVylbckSAaIPFNgmmtyG+uVLG4uemy7nBAoWslX35hCS8Z3UwkGwiraIOxr6wa1zsrn80kdC8fWg6lHP3kAs+Rfdk5K2WQYSvgbedzlIorIy3Ulq2Htl6GmnkIy//17NOBKhpIYfP56WrEhfDB+mYZMesUeHXZfAcdbwvry09Itgu6UHRJ6NygupEiqNsYgbhAioSyRGo1ZQ2Uj4CBh+GtOXeqP3jz10ZtqAtQoXGhUWm3JL9pII9PK4kgOu8z5Hxec3eonw1Wm4nOvh7JogwfbhRs/7pRPPGLq8aQonzdR3ecz+go+uIPavbaXM21EkbcZ4jcdhUKhx2qxILfAFy0EOewDViXx7s7LfDywi9nbjypEfMAjJbOxftzoEDzAR/47PQSHfSQX7RUx+gKM2UZi7QGjsER0iUAsI4SLw3dnfY1iisBXn58YVSY3iye764jBHb28dYtwPEFOyfmD43cfVYHLPOQDU0ilsBMx5fsfBuo9vg3bOex09+iYV5wSWkWfTkx2AYfhdf71HtFJt
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700016)(23010399003)(376014)(921020)(261021121427099003)(261102123227099003)(56012099006)(11063799006)(10067099003)(261026121527099003)(261021123027099003)(261022105027099003)(261026140227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U5o5R/f8qyh5BGtu92nHf/Pj2kCPm7ftZMdNp6Asf4flZqXD31LZUU3pdg2MIdVRiYclP7q/EN8Cg+HebNT7hM2/1FZMOfEubaWjo26e5YNeUH0PPpdmp9c9X6x+sutCmnp/G2aspmqqQH9+9240ysmH6dSq5beMrFtb4284hoxWJWahdy4tNI8OSOAkcJ2+aUPrbovXrCZqxMNoPFQ3O1XV1kmCIim9LQ8BKdbrYDvYgVLC4+SywL2sOMZKW8XY6DM1NPFBEUXAoNGNVmmVKu3E3JqxiaP0ESluG9ZWBVrb+T+VtSbvhrlyhokC9y39TxXp1nTt8khprDzuFWZoibI+Th7eWrXBC0iiCUejKbZCOEKXu2bWhKcdg3z08qDt102qDuB+Uyoa5k0Bxrb+aTyNMbN3NksmLHnyTlFXDU/Qzb1JBcBODmEbaGMHFu7U
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:25:45.0176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: becea57f-4235-4343-c264-08df43e51ea5
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008558.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7357

Enable the node for IWDG2 in the STM32MP2xx ST boards to make the
watchdog available for userspace.

With two watchdogs now enabled on ST STM32MP2xx boards, assign the
watchdog0 alias to the ARM SMC watchdog that may have been started
by an earlier boot stage. This allows userspace to identify and
ping the appropriate watchdog.

While there, sort alphabetically the aliases.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts  | 6 ++++++
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts  | 8 +++++++-
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 6 ++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

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

