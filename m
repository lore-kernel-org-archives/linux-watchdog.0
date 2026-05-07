Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD9343D504;
	Thu,  7 May 2026 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168811; cv=fail; b=f72FCR6REXo9UlnCNmHdA0CHOL8SaEyU+orl/sqmYHxJptGuC8Jwj7rvybSE+xcSX1pw0Fh/RP3RPjY+VUrt+J0hTtCd/2bjIbx75hiIPLubLneaHBw/WLYnslJPk2Jiy6axh/kSAsKprtiBQDc1IDKgkQTWWLhJjp8TnTCfkD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168811; c=relaxed/simple;
	bh=ZQKpX0pROAvL/IWoXq8oAZylau4Mgmf0bGOD5y8KP64=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CyJX6Rg3nb6qJ99l7Jb6BknX/Ii9wAQ3DRkq0teDs0mI+0Ng2ak7W82fdlCgTrilfiJMdcWB67Pg1/Lmrlpi86OeJZF/uQoFDaAjuuM9+cznK3AUhhTXjcTYUSc/OncfqRnbXf86V77HqMnB6wgEcqQTZLjpw7pEPrnTyWQ4zxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SjigiaIe; arc=fail smtp.client-ip=52.101.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SjigiaIe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxyzvbfyUYFW6WxrPkA9gTit6P66JrY41rdXJofxofzgXNBk4uhYVWSLzFW2nkSxj49mDCDZXpBgbgq9vx3L5mq/3vcrImrDAhIkF00GRRdpZvAdGOWTaFquSO3skJFMqS8WC3PKPvkH9f2rCRbw0SX+vRyao6Q7Q9UNXfvjwbbUOeBvMuQ3kBLXl+dffKMW5PVqiriz7BCQ6vNlKVD1mLbcNp8nht4TdFQvvG1YkQ+i+erK/eSRi0Bofx/jvxb5C7HyVcRxDQCpdYrh1oPY6h7zIMKtKBJZBFdlErjvT0Yev3Tmxar6D4sonNbqqp8RGSPy5wurQuDSUSpfIF8Yog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRmp+j0swpXLTY+E9OL0A5JTXsNEOnxKmrQnE1Zj9iU=;
 b=JTA47+zXLwFI1zW081H+4mfIynEsBw0PFIoWPxm9nOEyj36tTp0OW1EQlGL9qYbyNbSqZcegBapquKLSXFS6FviHnlTVz1Gcm4a+aNi732lPV+z4ZT9GRyg0oxYqBE/66BA1ZLrichofHUKAm4bcowGj64FouUZGFjHKo8ad7yrANsNZWLdpLMMzf8W05ZoZup0ZzR7gNKaujzaokwjMiebYBctJ29dG6bVllZT9iBP6nhN0CUAQRLrZnvEIL4gjJAT+nZSH/UBQE321LOB5dVDjllU0pYyC4vE0f7daUj6DOiILgtkrERTSA2TKFIi+W9JfDOxKw7cfLKuZnJEx8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRmp+j0swpXLTY+E9OL0A5JTXsNEOnxKmrQnE1Zj9iU=;
 b=SjigiaIe5cq/W0kcCPa85SBX7nfSkM92LqBDnQ1F/S5tP7jDPMqZNRX9DD0VdO6m/BaxVyb9nL90RPzk5P3svphHY1C3pvg1vllA5M7bGi3R+LtyG9g4+Afu6HlmFyb3YhBLMR51WasLleXAcBHzY3fymsEMocBTXXY8PUpLW1RVkI98BY2kj1fZYRbZScsxRovnIyngsFzynRbzDe37qtbQMW/z2eo+krYPki0s368TBWIBQrpl+c+sQBH+rwn7RJWZEb7G7Smw5zJpeTrnk/hYqQ3XT6CfiomkD0z9jQ1aDLlT9VdJNEqWgohPMG2fEx3XdVNnAmDdJu0INJf4+w==
Received: from BN9PR03CA0904.namprd03.prod.outlook.com (2603:10b6:408:107::9)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.16; Thu, 7 May 2026 15:46:43 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:107:cafe::4c) by BN9PR03CA0904.outlook.office365.com
 (2603:10b6:408:107::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Thu,
 7 May 2026 15:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 15:46:42 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 08:46:18 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 08:46:18 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 7 May 2026 08:46:15 -0700
From: Kartik Rajput <kkartik@nvidia.com>
To: <daniel.lezcano@kernel.org>, <tglx@kernel.org>, <wim@linux-watchdog.org>,
	<linux@roeck-us.net>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kkartik@nvidia.com>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH 0/4] Add support for Kernel WDT
Date: Thu, 7 May 2026 21:15:53 +0530
Message-ID: <20260507154557.2082697-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: ec20aecd-5c15-4a32-e583-08deac4fd639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	u4yx+JAn4m9sByb67IaHxCh6VgNF8elBMJ4rhT81XMOR3indb8Ih0JBp3I/zhJEVSewBh8oPjpJQzOAkQv7YMQBH2W8UK5U9q2qDOmmudaYCDk1uXDA+TjUNLpIP0FFZeYxSv2CmA7UmXKw+i8kjemw5k/u5PYOWdnTSpi4vf0WjrzZNLRNvBcOHY5xxgfv9pXePqqc/+vqZRb9eueoI/QNGi0KOtKgM+hxfGoZuGL3mL47utJuc3AmplTYy4YGoVJ+OQvO499+BN4REYI6MutO6cr6iAFLll9H+sZdt12z4IIWM+YYu57ZTyvT635HlZC1qmFu30tw5nT8yEo+2/7/VPJUhUHRaSoe2rxsztElGjdbUgJljTJfKT4maiuqc2H6xYb/ub9FCR0phXGcoAw1ruSY0Ipki8GIke+aXKzXZw6Y+z8U6m/7L59LaZS/U8dEmM727wTyp2Hs7PsB6G761MXP2zBD/HCGQGWC80NCaBhbeofXNxKGVU8AvAVB5bnfAxecdAXhIruD9UGGDQ+mSUEYCd57WfqM+eXz8v9Y2sqxJlBWXZYLNdPS/Z31Q2wW0xkSViBa65HYpum59FNuNK/ECDI3Q+k94UCek8hUEgctQfxrs6IOGNMBBx7hB6DjDwylX4bu3FcQhkezWG8/opfhf5RREQF3XagUmPPQ+9/xC0iT8uluhXPI9RZU54LTlrQibh+tBhl0umOix8EtmO+cM7Qz9XrxqfqCD5Oz2DdS1+e4M7ymXRZfU6hmF/1md2QnX+Tccp68EeHI47g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DcuLAIhwkRZuL7Rl/VGdWXIfcWyz1vLgBE1zSAZm1zoPbkRM9IZ07JPop7Bv4KeoG1RvfVLWWBOMDgWbJcDq4Pl5VkK3tOC/Df2oMqpP8xHlXO4s9kGOuLzPVDRHmWYKmEHyLPXslUcGhNmNdfaUuiOqaYvEXKSMzAB3ZpRjnaykjvqhLq6Wr4+/LpQDhF85gJAje7gtM1t4i8cgAOz1Vv/1z2lEtfW9ycorIUPIXFi9+4J1gcqXyyowu/2tp1v0Er/stkbU/SIPfZdYXc58PF0NPFEMwRrLAVTyDb7QxgZojhIqJqqF2D36xFjVf4yIe514UqJuJO25qvvSPb28QoiBZdmc7YQ7Y+5IaYEGaM/rRSVVBdDzGijdW/o/lhElrJw3FfmY7advmkJTf8emL1fqedIKqTjAQ6rUPDBXjYsAozgV3f9tqv0hpH6CHE0P
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:46:42.7677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec20aecd-5c15-4a32-e583-08deac4fd639
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485

Tegra186 and later SoCs support multiple watchdog timers in the TKE
block, the driver so far only uses WDT0. This series extends it to
make use of the additional instances and reserve the first available WDT
for Kernel.

Patch 1 fixes a read-modify-write bug in tegra186_wdt_enable()
that would otherwise make registering more than one watchdog unsafe.

Patch 2 corrects num_wdts for Tegra186 and Tegra234. WDT2 is connected
to the Audio Processing Engine (APE) and cannot be accessed from Linux,
so only WDT0 and WDT1 are available.

Patch 3 iterates over all WDTs and registers the ones whose TKE SCR
firewall grants OS access.

Patch 4 reserves the first accessible watchdog as a kernel-only
watchdog, arms it at probe with a 120 s timeout, and pets it from
the driver's IRQ handler, it is not exposed to userspace, so the
system can still reset if the kernel hangs before userspace opens a
watchdog.

Kartik Rajput (4):
  clocksource/drivers/timer-tegra186: Fix support for multiple watchdog
    instances
  clocksource/drivers/timer-tegra186: Correct num_wdts for Tegra186 and
    Tegra234
  clocksource/drivers/timer-tegra186: Register all accessible watchdog
    timers
  clocksource/drivers/timer-tegra186: Reserve and service a kernel
    watchdog

 drivers/clocksource/timer-tegra186.c | 122 +++++++++++++++++++++++----
 1 file changed, 104 insertions(+), 18 deletions(-)

-- 
2.43.0

