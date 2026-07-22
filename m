Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013016.outbound.protection.outlook.com [52.101.127.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDFB480DC5;
	Wed, 22 Jul 2026 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709776; cv=fail; b=jqtNiA9a+G7TpGw6W/IocJY+MbnLzdvMLxY0dVA+f6zc41FriERDRApzJ1cZ+scvTPUKDjN6BsMH57kVvepuLaPzkFZ3+KHEK/R1LTHMkSrTNf4MKgvfpMchVuqxL37IeLNs3m/JE7WbzHrXgw3Ty1d8x3zdB54h2xg1lVHsrZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709776; c=relaxed/simple;
	bh=2GHfydUue+wkXQsoWqki7FcnuVUlZ2SvCiA4urqyPiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mmOjfd7dbDspxtFp9KaMmbA6KxtOq5zNtApZR2Vwhkm7rgYnXX5vB5yB4NRglHUpY8TzzpbWyotoPQ8ZmqnrEwdb/qJ3Ap/1VoIcXG0CkfgRaZ9chtvydHV7ZPPu/vThm0uUrqTSprXWn3sCulxklBGsc1meVxqP3hdwFTxrvaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=UZbCuntg; arc=fail smtp.client-ip=52.101.127.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="UZbCuntg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLk06SG/+iXEcPNKCy9rl5gqk79o8CesGP5jbFJXc41h0qwhtS2Zjn8dzIglK/qIlefHyqe5c1Tvq4cVI3NSLdIjoajltCEpUCD9JwT9/wGJ3IM/4oSRQxBPQrQVfEqxwplcJrTzF2F+66u9P+Dmk9EF08MTpRDtFsR9c0JQ/72eMO2Yc20hzNogeD+uveTPAHPQ/BhBDL//+eHZoJPVbPh9kGIw7yEOoMHlh+sJlMXksWmvrKiiYBbFTvTHA5t5YxRkd2V4asDOgGRDjDe0oGoEJiLRky5hLPIcKAe1HiuZV4sIX16mSKf7V+dZVOy4W4+wRq7JsTmV+4jqQaSRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3XEp9K2NEWfbkdr4XQE4DVlR2tdcGjCxAXK7DopHag=;
 b=wQi7ulHAdiRTmtnWa8pUMC6tUoU84GD4XPutcvZxCWafimn/NcG3uEkmfzc26AF2Oniaba2c0Bil5jxTGlaUwv1G1/qyUv69kyVXssIF7sWlMeD+SJf2/ZQZcoTehWapqdryagSFIgjXJeb2hhbW4zXtEP8o495mQDtOPbNm09JyRKKiZ7GKjdvk8cKEKU2PVemJ/d78f+vsLJq1HAbdQO8AAVFTKg4C6zXAp6MnwMtvmmCAW1mILOnTpUrDUwXnbDKUGR1n0yZXbDm11bwl0aDIxdYFxT+bcNuziyNzkVnBrQWaMvUYaGoVLTSfSm+7krbRY4ukE0gr5QaykZPjXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3XEp9K2NEWfbkdr4XQE4DVlR2tdcGjCxAXK7DopHag=;
 b=UZbCuntga8zoyeoSam6enh06ag0lfhgeFJaVV+Cbl7wbzHT2OKUoAcJrQ4Fz8GKv17CZq9slINR2l1PVDqngvOoQEzKkwLZxggu7UZMQNJs4L1xWl2X+P1pcMM8k9CAp3J/YA0u0mZrakAlTnkck6PHcasCrh2mjgPMxBzy9h1V1NFSHq67T7fGHXTarWbb/PCMGpoG3Z3CyCaBYnBUajZTMgBIW+gVHrDzrVJ0MkJJBdyFD3yk6C2xKafwPh5pblFvYWVxV0M4ClcmIH7lIFGG0Jb6F00wXWmqAV6BxkOdm+yrPuO0ZKkdi67+DUVclTIOCcxqqZ4QwMY5biSSjEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY1PPF6C31DB54F.apcprd06.prod.outlook.com (2603:1096:408::919) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 22 Jul
 2026 08:42:40 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:42:40 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Andy Shevchenko <andy@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list:INTEL MID (Mobile Internet Device) PLATFORM),
	linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 3/9] watchdog: intel-mid_wdt: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 16:42:11 +0800
Message-Id: <20260722084218.79073-4-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a98f7b51-cf59-4559-14c8-08dee7cd3075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|1800799024|376014|366016|18002099003|22082099003|38350700014|11063799006|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	H8+hXqNfXFKrVqBlYLq/1S6A4p5VTqo+HMO08lBvs5rXccT23U+naQo9/GILb8CTbSCwUbFZKldHuH2hnojSY6IH7vSdCvfGhXqpbYM1UrR1gKaTC+5cFo2mVHXEx3oXeHPe11bab1vjHwWt4JgVjJ8pYcTOo3UDaR6CGwXtWRUFKyvMw64kFkLuRYGwj0SCHVBqL0rHSxJ3MVGJXPIxlPPIBeSDBQXKelKNdqlPBnGoL/2QDB7JMaVT/H2w///ypyLKbVdjqQu1nP22qAAWf1u4YdhbiMgkK7c5DJKiSo3WIFtPhe/N2xVKPAfljaVbqXnBMFN4b7QJKHJPeQ8ojPSPGUIHZJWA/2x3Qy6SXmVu6AxtntitSjt1GnhQL6xbI0zeijpCwGMA6OELq1d1j5aGVefitR5Hc09stHgWa2P7wp4Q27P+8+25/Eqisj+4F9M3nY2Rsy2T7ioiHAifBY0oV8ZHxB/dz5YlAuyU45Fmj4org8sbgIwwkzgDMqA4ACeY6JOTlyDMBRf4e1zJ3w0FXRb8Qo6/tbOD4LNbapuIhZ/9e5BA3nA0EuiBjbwZmAlXAoo9tkLMB0NgC3feqW1OggghNejBviI7yhiHzB8HTq5UbZ2X9wjMIeBnxm4OJwcSL1jK2LpBS6Ri9E6z46WosQTotAx9pDT5WdqOkbWSkHz86CPcY2nkYlrPQ4d9vduymPtATuq2535xi/nRhCFnh+Omm1dN2+pH2IuSa64=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(38350700014)(11063799006)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7NozHST3YbiecE5rj5E5Ae5aMx41H7z4i+U3ChwJkRdP8pSbUWAe7NT9VnD+?=
 =?us-ascii?Q?r8o/igvFSH4oOVHuo+7vwrhyemqDnROCi8PIXIXThPNU77alTU9TlOYkUKjF?=
 =?us-ascii?Q?aNuJgrytFODajJt3JTjVfXW+Aa55ByA91G3d9tqFkcY1GvFDZsAzJArtbbLH?=
 =?us-ascii?Q?TvhbatRbzXGOUsffFGlkgeF9x4osWMvBEJ1laGnRUNscqAC2PzOlLVYhHPqi?=
 =?us-ascii?Q?BHU+fITAY0AUwfSEsClqQ0SgP3pFV3lL8tio2g0Iy9IL5gYbZlmQyg4vnBjn?=
 =?us-ascii?Q?yeFjHo88EvIi2sIy0KPiP73Qb7KejDSNuoP/gq7nn/i04Wc2uRCQxnilqJlV?=
 =?us-ascii?Q?DGEMRFN36qt43CpjgFf5OnURaSZ+TbFJEG/Q7XAMA8uiiX2Ll7TQ65QT7xZr?=
 =?us-ascii?Q?/2Z+EcJp2b049utvlwdDFHZeTmmhscopWJjPZlD9bvFOBO9Z8pxVbS/8B7Lk?=
 =?us-ascii?Q?Z1GF9gbbqpQCSLf9/FYRLpnt1bsF07s89/QR3oCe2GOTOYsGwoO9AqnQ2gpf?=
 =?us-ascii?Q?4BLpl/QsIhJSZMO1VW8CeBuhqcg9qwYLg0NQ3JUwkvFZMs1acKL3Fqqezq9S?=
 =?us-ascii?Q?4kXpsrix6Yf4ubdVpvdKJG1ajsVUfgOwA+tzZMt7PpM/t7SLVktRuMbCHsdD?=
 =?us-ascii?Q?Sp36p1WQy3haL8DWNL7x4Kj2sRe0JfZM8GN9AISDdGaWc4vJanSv7kHwFJdo?=
 =?us-ascii?Q?JTaPqpUzpsKVO9fbYBsUNcEFGHlw4r12lrjqeVU8n6HszoXPf9n5SdRHW1PB?=
 =?us-ascii?Q?p74ALyL9dcVrsU4Gqc+89dZYEsIDDuvY5DSJKGlOBXMieReQIPq7ZUuuRn5Q?=
 =?us-ascii?Q?cdwqpOtd7N99cVD5oEiI1FChJssB9kMomobmnI6Ycn6Xh+4JFjyGD+7l6NXa?=
 =?us-ascii?Q?9RFxEnamkvqj81OigUkhMi3nMYUdNfBVf+kRVKo+6+MeWb5SRFSY5j/aF8w3?=
 =?us-ascii?Q?I5xyHiydmSS7lCt2V/0X2PK98voFXRU3W1OUlSCTglqLv3gRkBJGGPdRBGcl?=
 =?us-ascii?Q?eOIsiINwK4Bvy9aTNfeJCwjoeCgDqnmuKkQGJ2mFJJFewCKNGn4eO1y1rD2S?=
 =?us-ascii?Q?SBXHFRq7az01kHqS/LDmDile9yds0+GzrYN7VM8L+O7UehR4mw475gPYFNQX?=
 =?us-ascii?Q?zkrgDtm7nPab7sHuKsB8zdyeDiVUCdBq4Vi/uAmncf/MxaZmoCnbV482KOv0?=
 =?us-ascii?Q?YLKzNgqOTzsjW6GN9jQJIwwfntUrdCWkafSRcQYAZRRNu3YwWjeRnbijy+Vd?=
 =?us-ascii?Q?zPgHXKhHf6AgllugiwrvJXKeQLFOuSf4+n+RuscGgiwsJ2MdLWAKNIHR78j+?=
 =?us-ascii?Q?lK9hF3y1ULq3Ka1xgUjXFbwEJpDqEM/PA7nOXJPB85/00fC+pcP5of2DHatb?=
 =?us-ascii?Q?m0NrJ2vtbVmWu3qUVsFnA9ZhEjLhQkH23G35aKn8ADAFbVRATX6XgiXziT0X?=
 =?us-ascii?Q?LwUZuAqKd71aA+1yL5pNQOd0xaDnWrth7jnUyb0UQ4q+oLgPokzE93plj7/b?=
 =?us-ascii?Q?NjVXiAqrSTJQENTVIRCR4XmfsM+j/21Vv4cunSm22mXQfarKb9JPt5ew3vj+?=
 =?us-ascii?Q?sCtQ0MpiCQf2LijxwVh80fRkgv9BRLeQJsEMW5rGD3xzLrgzF0q91unKEe1k?=
 =?us-ascii?Q?UG/A1nHf5lM27qDwe98FMt/XCEQ6ai3CmEk2TvPtzmxbkUoIcRqlC5HmgCqy?=
 =?us-ascii?Q?RSrvG+g/Hj6HjumOjcuG0zP4cOHoWUdPL1TebvJ2c9dLhLk1AclzBoKSGpwZ?=
 =?us-ascii?Q?Qg7UeHkGUA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98f7b51-cf59-4559-14c8-08dee7cd3075
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:42:40.2498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfaWZ216sMX7cSE9zFD7jUbcuH3aizlGowZ0Hfe47rURO6YkXkUiz1VA0oTpOyZkWzvHJxtkdOhqxpRsPK5LDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF6C31DB54F

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/watchdog/intel-mid_wdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 756d262dc580..b1e1b77ed190 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -165,10 +165,8 @@ static int mid_wdt_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, pdata->irq, mid_wdt_irq,
 			       IRQF_SHARED | IRQF_NO_SUSPEND, "watchdog",
 			       wdt_dev);
-	if (ret) {
-		dev_err(dev, "error requesting warning irq %d\n", pdata->irq);
+	if (ret)
 		return ret;
-	}
 
 	/*
 	 * The firmware followed by U-Boot leaves the watchdog running
-- 
2.34.1

