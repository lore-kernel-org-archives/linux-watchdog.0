Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794835479;
	b=cz2sA554g9gXP/av6XrsOByzjao5iFMM8oN3Fm8fUmilbtisZNGS1+UC8AMLp6tWJdf7
	 q0/Le8z7V6HHPrna8uAn5zaGTaLqjoP0L8JSDEz4kH6civB5vrTo+xIhfOycAEVZu5TrA
	 6YAKsuHaaCI93wDR80PrncczNpCes41XvZdJnF3O1vtn+FsI9RegGXSMFgSAcLsIO96o/
	 Yhlxz8UC3ovIKx+RjWZyXF3mjXFh/Mudq+lC8z/pJry9BDxC34jvpml/7jrFICqP61Xra
	 WQIZJo+gsR+8E+7Ve+CsShzKSSTXG5cKRgIn0nP//ia5Qw5NxE3NffDF728w6tmjiTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835479;
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
	b=b/BR9CO7HjSNv+eEeJ8CQey56FnAGpN86nMGHOyTZ1ucepJuBpxjJd9sN1WoG/ncMBAb
	 lQcXjDdGL8IVPGxhGdXCivsegwLVigATTc1EV5xyU2HH/XBkdzSfGvuzopZcSS0V6x7o2
	 msydJvIGKFUSz8MxmIvQD15jSOGkQ59hUWAZAaibM5aAZMT7XydgRXth0Mn27nhFpFnBY
	 rYkjXxrOzeCRddSGv6QO06pXwcHN//rA2ax8ZlB/R2bNerwIT/d8XL9qsjYqr5dsPTTue
	 IMWqWzdqZNZWzk1E+fpYl1q3ij/N4QJeK5qv6w9iJ/eU4TILNd0sJ0bd08+PqMoM03g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=HcXnrwJR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.41
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013041.outbound.protection.outlook.com [52.101.83.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE90B606A8AA;
	Mon, 16 Nov 2026 13:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE90B606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=HcXnrwJR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkwYSTcMQlfUBbDxJwmbdEI1OX+6zd4tLXSBtVoL05XWA3QJSNJfwMV0Y3JjizuEi2PDO64ohIO6EHzlaRirUEFeFBcgs9+jtSiym9+LXcoq+pY4z8LPmleZgjFHQp2mqpLWXA1DG3f8FusIoS8hRcypJqph6lbAfLe4CprRCzuzOAWOLpCOOFYZsa2P8dpJ8yHjIL5ChxI6EAV2dI1A/+IQ2jgTGgA/nYcT48p10YoUK9rB0+a5xva3Xdol9WfUVVMFjdoNvB8pXIa/d4EPd59h+04JpesO1e6tvF3PouUJKDjWIZ4hehjNWf8t544onFB6VXXrgFdSzZNsicUpxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIMEJxCXc/2QUsjbE/IcYEwjWJwNOlAo2PDssgQyVH8=;
 b=QXNSaPpa1NIiJYPLKiFqCatV+WhuRBD0vGR08k4/7FZUcdoBMnBwF6AWyQ5Wm6uKzwHGPoiYL9G7gKw9/Mpi1gxo3c5WsULJs4Yv/VnOkYxtodpd2jx3kat5V3drarYcg+ZM3Ksu4thCpbcR71qeVZr2C+G0Sp9eTdJD0TATNXOzeOZ2JyAB3j/Plb0XjWe79Xt0F0u12TNXAHMcSofBj4/LuBw6rsHdjfiA7S7vzRbDeRs3wlxPbN7g9PwwHD3vNRe20/YiVoWAHDhdD+EVTQeMcQAuugmS5IfaxhV0KkplfsrdBMk0EO1H10gPNvYDf/vz0nk9Jb9HNgWtVhjKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIMEJxCXc/2QUsjbE/IcYEwjWJwNOlAo2PDssgQyVH8=;
 b=HcXnrwJRIodG9OxmZZHpASv/W6BWddy+Pa45nIudjiiY7vkxB0uN3PtUzMrH5muIqnLszFswPWbvFnGT4xTGCTfov6XRqtDoCCeGTLw3hUraL8ilPnXiNFrTT/GhGcTHKC8FJq3iQD3EKbmv0yYZhGr46+bxynfXFq/H48Huh2U9/r5vxlrdo/vY2W+Ewp8j3S+nsbvqn92x7krY8U14dz9+YY+yvbkL0ib7fa6PHCgJUM0uje5idYnLakYBM29aI76Jy1d+Owcs7hGqVUfFtyhdpB8eEWVdSlw8XncdIvPEcAKnUEiWWjK1C6X3jVEVct/LHlit1NaVWwN+7uYpJQ==
Received: from AS9PR06CA0230.eurprd06.prod.outlook.com (2603:10a6:20b:45e::26)
 by GV2PR10MB7440.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Mon, 16 Nov
 2026 13:24:32 +0000
Received: from CPH1EPF0000052D.eurprd05.prod.outlook.com
 (2603:10a6:20b:45e:cafe::c) by AS9PR06CA0230.outlook.office365.com
 (2603:10a6:20b:45e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 13:24:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 CPH1EPF0000052D.mail.protection.outlook.com (10.167.241.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 13:24:32 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 14:25:12 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 14:24:27 +0100
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
Subject: [PATCH v4 14/15] arm64: dts: st: add iwdg1 and iwdg2 support to stm32mp251
Date: Mon, 16 Nov 2026 14:24:15 +0100
Message-ID: <20261116132416.1184447-15-antonio.borneo@foss.st.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF0000052D:EE_|GV2PR10MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: e1297047-d888-4259-455b-08df43e4f336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|23010399003|1800799024|82310400026|921020|261021121427099003|261102123227099003|261009223027099003|56012099006|11063799006|18002099003|261026121527099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	8cai/kOjYulrhvSc8mpjUpYPqueyvm6Wci/wF/FDYBT0Fp2M2wtKjwjPHE6oBOmJ9EyngaGdD16zOlsYXX0YmPL0ev7uidsZ5pxyTU1DGY7WJDVmnwOBC49gz9Zn3YhsMm2ghMm3aNwVad2pQL5BfVLBdAEPc/7p+BL/Ydi41n/D7nh5481yAdQUhhrZJuqDhAa9w9PZUyY0zljCcEH/JoYCgt6rzH84V75pen3dWSsw1wHwAmjLQ2lb9LhPiPnlSnmXIeGTQxxjQyZo4HjO1rBG4+Bkj4f+0CHs/7H5G+2cRzmGnTrL+glU9JJV8W8uwMcavT0lwPKpn0wLoXkM3Ml9msnkZV+k/jxn4LtYcX66ADLxT44zHHuvocHry5UCRGLjaHAJ+W1oCUHlEyMASUnIApkGdEvPA4jMd/0Vn/tjI8GZxpyFrA8HZlZm3MKaQdSpjhglWaY2rC2Mdzn6qj+VwEz9vNK0R0N9nnVvfj1tgdqO2e7JGeRtmmBzF+SUdSJ2V50FONYRQ177TBIpqW2L3RTnNnyv3hPjjdlWboma+2Ph3yVNNFWlRgfgLr04/QwvYUVR7CPRfFIbp9qzYvjqOFN722CYSr4qDtwK5AD+WUc8s5bUec3jZGW3+EwIw4DRAMSxa0fPVzKz9JvprVSAQjDKr9U/7peurnmV6JOFGVbsrJuRIrA3rwFldKtQnyXflmnAQeGZ63zSxGD9LIPNoa8WxC+NWohwYC5tuGJamy1L3Q3uYg9J3ZvyNoMK
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(1800799024)(82310400026)(921020)(261021121427099003)(261102123227099003)(261009223027099003)(56012099006)(11063799006)(18002099003)(261026121527099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IFLYp/XMZ+5/8lJtrzXThBQ9JhSRs4SqYtFX9YFYM8CSkA/gN68Q8NAloSTKyObf5TYO+gRuuj2K0f/BGs0tMqOSZ+pYn9Rw5/Od+fVdoF1Jsn9jjNLy1ElgJr5fhKO/TRrCCRcs6utjMN/YeUTxPZ7i4hclm+5LJ+GcxSi59kMKvsudKJdnup9kIUtRzVJp6ND+XW4PNo08ur8EkdTzAnNf332ex/dKPhoSzdK0eR9z6PR/w4IEqh+wASlvPPVOSwD0tMHTBIzRESqQrfbyepG4iAE2JjI1sMfY6OVjn3ghzn1ERXKO/fStO8hO+sbeQoO9lmJX6S9Cho+JJTuK1tJa/l1RfUnEm/NZR561Sgxl00XwTvl4Qjknci1dWBu+cvKcbl9gn1Ql/SbZeR6nRvYU+2TjjcZt2vsPnSynt0P7m74zxUBhAvMnkV/lfPjl
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:24:32.0964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1297047-d888-4259-455b-08df43e4f336
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF0000052D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7440

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

