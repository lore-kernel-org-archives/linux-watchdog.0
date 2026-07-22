Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012026.outbound.protection.outlook.com [40.107.75.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D513932D9;
	Wed, 22 Jul 2026 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709781; cv=fail; b=uYe9c0lrNoKSQ6+JARuU/gOhcCKw+IyELz2gVimY1BoDMGUKQczPxeNv3Fr3h8/Hqcz0Jz0HmBBGi8xuuaIHF6tBHlMkfnZBUnVTcqk/mwegDuHaGmgUOPdaQUXR8IHwLfjWOGhoIReeJ8OZefDt5J4vtBlK7IPgiegxSGCV0oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709781; c=relaxed/simple;
	bh=DUDlH+CUQwtb3g4l4VnjGSHwn10Ek4Jz4IU3yglKaF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dl1rn9yWGkscxrGAUZiTYD2vv2q2w1gDvhZlQrCPOHzVnHRN/fTTQJEexQ1B6cwJhQMDjYUadWhXXKKE8CNrY1WvHd5tH1D1G5osqLQRV5spnaTBrGEqwpgUAuOtPh/efAE5B99Wb/DQMlsqgRAsz/zjQu9JDos6eT+IOfZVMus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nMSjl1NZ; arc=fail smtp.client-ip=40.107.75.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nMSjl1NZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYSqgh97UfjC6lzW29VCQCrqqzACpZTf2nYBOyf1X+hWtiCui2jQEfE5fOBlmq2EvxPigOlqpb+17ujeV3KBNLxvaZXG93ySaSl0MxPsx+wZI1jD/tNYArywQjnicQCn2MaajXLsvyUKa6ipSAkR+Y8GRcagSLhvoNw7fpjJ4YUtLkSEZFuU5TWaZQEDKwXCLgjy5nWjeQWvouzzdGZCkIp/ory0kflORWk8Q6Qd7npgitGyiLaozVI851Dmy7jAqjPZDJ7CLpLEcIlUYnNPn4BeMfmf/vR6guW3fvDSuvc9VOluqo/PMNTsV9/oKEnfW/ma7lOrwN2TAJ1EOYX4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMMGSemNZTgnOS33a6vIHkfpchw7ehIhmPcfAZWLEb0=;
 b=DTUG9rfiQm6Jd66bh9JLc5/xmhgbzCxRG8WzgsD4ZBKKVlohY+cX6P5rwALl0rD7o3nzg1rskTJWfkp3iPcDwlPxMae6WO/JqNGpzcmQd65fHFJNaIJ993hwZIx8BVyP2UYkXWK4XrjMnOZ6b2atRyJI9iD+jkN8qO0IOt5oecB6gJ35p0HtZGqesKMn86vOOkELRKb3bqZBMmaQp7vZTI/N6u5oyre15Xo38ArMxyV7XM9Suu3XS/Yb7vbwGASVTf5j1NhKpg/0JG2eY4naPA3gBwwMfkyDr8JZy+KUwcelOkCVM0HGO2QSEfvWatakKLJPYzHrSb4kX0PNimfRPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMMGSemNZTgnOS33a6vIHkfpchw7ehIhmPcfAZWLEb0=;
 b=nMSjl1NZ4m6kIEQ96PU0pvQfX9Omtkpfz4pmaxWjO8QdYRGMI1P+t/4ThxiN3s/4FP0g+rGqv2Nl5WOIWNWUCe1fvtorDgqbsmMx09fobblCroEsFQmOj2LA2OT2HSgJ1GLNPAKPEy3X8bUBEX4p1MtnIcdwWOH4kpp2LYGp8ZsSEA/BJ1SaMj34nXpdwIWiPB1N9Qh0PR8kLV6Tb6pV+t3z4hOHdUdOXt6QSB6iGj5oml3eaMB447NggnlUU17EdARQa06+d/OCtfF2PH9vN9jB177A942m9k33/G3559RHz11bP+4CSybQCBl4ANvh9uzDN+dxqVQMhJdjUEZysg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEZPR06MB6037.apcprd06.prod.outlook.com (2603:1096:101:ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 08:42:49 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:42:48 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Sander Vanheule <sander@svanheule.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org (open list:REALTEK OTTO WATCHDOG),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 7/9] watchdog: realtek_otto: Remove redundant dev_err_probe()
Date: Wed, 22 Jul 2026 16:42:15 +0800
Message-Id: <20260722084218.79073-8-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEZPR06MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 201b7426-6a19-4b0c-3cf1-08dee7cd353b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|23010399003|1800799024|38350700014|22082099003|18002099003|6133799003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	X0mFzrMpIGR0wjBAAUmGLKH1n8FmRhssB+w0+TpagXMsW7PBs6+SLba2LklIk31JI5IDg5F8X/LcpFl0Em7oPYdGulS0WhHJQCu0VaVFiAv2g8TJL3nfUh+Mz1k92fWY0sIRtIHL8kRYTgsEqhJmyyMYtLw/jUY/Ppfy5wi8Mjl9+K1XL16XmpKXXUZZ6buksUZNMaiaDtlZaqHZ2iCQDtVZ4xNL7bDuIe0Q3IlM4mBMEuvptvpcFPRnaP70WAfUL4CCmwUxE+zFt84xhrEuELVRqrw/EJcDZcer5tIu6iOa9rWmV9xloXgnsdFn0ryOp0sNq2tJLD2HhflaHAQc3dLFF1GHe7kvSipVbtOLdOVRUh/AHt4sQb+YucjGfKPJjGR2Xv27zj+lWS/Z+y2AuO1zv+XWtgdFeHzSRVJjDrpyhnC/L5x0waXjKEONJxI2wc7g0nqvqOklO/XECIXeIKJjexkMm7+ISB6MmrWtED49DbikF8izwRgfRiIZYsmXK/nMSXvEkCj8PA7qaIDyFEmOoQaMUlKgM+YUIEp46XoZNQAQ6HAHo7EZYaeQHV2M1ecFnfnlp8M3q0W7uSqLT2KdWD6qrHkQL5SE6PPEzqqzjN6/kAns0a2SbnLNFB8iItdyMwMEtV7uT/DMHn6S8s6/LgvnfRk2wbQsaAcghccrTFgYUS/ifBjEKWB6tDyBdl+rk7IDnd/wDyYrlYnOp04pB51WPMuDFkPrl67Ll1s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(23010399003)(1800799024)(38350700014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2RuD7ZHY3m2ZXKV/f1Q10jP07yvbQCaU2E0+IQMURHtX5QMRexi2aDyCDt7g?=
 =?us-ascii?Q?lPGHulBjV6pS+GTk02m6W2Tf9rz6A3JDUgphUqXoiDwCyhV57SxGdCWclrqw?=
 =?us-ascii?Q?t40pHCo3moStFy8nnK6m4YNsVPoMskGhat/vBpCMd9CNaEv6MSHVgp9r2JeB?=
 =?us-ascii?Q?DnWJugtZU1fGkWsccCOVWFKQG28YkKU5eg4r2QIgcsMEDKTn8nD1VQEIScbF?=
 =?us-ascii?Q?UDP1imYk+wCZm3eOLdCyHwT4earF8ZZPy1JDS5bT6Rnk9z6hCYUrIs9WdjUQ?=
 =?us-ascii?Q?7MvDBNoirj6jkKHhROrplzujxXd/pSSUwLfXyU2CEXSjGdRULjQmUPJ0lQWm?=
 =?us-ascii?Q?pzC52nGaYMCvbUzywm0Y1RfYIT8V0CuRCkZ+E+NebfDeIOK/Fx4pDA+BJNZn?=
 =?us-ascii?Q?8oB0NyEddUvSzApHxoYj8sn8ONPPiqt3fowI7TvqHfc9Nb0jDE3iW1dvO1iS?=
 =?us-ascii?Q?SWxzZadClINbOucat+WWCVTNF7eBOSKwVJGNU/+9ZiIE+OyjlyTCzenRy01X?=
 =?us-ascii?Q?uuQIDn+D2Sy9JXTRIz2qJON4gYir31XTMkAYf7SeaSa3u41vq3urwqrbuT4u?=
 =?us-ascii?Q?m1XOYwxABwKKXlcEqJ0v24RpaxYtx8eEc/D8TrlBDC4GwzyNpGU03t0OIGxK?=
 =?us-ascii?Q?8DwZbnulk7LlPVg54Ftxl/VdtcUh080dZNnmGqG5ZtpoekqLYEH4wpuKMl5R?=
 =?us-ascii?Q?fkJNr8YR54ij2TqclZcg1QjWBIzrZs4+lI8FXRqOaPaEb8nqgcuJXsMZ+tvL?=
 =?us-ascii?Q?eoYfHtcC/Ro8J4KZSeamWkc92QZ3QEUoFMBomnDWVNzWQKCkOqu3nFzr7KVV?=
 =?us-ascii?Q?AAij36t7aRiB9yN6FJArP3lKBz6c+RPDtVsZnQC2lOM3DRmrUVgV9ZIP59Aw?=
 =?us-ascii?Q?y0nK+/K1xP+KS6MdO3CGrQP93CaeN4rPeQzYfYaDBBVxnrb6xS4qerYnCxbh?=
 =?us-ascii?Q?n2xFDmX90Yfu6KFkXvFTWIN34pTYWQnFfn6WNPe3WUcFslx6wHrP7eO2hCwx?=
 =?us-ascii?Q?8f6gT5c4FSLjIU+4mSeFKEcxGvV3OIHNfbqFOPcr4Wz4Sv8g2U2Gz4Le4yXg?=
 =?us-ascii?Q?DfIsGWQvH2MHj6xRpy3r0WtsQWf/NcHfC/v2uvcwtVA+XSxVNJxNPae8VTr6?=
 =?us-ascii?Q?iXR1MBrdWzry4Q6dDuGlq2wOJ4xW8RASQQMKFWw6mKgDMqUnnQtZRgYMV3yI?=
 =?us-ascii?Q?UYZR8kpk5LoLcRt2vmnYfIn0umXnQNePWSEd+R9hac9ERfcyG3RGeSu8vaAN?=
 =?us-ascii?Q?It0hnxoO6F8+7BwyqkBGzcVgiRgHCLxcXYJG/YvAdlAkT0U3x0SSPl3va6Ha?=
 =?us-ascii?Q?663agdmLf0pNmV0uu/PzJ6msqvZE028XX3f9QU2t4pHsbUHnU6OdGw7kuaGd?=
 =?us-ascii?Q?AKdTaUHhmBuV4O01Q/NL8gg2JM38dQF70rzHTjth9hRHz29UcqRD3E1FoXJ8?=
 =?us-ascii?Q?v3U0glJQ9FoOTZcgXT9tybDBgXSROQhAYcFLx1J4qC0jJ5zxiSHV6cD3Vbw8?=
 =?us-ascii?Q?L1OInY4trJpCNfGr690rcPAVosPk3lU2Z8xGGzEb248a3TG6p+v7bBuZtXDF?=
 =?us-ascii?Q?wbX0KBm6+Y0ohIPifp6iwmuGWtLS1DKwPIUWl5188WOP1FqRBpa5/Ysbhhy5?=
 =?us-ascii?Q?KhyEGaQ5XANvbtS5fy2RNJJjMqZsgY2eQ/4S1BQtpTguaub9Uhle7s8b3F5t?=
 =?us-ascii?Q?4qYuf/eS4xpPWqh8a1oRNxeTdV9RxcK3Em9//1jyrln6/w3VtQrQzGIXOkPl?=
 =?us-ascii?Q?III/EATvUQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201b7426-6a19-4b0c-3cf1-08dee7cd353b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:42:48.2702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YJ0dhcCaPtJy9+aeZkumCGvr2aOECINb2kCQ38IS4XsnSoTVQ/SOYP5Xz8APm7HMNuqhJqBWCPimvmGij5JDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6037

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err_probe() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/watchdog/realtek_otto_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realtek_otto_wdt.c
index 9094f2189f55..a07bcf1de7c7 100644
--- a/drivers/watchdog/realtek_otto_wdt.c
+++ b/drivers/watchdog/realtek_otto_wdt.c
@@ -311,7 +311,7 @@ static int otto_wdt_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, ctrl->irq_phase1, otto_wdt_phase1_isr, 0,
 			"realtek-otto-wdt", ctrl);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to get IRQ for phase1\n");
+		return ret;
 
 	ret = otto_wdt_probe_reset_mode(ctrl);
 	if (ret)
-- 
2.34.1

