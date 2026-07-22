Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013016.outbound.protection.outlook.com [52.101.127.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF9748097E;
	Wed, 22 Jul 2026 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709782; cv=fail; b=CsPrR6m8em3WUrbNkGf4uHdM5IHH6fFfg7rUQdMOC6P+LmqHAltWdLqfFXbNDbCTPh/jjKVKl6te7Jm8L99+6W8JU3lNm4oJXxXIiD+D+UZEhsYpslBhg5+fSknoL472oJNBrYQxCtu5J1FIaOXu+Jr9XLWmDzgZU+I7zBXifj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709782; c=relaxed/simple;
	bh=1ssHhZEWpJ53NzI7v4L8uJ+PoWbOT0Z/8IZxO580lAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BYCya9iP+Zy+RW/mxnUBqjw0xosvUqR/wlAstbgLGMeMEbZEsSKdabpK+rHlvtyyvZJhUyJ/ASTjnn+066buhfqyXFdWJ20IAe+Qai5JnW76rYJmAepZiOB19iqZNCgbdqe6uk9wxv/qbcw9PCGDSpU5OTkQKdCbwt+3MwAxyPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Y3hMlUKx; arc=fail smtp.client-ip=52.101.127.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Y3hMlUKx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1AvahZRjxb8vctiCjVjk05xXQpMA5UZN6b361jmc4cJF74d2etxCEiX1Nh21rg6waU+DNQQ0Lk+n0aufPFU00+5OcGVavVDGet2YVKjLf59lRnPSUNv5A9CaRwkflO5p1yNJ0G7/6MJoUnecShHnqavE8i1tZYV1arqSryUven8uy1psVT1QxW4g1WWjGJcvs2o4TeGywXK05sa8zagz03W5RmZ1YKIjnCNXYWc8szpjcG6X91kPkP1kUtuxXk0W8CDtvaA6tiaG3pzmm0xU9/XotYpUAI9Rbp81zzRjUwxSsnnwWyq0WIvFBH28tODXObkL2epYtoHz6VQl7YcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNkpY0Mg68nbSJlRyK7B0M8PYDyU3rR68zAYBjpMzrI=;
 b=iJZCmyYgoc0G0dy3IEXvRp7YkJT01Qo6Jr0Pycw1LMvAld761QyFi9J8SJFxOLytZsAr5dH6SkdQ2oZ/UOU1gvfyTnE/lu6SapSyGKRDqIdmyfiS7RJ8rCmc/z231hNYzs1tgCb9iD2ahJDkIl3RITJ1aezkVGi0AoQvrv9GaMVth8sfzngMbFOcpYx2nmnJmhF0ziaTZ70u9FW/dPP4sHs9zWx26eFsEvnwwTUvWkW8P+fFGfp94uS4nZlu7f0NVdpy8h5BEQV7H7h/J9ZKtnhx09GQ5O7Eqefffd13CFbj7aQfHdM9acDUFy+JCbRSfQK8/EPGLeebqVbHMoxhXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNkpY0Mg68nbSJlRyK7B0M8PYDyU3rR68zAYBjpMzrI=;
 b=Y3hMlUKx3UEgw2NrxtXWx1NEHMBTrDpGeMLAPFGIduPmsWx2BhoxMC4hWHAVVyS8ccMFyaIckRfHX7AxTJ1Unzy5Ty9JrUnyIBkyvheTTbW3nDGt4Tdt7MJYm9DwKCGhQ8q6Sd6dfpHF1rm0xuvJFaKlavvmzkTJuv55S6o9o12KcVj1k1kwcg1fqRLs5yUJw5gtWCb1wdGEyEYs/AJGdG6/mVZCPgcxRCTKejAruCBAlzCom7fWAe6gBWNjeHdIOYVPMmAVgw2S99+yyyqhQ79/zqDzUOCjbV0TupF2Dz2kPi23kXqM9BNEwndBUAixd+Hd2GaNgeSznyPVXT51Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY1PPF6C31DB54F.apcprd06.prod.outlook.com (2603:1096:408::919) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 22 Jul
 2026 08:42:42 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:42:42 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 4/9] watchdog: keembay: Remove redundant dev_err_probe()
Date: Wed, 22 Jul 2026 16:42:12 +0800
Message-Id: <20260722084218.79073-5-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3d5ab609-5f2c-45fc-d71d-08dee7cd3173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|1800799024|376014|366016|18002099003|22082099003|38350700014|11063799006|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	iQ7DejpjBJOGNrY0MozhxH7Muzf8CgwEaheItO/zeWXg8rGx6wlDtk29h5PcN6FTeqGAGrrM8h2wyBDdE+ilOfEYf+ZJD6QiVkaVL2SHIb9RtN2Pwb6tGegduma+3at2LWbCb0EayO7pSCWPUB/c3vu7IlAP0g5K8Ry7WEllx2rKcTnSO8yFGWbJRvix2fjNcIbNlkVxxvahrFSIDej0AuYxZ1c4rcVHPa8rHbYZYSU8s24+CbtnNynwjHrfs3b0u/djbqk5zvvhjyq91k9twgQoCtWMZniY19Zv1514W55saCpnJX5z2Ycd/wRGVLR1FOFi4wJbb+BRRa8AskRbN5JYzrB2Xb8agJn8uNftBMwk/pbE341rHy6QKnmJHEYXAXjQjDexJ2r8yhQo74vYB6NxY7sDj9g+ZQ+gL4OzU35Jhyas8Gp0LFIb6Rvbdo0gBuW+aLg/jjuSOf6sDF2CKTPFKZ1xKe+mRkg3ALKEPeNC8f/mKJIGsYwk45fuCpPSU4YYJbGXqEMgm1TJTg5pE3hQZPs7+cl8/KFVNqi6qzs3EJY1UyuK/KpuHDSwfWQaqh/bjb78ms8IPiWwuj6b2fqwC/uOkKTEO4+7iAsiKPp6DIJKyVKMFMv085AJD4t/xtTmsMO4+vEMMUzkcieHOfew9cvu8PnhysZnWQ50CkO07VFawMHzv+l2bjBb8MjjUAMgP4Dcon8vFGG+HnIGoV7ZQtNTJWs6tI5unAIfsHk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(38350700014)(11063799006)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oxSclGABZJKFarQPwXwooCX9YxeKWHh7/Izk5ieBg2ehZPYd6Q8Z25mtlBKm?=
 =?us-ascii?Q?+yQlFSzHAjIFOLxm8LD23cUsl00sa5lAPfhCQ/MTCE0IVJRpAd8x4hU5Gqe7?=
 =?us-ascii?Q?ALtNVj6YlkDNVYWwSqiNGyUzyPL93Mlm21cZhInw/JSmmxe+nuAjP2hMesj0?=
 =?us-ascii?Q?M9mHxrwm+PrBFqamX6jIeUkgq4Udmi+sg3+o1ax1HK9K/wREESM+Vy2J553q?=
 =?us-ascii?Q?pRLm+lqWrY3+yEe3daNBmd6rkWtqrRu7mVu3LR1M+TPz+Vez7y2UEtm+BnWG?=
 =?us-ascii?Q?7Ue5VvsEtJsRMjEeRawUizmNLrm0FbMl6UdZNYWKmkxuoVnK8vpe7zPG+4t6?=
 =?us-ascii?Q?QfmFgAG8PAl1WixCdhGSA5WpD5l0mVUeDTvjT5mNrp4E0VOImXq6TNBX27Rt?=
 =?us-ascii?Q?Ze9PGItVp06T4g5WbiHaGAfzlEgCs5HVlCn57W2V3Gsc3An276GVPifNfujf?=
 =?us-ascii?Q?kVThcKlC7ZwIsnHvN9M4zdfG/7URJbIIMnqVx+cDm3NBc+RVSDXO9PQyV+YL?=
 =?us-ascii?Q?RufCVqn/K5gavK0EVK0DZI/2ozk2yROR4uDNcP56DekutCYvaNPVsuZdnjoo?=
 =?us-ascii?Q?4uz0pxDW8C6D7sMwLuxysI0ca08JJJ8qhZO4Uouu+Vd8n9POgHbo3DaEQiqY?=
 =?us-ascii?Q?D7kGiHZiyl5BFTVq55LYGFkqNhugS0wt6NZymUA70CvCdmkYtRbEbeVSQ6nj?=
 =?us-ascii?Q?dSxhHtinmNcTN6F/LCewGVMu5kvGyJU2Ub4Q153RxKuCpQUds/6hgDhXs7GB?=
 =?us-ascii?Q?lQ0kDabZdKQsxeAvyNwsMW09MMhD9KUa6iLGYsB+qdu9zPOUBBDTlbj4DjJ4?=
 =?us-ascii?Q?rgCea/T0b3Nt6kUBfkLFWOgiMn74B4tFfc6S7j9pt0HHLhglDBDMKrdd8qA1?=
 =?us-ascii?Q?zdyGBtM3ivuK8Isv+zSwNGFUU29SGD9wZY3DOfqhdZ3BiadQsbsCdWrIJrFs?=
 =?us-ascii?Q?/RR39frKLFxepnRcA8UNgDzK07ibDKil3XUtaB36U9Z73rCmtFfv65NdT2nj?=
 =?us-ascii?Q?GarqnII3S65HiIReG4BrA/jY+tta66v9UV2lKl5Du1R+dWic3XefsQ4VvPg5?=
 =?us-ascii?Q?lOZVeqPWDcqMkGys80nb0ir4XHYiRPuwvzwPoNSJX3mcH5ELl/MmlC0tM5IB?=
 =?us-ascii?Q?1RldaWH7YW/qjL1h5hfyaCGa95yNKrL0Q88rsCb0QpZCWppXtKc5O3e4Sy3N?=
 =?us-ascii?Q?8TWrX597w6QmkjkfdRcuI56Vjpvjb+C16f3gn4auPWC9IhfNVqRpus8h9rpj?=
 =?us-ascii?Q?s+BFw/LfMJTAN/6TFdYmBmH/sURZWL+iyt46rlHEjCwaqSoHO+W/+zCMEU6b?=
 =?us-ascii?Q?BUKHPLzLr7/imfBkAEH6gxpXgTOT7tqmPXSdNmZJVYIqMEXnJ4fxOC67zjXw?=
 =?us-ascii?Q?XzPk2pznK9Xf9iwCeYN7EP9+ZkEgo7wgjhHIglSstWie64kGXQkfGIg4s84i?=
 =?us-ascii?Q?zqYNArlNg8mBHuOHStBdnGLICsgcO/oV2PI49QgvzGPo+tzx+uGTYGSOKY+F?=
 =?us-ascii?Q?sVLK1Olm1p3sz3o4ydmvb7237/MgIiTrKb/TuhhJvPHDhwXNJaNfzOniU+LR?=
 =?us-ascii?Q?VuhCoRYcoRPlHg7qaI2elqPVKi/mw51cB8iFth/1450jubBS8Cp1Ox+d4mva?=
 =?us-ascii?Q?WBuGcinVjb1hVb+0JL7ffVGUyY1HRsbcbwcXQMqkSPuAiCffhUSE0WP2y9BW?=
 =?us-ascii?Q?GZHzkEmXwoazWIBOE3bJISfX3TjjUC1bG0PK4hijgQld3tMcWIZT+L+N0ddG?=
 =?us-ascii?Q?P128/fyEnw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5ab609-5f2c-45fc-d71d-08dee7cd3173
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:42:41.9397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQy6r7izBR54R1uMcFYsBLEOHVrKGoStctLPF4VGhxxGiBihDj6wHRYaXpt1OQYo6nFFS2Pnp1JpI1K/lb+PfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF6C31DB54F

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/watchdog/keembay_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/keembay_wdt.c b/drivers/watchdog/keembay_wdt.c
index 3854249c7455..7c8e53921e40 100644
--- a/drivers/watchdog/keembay_wdt.c
+++ b/drivers/watchdog/keembay_wdt.c
@@ -214,7 +214,7 @@ static int keembay_wdt_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, wdt->th_irq, keembay_wdt_th_isr, 0,
 			       "keembay-wdt", wdt);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request IRQ for threshold\n");
+		return ret;
 
 	wdt->to_irq = platform_get_irq_byname(pdev, "timeout");
 	if (wdt->to_irq < 0)
@@ -223,7 +223,7 @@ static int keembay_wdt_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, wdt->to_irq, keembay_wdt_to_isr, 0,
 			       "keembay-wdt", wdt);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request IRQ for timeout\n");
+		return ret;
 
 	wdt->wdd.parent		= dev;
 	wdt->wdd.info		= &keembay_wdt_info;
-- 
2.34.1

