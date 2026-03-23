Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022122.outbound.protection.outlook.com [40.107.168.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E73A38C42F;
	Mon, 23 Mar 2026 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265147; cv=fail; b=JEidC/Iw8a7yvbQ8IOuoIa8YWemTcz19NbGcbeYT7kkgUrlMrJTe/UNgpC2VYSFnBRtE1vNzRvvfNd5eTe7Ll4W0R8+5zFSJz4nYMm2SeDbf7hOM5CfIvowwmb2rBBEa4ZIppPq12JvvMLWGZq80vLEYLpcCgiM2JkohPHvX0LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265147; c=relaxed/simple;
	bh=LE/irtRvwHSzF+xHfuC2k0p/NnAY/upctq+rtR3W+eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z9iqUq6/RppUiuYy4giOUqGERLwOjydRjChkteGHZztjlo0LMQGeYDzQ05jWHA0rMjA7r3aFRC5MHjql0fThAj2LPnlcm7kgdj6dA8WQcDvYoyFCGohH6gp1tsZ/ozd+h62QAfFop8iiHkUcdyGO2EK9P7t62rJS7o+JBhMdHOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=jBjtpsFN; arc=fail smtp.client-ip=40.107.168.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="jBjtpsFN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hq2CW/oyHr+nqKaNgXbz9zS6KOTBkG34P8tLhMdVUfhH/9G9SFIUXdKsRycLAHWpg5YSGebE5UcR/DJvIIhkfPD1NpkvT321z7YGC4LgQpC2qDRgMm2F7IXzNnjEkPihfiKsA30BLYVujhVGeym3tMk+IFXh0P4Y8v7wMun3WnryHqkZwf9oFh/OH8wNyIMKso/2+nwKHJj6ETtXCDiwDST6A7L2yCDz8FYgIK8Jkj4sJB/tQC1ZMt9mPkiD9j/moKwL1n+nHm3pxRgQbpGaBUFBLFoKXwVNLLBo4pKX3XPJNw9mp/d8uHaCaqclYtDTpz2UH640z8xIpDtrAUPM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZS587k1PXcvhpvh1Gt0o79M0a6QpxK/SoPbJTNWVCI=;
 b=BPYdlDlBTdRR8cZZyScBayfs80Z9GNWfUdO8OlDxHnEq8nNEAWyuI30hhd/3DwxmyP0PBcYCOMrMpzTwv0poVv9citEcbKDVevlSPOzHWzD5TwfY9uxRk5+xhM1g4f8lZ0xerL/slsjv87aBgAhUW0vJK5mQfd5M42QB2vVyGCRG7V/Zq8xe1I6A8jlnnx8zNhN+8Qt02NZeeKVlpde++IXZygTfQBo5sMQy2jPxmJkzq/hlfwm3Jgg1piu7NVUL0oo3pPQ3Khlhmmc66JO6WWKvqc9OEsz0h4CfX2hDts3lqVJJlw3peqBo70HSHOOR8Icmsl67y+liUQs7VrfJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.1) smtp.rcpttodomain=kernel.org smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZS587k1PXcvhpvh1Gt0o79M0a6QpxK/SoPbJTNWVCI=;
 b=jBjtpsFNEJi9EzjocRk+Ob6WcoSCfSFQ7h+MM51lProsB51zAsk3U9VbkyaQROS9D53HTGsG3O0TYS2A9NuUA2lcbEBS7v7gz6koY+9AK2F1yMTd3cSdlSb4OaN3qgxyQ4vYP2SdtzA7xLHoOXrcQGjRWiDDpcrOXV36XCwUaK8=
Received: from CWLP123CA0198.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19c::7)
 by GV1PPF260593666.CHEP278.PROD.OUTLOOK.COM (2603:10a6:718::209) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 11:25:42 +0000
Received: from AMS0EPF000001B2.eurprd05.prod.outlook.com
 (2603:10a6:400:19c:cafe::4b) by CWLP123CA0198.outlook.office365.com
 (2603:10a6:400:19c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 11:25:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.1)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.1 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.1; helo=ZRAP278CU002.outbound.protection.outlook.com; pr=C
Received: from hz-deliver01.de.seppmail.cloud (2a01:4f8:a0:13df::219) by
 AMS0EPF000001B2.mail.protection.outlook.com (2603:10a6:20f:fff4:0:10:0:6)
 with Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:25:41 +0000
Received: from hz-glue05.de.seppmail.cloud (unknown [10.11.0.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver01.de.seppmail.cloud (Postfix) with ESMTPS id 4ffW7T3srnz4x0w;
	Mon, 23 Mar 2026 12:25:41 +0100 (CET)
Received: from hz-glue05.de.seppmail.cloud (unknown [172.18.0.6])
	by hz-glue05.de.seppmail.cloud (Postfix) with ESMTP id 4ffW7T3VNTz20FF;
	Mon, 23 Mar 2026 12:25:41 +0100 (CET)
X-SEPP-Suspect: 42e8c3d9f7124eef8fa5794b18aa0284
Received: from hz-scan07.de.seppmail.cloud (unknown [10.11.0.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue05.de.seppmail.cloud (Postfix) with ESMTPS id 4ffW7T2nqwz20FB;
	Mon, 23 Mar 2026 12:25:41 +0100 (CET)
Received: from hz-scan07 (localhost [127.0.0.1])
	by hz-scan07.de.seppmail.cloud (Postfix) with SMTP id 4ffW7T2FNLzmWx;
	Mon, 23 Mar 2026 12:25:41 +0100 (CET)
Received: from hz-m365gate01.de.seppmail.cloud (unknown [10.11.0.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan07.de.seppmail.cloud (Postfix) with ESMTPS;
	Mon, 23 Mar 2026 12:25:39 +0100 (CET)
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010001.outbound.protection.outlook.com [40.93.85.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate01.de.seppmail.cloud (Postfix) with ESMTPS id 4ffW7Q4W5rz2xGy;
	Mon, 23 Mar 2026 12:25:38 +0100 (CET)
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 ZR1P278MB1170.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.31; Mon, 23 Mar 2026 11:25:37 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::30b2:3be9:48ab:c354]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::30b2:3be9:48ab:c354%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 11:25:37 +0000
From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
To: jth@kernel.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>,
	Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
Subject: [PATCH RESEND v2 1/1] watchdog: menz069_wdt: drop unneeded MODULE_ALIAS
Date: Mon, 23 Mar 2026 12:24:13 +0100
Message-ID: <20260323112413.21923-2-dev-josejavier.rodriguez@duagon.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323112413.21923-1-dev-josejavier.rodriguez@duagon.com>
References: <20260323112413.21923-1-dev-josejavier.rodriguez@duagon.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0053.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::13) To ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:34::6)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0523:EE_|ZR1P278MB1170:EE_|AMS0EPF000001B2:EE_|GV1PPF260593666:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b29666-6a28-427a-804f-08de88ceeadb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 jAj8MamFlpaVGp2ZGS9YoX4Ni8zMXPZxrPwAkvGJrlBt5gZrNPSLvashFU+OXwhNhrzTD3MOolSfFPKGcjbeH1Ga5MAi4jgXF58ybHRkjxapi+Ru5BYlHRoXp7X/1yv5elDU3KITLI5qm+9YR193QEQShGN2KD2u8ZbiZrCBrrgGRUVdQmpAsRjqVpE8Zqcss9wsrXz90YsU7cMA1DuiA5wpwSl4UmIhH9Tbrx16ug30fmn27rNhOST4L2IBvojcfHJ0tHrv9Eq9BAAnBiYNzet/i0pup5KgYsVJUSAitJ2HunSG0SHLkmx6s9uJNku2JFvW7vfA/7sZXcIBfE5+IpeQgtwi1/ydn/gedepqqK+bkEyuc8kf/6D14f7DUuUsdKzOBmKUyXIWLe2f0es2l2HrI2Rgn6R+UMNWvt7mUL7rrVoHJyvz8f9kZ565rTVJ2oblynXw1RCKrLORx/7EMvce8FViAYV1Rett6LYB7rLsvaWHAaGE5HhegaIelQe9KM7BY4tATwfzlbUhJ33gZSbdjW3ElkYSn/YZc6GPJR1ZvPsxavXAwnVK4Vy91OvMo3JBtNfAs9dL4/B/7yL7IBiGpGBjDeKhHLXvIYil9TAUqB862wdfQ0CFjtzJrYagdCI8JsV9JxOjKF1kkyAX0e7NvT1VEh3p3dnFr8rzl80VJ7Y8K4m2W5Ky1XeVS607f73wFd3zKjhsV2yu0zIwBlP2wdYpjb6JqLVUjbZ/iIRpej4RMEk6RJxvegA3wjdM9idfe/c6YS52+vMFl9ED4ZX2eOWMy/QoN1D7T0jKf5M=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 XKRgTnHR8ir32hkw6eso1qp3lnqnfdcTuNtc4eIWt7A1PV+aMT6ND8FN1QVRaDaXC5+nJrc2SkjOhqi6F8P47xUlXjeZ7cdrBUocRG+5X4dcv5kXbEPCUxDyEiALzjolwcmBiUCnhEOVvUA02ZfuPHl+fdCwg3M/hR4PSWUFjO+X1HJ3+axuCyy1n/WuOgSHWxONAc+W/wHkQamHY6AUs/lArAc0CmDQT16Do/rLl+pdxtyOQw/Fdf4oagTXWHPiywqK/XqDo672tG7QnBSXKk22X1sFxeBWWyQtdDBnGDeiMowPZwiIRRChk4iPP5TDAn5aoyDHDapXoYvbjO+lBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1170
X-SEPP-CCCVersion: 2025-12-11T08:12:51+01:00 9ed91da2
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.1];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.1];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4f82c545-2d24-4636-d0c7-08de88cee7ea
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|14060799003|376014|36860700016|10070799003|35042699022|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AxrnlHSc/9s9pgD3msA+DlqWKkjgV/GoGUUj6djDYPXe5VP7tZIkvcQm/xjM?=
 =?us-ascii?Q?iZ9jyK2bvedn57qKxnFZ/DpSAUAex/RI1e20Tp5v/JyDZW7nN+Q8HAPiUOjw?=
 =?us-ascii?Q?bZU8b4RHNzlqKC1Y3mw6o26cQxRLXXF/K5lmLrKibCRchIlk4Frimbbr2e0g?=
 =?us-ascii?Q?+/sCkzTfU3UbEtkWVaV/FMBs5ufvWyGlmtQw5YtFF4/36uR5UuDon1xmaiNQ?=
 =?us-ascii?Q?lKnTAexPPhIVncLP2H8OeSzCE8KXhGhjcAsvCsMDzVINGQUCUUf/WFQCM6iS?=
 =?us-ascii?Q?OJj9WrLwLGC+zJPmuIIeKH2Gy/Rt2UBeWK0FW0FmNquOGtJnwLNkz16uf5P/?=
 =?us-ascii?Q?xy7PQn72fXaZW/h0c4zKDl/6R2i7iAPYF8igRSuFkMk/u7n4bp1BbFG3XNXx?=
 =?us-ascii?Q?G6L9TwT3cC9KBOvRS//L+fVSVOa6QBGEDqGrcMNDhoHZLTYsoKu/WUKh09Cs?=
 =?us-ascii?Q?9mAg39CAfyq6aIp7hzt7jNiF+lZrGYaY7TUvkjySM9afLOnAaWmjyb/s7+Iq?=
 =?us-ascii?Q?k44bvaclJOjvZhKVmxh0oZ4IOmc/p5NNo3FffVc8LEDZ6Okwg1DZsO/DsK+q?=
 =?us-ascii?Q?SQtR7YMq0Ju0OyJfgyef8hok78MsCt7GxOPCteYOdTh1be3RSZsAEtEF5OZT?=
 =?us-ascii?Q?cRBqRMv4KcOZZQhsIzYvBd9mCedfJflblRXxX06Otfn5KeNBIzvQ2XOVXtyS?=
 =?us-ascii?Q?+p0jSeF8Er9Jb6QIW8DRFXeSXie8RwSmVf+2OSvenlKbuW4oDCL3tEJkPMkH?=
 =?us-ascii?Q?zZcDCy+ozcd3HxQCwutxCPEa1Fm+aa7XcZjYET5Nx1GgB+pNzICZcmu2esGv?=
 =?us-ascii?Q?di+ti1pNYR61bMRUFIfyPWYXIJK5QJ0MY5NTm52w9gp4JCM3ROlg4XrJc4MK?=
 =?us-ascii?Q?4YbYyrBbg54Kdv8MH5OHY/4Vex0pwoo1Ezcdi48gSiFp4WbGxLka90cUOHtz?=
 =?us-ascii?Q?6r33gwg3BtvzE4Yn08sNEKq/udpS+SC1z6XKr3eA3W288g60//jKuuou55ZL?=
 =?us-ascii?Q?HPAfr3p2HjMtFv+C/jm1wtLYHyP/9rUlsQyan1KGHdcDVwewNs+hPZwaZsHG?=
 =?us-ascii?Q?7sV8Y9t/5yPZqTW/qwKKL0DfnAckvPfICvMcFX1RkxETXVMWUC7SqIX3KSOG?=
 =?us-ascii?Q?AtuNX/uRVCIHTqz+B4s7hfkfso0mxdKytSrjM+BjhYZxYX+yFCGdwH9jFJd8?=
 =?us-ascii?Q?5cJy6LeGChKjVHbbW+T8vztAEL0Ls9WG769rN1vZDSYW+tankycopjYZ7aCt?=
 =?us-ascii?Q?PYQaf3EqwMKztNQ6rkIxJzRP6ejz+Da+JHXhmF/VQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:2a01:4f8:a0:13df::219;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278CU002.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17010001.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(14060799003)(376014)(36860700016)(10070799003)(35042699022)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lBrjc6IwDrdSi91MTAgcdwF/9zF9CO27iXUGNY9UJZPcRih3ar3rXUR3E4BlTwi7RBnEkFPRwttdz3mez7HcnVZB0r7XJAs7VAb9xR23X0yA8sdqm0EY2oFRaAhGVcpAj9RPerlXSk+nByMY8aQ+6AlWKqWYKZPdaAH5xPWCLDDrKRDVEAPGGmbMPi14UPFr3Tyxs6Vdw3/Zgh/r4gjMctUP13Wi9VhDT9zWH9fQhsm+NIlAtNC7y+HIH2ooxgqCkxF0ph3kVC3LLNHbbsEp2pwQMjgnyt/B5c51yLEHcB0tlEp6e/dlMgDNKnhNFiI+ZaovHYAFcGEX/xGw6u0rK+ucMa0XXt1jpqZJ9Oln+8swKM/90k4oKogkYITeJkBCsZnrsQEGVLWyv7cxkVekDnOqm4aj9Vze+EFqWD4I4zKih0uCUbrypuWPJa8OA2zZ
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:25:41.7205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b29666-6a28-427a-804f-08de88ceeadb
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[2a01:4f8:a0:13df::219];Helo=[hz-deliver01.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PPF260593666

Since commit 1f4ea4838b13 ("mcb: Add missing modpost build support")
the MODULE_ALIAS() is redundant as the module alias is now
automatically generated from the MODULE_DEVICE_TABLE().

Remove the explicit alias.

No functional change intended.

Reviewed-by: Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
---
 drivers/watchdog/menz69_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/menz69_wdt.c b/drivers/watchdog/menz69_wdt.c
index 6e5e4e5c0b56..3fe23451135d 100644
--- a/drivers/watchdog/menz69_wdt.c
+++ b/drivers/watchdog/menz69_wdt.c
@@ -163,5 +163,4 @@ module_mcb_driver(men_z069_driver);
 MODULE_AUTHOR("Johannes Thumshirn <jth@kernel.org>");
 MODULE_DESCRIPTION("Watchdog driver for the MEN z069 IP-Core");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("mcb:16z069");
 MODULE_IMPORT_NS("MCB");
-- 
2.52.0
