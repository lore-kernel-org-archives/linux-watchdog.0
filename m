Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794835471;
	b=q2eagYKqQI1xqYa3Ln2LcN8GAya+vXSppqe/mkd63uAjxDeUxqaRLtQclABL6TVK75M6
	 U/CaZ3Zu/e+VzipX21eMafCVKQUz6CE+1MFqSYUfPDkRG218LldFjMg6EmFEjdU/CH2Dr
	 tDiSTBNJgg5h25hwNVmBUXOEe2otqFKbP12o5/mp16Km+BmmS6UUP2U1KWbEeCYD5Yc8P
	 51YuEBsUvscFCco7QcWWZ1+rqArQ8Dcb+imxj6vT2R2t4ZBRhIChUmtnQIagdtwfZI71x
	 YZmEt7Rz4h7unwMqf+58Sa1YPFe0PIhPNJxTB74nTNSXoufOQEzmGxQhxCxUHz7rccw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835471;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BscThfivprwWjTOTQ0cyiAdJWanwkXp9CVEAyEXsDZc=;
	b=Nr0rjSk5/bU1BsAbvBXePncE0X/gqp4ILs2ieNjGD0pC6wjtpu0ZsXiZzj6eQ7myLmyj
	 uglM85HGv6g7JluvJdNzoWzXGCTEC8xjqj1kYBSBQmSEUZ1NmpYY//BpgyWpJIkLs347b
	 bSebUXw//YvOVwLk64fBHcwm/3cGraj5MI6RpkvPUOOzVoYnEuGbPX3hphkosORmFVhV3
	 a2DYjgKynH1AMVKC5ss1G6mskUdY0VWIp1dGp0ObQMVHbZuLNMNvFWYl0iYPSs6zwEU/v
	 QyrHHxVoMxgu6h7E/LXpzq8jDfMaCPbySsw3gFAIqfwElgENuUphUU252wXAlQpowYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=D9w+bc86;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.43
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013043.outbound.protection.outlook.com [52.101.72.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3968606A31C;
	Mon, 16 Nov 2026 13:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3968606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=D9w+bc86
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2oom+wu7/6z0X4w0YrHTmx+gANNg125d5yMCzPiUxB5lnyi2Smdm8XK7ZKiCe33tif4YjPJRBH4mIR6nSra1770UxQgLSAg+zm9qhLFji12PJ3D+r36uP82UcT8n4zqQxBm6GqOkXK1KhoNS1qvLxwyXP4+Z/xgvE3bYoQmuvLRdSv61p43eaQaBozsMXYZjGXWmrrBD7d/48cL15vqR7kuwFIfNv4VDEe5SRnhnMhyMHF8DvJp5WnMmm8BJaaESD0LotSWTUlKkhvQ159LmzI2TSaQSNLks457Lix7dpXC9YP/xa7MgScDUQsbvqmyN2CI78q8HNWd54cx5o9qQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BscThfivprwWjTOTQ0cyiAdJWanwkXp9CVEAyEXsDZc=;
 b=ylCuT5m2XN4tCR+s30Bsq0OI2NLQb1w3+7r83WDyxWgluub+uXh/7PJhXh/QUZ6ro4kf7+2JwOaw5fCDYREl2agFzwyu6NpkSYxCztJLTBOpgSFGU+PvVa2n6i/2jZb6CNKUeJ5acQHxA52rWFS+kuH3ddkEO9KMXCWVBBePKV2gqrdJ3+Xfx2VpVa+Pah4UObDsM1hY2E1gyCSdRwlTfURkULbK22o7YbUMkvQcba3jD58GozC15KmdTuE1TEQr27q//CiwvlWTnae9LoRWq8FtJI2jPWCnjh7bUfVqYGX90GAVjZTIH5bF6vl9cwJCN6xB37ceMUc6r5K21zxhOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BscThfivprwWjTOTQ0cyiAdJWanwkXp9CVEAyEXsDZc=;
 b=D9w+bc86I1/AZEpvpoGO7iQLGetT6lhtVF5jygJDiAddzhsW9xN5NXRLx5tH+pJVXiX3h/YP8tKpvSCd4bVRZLvCyhcI/956tt9iul3UyjsWDJG8W3qMYsJvxmksKuLV3rwlqAJBLtdwOO1+CrNzjV823OqdX3YOhXwVSO+4Fr77dkJHgEr9iA1bfUGI7cnD7quC8ydfZv+l3WnviUwKWs6BXYSjfkcXk9ILAGqkjmZn8vyu6+7r3L2hSd+j8Re6lHnl2XX/nw2fmd8S39JySkGG3EePyS2u+BxvjKJYjNtQVAwY+XuYZYj+8D3DguZnuj/lmnITqJ3G0YCd5rnCHw==
Received: from AS9PR06CA0218.eurprd06.prod.outlook.com (2603:10a6:20b:45e::7)
 by AMDPR10MB992223.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:70d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 13:24:26 +0000
Received: from CPH1EPF0000052D.eurprd05.prod.outlook.com
 (2603:10a6:20b:45e:cafe::a7) by AS9PR06CA0218.outlook.office365.com
 (2603:10a6:20b:45e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 13:24:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 CPH1EPF0000052D.mail.protection.outlook.com (10.167.241.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 13:24:25 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 14:25:03 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 14:24:19 +0100
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
Subject: [PATCH v4 00/15] Update watchdogs support on STM32MP platforms
Date: Mon, 16 Nov 2026 14:24:01 +0100
Message-ID: <20261116132416.1184447-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CPH1EPF0000052D:EE_|AMDPR10MB992223:EE_
X-MS-Office365-Filtering-Correlation-Id: f9cc9e1f-821f-4ee9-a729-08df43e4ef2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|921020|10067099003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261102123227099003|261009223027099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	dinOUvyKT2vxRZJtjUre4mi0CoFlgCAA9vzru++Lix+Gc8W1jxPu8/4+5wUd+G+m6bZ+/tXCMllB2Ik8kDXTZBWoYEJrzJUBLOhBMvms5tflzNzcfKqLii12sBDz76Ka2BNHyBCwSkzb+Ou4+c1dxILAIPG1lcBNh0K/36+aewi788u1wp/dKBJd8215KbLdnoeUylmBllOffmSD2GFKtYHwyvYhifIidRiDKtaFN+4Dz4tHdT7KIp0ns5MuBzIeu2UlYI2X7sog7v7FWPl1yuLCaTBUzK37zbgVFjmE6IZDGmF0S9PB8yM9d9aaQ/WmNXGvZV9HhH7ppfmWtA3Fkm1bkEN2yxcq6Ko0PL5bYVdh4bMcgBrS9KRm1yltEmEVnNXI5Aw/E6HMqUn7Wky+cn5owEdcUu0cpVVrIEmmJwEhzUyh+TpHonsT7Zh0RSFbMQ1oD7xmQOM6++03JXgIPpRYmEAokBkOeYUh2Uwh6Ydp8pK60n7ddcfv000z3Y5RBduVHwD0FTYAsfujCHXp/wlVcCxjYq/UNp71+G44b2aiFcaSPlrcSxgdCPGQxIk3VU86aOmXyEn2eIGU0e8H61wfuuGD0SB2mC3+ZwYRle1Lv077OkxICciV0CHKfdx9iCnNnLf6821d24iD6Wn0eQYndfLqjUZ8+ReiDh5p9rJXdKNzAP57Ri8OxaIg8W8x+5XmSxPPcWuyKK31rJRZPg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(921020)(10067099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i/Gc4nDFX6vbq8f7Xo1vZvQoBdCuKiTrs7ujZsFAG82oAiL5Z0sTwrYnwCcGOaZtmH+Opz8aVWQ7Kc2UVmmU+Bk3PnX4Prhu06IDEgnvD3Yvakuvn5PGxk4t1alHaSEgvtS3r8giPEy/F33dvS8Bsheu8U5/2XJIgiXbmHcuGZg8nxUQOQYXqeNmmTwlIju0DCXpMqdDf91P0Vmgks4tVHIC8DPIgGIhA0baTuLudyIWcDvYIo0QxXtvGXlQFtqCH6bY6WHyfjdJ7ADv3dVQB7DwllTmKK5kZKqWcn6uyc+iGG3H/csanuve4cQ3teE4IVYspLZv1CyClXJ/1rwkPgyi3ua2l5tMklw4dEk/1J4w/Zi5rmchJmBGQG7/qY1QNX55rB3jAtE3f0La7ff36iX3TEIFJkD30KUrAiwbugf+AsDtUzDZY90I+SRybQD1
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:24:25.3142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cc9e1f-821f-4ee9-a729-08df43e4ef2b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF0000052D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR10MB992223

This series allows the stm32_iwdg watchdog driver to determine
whether the watchdog is already running and adds support for
STM32MP2xx devices.

It also completes and rationalizes the configuration of secure and
non-secure watchdogs across STM32MP devices and ST boards.

For STM32MP1xx devices, it enables the ARM SMC watchdog driver in
the machine Kconfig.

Regards,
Antonio


Changes in v4:
- Add two fixes, one detected by Sashiko
- Add access-contollers property to bindingds
- Drop update on stm32mp21x DT since clock framework is still missing
- Add two fixes, one detected by Sashiko
- Integrate Sashiko comments
- Patch v4 06/15 (former v3 04/13) reposted unchanged, waiting for reply from Guenter Roeck
- Link to v3: https://lore.kernel.org/all/20261106163429.618392-1-antonio.borneo@foss.st.com/

Changes in v3:
- Add support for detecting watchdog running status
- Add pretimeout irq support on STM32MP2xx
- Build ARM SMC watchdog driver on STM32MP1xx
- Use ARM SMC watchdog on platforms that have secure IWDG1 and use the
  native stm32_iwdg driver when the IWDG1 is non-secure
- Add iwdg1 and iwdg2 nodes on STM32MP2xx platforms
- Add the alias in device trees to have the system watchdog allocated
  as watchdog0, independently from the probe order
- Link to v2: https://lore.kernel.org/lkml/20261015154826.1947492-1-antonio.borneo@foss.st.com/

Changes in v2:
- Drop addition of iwdg1 DT node, not needed as OP-TEE keep the watchdog
  secure on all boards;
- Link to v1: https://lore.kernel.org/lkml/20261007151358.1166329-1-antonio.borneo@foss.st.com/

Amelie Delaunay (3):
  ARM: dts: stm32: add iwdg1 node on stm32mp151 SoC
  ARM: dts: stm32: enable iwdg1 on stm32mp15x ST boards
  ARM: dts: stm32: enable arm smc watchdog on stm32mp15x scmi boards

Antonio Borneo (9):
  watchdog: stm32_iwdg: set driver data before requesting interrupt
  watchdog: stm32_iwdg: serialize accesses to EWCR register
  watchdog: stm32_iwdg: add pretimeout support for iwdg v4.0
  ARM: stm32: enable arm smc watchdog on stm32mp1xx
  dt-bindings: watchdog: st,stm32-iwdg: add access-controllers property
  ARM: dts: stm32: move arm smc watchdog to stm32mp151 SoC
  ARM: dts: stm32: add watchdog0 alias on ST stm32mp1xx boards
  arm64: dts: st: add iwdg1 and iwdg2 support to stm32mp231
  arm64: dts: st: enable iwdg2 on stm32mp2xx ST boards

Clément Le Goffic (3):
  watchdog: stm32_iwdg: get hardware version during probe
  watchdog: stm32_iwdg: detect whether the watchdog is running
  arm64: dts: st: add iwdg1 and iwdg2 support to stm32mp251

 .../bindings/watchdog/st,stm32-iwdg.yaml      |  3 +
 arch/arm/boot/dts/st/stm32mp135f-dk.dts       |  1 +
 arch/arm/boot/dts/st/stm32mp15-scmi.dtsi      |  4 +
 arch/arm/boot/dts/st/stm32mp151.dtsi          | 16 ++++
 arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts |  9 ++
 arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts |  9 ++
 arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts |  9 ++
 arch/arm/boot/dts/st/stm32mp157c-ed1.dts      |  6 ++
 arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts |  9 ++
 .../arm/boot/dts/st/stm32mp157f-dk2-scmi.dtsi |  7 --
 arch/arm/boot/dts/st/stm32mp157f-dk2.dts      |  1 +
 arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi     |  6 ++
 arch/arm/mach-stm32/Kconfig                   |  2 +
 arch/arm64/boot/dts/st/stm32mp231.dtsi        | 20 +++++
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts     |  6 ++
 arch/arm64/boot/dts/st/stm32mp251.dtsi        | 20 +++++
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts     |  8 +-
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  6 ++
 drivers/watchdog/stm32_iwdg.c                 | 86 +++++++++++++++----
 19 files changed, 201 insertions(+), 27 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.34.1

