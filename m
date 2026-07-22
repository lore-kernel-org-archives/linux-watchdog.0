Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013016.outbound.protection.outlook.com [52.101.127.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C617403E9B;
	Wed, 22 Jul 2026 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709771; cv=fail; b=VMVBT4GSR+l/ApfX5KdsLxnDHUyE86oM6wkzNOHcsRGkg8VQ4VOfu7EJkTjW/p0+dgGpsOUpSl6Fpe1zHMBxg+69q0mcuTvQ9hIRHRB//LkTVQ0xaIPENbleeQK5LyNvdd9Xmb/G+THTyftcaoA8EM+/heF96Q3fzV1khEaAw5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709771; c=relaxed/simple;
	bh=DWw+OsPpsmC1Zh/H9cjqgJH6CrC6YMfyFgngcsCPM3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KAyZ1++nqPonnVtmrpTTtF2KYBbcOj1xI7Hdf2ak0lnAB+DqmqzVowVsOgpLo7C31JkcMQsYICXMS7itJwr12bPHQy5+WL01ltmA4uh0+Oiu1sgo28RZnoP0ypX2Rp/95sIlbxM+e7J0GiurDA3g5cB834BWamg2WJX8TZ1yPCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oc6TQG21; arc=fail smtp.client-ip=52.101.127.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oc6TQG21"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IETTeojTU8tFuW/G/24Qj7SWdmrb8snMm96+GSfwsVWVXmmyLDGsejou3qYVF28ugyzGhZzjc+xrRKnt1kkUuZxDB5qo6OdV2WmIiW5opAVlZTdjVL2ahHyIEza0ZxBjccQ2JX6itSRf4kHCCZxuZJtdsrDxVBLJciq3sdesQmgPkH81FFwvTJhnhauAcPHGit4c6/vDO+xR6Cub9Ko4OAEi96Hw8MYTixPpaHps4XUkvakj3N1VKxbmnIAjDSO3dYd9bUoABpR+YGwILBAmeQbAsUP47z2hem6RHiqRELG/9/V4UXnTGMdt7MhcDV86BuUtKjgqP5lsg0NTx4dfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9TLwDdOFoZ9uJVGKGzAzbfkgnJBlK3KC4lEMPqlTpg=;
 b=JJ3ykF8ztl7pYTsFg8wb5EC180/FmNH54UActEodHMhXpPHKOf91iFg2HgsbiuoLrEwejoyPwxccMnqo9Th9PN7AH664ERzK1gMbcBcwBzPZHuUgkISa1ssgAUVeoXHLHEnWNRSnU27KMncrpO9rvQPHm3H1HDY03dLWgbREHcs8Fajv/44mqmb7FE4EasFHhCAzMNMAembL2VRFfooO1UmQlxu/ImKzLQUd+yQlOY5bqwqjL2XsVioCFdtUY0TY6rSZxR3I1CnsXCZmln+haH523qZZvQXtugEAY5Eq3gw1OCPDzz8k11fUPAlhtu5kA5WcP46dmtYAwA50Qi4rLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9TLwDdOFoZ9uJVGKGzAzbfkgnJBlK3KC4lEMPqlTpg=;
 b=oc6TQG21i8LqM5jbk03zvySBc4cc4c1LL8XoRkV+2VY9Lu28wMfVL4yzebZf0Q78Bb604NRHyOYmBVeDirGn235FGIXD5NB3gRj7JzlNLcONYmIeVORNO3M5qTB734kAJvgDmNw7yGTCTtaqaiQjXsZQoeGAm7tUd5hScYwq5mYn0A1P1gdrpRdhawzfxNgjw08Dy0Fi1nLdVUqUUdWKqTulNM30mVdCzOPJ8ZlK92x3tHmuIf11unloDiBOV9El4gm8GSS9XemTf+FZ6VQKDwxSA8TXsZyGOHuGCk3WFwrFXw1KFMzBgL34FaocZMnsOXF3h4/PnI6BwNM7TySh+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY1PPF6C31DB54F.apcprd06.prod.outlook.com (2603:1096:408::919) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 22 Jul
 2026 08:42:38 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:42:38 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 2/9] watchdog: cadence_wdt: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 16:42:10 +0800
Message-Id: <20260722084218.79073-3-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a0effc44-18bc-4a84-4316-08dee7cd2f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|1800799024|376014|366016|18002099003|22082099003|38350700014|11063799006|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	v4cJZKtKJBsni3FIzqXqJlroCdUCPxadKJ3cw5jK1dxobs+CkFnwEr1SlW0BHX2V864X9RMm0YKpzMYm53OUxUl1+sK42ZQdcE9Xtx6afMwCJIJ1ZpGHgWPZ3uMdTMz2FDsGY9vbRkiIaX0lPuXUkYXgdiH9dQCHBYemx9xlzMP7qt3ebwpVm+rD2teFgnhsB/ezqWDVXs3aKubVhzrdpucAqC5wBUq0TWYPVsxBAUaUxuh22mJBrHihiKRxpuRJD08OKCI21WuHxdOfsbejA2vULdeLKF1DveAebQxj+ghmQQUblRsJ93uVjExO9ZYNl2p9RSdxM44AlPKhLkn1bssDvhN8E0sL2q3jrBUB4j2cnkuAgOcVGxzRCD6UUIQbbwu9KSJ6VwDttOJ8cbBlUnGFw79ZJqubSFLeaPmouqqeQIl4+VPU/8wAiG6er2WQ4YbsDUC867aN5vA/0M7mh9o6392AV7/3WLwoS3PkNMfpuL4NCTGn2Tiu+wMo5XUi+At8Cvxsgi0pfjixlYL1a1Kn6miACCm6ZYR3ELFiGCrC4xk946d+UXaIYLtFL1cLRUDTRUydSwAqOdgFVTadNWPJmCbCK29DroxH7jkmFyyTh1Ic31sKt1S+KL6WQTA0a9b4fDNDY9ihjrF1rpy9YqID7E0GiH3649UWUOT5dnU1RDu1JT++YCc4b6biyZc8DiTt1VsOBSJ8wYBzHMz92uUmvHDutPqub5GPZiQOS2s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(38350700014)(11063799006)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ca564eSiTr+3ITm38hGF6Q7/eQPyanlSXATXX0LHJEa6I7XGsPutOFxTbRtk?=
 =?us-ascii?Q?1ppvJljjCq06NEhYlJojWIVOSG9ONnOF9nellTviEK2kDxRqCDp8rGsxp7+7?=
 =?us-ascii?Q?5pkl1ugxWOj7vIgLX2SED8OjsHMluZXb3InGNCRva0j7VcXZHkOEo5lDRoa2?=
 =?us-ascii?Q?39YQKfOX4qaR4DpXoksMkGQX3JXMMHVrPFQG6r63WbhcVBEI9Ek7S0zpAeyp?=
 =?us-ascii?Q?SXgrn1xj2/NDXSHX6KeLyu6JG5y0wrOnmPN2g691o8I13ykpdTYJSe8AiPoE?=
 =?us-ascii?Q?W0dXwyw3OMFoQCjgFgvxjEVPeI2pwRWDvWAru4eg9oWKTEW4aD9Edq+zmjVE?=
 =?us-ascii?Q?RsfVZaPp7RnEGdnwT4BYYSyaypc8V0X+SC+hvzpg026EWJaHuqnDipBkeNtw?=
 =?us-ascii?Q?v+DFUnvuNP9bqbcaIh9Isiap0YiybICpb6v40YOfFBx/grtaMJEAiubOwtju?=
 =?us-ascii?Q?Rg8xp4PMVe2dDRbPcwUugPgVmjGED/MUyWYRJFIL+EJ3JU4bYNIltuSIBwrP?=
 =?us-ascii?Q?DM2bS2CTKoWKt+gAGsYZqdZKJ+1SIh/4kYHYsDw3WzqnMEow5pTPwrjXEs14?=
 =?us-ascii?Q?9bCy/bDYGabdpwWY+/Qb2Z+si86DwrYbY14WgtgDC0qOs6q1YSqyDwlReuy/?=
 =?us-ascii?Q?Sxkp89WWxqstcNZv6KrCgOqlHayXpwQRLHJJC24EpK9qLhbIgjH8K4BD4XYg?=
 =?us-ascii?Q?9e+eBdBcb9tySf4k902PfGhn0JCMms9rA9DECa4yQuhOxvbAtTEX/eyCNLq8?=
 =?us-ascii?Q?INB736cbhedhEogG7Sw5sieYU8+MHfmenwFefWtKqoLGUZK59bDQC81eAbZf?=
 =?us-ascii?Q?RCpwNaxhUJ4CUPZYF8G8pZEbMebR3emiYxTLzRSQXhQCgS7G4gmHFIU5fz6h?=
 =?us-ascii?Q?/VxniMvUHr/ClRKM/rrl4rXb0XnyTDnHqshxCweOixbOkM9IBxw4IERLwKua?=
 =?us-ascii?Q?8V+ihVLHjDxrWbZhfXnx2HF5GncbllfJ0WyGMYMkxu/f/53eA99aatl/494z?=
 =?us-ascii?Q?x8wI9AcLZElz8yQvNfMVsxhdQ17Qn7tNV0UWDmJ0SDkIHm2Y3C/VFFDMYziW?=
 =?us-ascii?Q?EgzTmiTN5BVISbbHreWADjAsNVtyuBfqYsOplXJ5BCn+C8Qqx5gwd/ewjTW7?=
 =?us-ascii?Q?GUcyMGwkViQSMpVjuxCXL5vF5/4s/DURgTK1OnwotkuPdUHR/N3uix2pt9W/?=
 =?us-ascii?Q?30kmBsh+WMM642KiSjohjx/lSzA07SUVgMuFrV6jXbOhES0Z4ipNDFPPNzvv?=
 =?us-ascii?Q?1+M2mm7Jw9tnNDiZc2eaVjz7myEhynjW/fCOYpHnrpGHKB5wjjFl47axu6Pd?=
 =?us-ascii?Q?JBYtE1GH0yyp1CRVThsx86TKomeoREzt59e+ko37O+nC1WrlBptv0fsfU3VI?=
 =?us-ascii?Q?WneVtyZOEshre2Iqm5KJYQqLFu+IQ3tTmrbjdhk5zV3knBzP3hng7V91F0vF?=
 =?us-ascii?Q?rE4/tQBvnoxQF4FeTmu2nKn4zepXduV/gvklSZ6CngGQ7B+zHVfiyv4fBGAD?=
 =?us-ascii?Q?M2xMB8QDiPZPFVBye+wV4/zZ+y/6vG5VdBbHUfJ/iARwDrvM6VUvuTFFJ+Ia?=
 =?us-ascii?Q?9fyivx/2iqMgMj49dWEZLFuSuK/1KN1z7dJ+Jt+n0og9KZ0Ui4TIR5CONr3Y?=
 =?us-ascii?Q?syHjx8MSeP940gAGFV575pkDWW0xyK1dnIWYe9deJib6WI7VradhDQuudcV6?=
 =?us-ascii?Q?Yf36TSsWoIM6+nr9P+Bi/r4bZ44bSgZG6qhv043hlpoVxK+FwiH+EAEQ9wVv?=
 =?us-ascii?Q?Yeg9hpLf5Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0effc44-18bc-4a84-4316-08dee7cd2f67
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:42:38.4877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXyOIkJ1RLPEbKqZIK/OfX2T2agEXk+2gTjXaKrMxd/9kA+N0Oi6Rn6gjXTuY9gcjbFiawjtciuJRFxYP3unwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF6C31DB54F

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/watchdog/cadence_wdt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index 23d41043863f..ad46b33ce5f2 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -312,12 +312,8 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 	if (!wdt->rst && irq >= 0) {
 		ret = devm_request_irq(dev, irq, cdns_wdt_irq_handler, 0,
 				       pdev->name, pdev);
-		if (ret) {
-			dev_err(dev,
-				"cannot register interrupt handler err=%d\n",
-				ret);
+		if (ret)
 			return ret;
-		}
 	}
 
 	/* Initialize the members of cdns_wdt structure */
-- 
2.34.1

