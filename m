Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020137.outbound.protection.outlook.com [52.101.186.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8362539658C;
	Mon, 23 Mar 2026 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265145; cv=fail; b=D9Zm2wSpvsZdt3HOyfeMFPV8cxFFr0qhewUoISGkyKp8jZAlPl2SFVbkm/oI2zwa3EjX2zI8jSIOyewH8kU7e3RvrOvszZgsDV9HVrlyLZdZrqZKF1qW7pkoKjAiqdQW5FTFEjXGngwLikLjHL/h5jUmjfY/ydxHhheg0jsmkA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265145; c=relaxed/simple;
	bh=F/r4kE4sVQ2Kk+gGLuVrYGX5lWff7fen3hGJgwpfMHM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LM0e+E5yvXBzYhju9iYa5Tx0D8Kc2WIaGJ2KsKgbXDZEIvYt1Qc94g2iGQor6ffFhchZ3Cbh1TY/f7KYlr/AZBSMLYKNhy6aEExFiMTS1NKyePtmxLczZR98f/nMvi6ULCzdYOHZt77UKe4+tlSCA+Lqv9T6eaA/4y47aab9Cbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=Brl+Nlvw; arc=fail smtp.client-ip=52.101.186.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="Brl+Nlvw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRUfQi/n8WC3j5rivkOG4NsNV8RNT0tY8t0rOuErcMqfHJKzQe97yCzoTYpZD75g3V+Mc4kNRsWbCSF8F7UccegRIfU6Ndm4c6s7WL+qzXjrVFXVYom7RXRbfKYaWsn4n8Ia7DDAdEAKKNA1+lbL8HvnDSzOgBsPPyPYgNUFXMIFs6Z0YXMYfebTfVogl8QTSfgxAwUKayfaQQY8vd/tQACVymw0uSRF9Cw0WN6ZTgN2vyQt4kaoGYnBXT2MpXOapbXtB4Gkeh2Wz0JbAJknvH5hwnlo8/MWRYLkizTNWanZS90bKoSzC9+JIe4Kbsy18SfseJoJsDev+Fc62ruIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAbJyLgl+5nNVDf8f5aRjjTeEFqjYlbDdKDHxoKVyqI=;
 b=kpOm2Dy8dARgsEpEyc/2EzGCaSIRqD1g4lSaJUjReyvNqx+60wJ6Gwekldryf3nmb0u6cf8Xhm83JnNUziE7A8ipoguObWWVR497t7DYrSH9QOoWu0Eli6xkMgG9K6yDXky6oNkRb/+Ftl4olgtLNdvYwcClvXturVqRjZ2B8i3mHJPclUsPRkasBG/8UnxKs+XU6WPD8TtNDzQVnDaiuHcbicu1QHoD5f64gJqkU9V6KHC2THheeXbwDBadB0ZinffrQek8VoA1i/0D7rNlPAXmJ4Ue8307oy8LLBexBDonKjqbBkmeMeFb9v+R5hrjNzRcV/hAULYkmsXcdvVQrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.0) smtp.rcpttodomain=kernel.org smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAbJyLgl+5nNVDf8f5aRjjTeEFqjYlbDdKDHxoKVyqI=;
 b=Brl+NlvwVoxnH1kiVSE/7EBoC6RzJ/YLqhSwjO9TIiYJo+e7z+MDMrwtkXaeP+iOcKEK2vawVHcBdzFvdNitx4tA+NBGfpmJESTmTylHaeT0glNFoH0kR2uO7N45Zb8/mg4njOMwe3Hc1SIVPqwFgRi/oPtAEFC/6/rCLfqad+w=
Received: from DU2P250CA0024.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::29)
 by GV0P278MB1961.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:6f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 11:25:38 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::70) by DU2P250CA0024.outlook.office365.com
 (2603:10a6:10:231::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 11:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.0)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.0 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.0; helo=ZRAP278CU002.outbound.protection.outlook.com; pr=C
Received: from hz-deliver01.de.seppmail.cloud (162.55.72.219) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 11:25:37 +0000
Received: from hz-glue01.de.seppmail.cloud (unknown [10.11.0.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver01.de.seppmail.cloud (Postfix) with ESMTPS id 4ffW7P2jrmz4x0w;
	Mon, 23 Mar 2026 12:25:37 +0100 (CET)
Received: from hz-glue01.de.seppmail.cloud (unknown [172.18.0.4])
	by hz-glue01.de.seppmail.cloud (Postfix) with ESMTP id 4ffW7P2bV0z20ch;
	Mon, 23 Mar 2026 12:25:37 +0100 (CET)
X-SEPP-Suspect: 8b2ec3293b3a4bd2a17a402f4fc76b71
Received: from hz-scan07.de.seppmail.cloud (unknown [10.11.0.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue03.de.seppmail.cloud (Postfix) with ESMTPS id 4ffW7P1lYZz1ycX;
	Mon, 23 Mar 2026 12:25:37 +0100 (CET)
Received: from hz-scan07 (localhost [127.0.0.1])
	by hz-scan07.de.seppmail.cloud (Postfix) with SMTP id 4ffW7P1BC9zmWx;
	Mon, 23 Mar 2026 12:25:37 +0100 (CET)
Received: from hz-m365gate03.de.seppmail.cloud (unknown [10.11.0.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan07.de.seppmail.cloud (Postfix) with ESMTPS;
	Mon, 23 Mar 2026 12:25:36 +0100 (CET)
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010000.outbound.protection.outlook.com [40.93.85.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate03.de.seppmail.cloud (Postfix) with ESMTPS id 4ffW7L71L3z1wTr;
	Mon, 23 Mar 2026 12:25:34 +0100 (CET)
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 ZR1P278MB1170.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.31; Mon, 23 Mar 2026 11:25:31 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::30b2:3be9:48ab:c354]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::30b2:3be9:48ab:c354%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 11:25:31 +0000
From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
To: jth@kernel.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Subject: [PATCH RESEND v2 0/1] watchdog: Remove MODULE_ALIAS from menz69_wdt
Date: Mon, 23 Mar 2026 12:24:12 +0100
Message-ID: <20260323112413.21923-1-dev-josejavier.rodriguez@duagon.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0053.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::13) To ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:34::6)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0523:EE_|ZR1P278MB1170:EE_|DB1PEPF000509FB:EE_|GV0P278MB1961:EE_
X-MS-Office365-Filtering-Correlation-Id: 238af40e-ab2f-4f5a-b6f6-08de88cee896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 M235+KNfTNthdCF40IHah4TFQVa2djrz8FyBOrU06oCO5CVVz7aNYn6whxD0naE4Q4pswLQM/mZBbg7ZJX79ZWk6PuUpOZayzU8Oga5MVWW91QD6rVUjsviMetUxnxD3x3Xc0uSUAHi1QnxU9wWybQILwDZ3MEPVXa9KoAQuVh1/EUS/MzogOZrpS0RQs+uOCYzSncSNoreJx90jzNPswTAheKqUv4Px53ZRSPt1AFDJvXddnygE0NxLnfeXV/Ih3Q7jaiVsh4XKLeXAQZRfWSxCFrjQdPPZOvVtfEQU28gEjPIuAK1lmxrSRpOJuB8GWWKDfyI0OpgtLhmKNj9DXLkpwmF2lbbeltZA20yIfi0tb26aj7bRgPeJhjkHU2C8nm3mVA3xdItbSK9emmRRzJe3ImzpRvONbE1x39wvkNilj0zR5ZvnKnCcse52aiw7SWBsXLUBgJJT0xRa8nhmJEWf95n9+aa3PlOuOwPoDcouIRhQryWkng/pY1lZN9I5EHId84O9FhmoXCn7wBdI4twnJYicpFynDGEulWSg1Def8m8BAe9Xw7r09adpSkyg9HVxg2Mn6Ix8AsojbOk5aIShpxsWIz7oODVEpSk1FFmsDicX3pwfg5StszX18LxmnXJFINoWo1eMzVzfZU4KeP4cA4TM+glNFa3ObDmYCSycAl7JXvwgdbwNZmKx4+WgzHn9xQYJH1sY68qfFnRhhi6bPPl1B9EJaN1ZxV+WW2or51V7Z13yDshZctgmX13TK/j7QIvwd6J4KaFXrJGq7SXVH6hLk1BStE7YS+IpG1w=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 IwcsY86dPuCjI8hyuHdulzqpIZF2UDdVOooT3YZkMSCuoR91fPqANU3qRFyQBemN4bCUPXDGFT3SaFKe5O2cYshH51WxEDTo31DoJcdKjZ41JfqptDDnT9dCX5UixHjB4hN8FV7Riev5/gNzIOMa3CjbdHnzQBoaef11gOWB1juG5o4XIx8aPnLVFNFtKN1MAONS4NkQtwMMWtoMcAU+c8I+BhxGMaeS4tBAuO2y7kfgYDXp9YVlKtxJq4/xGx0YR5oV5n5EMwg626GlJwuFzNHn20wsi/9c4N3pMwi95SyDassjCTn9sa98XlI0quMD+hozDO5D/bjxJUCM4ONUVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1170
X-SEPP-CCCVersion: 2025-12-11T08:12:51+01:00 9ed91da2
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.0];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.0];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	bcab5c4c-1bf5-41b8-8ffb-08de88cee48d
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|156008|14060799003|36860700016|35042699022|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HqhM/2qt0tCfsFSIOHqwCsANKbLrH597EB5KEoMSrHc3cLVT4GOyzmHDfqJq?=
 =?us-ascii?Q?ClDNFWkUIDBoBWYChhcZip3eXb2kTCEsP0yl0nTbm5kGAJik9NrYZ8VtL46C?=
 =?us-ascii?Q?B4396t51kY8ajnhFwJm9QO24/EIt6YLuJ6gTX2d7vEAF9JVYqgcxv58d9Of9?=
 =?us-ascii?Q?1rDN/vhKbc3PIytyrXBWmrwujtUyKASEVvHqWgiKldNp8qjzk1TF6JkGpWYe?=
 =?us-ascii?Q?eIq0tBt95NL2i6o+NU5Jds5fa/tBwzQxhwsW9jmvhPdnSiOJgLB3C41ps5lK?=
 =?us-ascii?Q?/ubwAHSmHfngmU6oTJcoWY4K6shlrKTth1DEyhy49Aj0YnRj4250cf4wXUPx?=
 =?us-ascii?Q?cpZP73Qv6Js5jGQksjJ/DbQr6b90KpYFEj4nY8+QTfY3nSzcDPSJUhmbfZNT?=
 =?us-ascii?Q?UAwlmolozKAfLXOhc5SlEGcbk510fgW0apfAqmlcSduYqpxjgzGhqr5snIbZ?=
 =?us-ascii?Q?kq4PLj5HKuefIMt+OWkAgX5/AEbORaCb1ksuDQeO+FIGt9KhOg2KbM+xBsFR?=
 =?us-ascii?Q?XDiBntrzOdKvlXM1NxlK81EPSwM0ldPc4Qn67oFynuskAujOiv72mE3A6wJ5?=
 =?us-ascii?Q?CQya0JOkftgBA+1SNE6YF2jjy3sIQz+fquKcFsE5zpUOqj1wAPW6fQ763YOH?=
 =?us-ascii?Q?uSI2TX6GP+MeGMaVYQpRMmwO/a5bE9rsn//BbdsmPt/DD0Qjp90dtCi4XT5D?=
 =?us-ascii?Q?CeQAqVYk0zxSdu/A0lG0AerMy3PA+7fFW2Yg+ZhWV8YKuDBSChir2XYQNqx8?=
 =?us-ascii?Q?BqVuhMoA8TObe0e7oCoXcaCPlG5Tp49cM8PF08sQG+1DAFTySOnjevICJDAp?=
 =?us-ascii?Q?lZsK5shHZpvFfmUVJ7+STqH5N+V46NOMUuuDaJU7jdO19tN/toneBvfzKTJc?=
 =?us-ascii?Q?ZuPYR9o1GahOxf3cHTOFfnsNKJFWBhkTQ7magg124ek2x+sVNGfKQRDw7HRz?=
 =?us-ascii?Q?aDzSlrTU/gQPa6AUIMR9gT3IdUPDLX3tqIbrlPgoh/jfPNauuHXNNkY24b9E?=
 =?us-ascii?Q?Zn+xbFnQ4QLlyh2F/JiBMUl0QagSUOmvRRg8afT5zgtKSQkljCSIqH6oSwkP?=
 =?us-ascii?Q?9nrBKiKl/2OXTqpDiSn0Foxe7kRadLtuF1aGbMmqTy7HTFZnV2iJzu3ajZGG?=
 =?us-ascii?Q?1gDjnBee45uXJ0MMmsNE6YJ14OMrstFx10ypkqXax28SL4tOvFDuTw/GR92E?=
 =?us-ascii?Q?r6nOYGqdgVl7gNgxTaTaB7Lr/ZEFGgXM1C7qhw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:162.55.72.219;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278CU002.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17010000.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(156008)(14060799003)(36860700016)(35042699022)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hGwJ9u446U0REsznGhdNwDqihAf7vBa/DMGaZ/t9l7v7iN6kuhpVZAFA17yB3H+WyjJJ0SN7Lbs22u3CJYMhIYUM37nhsWl4M5TjKIP04yC2TSP7GsfSMlUSoz338Tx6ZHd7iu5Mvv5fLnKh3xjv97c1NrLSwegav9LvUD/PCLTbZY6xeBdRsYfZ3AYrW3mTkDBVk4TY4H2gEz5s5y2kUatoSuQt9g6FBV5T09z8OrB8dGYLELFb8dsQc4hjJCZCHWX8bX1F+UGgeJW5JLg+Tbn3RFMuXtA6szFi5ndZfX+/8tMLDeFmcGReLAXSalgh16eMUOkd72iiPzny3asm/JCQYPT/NN0NJiSaYwyZp1mSTdaq7iQBghCuQCT5zBom2f9cxshHapvVvszLoXM6qmHHWZ3CtkUf4KwNwxhVYY2a2ZjaVxYx2RjekESi/WJt
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:25:37.8812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 238af40e-ab2f-4f5a-b6f6-08de88cee896
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[162.55.72.219];Helo=[hz-deliver01.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1961

The first patches I sent for fixing the autoload problem encountered
on mcb device drivers were 2. The first [1] was focused on updating the
modpost process for letting kbuild to access to the data within
MODULE_DEVICE_TABLE and the second one [2] for removing the MODULE_ALIAS
on all mcb client drivers.

They were rejected and Andy suggested me to split the second patch
in a per-driver basis instead of sending all drivers' changes in a
single patch once the first patch was merged.

The first patch is already merged on Linus's Git repository for 6.19-rc4

commit 1f4ea4838b13 ("mcb: Add missing modpost build support")

So now I am sending this patch for removing MODULE_ALIASon all mcb client
drivers as it is no longer required. This cleanup is being sent to each
affected subsystem separately, as per the review suggestion to ease
the handling for maintainers.

[1] https://lore.kernel.org/all/20251127155452.42660-2-dev-josejavier.rodriguez@duagon.com/
[2] https://lore.kernel.org/all/20251127155452.42660-3-dev-josejavier.rodriguez@duagon.com/

changes in v2:
- Renane commit message

Jose Javier Rodriguez Barbarin (1):
  watchdog: menz069_wdt: drop unneeded MODULE_ALIAS

 drivers/watchdog/menz69_wdt.c | 1 -
 1 file changed, 1 deletion(-)

-- 
2.52.0
