Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013016.outbound.protection.outlook.com [52.101.127.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6130ACF2;
	Wed, 22 Jul 2026 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709761; cv=fail; b=OZPC22tmOTo91ubLvxhNeEfLZeNaaY6+0p6w19V+9WqRRKIDq5WJSUmtIhk0gwZ0GGGKINDzVjX9i+vVH7//9bfHPiSIEScHpmKZZ748kWuyTfEY0jnZB1087GqJD3j8i0sIdKehPd8M6RT9prn0TGl/DpAW4FjClGDDA4BYWag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709761; c=relaxed/simple;
	bh=j0Hzhrz0KpkU/JbTdwwvsjVLL9vMGFviUSdr9CCaWAU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=g6r4zoFgTLnrX4tA9z2e4EmJAFFM6gddqg0CZaO5TZvYAd7wUsn3uPDDC3Kdrgkuz0NoGWmBPxAWSqFR6zTHB+x+sE47BNbdh3fDCpSHDc0T45vQI3oeAlrJqNdmqzNNAsFvaKYe5/1Pcdym8M9rIqjS09m4N5NWKEUvzMfAEGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=h/f3Dium; arc=fail smtp.client-ip=52.101.127.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="h/f3Dium"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siWRHjh1XQoVx5wnp9Z95pksHptMT0p0iAgNXtQRrFyO77JK5Eexa/3M0Ju+wGdlA8k2L3Je9wsIJUUcqFzOYh4Wb7obdD4xQGXUZPe/ffOD2SQm8uo+ACF2pQ1YkhwCvG5x7H4w6MaqII37TwdZwjmzcV8UmvjiN4R1wNTVPeA7NFzHdv5gTxB9ceyFiHRiZj+OUazaP1Dh/FvxgoPOxkCDyK4A9tyBmzaiZKR6X2bkRVFooimtjq4SwwEuA7GDAz4fkAhPysLe1ecyGCDxBo4Zmk68kZn2JoqxuOEA/SKYLS2z0PSS4R7affVRrRtW9SMBsD6okw9TqMlWnN3ytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FREZyWM8VfEUqtRssBmvcCZRsIRjMsjiffnAM7/TbXA=;
 b=sl0db1nclzBTteQ96jLbwQ23S03dalztqPk6653H8z4++g6Mzj+0eO+7uCB8Ln4oXaXMVuTljXRV+yODNeqHJ+yLFv/TnKZFlF71eGSWF7eoZkdS/FP2FCDwY9XyG7KFg53BDhQYWigqDU60DPuj+3GxieV3qv8YbwCeIMrui7uNbIPmwhF/lKRVwPayPeido3APPex+eppuUbrljJmjp20AB620uVxAZsMbIqM7bbaJpvOxDJ9/X/VmkiNhDI0HVxfbngFnaIJxnXOoln2107FQCBjEVumSAP2JbFwUuqezybQ40iEyym/I2JIkoazjGha1xEpXLcVz+beavbN6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FREZyWM8VfEUqtRssBmvcCZRsIRjMsjiffnAM7/TbXA=;
 b=h/f3DiumtKX3AXHlz3zrHbSkCA6wOWFO1IEUVo4Pa3oj2tJQ+gF3Iq6NCSgdVm3KyUI6qzh+tTHV2NEYX8lU6HOUqLuJa+9JM1c0l5kA4w7CNaYdxMxn3YC51ktt0fsXvX4v21gb5I7oGt/tsYG4vYvr9tyljrW0WNRdll+NQnqhYm/BIPB7RzZOSRbn2oZKAqLSFp++DTg0o/3hNl4fM8QfGskiGeIzxuRCHoEkPuhh7yHn0KgKbRvKuaRDLc2A5Kc1lv4c30JjUIQPMw3+MBhOaCXMadtn94G6qXsDEPJD4cdXbZ4bJAm9ZhPvxwITZW6z5nuv+v7170pRknboYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY1PPF6C31DB54F.apcprd06.prod.outlook.com (2603:1096:408::919) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 22 Jul
 2026 08:42:35 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:42:35 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Andy Shevchenko <andy@kernel.org>,
	Sander Vanheule <sander@svanheule.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 0/9] watchdog: Remove redundant error messages on IRQ request failure
Date: Wed, 22 Jul 2026 16:42:08 +0800
Message-Id: <20260722084218.79073-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:295::13) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TY1PPF6C31DB54F:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e4c4739-4b51-4f67-d0db-08dee7cd2d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|1800799024|376014|7416014|366016|18002099003|921020|38350700014|11063799006|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	OcAKMuvWbeUVeEvZHOP1uJxAB71e075S6FHkkUNrAWiYrsJg75qjDl0XH+N9M06O4/XpShhz2BOPSQYt6bUpPnOy8QfU6UDVuLCxscXpQMySaCts1Jhz45GRJUKsc9xHJsvi//50Vbwu9BI62SYFS1Q5zTVhte2zmVlQbokuGdIxOs07TEIeQ2GZg6Qbv5EasGwHaafhDtYpRF9/gQVY73ixngtO/CdkKBKW+3Ihpt5qvDbrsItfQV1KyjYbeAm3Nd/uftchY5WZ/KETZ4ooOz8qtS1wfE3bBB7LavosiFUBzhdY9mHbI8NMpzIWspU6yztNcEJkdyqqjNZM8lg7I0udTAJAk8moIIrr5SEUdFhfq28fa3CloJvqLHM1lwMrao8asl8YJTjCJ47F85uvmA9U8RvBJs7vMj8MSeDMsmCn305Jm0t+2Cg8OXcON6HziEfBmKGaABEw9Q4SWL1pyFYe+nhfBLWVSmdDxUSq5cREsMh5y4ZZz/wAUXXgDmk8VkwGS8rx0oMUauIUMU6g2IZPo3lY6XbgaMwcpubB1OqqyHRTEJ48kyqY5wBIJDyFJaJLPvL/8B4ZU7p9frxEkuEbChytVCYv06RDUqjyCGbxW+skX77APBT/a3CSXA2Q69k5yLO5hzYZVhs+JKMeLzTXmr7UZgF88mqSqrERnJ3JKRmQBngLzHYpYFHEcJUDpdXWdqytU6eEPVxOBndbfL1wpPpjaJB/XfNcswnMrKFO4uaEGoVYX+2NXl7M1s7w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(1800799024)(376014)(7416014)(366016)(18002099003)(921020)(38350700014)(11063799006)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yyf4tc3wSDutOPMFViBHozphl1C/FOTyd+/jpBj5An2tuhJuYS6opEydwmIH?=
 =?us-ascii?Q?ObrreIDQVJRi42iXXWsCM/bkk6DJA9FycU1hZPxXe4nS7EkKuF+xsFgaMGK2?=
 =?us-ascii?Q?gnnvJejQ9CJNT7AfjaWfVxcglw6cyx6jMkRlIMYePoPcnDGfjJxPM+KAHoPJ?=
 =?us-ascii?Q?dpxpxcHqIft65MFk8DM1AFC//sfLqokL08j0k85M8Z9mfTMynbASlnYz6T0M?=
 =?us-ascii?Q?ft/pjYmR3Pq1egEYu4gBPx90riXdinGAQwBeqcojNKrUJVG0RFBwAwnPRBG1?=
 =?us-ascii?Q?tGCz450GiZC9YDxvdaE97HlR4D1Fl2v7C5r6TFnFpDfSm5mQ9/NjyLBji3Kx?=
 =?us-ascii?Q?+QTJ4i93EjjEILrV/hhHGsodVnpiLL+/jACSpC0rLR10i+rzqW1F8MgouSrC?=
 =?us-ascii?Q?+7a34Pqc57VPgF+MoEWR92sFBP+hpk76suBIdWlhgYZzg9nin/+27cE26hjh?=
 =?us-ascii?Q?belvevfGMqjX6n5nGH7vxoeEP/+uEeHLBZ5JOuegxojTxeFhX5J0BvBdumKv?=
 =?us-ascii?Q?wdOQ9XUWNzLW7uGE/TB78Ts4e691DxOqAHazVBTK49Tx7UVNvWP8M1v10w4M?=
 =?us-ascii?Q?Ay6p4IrHQIN7t/BBRIW/nUdWr38AilIe93B+Z90hgIDaIKpyEMapLJVnlYIv?=
 =?us-ascii?Q?lPfFOYvpzdg4qxt6mJ+afxdRc544rf8zaEH1HEqVVdVavCCW0jxa6DRJLr2b?=
 =?us-ascii?Q?yqhUO3ecU7q7LumoK9yhwhFuN1lRbxo68oRnTSEfgVMCd+oYdkEcSv8/xs29?=
 =?us-ascii?Q?Ms4p28UqCaN5iYpr7LA5RTlhF+QJLWjnGLBhjICos2Y9TlbqYm9/zUcMr7vp?=
 =?us-ascii?Q?fGd1wZpvxTLlewuGAV3fg6KGr79+41uVosqw5KtxlFJTcWIV0FVv6e4XubD4?=
 =?us-ascii?Q?jNNj7cyrM3eiml/WotQegAuTl7feL0lQlNvEiYb7NmnHdfqeV5QblZvqt8j9?=
 =?us-ascii?Q?Xad1ZshhTo3OB2QVi9BfGnQf4fXhppj1nqOtMzOaD/jnCk0IJB8U6mr5DhT3?=
 =?us-ascii?Q?91+9ZWsGpMMBkwusXl9zb4+E+cPAshb51LlgFGm+QG8JIdnPGCSjA4b9LCkM?=
 =?us-ascii?Q?1Qcr9jtWxeumUSGXCmb7SaB88lsHYe+NeQiRc8pR15S5hLbQ+1PjlyAK6A93?=
 =?us-ascii?Q?Eo91tGNDkFYT9R3qf++VguHiVQUTFDAoac5vsUkxCC5dTJX8NYyqXrhSkXzb?=
 =?us-ascii?Q?giJTwi1Z2O0kR7I0jgKrgDcveZj7NA2bZahqqR6h6fvV+UG/Gnve2zozsxco?=
 =?us-ascii?Q?d0tf3rssCOhrkAeFzzW4/dNsOV9Bj+BsZ3LRIUjNxGWCbXUn1suo0JFU8SBb?=
 =?us-ascii?Q?ewPFb+a4tR8zoMf4nXwbu4jmMFfmYDUSPMWQY/tTEHtLsCLbK+hOM5InsHad?=
 =?us-ascii?Q?3IEE5CTMJduPGGDl34XSG3LCktO4j8/3qyotggLyUTgInXh+4UzpB5Z+FlXU?=
 =?us-ascii?Q?HhulpAWYnA+Zdh2W5e3PPqzb9GUcaD4z4kPyhPRXK86qDNZDYIlbmoj1LFqy?=
 =?us-ascii?Q?G8O/CLrvGIqkAN0J/615qTV9wbyQFG6fzzbvdajtO0AToYY80v/lUhMaz/88?=
 =?us-ascii?Q?hLR0zPjncOp7HFcKVTEGLGsOFsRoENd5GAGfZsX3lFnRP/RJFnO9LqdBWrws?=
 =?us-ascii?Q?y3pR9rdMI606bxDtqkbFhAdcBETldZ/hrr4H7b0WouWsiyZzV1tVXWTiqOtc?=
 =?us-ascii?Q?/y49ZkS3x5StWmoIrNRNlBc9duRzSSZNGGidNzmuCV2CHJdPOubb+jc713Ki?=
 =?us-ascii?Q?Q0kyCN7NOQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4c4739-4b51-4f67-d0db-08dee7cd2d4d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:42:35.0078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsjCMdrgClUPazrd7CZ8o41xFiOkXbxbojl1HVJfC3nJ+mKT8pEKd8BqGLII++gJ0PDifA/KmoDuW4iCtU3MhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF6C31DB54F

Commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()")
added automatic error logging to devm_request_threaded_irq() and
devm_request_any_context_irq() via the new devm_request_result() helper,
which prints device name, IRQ number, handler functions, and error code
on failure.

Since devm_request_irq() is a static inline wrapper around
devm_request_threaded_irq(), it also benefits from this
automatic logging.

Remove the now-redundant dev_err() and dev_err_probe() calls
in watchdog drivers that follow these devm_request_*_irq()
functions, as the core now provides more detailed diagnostic
information on failure.

Pan Chuang (9):
  watchdog: bd96801_wdt: Remove redundant dev_err_probe()
  watchdog: cadence_wdt: Remove redundant dev_err()
  watchdog: intel-mid_wdt: Remove redundant dev_err()
  watchdog: keembay: Remove redundant dev_err_probe()
  watchdog: marvell_gti: Remove redundant dev_err_probe()
  watchdog: orion: Remove redundant dev_err()
  watchdog: realtek_otto: Remove redundant dev_err_probe()
  watchdog: sama5d4: Remove redundant dev_err()
  watchdog: sprd: Remove redundant dev_err()

 drivers/watchdog/bd96801_wdt.c      | 3 +--
 drivers/watchdog/cadence_wdt.c      | 6 +-----
 drivers/watchdog/intel-mid_wdt.c    | 4 +---
 drivers/watchdog/keembay_wdt.c      | 4 ++--
 drivers/watchdog/marvell_gti_wdt.c  | 2 +-
 drivers/watchdog/orion_wdt.c        | 8 ++------
 drivers/watchdog/realtek_otto_wdt.c | 2 +-
 drivers/watchdog/sama5d4_wdt.c      | 4 +---
 drivers/watchdog/sprd_wdt.c         | 4 +---
 9 files changed, 11 insertions(+), 26 deletions(-)

-- 
2.34.1

