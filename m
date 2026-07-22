Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013016.outbound.protection.outlook.com [52.101.127.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4389A480DC1;
	Wed, 22 Jul 2026 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709766; cv=fail; b=srdBP2vRL+1QmnbQci2lIq5IicSEOC14rcWPqptzu0OZweATx9aGLWTCvutOLNm03GXeYGRIahvnKVTr5uCdDojLsniX5wS2uRIdwh1fmGpd9EmPVH6J8VMvscjiC9QeZMn9vycpOCIKFhB6ZDi5WPfIrYeRT+NXpiH23Plx0Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709766; c=relaxed/simple;
	bh=7p2JDmhfptlOoNvnhiHwV5K0AuOoHX5W16IFDzMKYOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hjpJVTLwo8FytzQweXAzYpPUVsp+EHrZ//3Ru7M43Yx/XvtDvlUB5hDrsbFsnkalAiqJ1kSewKIJga84QUMs7ZBaFuGtDIgxz69KXy4+FvTpxWWCV8VTHS9GcHAY3QtnVT0Dm5QOokTcWxod9Og9ur0dx7R6ezgGaGNwyp94D3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LbJE/Zus; arc=fail smtp.client-ip=52.101.127.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LbJE/Zus"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFPjUUlx5H0Sr+ThzTYlTC5zoBvJ4bL/PVV97ac/gDIRZIzJXysR5ZDWBNAlH7WNAzxJTUA2JWcVrfMIcB1jBo0LOYO+BufmNL7K88x5+veNqC3bpd91U9yiJBXeGyqv08gQ1qI78kwbHs+LOe3oxDMxUcUfFNkGlvpPhRLAfJzoetI42jgCFSK5kMWUfwc/O16e0HWnszs5Pg7VErc5SzT8e+vkSt0gNGd/UwAzpkEt1JQpvzgc31PNcAxv12by8FqcIpnySRtG37a1ejVNOQSfhhwwSFZy4n4/jLIH2rBJT7l23nX8c/FhqsNVewWTk4cYHP3E/oM+fYsAVFKQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RM3BFPHm82wufRTrBKxd4pQDsH/pMUZlLEpt8R2xNos=;
 b=yPJ8Vr8WdAYQGARRdc0OTd+tn6Vwtwy56zPyKNSZSqUCNkViZXyRDZQjDmbyd8emZm02T4ZbXsJMj0SPtUGsUVnnO9Na2UQ1ojgWne5pP4xPjx03Zz6nfTnKdkIRVw9zigDjeMJQK67oyRoHiEiZs3mVBTrSkZvNul8fccKbPI1ddjcXZBCrNy1m8+mBV4tr+NfJ5h1QCQ3sdz4g0oCui9Tciffb5H5npCaKZYWK6yZqZ0GR2vAyIiOYnyFJbuJd+JyZLwflvBoYh63goDir9FZM3aP/ICaWo3xhFZ3WMEFY7eMnThTSfngdXQDzXdb+xNn4+cSki+4vgal7e029Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RM3BFPHm82wufRTrBKxd4pQDsH/pMUZlLEpt8R2xNos=;
 b=LbJE/ZusMmKDNfNqv9ZEswwNu4Wd1rYEu1bJOEO0a8G1nDkeTE2hkA4JnKFYph+PW3VdfA/vXBJVmj+YYxRg1gMk21DDPN3zACy+E/OhorDGZuH+I+W/pz27Jnv48zlYkvD45vv9EWMmq857c9yxTux7fevjkYtsNADzkd8a6+wJS0Yrbyr4Y1uMaqdYVc0YeuW7t1LC6ItJWTF/l2qiQbqkaTQBiOUCHEQVECVmpyzZ4SRBCS1H/z2HJVX2tOFjO9j5I4G7B2994cURYrrmQskK4E2oQ8bwNLWe8Jg1OfVfzage9ssOqQFClz+vFpozlib5JRz2BX5Y/vvhx/LZ5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY1PPF6C31DB54F.apcprd06.prod.outlook.com (2603:1096:408::919) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 22 Jul
 2026 08:42:37 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:42:36 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 1/9] watchdog: bd96801_wdt: Remove redundant dev_err_probe()
Date: Wed, 22 Jul 2026 16:42:09 +0800
Message-Id: <20260722084218.79073-2-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0a3c03da-0d2a-43e5-2a3a-08dee7cd2e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|1800799024|376014|366016|18002099003|22082099003|38350700014|11063799006|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	TeDSFyjLYb3goegFllxFrcN1FPv5b2b6A57wb5yIspMUuJkZ6+sVYjwFRo+Qqfh4XRk9j4cR2oRVhgBJiMlTznCuq62CXK+e4gt9czpofr4ZIvS6wRxKuGoKchElq5mxiFs/y3NgfYKjWNzEBgoPqe85IySf5hTNrkEIztOlWELSXwQcXOOnlw1gDtFR8WYG3PbvPxfP7rPcygnPY+siicTpwPCV1GqDyZ3mc527LzNzldpclVngGY5bPF3F0O2tNl4Chjhy/JuO7D+utRonHqJwyG/ozSy459dpIo0GnNEATI9A/07lL5YxAD7eSnBN2WVnqSgzj7aR7MsdAtd5wGvT2J5NQmJ78+BzE+5Lnlnq8DfbGkYzb4mgHhAv9Ycsdwg2rzTSmE08dxHoz0BPtQJZN18rJOh2W3x5LhYX/SFVm2nR7fYY+9m9UJ9OPTl57v5kBd5jEtNi8HBcicXEgrTQ2n8X1m+9MWuQUsScgsoB64WIfPhs8cnCjGOZHaO+KGbB77On5Pftz53hMcF6oggJ3kAIalLyUAzWdwn/TNlHsWYS9Bn2+KHeYlwROMVK9QkE5+0cwokcALL1MmvPkexuL0clr8Hj4okfzRb3c/Qes/IZuvM9yD+APTGd8l0vkX91yIh3Koiv2GdSQh63D/efhN6gQW79820QJZFqgXgfH+vqPINwj3Rr+hEh+qllMYl6Gp7A9Do3W9+b+yHJRxJpnROOFbuAhAjvL9NhtzA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(38350700014)(11063799006)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X+1tT9/swE78TMXihyltyz+ukeQIa7XIsNkggXss/R5pcQTSN2cym4hajufN?=
 =?us-ascii?Q?XwzC2+cqHJPaElRSLVh9Jpk7h6poybCf6vH5z64+P57CghvkyM8Wp+u9HnE3?=
 =?us-ascii?Q?oDodT13sdecw6nvl+aN9E4MZaOpoCwBkJXyZz3+PgdtUMMVJ3H8C7MXwCeho?=
 =?us-ascii?Q?TNSRjCgKFwrTG92XhkDVgcaOK0y4Vept3ZBRitNFd0I78xiMPHOhGi+eh3rl?=
 =?us-ascii?Q?RtHxNscIgxQl/SiPRqwmNLIz2llDKhXUOKUK5D+eBXhDXWIiV55LV/grpunD?=
 =?us-ascii?Q?8PiIJWTd57bE90m3YV64K1CecG0CB63pOTx2hOyJDLRLE7m/aKh+EHyw+R9H?=
 =?us-ascii?Q?uANQ0R8AXrzujiZRX50ikzARIGqRxzKGRTB/qISJ2Qhv7TtFiTAM1IKfW30w?=
 =?us-ascii?Q?jpjrPUB7Z/AHK+q5byvFA+8AG02u7Kjr6vGv9BJeu3HSCNBJlbf/GcyuZPdJ?=
 =?us-ascii?Q?lApMUtXFn9ZNsifZx9JKMIFeE6avDcjjpsnrC4METmhaXY5PX1Rcds8eEqyH?=
 =?us-ascii?Q?+6Xju4axnDj1i4N2hTDClkDHwDVkJ87QlcEpeHwCu0ruto41imsA40dr6m6g?=
 =?us-ascii?Q?/LJQshnIJI5ixWH0xQ9arExE8gz9X5iwW8tvlX7Al1+NIoTJyHQyVv++f2WX?=
 =?us-ascii?Q?tYHDpaWVT/Q3+qd5IoFcxInohDevRPFdyO5K0XcI4LIyOGlxzsnSG3ljZc6l?=
 =?us-ascii?Q?RI7bf5QK187v3KSdNQAt1yQr047bbOIRwcD7t0Bds8jEK1D26zDep+5bg6Pz?=
 =?us-ascii?Q?qjUs1JBI/oWkLeipaIbwkCXrDluYa8bAMUNA+qUVfs1lTNXJ7Tsd1xYrWA1j?=
 =?us-ascii?Q?8c8NKz4ZLh7kHkbaCkzPCIn4c4mVpnBL1fj64fXXOUWKEUPpA7+lTi00PXkl?=
 =?us-ascii?Q?M6orrWjt7mOSWkdQqHhF5LKZIRqhTYev6irrmNJ0casJyfSpdjCM3XsUT7rV?=
 =?us-ascii?Q?llT1LibVP65nSQDc9fIUq3XQu/Qh+P6RJTR8Mnxr48Lty6HR4zx+IFEoj0JN?=
 =?us-ascii?Q?e84Pnz65kq8YzDi0hKr20HTCtLKxuGoZ4phk+Mx0aNn2sQ/xVEjZaKATuxri?=
 =?us-ascii?Q?qHY5gQGf2eNZIirm4mzAPf3wzH9b3PVXMVQ4lNVVqZYg2aNQgnR070vukoc9?=
 =?us-ascii?Q?SFp+Lhnb1b49HdMHBUSL7uE/UQYfSCz5y/szDmVst1Tj6+65zgQiJn91jGnF?=
 =?us-ascii?Q?4lyIZzB+zJ4bs1bjFy8Cy6j9jNVavS9bVXsxkRuHw+sMp6aAOq06YUTrxsFn?=
 =?us-ascii?Q?c43Ti6k/49zQCpqaErYdCGvs6DpTQ+mWgwFRoIc6y1/bFz/+oaPy3x172CnR?=
 =?us-ascii?Q?22z0MsEoFIYLIxls8wBZTBClWSzXmi2++CwhUkwlIC2fybzkBEV0IcgKjwhq?=
 =?us-ascii?Q?Zaj2ty6XoHC7fuNo4BKJb6uHULty/TU7s6BSFJfH40mGrYV8RH6V2mG7nXA2?=
 =?us-ascii?Q?juqcfSM64OFIRkUNhqqtaLTSjfFPb3Ov1U6btdMLpjv2jvmfdL1FYtm6RMXR?=
 =?us-ascii?Q?fMr5aTen8KFzQ5XB9BEjNQFDzIid6ziOjLWej8WY2Ek0+CZr3OwBptS4qqNL?=
 =?us-ascii?Q?czWu70GWBLPoJkJNDg8DL7Xrix319LQ1Z83nXHhqtTEhyrjPN1Q0wWQLhC4J?=
 =?us-ascii?Q?0kwDTMKuDQoXXONeH1Vm6N5ZrC91T31oUQFR+++iqktPWIWi74NSHPqY4O39?=
 =?us-ascii?Q?9Ri6SMSqIjzGBFIJhaiO0kdcdIRAdwvoYY0FR5g7YW9GCerXN/O1egEJfucL?=
 =?us-ascii?Q?Qk054JQd/g=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3c03da-0d2a-43e5-2a3a-08dee7cd2e68
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:42:36.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSY73/kkrD7ieyn1kl3isC6U9J/XNxWrTaZIrjdL7gnlQZis89TAaGcM1yNOtfgBypW/PvALp+c7Jadu8LbCqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF6C31DB54F

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_threaded_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err_probe() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/watchdog/bd96801_wdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/bd96801_wdt.c b/drivers/watchdog/bd96801_wdt.c
index 12b74fd2bc05..6a1c5a4d39bf 100644
--- a/drivers/watchdog/bd96801_wdt.c
+++ b/drivers/watchdog/bd96801_wdt.c
@@ -390,8 +390,7 @@ static int bd96801_wdt_probe(struct platform_device *pdev)
 						IRQF_ONESHOT,  "bd96801-wdg",
 						NULL);
 		if (ret)
-			return dev_err_probe(&pdev->dev, ret,
-					     "Failed to register IRQ\n");
+			return ret;
 	}
 
 	return devm_watchdog_register_device(&pdev->dev, &w->wdt);
-- 
2.34.1

