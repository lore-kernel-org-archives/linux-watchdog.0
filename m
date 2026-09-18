Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013015.outbound.protection.outlook.com [40.107.162.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFCB4AAC72;
	Fri, 18 Sep 2026 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741309; cv=fail; b=lgtgP+EfiYtW76dKpF4O3WRAALPCqmwgWFsZFmavntoFYqAnnM78o+e+AJ2NLuWJC2DP/QacchRYGXqjdltCGpmy18MRnByV5ZGiZhrvWIQwmikSGy3/IESA5shA2ome88Lv7Z1vp0gfR651QWiLXBS3mgKhgzBOY1i8rye5i80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741309; c=relaxed/simple;
	bh=wQqWv9VRDzuOp+uRycog8Lc5md0g35n+6wwXQ86DAs0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sObBFf0uae5GUFgjrOAsc1Zlg7uajFIsZnXw/JrAo+JGd6wdxnTkXUbtsx31V7SIwZMNPsLh37TYHU7W0A+Xat47stnPdrB8O9PpWT9eOEslaOBcPUwsgYVRiCHJkHO7lXClj72PC1orDbo76Ku7eTHge4WUOxJqEB97PVN6Ag8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EE1DOjQK; arc=fail smtp.client-ip=40.107.162.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EE1DOjQK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d78lvKfjbwnWtEMDWTT9J322fVANABqRvdx8XM1EPYK4Qut1Bft/f3yBDZjFQzx0TS9BVtUdQzRJo3YDAoR9ujZUNRHdDJ4UbxljytZcBRKf9QaZLAbeLa32i+1hIi0gBzZjV24MyF6IgPKWzGDpx0aDvSjkW3tbEzgPjntpJduxYLrsqwOVulEgmPozbD809YAWqac88JwGYBKQndKCHVC7QfsQ842WOzS88xjlmcCO5e4pnrr+6+VDPUAUfBKOlo5z33UeYIvI9cFfF98Zg10Z6t+rfdOni+bW1/mrZbh50ak2zELd3fAbhL9AXYzMjgV3FeNOKLl/Cax/evUO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuwkHkZMJbzh83r8iuZ+4Dn00UZG7qtkMTFg5AUR7Ew=;
 b=iLyb+3H1KqOlI0IQ28IYX76TIu6C4+h9TOJSS3azgWptWDundf6arWrm+u3nBHKpDY50xdCRhEWv7tmyjjREyP8ZlxlMJZEA6szySI9U4B3YK3jVxkUQhqop2fMtqjiEUUqDUM40ftqF10AzF/1zD+bCtnlvoZDVEEh8ykDZQyFqRZN2WoO8WdIA754XMeW45YBauNqLCsDn649mlGQzq4I9nsLMeueOFLcWj/al37n1syxQ3QQ1ZGCaU36lmwr4OSbSSr2Yl+TGjD61BhaToGMP//HF0NZyWNYnuTkr2P159mGh/1jZkA7uM9Msvq6xp/j/jFR3GEa/6zewGirLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuwkHkZMJbzh83r8iuZ+4Dn00UZG7qtkMTFg5AUR7Ew=;
 b=EE1DOjQKxWViTuo/6Uj+ivrX4n5a8/TLZjiTZo2OWRgdNbJlzXKEnP4Tm3NDiT5GyAyH2/g931oUqzoyxd0xOra2R8EAYhxrRt6YME1949SzHJQr58Blwx5lR5VsXaIFSxaPd3dUsohhIhWMxFW0LWYZUQWuqRlEdmx+YYvNXFFbxozthfqQJI+eDbIR1umh5+ETrcz2tOqCXQiZdzhYTgQqyWZDTISmmq+WWWMBBCQjEqbJr98sTyNqLAqkfpfMYHncd/KAH5c2832cSj9EhE4TLAbJGlxHsBYeVfw8S7KN+J2m4HNhe4XK2PqrItbbuD4LvyWxFfkLsKwbq62I/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DU4PR04MB11846.eurprd04.prod.outlook.com (2603:10a6:10:627::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 14:21:46 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 14:21:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: use assign_bit() where applicable
Date: Fri, 18 Sep 2026 22:19:14 +0800
Message-ID: <20260918141915.3023207-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:295::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DU4PR04MB11846:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e161db-993c-4164-4720-08df15902b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|19092799006|56012099006|10067099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	uNXW8z3oL7TAL8JFdE1ideKyJk/AA7nIgGRACNNDBZ4eJ8QyPf0pL+n/gMyZ2xHngWrHFXtcWW884NxyFVk3S1PxKD17Ey2uOW1DyZllFiv4KZZnTjxYXjzbq0vy5S9UgOswoCnTei7dWiSa3CDNJ9jYbFGTejVdR4yYVjGy4apsui6I0PsQdLX7k0x0ZtXMRVQsi/WJCpx1j8DeUGsU+Ij6PLSEeD8j7D7VGQM7THyDGwpVQlngkfaSM9Onim3M4tEheK7OxSXuqGHMZ8G6GpJDmvxeiEfgqWDDbnEJr5G4mIWjH5NUi2hwyX5Otccx7rL9ot6OCjontVHINU/n+7V1j8HFfC5c8opO0mgmcEjYFOFyUYKvsR6QS6pc/5EyFN83Ccy19B/cqpMM1901SvfLc6KfCuoF43szSw0AonzkpEdDAzKx6FjnuNIoQXM44lfKehLfBqkyTJqroKBPByoRjAsvakpAWyoYOeJUHsi9KKWwyx4oOjdAegTjf2TxwfuMmaQ9TW7CVq53vQqIdry50v8/Gsvh50oR7OyUz9Xbawb1OHBLFGMBbNupuBlxeKpwppHdRAwnWUJ9TvGJKbmyIycCa06bbOyy+NswLL5pDjXLuvsMoZfr+RVg/D8OHMwqDb/f0YaJ0uDIrQUGRM8+Od5gak4rn5NVB08y0c4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(56012099006)(10067099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZoxqlM9mfWUYglSfPJeV/1vyeFCZ3J76K0YASfgOIOot5E080cb1a9nRlhCt?=
 =?us-ascii?Q?UWHzY2ntGLeFG+w1MF90c5u1Pq5VxkTgiNFtpZDqBg17hNOgHUDe9BQwrzat?=
 =?us-ascii?Q?q69Ypl+aZMT7DrZkL3H7ANC1ZeeXm4xyZjeKQSrFkSLo9Hs3U4dr6KHZlqIQ?=
 =?us-ascii?Q?KNhSq+APKHTlrDOONf+iy0UevbTU4N3KwWZyKkMzilHOguQcaHezRjeppcrx?=
 =?us-ascii?Q?MCp8a/EccglC92l0EUX0MXhkJIIRtY0/XnMpH56FxFWVCPE/o+DfDjHFgInd?=
 =?us-ascii?Q?z97FpZJrX7+BDDZmGqPmNQRhtttq9fIHrxlUPdNA5X1zRrz/pH35RqB/Q2IB?=
 =?us-ascii?Q?I26Ky4iyVIF4gdKswc76PZX3wviPc6wq3Z2+UwkKIO++caFqXsfqu4PnvbWq?=
 =?us-ascii?Q?SzQxFbpbubKYOqUpUDyQC165eUfqF/ndSOvl7Gd61zcoqKrBghLrpOlbguvL?=
 =?us-ascii?Q?Fxa/DoQAAu4SuQsJ0LPh0xFK0JWWW3jwSaaMNZPtt2zOTnvJGzuNS7FA6jZx?=
 =?us-ascii?Q?VnivZkqfmJO6qMBUH4HHXCaXPSYRe4DU08ftDBAy0u8Gif1kHFbpEhlF/w7K?=
 =?us-ascii?Q?mgS2v2bkQF/84QFtQaDAC6IRIsecgGItFTM0QlRHFr7mdCwUHyhc0lGhUA7a?=
 =?us-ascii?Q?fIOtsA6Nzp5kc+Ms6a2sABl/n/dvj8qNEEXHE4XIbqU/gmk9E32knuScKBLz?=
 =?us-ascii?Q?f5oHeoQFSiuRB2NsFDG2+zeofMe4httNvs2i5Ziu091MdT2hAEtwoTOp4ToF?=
 =?us-ascii?Q?dkgH1zgZbeoJMkuK5O9TeuQIqk/TeeaJ27Z7+bZjNTG2uWfzL+xZxoqb4E12?=
 =?us-ascii?Q?Z/zqSOKJe6byXNjgceofvc63xfg8TZJvZkIQfHh83qZbu3V4ovmLGoScv88D?=
 =?us-ascii?Q?7FKWHBXzz31WQ3aIgWxRTG+Wh5aJJGFvPkTmBFbulGfrVXNGVzvySp3uSir5?=
 =?us-ascii?Q?85AfQ1wAx4kNzyjSoqNdAMM41gcc5Vjd6ed9lzJ8WmUmNM1mM0W8J8KxUe8U?=
 =?us-ascii?Q?NdNgJHbWA7hZP1fXIgMrzDZWoBzCfVjxsn28eK3NYckqXTmAEf1mQsWCDkZR?=
 =?us-ascii?Q?iMD8lJwitWgadhmz69wWA0JfN+18JQZNeDVYRGCDgOBpU0FAPMZG+O585/g9?=
 =?us-ascii?Q?bfEOg+qLCVNsjffNzDSYPPpp6G0kbVW0NO+c6y7R/jz4by0IpY+4SNXg9QHi?=
 =?us-ascii?Q?aG3qcEJwY7CtQLKkPVYa8FpmhR45UyffKwEpoLZm32VymVFGJhbm8pQhX4wD?=
 =?us-ascii?Q?QaqACL2SeKYvv0qcU2BhQh+5Jzq6ivLHFEUzA2IijT3Ho1bYrT/5gOiKedJl?=
 =?us-ascii?Q?F7GARj9zEpp0+QlNtL/p7hU+EqOgz8vRX2yp+I/5KUBMWV/ger+lGzvYdPG8?=
 =?us-ascii?Q?2ogNwD9TSJbZW8hr8mF7wWehT/YptlLbwxw7AHzYhsKySpn3e1pdgbmz3NOI?=
 =?us-ascii?Q?7xAbSKhH4gkxpATpOHn4vAOyISkxaaQktY7hitG4XZ8oGM16/DiR8oqAXoAh?=
 =?us-ascii?Q?MI2PtCx6H0Dou3NtVwAdxDdwdrfB00GSXlTcWMcbFEF6aKH98Ogr69t17F+4?=
 =?us-ascii?Q?UbHueVqkZKKeTdrCpX1oR/1h7tXTpULCV7JNH58EzZdh4f1nA4H982w6K8YG?=
 =?us-ascii?Q?O54lw7yNI2K4mX677TZU1+RzA5B9VJYpBxO8a1i+EmNmecGp9R76WRf7n/MJ?=
 =?us-ascii?Q?8euWpHXpmJ4yU11FTl+2u+7LAQAynNMbhkFx69W8/S+TMKuskSUXJjfV3ta9?=
 =?us-ascii?Q?yS9hEOGnCWOYb99DognfOE/f4N7oyRbg23T29nMnzL0h3tfexpqV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e161db-993c-4164-4720-08df15902b71
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:21:45.9094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VseDXookEvSuNfwQfp2/gR/f8r3mVgA6587CkfDXs0T9kRBRpGfpbb5IxhwRnBRRwawqpd2tpESosOz3uzE8NL8P1kZOO4tLUpR09JmfLM3jVjE4Aar9Hg4I8HAZo15o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11846

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit and their
non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/watchdog/watchdog_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 38c1e63a8e2c..2948fe52e093 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -314,10 +314,7 @@ static int ___watchdog_register_device(struct watchdog_device *wdd)
 
 	/* Module parameter to force watchdog policy on reboot. */
 	if (stop_on_reboot != -1) {
-		if (stop_on_reboot)
-			set_bit(WDOG_STOP_ON_REBOOT, &wdd->status);
-		else
-			clear_bit(WDOG_STOP_ON_REBOOT, &wdd->status);
+		assign_bit(WDOG_STOP_ON_REBOOT, &wdd->status, stop_on_reboot);
 	}
 
 	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status)) {
-- 
2.51.0

