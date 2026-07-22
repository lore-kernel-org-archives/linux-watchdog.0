Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013016.outbound.protection.outlook.com [52.101.127.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6A7481A8B;
	Wed, 22 Jul 2026 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709787; cv=fail; b=leYnZgBencmqhSB5it7p070ksYAiYRJvAss+TL/v+la+sQMc2+q5KcerCIUUmNAQ90WVNTqAwKbnSo24Gdy4VabPTdxIDbbBsa8840blVrP8ldzDcQjdyMqJLmMu9z1b4ATQhGH8dzjEM+sjU3SLiNWvf85qjKUx05PnZgvrxGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709787; c=relaxed/simple;
	bh=YjTSFrAV/wTF8E5WCMQhMQ8HcIFqmurwrjdDZhOdjeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y9Y4kRfDQkuucWyOyWVs5Mpv20JCIPJvyNLen62ZZqyavVlgkgZGDPDsYAHS5KIh2pfuabSVAB9GyS2CX5DvrH38QerhOpLv4Y9mdRmSNMQqH91fhvn64RPXEvUM/1oD8Vq1E/1VShqMpDhBlOXhjpGwfuIgMV3q1zpdXskhNj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kDbo0B4V; arc=fail smtp.client-ip=52.101.127.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kDbo0B4V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O98zhYlbncHm3Lk2asY4wWScBCC3CsCSZ5HRPvrJuJWMEBZXgrreTQ99eRL3b3js8WgcC/9LZzw8VxJCzT0N8kqxJjQnwL4o3JG2K6mELFzJ8LiT+FqrazS7HhKsYRUevYweo07j31nPy0oHGosgYql5BBErGFcdwJ+u3jNYU4llJFcMGqMoH/F5exU+5/RfiIVmjS9qbFqMmd46RRJzTqs9C4wa31f0Y0IFFNU+B2R1HMDsYv0iJ8glaUYpN5UInipnzpapBIbKI+ws4akb6lEVGow6VZFRGZwcnn0sbE/IH9Dg9xXGqBi4ltQBd5CM8RWsgtKHsm1E7ZVCUm2cOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvTOFm2RS0P5DKQa+OSnvze/nSI3I8BajPrfxp3Hq84=;
 b=OSzGW/sNhnn8CVv7ysVJY6u4D7Eihqi1JyWkxPMXg49/EN1TJqdOgKusScALjTRiTznAP6gRKz5FcMG/kaOxGH5VbYkJNL9UCQPoCnolp5VnE4mKNJ+zYr6riAhpvkhuPpfkFY2t7deTRHlN+3IA49hQ00EDnuW3YdC12cGL8NByAZO+KHenSkkeviXgVb/BB1Ouh7o/P2XUkNWNyKA00XfYXJRVgG/DlJqLlAYB2A4BTPKis9Ui0NMFMdGoJiTOKwBmwr4fMIbWuEbVGEjOcWi8IZNCARjyTR/nsPwzI9ibNc3bDLYzLz12fvDonDg0rrOKLXO1w5/SE/Lr6ZSgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvTOFm2RS0P5DKQa+OSnvze/nSI3I8BajPrfxp3Hq84=;
 b=kDbo0B4ViziFIypKLh/QhZshwDuYIVMa4MqHHL5afV9eXOaKG7g5IvaT4VcFoiaSBypPkW2QLXkRoBqin0r9Bcy4k+sRqEnE+Nlh87bAklYMifmoW7Fi6aON8eCX3osRS8u6cnlOaHo1JC11rWYbrWEiN4WjovDSDTDL6lmq11qkB7nIe9QlUGpIIbDz5a9dF1myWiHaRXOiCY/iYgOTrcbDBQcdzkgmLyTu+QOEigzjBCboSAXJzw0WYDJplwfWaIMUiVS49sN4tvkrA/7/1Yu7TKu6jwt5Ym/Wu0li2FKiI7OMXzZApXOTJdeKQXDyyG2xdjS67tug1R8T24S6Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY1PPF6C31DB54F.apcprd06.prod.outlook.com (2603:1096:408::919) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 22 Jul
 2026 08:42:44 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:42:44 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 5/9] watchdog: marvell_gti: Remove redundant dev_err_probe()
Date: Wed, 22 Jul 2026 16:42:13 +0800
Message-Id: <20260722084218.79073-6-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722084218.79073-1-panchuang@vivo.com>
References: <20260722084218.79073-1-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1c5643d1-602b-4694-a676-08dee7cd3325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|1800799024|376014|366016|18002099003|22082099003|38350700014|11063799006|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	vqtZqefLwh5TQwFJVhPbuIsVxv4pWeix/QpjqC0lIcpA3D35lz64xKCFG2wfLXagvyoizYCkoAiv7RQiTPpYjcTFRFmi1YqVQEUQNlY0kVlJMV5znnzvZ4TnMbigQvFus4f1FoLM/VKPpnH3aBjvDWnWwdWAuo69HpUnjO6k2t1QiM2WKDFmU1j6fijM5pKlICNtHrAoM040e1L7jt5BJE3lzR8RCG2OdTKB9YgVc0zwMGcAfnVGomlX3ksoFmbFCFz03k5/wUoiANFlhexXNhygokllBPJg3HuSSgtQgYECRNG3qVm8uQ9YuCNxu2YmYaURfXgLtB5IXi3TePTNHOCRjfvNBo4Ff6DyZaKH4SibT6K8vdmRyOoa1ZKSWg5sR3nc4UDVu1sSxjMXyKr773KjdiT110n3+d3y9PFiZBBFF8bYqWBCVRaFUla12j4gX6jX11T4CbUnmcH6kkafn6ge5PxV1itJW41EvObf4efY4/1a97Nccwq70TCb7OvOBt4uPYi62JHDzQBhE4qXlLh2bndtqiD1pXuFIOOR2ifAO4IFeeghNj4nJsfqA4PNoQiN//3E4RZ5MDEzAeiDJn/xtMlXm78q5Zx58zHMfn8XhZsNpuwPHrl1PWjKhjDX4uimnHIKQhyeUjnWzoj26sAdyPnHMz1/wG790l0CydyHlagCDKw3dabB6gjOv2o59yREQPWiG+Cm4T3bsy3AU5e2S6o+LFS2tBkr4OQU6sA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(38350700014)(11063799006)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lSbuHwkz/mf2Tc7TwUImxqp1Trb+qFtPtNg3RhjCBSwfsBOZOL2pNlaJLjkl?=
 =?us-ascii?Q?OF5ZjLfEyh7Ivam3z3NM83t/tSC/ka4bPZ6mQmBC5Jgs5zoZFTcl3D9Yv4Ze?=
 =?us-ascii?Q?E1w5UvCXPV9xuckQS8x6HeJdySfg8Zd3q1xX2yiYRmU+fFqjxfijWLKPzXni?=
 =?us-ascii?Q?DluDQUj58r82IKoXETnqjfxj9u7I5paUwDhULvICNdRnmONVOsY7LbV9WGG3?=
 =?us-ascii?Q?zhGIM5FeFQJoNEIP0BpN8arDjnWByPGXr8IlzdH7Ai7Z1RILRYEhQieLrURp?=
 =?us-ascii?Q?k6B/TfWGBkwiW5p1p7SjqlIM7Yrdh5e6WE3fpZ6OWHd67Uk9qhy/2szMdVQS?=
 =?us-ascii?Q?CJsSBZ89iv4WRCq5ML0Mbu1ioTW/g3LyRyDLKNgE/hZ4j5b+7fAb1ZAte6A3?=
 =?us-ascii?Q?0ETu7n4EyUYRqq6+XzjoHyKWNag4KrYAVIFDaa0qkFo3AoeVFPvPpnR42X7j?=
 =?us-ascii?Q?5ebiGReMRDvpzVrhGMUZ36E9RFAlUW20g20j9Hjg+Ximb3k+0RfnQU4efw+Q?=
 =?us-ascii?Q?pNJRwC5e2zwz+0ObnrJmGaXnUNT9rdh3ChTSNNB/Uaag5i9B4K3QUCoRNPWB?=
 =?us-ascii?Q?PPgYBn4OOCJQDqsRDVT04rDtplvmNKe/fzkV0pcLDIWbMfrrIWfq0Gb2KlSi?=
 =?us-ascii?Q?cJxa5gEvJKZIzvzHYBUyyvIyKDDCbZ8IxxXqVGvn5nkyHP5TJSS4uFX8XhMn?=
 =?us-ascii?Q?ySyPBIrZVVWzaL+HKElSqjujBWiCuHcFDNwkLibeeOdwMeSF2iGM7rJduRvW?=
 =?us-ascii?Q?6wYh5rBpNG5s/OdBkHyNNMqeMyG0NkQrAuFKpUoVyP4062tgVrqMy9Wn1XSd?=
 =?us-ascii?Q?YKTWmCVLiev5ZTrUFIO586ZkwgBktzaxHQsCqnYTlYD6CFYlbhOQftxYvLOz?=
 =?us-ascii?Q?jHlCbqjiljx0N1nh2HExv+ow5KvXjoOrKOsPB3zbRsd1CAlUiWuAHoiNGvvd?=
 =?us-ascii?Q?oVagVSIxfg14vEeb72GquE2ESgw9IjWg08cRx5jiin4vOiIQ9Lvv8N/rfOU7?=
 =?us-ascii?Q?9gBGUzUy6NHyT+qu4h03cY/Y6jy+E97HxAXca/HoQeaPOEg/K93JMKyAG98W?=
 =?us-ascii?Q?gSDBL5EyNRg/YZ4XJxE9ZwUctIatMGJIEg6c21Uki2Bvrd3EqESwBVEYKxCW?=
 =?us-ascii?Q?YjstR78J5cu1xH08kJP2N1vqOfmjvl/NxaHmVxknsjPkQoSvGxK3Npyhf0eM?=
 =?us-ascii?Q?tPE9kdgkPdyR/a0jfDa2BPqVrOIL6wZbfjR2KTf7P4mx4wuNBCFch855NJPY?=
 =?us-ascii?Q?tRoNwddVZoJLMn2NxIQ6RtJjqvhRki2W1bKxAfkvJKWL2q7u2JsqO2HkDD2X?=
 =?us-ascii?Q?IH42fr68w+sYYJGXhpmuIMF9tdApmwmtPpvr1YjpPsoAwyVngHqqTOsRylVP?=
 =?us-ascii?Q?7zGkCcs3B4mK0fRlMyptkHGPqAIFXdmZVixmvUASXvnMlPUcX3zluuzY+wou?=
 =?us-ascii?Q?BHCs/ETDq/UBj7vER4thAgiEjSxx5Xnmviiv/GmNtWaYnleqHOKkPfmB9Xs9?=
 =?us-ascii?Q?OaI86IEV073F41Bd4Uv8HWbAsJu3bJjdsKHaPI6YMYqJHWqDvu7wsjrq9gnK?=
 =?us-ascii?Q?wLYRTZgbN4HJ8vp00jz9kaK66G1ZWBQ1giSi4JEsJ2EXGCCxMc1Nr6d/44X3?=
 =?us-ascii?Q?9M+wQSgVW8XOcgSSdUwCpyKG330Z3QSvVZHpAzVAPL/lpR3v9KHs8hGT7GsZ?=
 =?us-ascii?Q?VabEYE2kLxN71kxr+4yl/Y1qFbdbpekisMf+1ey5G2JV2lRoU+xDkOm9yA6i?=
 =?us-ascii?Q?yB7wg8DMpQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5643d1-602b-4694-a676-08dee7cd3325
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:42:44.7606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgtx3McGp1BV+K/uKOBgdyk68ObolP/XoFSr0gOFuI0jdTBFWhrxZ1wKy0nKgT69Ymed3fLeHHETCNyOX1qgrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF6C31DB54F

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err_probe() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/watchdog/marvell_gti_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/marvell_gti_wdt.c b/drivers/watchdog/marvell_gti_wdt.c
index 298089d45ab8..31167034963c 100644
--- a/drivers/watchdog/marvell_gti_wdt.c
+++ b/drivers/watchdog/marvell_gti_wdt.c
@@ -321,7 +321,7 @@ static int gti_wdt_probe(struct platform_device *pdev)
 	err = devm_request_irq(dev, irq, gti_wdt_interrupt, 0,
 			       pdev->name, &priv->wdev);
 	if (err)
-		return dev_err_probe(dev, err, "Failed to register interrupt handler\n");
+		return err;
 
 	dev_info(dev, "Watchdog enabled (timeout=%d sec)\n", wdog_dev->timeout);
 	return 0;
-- 
2.34.1

