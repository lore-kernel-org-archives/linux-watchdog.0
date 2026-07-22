Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012026.outbound.protection.outlook.com [40.107.75.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14E636F8FE;
	Wed, 22 Jul 2026 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709798; cv=fail; b=YotXx2DB1qn9h76RUfdXST4gF1yJv4NKx93HLV5uXpGFGLT9SifbCJN1RrvaEsYaHUoqU6HGuPwtVd+dePflLAiOqHi1qYoLZp2qkbmIRuiaQj/6x0mTVoyLQxtJspcgyqoLe4sZNaz5DOETh75vBooycsbnEu1Pd65CYX/4OvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709798; c=relaxed/simple;
	bh=MItCxsTdBhBsAsQeTqGv0WiNlIEVa3B77eoIT+eEwxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lZ2ZiPVic2LBv470b/6m0HrV+R7yw32taZPLcv0vmdps9agORzeIT66PC4qEOCc+AAVg3fmbyBKlm4Br/nphV4dsS+Gk61Y3BPxSw8hdYmMalW0Y3AnIMn4peU8Bw73Tu3ufKswgcKGj38Q11SSuC3VZMnz90jA7u/YmXFtYiB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Qr7aeMqq; arc=fail smtp.client-ip=40.107.75.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Qr7aeMqq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxXTQhrpOfTwW51Zn36ZdUC8ONOg6LYxYFu8VbC8pTdteHN0ZZUCVzUDieoEAGu2uDZz0uw6ZEnGx/pXtIe22p/E8Kp4Xib9yZ9pNfInAoX1WlHs/QNmtbfgcN2g4C29DQy+6qg+z6UjJlijqSq/xnNOJ0FCk48ntxsKXAEbcuUyWbyQ8nqNjEemCjpccIL4RxcIDNr8cF66ZGxqhUJwtivyma2kClAJbr1htR/KwTKFP58d5g9gBmnyk/XX0KVdf0qHsJHT2o+HPI1s4m/AmX0JLv1NOOYb3K98HPGisE8eX5gTCiRiUmYY4vy86dKdj0YO+1EE8kPlLZkscP5KrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXogmcNwFIPmGl0bit4zeQzrpZ/9HThoKwORjjWnx5g=;
 b=eWARoWNST8DNefMhsTEEDIIgG7eMyYK2Vo06CJzfc7GlKNjbp2ODCv8Hm+hJ8lY7EN9V3KcZNIICtylfhy7n1bMZxOe2vb/D/iZTJRC/uaY+pAf53e/gsjkoGuDgv4FUlbdiCaVtzLF3KJJXkWVeTIJk3IllmziqX0uNU6qjFUG6/15EGdxaBKuros9FhQCiX+aCzGxcYqN7nKyoyLDYMMJy9W21FzbSWvc75THMPjHunBtZ/iQMMAToPrEvpPla4VaG+lzQM286cgeQA4u4c8o1L6tqei11zmPvnuIz7OWUQURm/05qsHlb9srPDEhQklUohlXXX9h0hmviybWHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXogmcNwFIPmGl0bit4zeQzrpZ/9HThoKwORjjWnx5g=;
 b=Qr7aeMqqGCV55QrIcKVQ2RGVzf5/F4Q+x+gRO6oZ6FuNs9hV/y0RKLR2qrzRSHqJP/e4/WfoclIyZDIU0WfYMpReK6nABC9Oz4GZX0WN1maBRG2K4OXvYX/sbAQ3Rvmp9XtAqZUoZ9ZCK8iNHiq+QHBrQrKFh3qmZq/WFZdwZxw2kHAMN9QGGbJl5H4EgJhAZrF/sMocdNsjrrXclOZ7kS9V5KY8PspC6Gkm+H1gFKZbDjL1kqYDXI73dv16FI4AjIZtoenIF8EULbuugYbQgaRAZf4qZM626/FwWPZd8tvtEquskYbQDpSxRFnTI4LPm+OXVUhntgRijWmHPUFrIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEZPR06MB6037.apcprd06.prod.outlook.com (2603:1096:101:ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 08:42:52 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:42:52 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 9/9] watchdog: sprd: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 16:42:17 +0800
Message-Id: <20260722084218.79073-10-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 57695353-5b4e-4d43-2af8-08dee7cd37be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|23010399003|1800799024|38350700014|22082099003|18002099003|6133799003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	BCLQgFhLeIQoE1IeZQ+3GZSMfOy513u2g/d5Ktun9EfW7TeMmd+pDJgwAyxQ5s4RsOw04Rf5/rkQIgBiLjlDGRxscvt43OpkSLnR3YoN0jOEAiZ5/dv/jhcdBiftDh9aRsKhfxC4aHhwjz+d5QfMOgzpXAscqSVDnLKKaVyL3wFfqOYhwIVkbpHxfD+gUHxvv9JllSXWUp+ZNXiffG0G/M9cXcFPj5zoBUIQsy6ZZlVEJ7Qp/CVi8Fu7ymVphsrekCU1wxOz4Cai0STsiOUvK0wggt2IPuwgt5y9WwwiZVXvyf9IXW0puEkRLA6xnUI8tqjEnC533SyLDrEjO6gX2fHeJ/3VhnaVddq8P9bnIp9d/CFyrp+Wf+SeB3D6j/dDGK9JWn4/n6i6FZiOwXOTl1Ke9yo8IVC5EDRx/mh/SFunguu8e2RgIdBkLpEDymRW7yMQc6bQirKVvreyHJC+p0Bf33gwJ52CK6LeSNdAQQzy6L4TtkExi/6k7MCFmiEg2tigyCMwEHxCBb+ugfKf7JWG7prIbveuqn3BIi881UZP8j00wZD6mrxdTYOSR6CgV71Uqs2zfippNZsOUkcN99CSAAfV0O/Zraf6uCAmX0e6e3vTfzs+QYd75WtGkkM6CoDdCrnjVmA2K7tK1seY/a8n+YbPAaHSBBDIGqj1ko5rYUaRFjUyok3vG0hEF4112MaDF+KppcXnt4SXJnv5i8RYyHZWUlSi+13PoaIvkVA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(23010399003)(1800799024)(38350700014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K4Eb0Z3W1yMCBaRrIblf2evwW+PPoSQp2IsqU0N3kQ/0FTEJBgJq85XQvjuV?=
 =?us-ascii?Q?PHV1Qo4xasTgJ1IG8xOpUyYEARKB0rk7rgfMfFK3W90KCHa0gEyYRJIGqjcB?=
 =?us-ascii?Q?JN2nSnU98poYX031EjJxEdj8BPySl2zwWRNZWocm4VkdpECrCPBRBYk3Do4r?=
 =?us-ascii?Q?uJgW7vHhGwF484fm1QurCKnZpIkycgicDKjo2PIWkGjq+s6xVG51wtpizJ34?=
 =?us-ascii?Q?99Z7yUu39WBPOO1R+DBITOgBDvzieFcFb/e0uMKFzt8GA5qLJHKfz+8cjrhi?=
 =?us-ascii?Q?JOB7w8A9ZGaCo29bTKKbB4KgTXl0uDidRwZiTBnGxvj7uAJPBcnEwsOqgHJE?=
 =?us-ascii?Q?0iLk5PUQ9n3vjzS5mY4VnhVYf8i3I+aGKcERmyrWnZ30D9jaG3sQFVV9Uey/?=
 =?us-ascii?Q?sdGV2B9gZqXzh2tKLXJ4Ncs4M0J2VjB9hvIu4hlHw61l7c3DAAId6NtXIqIc?=
 =?us-ascii?Q?XGRyJnuUGj2501qbdwi1Z5Qd0pKPkG51pWCHklnnwQ/QZlc0tsx9jFgJVOcy?=
 =?us-ascii?Q?4CFkvpIvyWP5NadssV5+a57Fjh+8zB7Lw8+JR0mbWAJli4g/JV5Wf1Hm1EeC?=
 =?us-ascii?Q?5VZZs/QnqoqNKmAK9o0WUM0vRyp9dKRqq29bQBmpjGr9aYjwHSpjBjZWalIW?=
 =?us-ascii?Q?A6v5GhjUpRZxSiB9FTFKHtAYvM3fNw8dOj3LxRZFATb1z1KvYY69BxOTF0rY?=
 =?us-ascii?Q?fYiEz+nzOxun7uMSK42IafJiscV6/QfwykE5sla1cet8ID7zH0ElPImtB91H?=
 =?us-ascii?Q?hEAJTMEVelTfqR65kvMrTtcS6aLQ2ild3qxxlKum0GCu4JVqeGiZixOKKMgl?=
 =?us-ascii?Q?MGTB8Rdlki008c6+FDsHEL59oZc/07tV28/+3QiEgWva8xvgYTMps20fr2xa?=
 =?us-ascii?Q?7Vi9ZcIXupJI9MRFqXPtf6vkjyQs2lS/U4aH4qmqTkscE40FsrEZBFDB9XVE?=
 =?us-ascii?Q?34mDvBuTQrOm3KVDzakqTo69mim1iyDVuabFHXqCGPxsrEsBGuAq4v0kaY/6?=
 =?us-ascii?Q?wsm2MPkgQEWtVBKPZOjeCGeI7avcpO7QuK1xjcOujcYLTuYpG2MBSBJl/ZX4?=
 =?us-ascii?Q?SdLOKd3XnctAsv1/CZoIuhcJ08dhheM+7dABIrtnvEZ+gv0E3LF/ZBNSoiUa?=
 =?us-ascii?Q?rcKXBVpTWlzwBCP4dkU0Y8SPu1qjcgW3JpDq9VKdOzqTAxs7uaweObSnTUh+?=
 =?us-ascii?Q?Y8pPKTziecyYbCGUiX1r1JLm3JGfQoijIsLlyNOlCHWG4AcvVjFUfb4J63M6?=
 =?us-ascii?Q?mmJv5cBQH4SAFuXT3lHzWpGQaGduIRFiAWagAblLRY0EMY2Twxn0XqCfN+hD?=
 =?us-ascii?Q?hYYglxf6k+ew/p00HvXV5wCCIioobKmkWwhTo/L3haf9gmQlNSAGYqnvSH4P?=
 =?us-ascii?Q?Pi0/6M4/hf7bqzl2WFFKkCSoXIlfwCcmXt8y87iRL+4cwlRkJR0jrpjOKAHW?=
 =?us-ascii?Q?JZpqHy7bahMSbQW+OvJg6g4jzPX+UAPo7yAa23sOapcP0Wjyqmpi8M5QVU3n?=
 =?us-ascii?Q?UG1Rp3UCp6KL3QF6L4vf2Jo4RAPbD35AdRBzjYlsn2I8oWZNUPnbro2tmRXz?=
 =?us-ascii?Q?uSC9O0FSW/mPViQu/jNIlHT+a7l9noMPTPSyP/ji9T0ojB4lDsldzvZ5rlst?=
 =?us-ascii?Q?4PGAwF7bYAESDMHcJSf63OcwWpetui4/c7rm53EX69H7RV0nPYFt9qgG755N?=
 =?us-ascii?Q?1FQ+ttLl/5u+gTZMiuEPg8OV4BXgDUMGf/rFarjf/SQ5WDf2+/7gZ+PSvevr?=
 =?us-ascii?Q?7Pv7prRADA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57695353-5b4e-4d43-2af8-08dee7cd37be
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:42:52.4761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kwd5qaoWUU+d79xa3kfGtwjy83L+MACucvzo1rB94TUO2+okOLTnYiNk7fU+UiH1EaHCuQmuJVvmNlnezqWFOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6037

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/watchdog/sprd_wdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
index aacf04616fef..616b4d7f21d7 100644
--- a/drivers/watchdog/sprd_wdt.c
+++ b/drivers/watchdog/sprd_wdt.c
@@ -293,10 +293,8 @@ static int sprd_wdt_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, wdt->irq, sprd_wdt_isr, IRQF_NO_SUSPEND,
 			       "sprd-wdt", (void *)wdt);
-	if (ret) {
-		dev_err(dev, "failed to register irq\n");
+	if (ret)
 		return ret;
-	}
 
 	wdt->wdd.info = &sprd_wdt_info;
 	wdt->wdd.ops = &sprd_wdt_ops;
-- 
2.34.1

