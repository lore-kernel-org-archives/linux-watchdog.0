Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011054.outbound.protection.outlook.com [40.93.194.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA7B449EB2;
	Thu,  7 May 2026 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168807; cv=fail; b=E3nLih1t8SvdTeR5UojJm5af7unSwXXuNCEptYY7a7/giHexJDyhFH4bWybEGvmbYyhs1/W86aSoJIsRnPhoq8fTgdlAE0JoJLXHVPK5y01TweJBVW5oisxpjNAc8ggUPat5M5aHilGWNdGwMd4mJ3oU8orhEDJWA8bzF7yf4nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168807; c=relaxed/simple;
	bh=7rU+2gn8l93DiQsmB0xRwI8LIU36Sj6bfy6r8+TSX5E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTxyxNVr0WWTJuVAgAvkhYVMAaNghtvRE2oCG6hfE61bhmIwJ8hOc6TFmGfMBlQQFnJa1UaN4ae4jubbO0cnJxSC07UB9kWONyH7+oynHQ7Vy5vnvUK+VGQkJpKGJX+NX2q94jBKzlL3C6qo6swWk3DV6F5hhZ3xw/dZbLV4F0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hjmyy844; arc=fail smtp.client-ip=40.93.194.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hjmyy844"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3w3ovhf8q085psa81SVGFd5Q8zLHjkM5wLUP7/2GqmpF0XR2hKArtEa8R0NKdEJcFG8SFzLDUfb3cMy0dvM8eZ8K5MjszJut1FUxzwUzPuJVKGet0Z0akPajCIEBgiQVK9RxVBpnIr64aTcol/iUwlNqefHh+WNDfDYFLTdJLy5iw91ysOsn7Skz4qHL7ytjIrlJQ++hDtC1wrUosPhU6laG5nbVDmVjc9e3JCCkiaB4pXhw8fndk/eK+fxDLwbDJWMxTibF7Fq8orhcs+SoVjc6+uNv3NRVwqoQIVRKwoTms0yDN5JwiqkMwI2P2MDN/Bz4p0tCbRiD0uMcB8GHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQjD5d0JIONQO7qM8OXzU38bV5XfopoEBbGVPjRVJgo=;
 b=qYsG5nMZKhcCW0xBpmBx0W2gOsfMz+XyKg0X1J4I2cHelyUuXyJMTjdQ8qdSIQ5GrHSVzqg1VrX3C91JvSTTjJgp32bOjsn6aFw7ZAg1uyjQkFxa2tBBKnTdiw+7+X+BLR6lnsqmmJig8tZpQ5QbfbT2KEBQ+128NYsRKTktICLg6UWCJGAep73SMUfpfGZ/SFhmvzmOyhEZmkD15uYwK7f3lV/MnGrJo6tuEpgQCS6zAahJwFmRUovVPIjPvCRO3f51XCW9NGKmHBdFHQ4lOiaVD6NCpdjV65FOrpedsJpTwWA2IwJGF2VyfEkeYz9UsfWo0ZEHWiWolBvbA6Aqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQjD5d0JIONQO7qM8OXzU38bV5XfopoEBbGVPjRVJgo=;
 b=hjmyy8445qr/JPVqAaH5FZ4Jt3idq7EjiZa+tS7dTb1388e1Ma3+czFtrGoHGNBEBZ80F3lMfOUA2P6ORc6yfJ63wWQZydV9fWs8qTl6l1JdpEipNejPjTaGSOpW0tN2wxRhY25CtwffU+lZndhTxt1GylT/TDDFa93TG0UGWpgy05yDzRwHZWfm6w0kTckTTIGvsNcCePya5G39GMheiv/fN3ksqGY7ofTk+H18PmRJrcRE/h44uzMFG1mTiIE31nV5wBX4dxN6wiLAztWtvj9bq27C2rqVTU+fnBKkd8hhtaoCvatf4p9abmdK3nP97u6tYTXu3jx1/SyHdchpMQ==
Received: from CH2PR14CA0015.namprd14.prod.outlook.com (2603:10b6:610:60::25)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 15:46:39 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::3a) by CH2PR14CA0015.outlook.office365.com
 (2603:10b6:610:60::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 15:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 15:46:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 08:46:25 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 08:46:24 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 7 May 2026 08:46:22 -0700
From: Kartik Rajput <kkartik@nvidia.com>
To: <daniel.lezcano@kernel.org>, <tglx@kernel.org>, <wim@linux-watchdog.org>,
	<linux@roeck-us.net>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kkartik@nvidia.com>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH 2/4] clocksource/drivers/timer-tegra186: Correct num_wdts for Tegra186 and Tegra234
Date: Thu, 7 May 2026 21:15:55 +0530
Message-ID: <20260507154557.2082697-3-kkartik@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507154557.2082697-1-kkartik@nvidia.com>
References: <20260507154557.2082697-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd5d3b3-be82-4021-7880-08deac4fd3df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FzEjGESkW2JVQocR3WwaEMXP5PRfQod+f6bVuwIT9tvhmKXk5mIrE4EGwXl8u4dL4hVmUwkn+EdFlxywxX/oEZfPF/LrgVWtSfltS0bddEYyzZ63pUMOKFrDhxfiHNjQ79ly1KMgXA6nHBhm49BGedIZxEgF62QH3Hc7ugT1MKglYd1k8LRvXL075xdZGzLtbHn0yyc/mdZewiqFoy3dk5Ji6c7E/DgTyRTdLN7ljhPLq9lDDs676gElj0ZHjkpwiLHvRwsmG3Ceq9sRuj+seHo8hQ5+lnGiaIlJy+nyd5m7nGI1mauHISQkm0Ckhbo/p+zPdewCGs8nRm9XQ94vT74CUqn8lsKpeDzVXkrp8zfEKDOW7BDg0dCQN++9/e6bnBwmRt0sPTU9DovQZ47npZlED0QIgk1qiNQoc/Mb6z0JvJC42xBW0tuPyNjbY/Ra+8QXkaOILEM8FVHDZAPTJbcqJbI7RfGVptWA+1NoVtz4y7n+zwLtVF/67zrYQT0HSJcLEq71l+HIyORo8lEM7IX6D+YywHONFgYeOk3VkR1dxZR4yu7I5QF3szL4foG8XmIF3cKNwq3qH+JesakQx2CB/fCq2OJ2C2balIYAvlbluTWyVw+Tg1e+md1HdpxJapFc4VqhpFl0UOEu1lswqa38Nt8nyx/dzd3yOgSFwAXmKe+SwZk793bZXSmYo020aOLGYTLVxdej1G9Qx5VbG6ftDybLmi/3IpRSDVMhSiAZt6dBMs3TyQoG2hmwE3Bfxd2OmLriiRAYb05kMMR97g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9ZcYqJriFfGCorvqg5+/u2w7Q1xEhWIWnSzt1U6ADpVNQpqetjINN8ROk88XD3WZrEjFTBhY3RVc9ReG6iz1NE356fgTrX3/1ODOMYE4TMAfsEAb/wRyMTBfIJxm49qFA1w+zaTGEldnYzCePp5nEcc2kiqzepRyci/bftnNqFXvcjwYdiaqBsVrZWzQ238B1n65VHn9zk63w2Z8ROB4mY7TW2buJi3t7Mv6jaBxqVaLxnmaQHccGIlrNVTD7X2K8Er7/fEuIncPnGnCXLyUeiCtjRAgiKQU9aBxrWaC0FLhUoagODk2kTvHgIzB7LGhApenP/SPI/JL4zQejOsinIj37qf6WXma1O2GgOlKn/5DeJLqiDPT6ZyONgXpWDOYucw/Z9ra/mjva82b54W5lAXVk0ymTdt68nocY4/EKBSsBn74SP8DJf1nJN3Oa20X
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:46:38.9045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd5d3b3-be82-4021-7880-08deac4fd3df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393

On Tegra186 and Tegra234, WDT2 is connected to the Audio Processing
Engine (APE) and cannot be accessed from Linux. Only WDT0 and WDT1
are accessible to Linux.

Update num_wdts from 3 to 2 for both Tegra186 and Tegra234 to reflect
the actual number of watchdogs available to Linux.

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
 drivers/clocksource/timer-tegra186.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index bfe16d2d5104..fd82a73ab2d2 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -511,12 +511,12 @@ static SIMPLE_DEV_PM_OPS(tegra186_timer_pm_ops, tegra186_timer_suspend,
 
 static const struct tegra186_timer_soc tegra186_timer = {
 	.num_timers = 10,
-	.num_wdts = 3,
+	.num_wdts = 2,
 };
 
 static const struct tegra186_timer_soc tegra234_timer = {
 	.num_timers = 16,
-	.num_wdts = 3,
+	.num_wdts = 2,
 };
 
 static const struct of_device_id tegra186_timer_of_match[] = {
-- 
2.43.0

