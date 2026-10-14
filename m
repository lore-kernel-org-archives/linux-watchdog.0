Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF63A30D3FE;
	Wed, 14 Oct 2026 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941406; cv=fail; b=LfC3lmQZUwob4vUoDvXrCOO1g2Y9pl+FA2ELf54i4SVOrtYkAPPi1gSGl2tnb26c1ng5tVD4SFT5MiXk99H5R47Zu/evFUX2Mca+hXeod/4x/5cFTom+AUzsGF677qCX/eNaRpLZxBus/DcCktz/soziZsQvufEBIlnMbemOk+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941406; c=relaxed/simple;
	bh=h43Ss7PdOnxLEBzuKjqmcNa2xm/5PEaikdGA2nv2uIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=maH3GA34vIUrta5iQvusMoYdk6nVsvOy/DtFMgxhZqBvKmnd+gP/+aEjftq48aXi5dXL3YGN6XXMEDA8UTF0EB1Nn4AOf9/46O9HBoh9q5zWk3cfwDmsvbZvLyktCGCQzYY1hp+/VVrxm4cq3sfEkgnfrSGGyviJ5P8zS8vxdkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H8vvCriZ; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H8vvCriZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiMsxNefvBhWVPYb4jP3O+avRfueUs6roo4Cs67Gr9OD+yjcI88GnQ1fxmFJOtVjlHd8rAQ/OPydqTbQTwVy19pILkpeeIdzjcpVQWXruMrl+BDQVE5e2tP00jElwuqCcIV+f97G3IOYNN6Pc245r3qQ6w1buq1IL8FstzSK6bpYdXJaT/9nHGSdJ/ItDRm6rDxj3Z6JWhWY2CsX8Za7GprYM+OeF7zVfX68wZgQi+B0bnvdx6JOkb2CEu9/98oO0kSUPj2nLaXfYizX/OOI7MDpe9lJkmk0rYt8MAkKVp+1KshXCU69Wx/kczdcC2eoVtnofskPs26SyLqQb/sCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h43Ss7PdOnxLEBzuKjqmcNa2xm/5PEaikdGA2nv2uIo=;
 b=nrSydd3TOsqDiaDbRRq6uObz5e89mH7SFvjN6OSorasLdxOWB+Xxz8JlIYsR7bHsXNd+ixtQYS+hwQIasqJ4B95edXE/lq+YUgw6LkVffEC5kifhScf1baLmIUR/g5wY+d9kA7WZgS2GstX4ezOGzm/fonskt/ASXzr04oRQN6YJsnddn+z/lFEIOdelxcbUuZ1v5kpXZKafUx36IF86uezpRIGMte6lQpGNvhaUzmDyRj9kUABUyVtzhq3r/dM7eopJI7Xvn8O0n7TGLdmIgKgAFlUTDnFyRxPaxbf+MpsC4sXuNEJgsWFnHqo3m9+VtfQLvLMwZmgWYw4Aipug1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h43Ss7PdOnxLEBzuKjqmcNa2xm/5PEaikdGA2nv2uIo=;
 b=H8vvCriZdVuRP9wZbiHKrLcEro6YWWGQHYNHx8ofIE7AOHmmf40qu2390M6/lnhAQbykyZj7ycsPyoI2y4utnC7UMnUdmho77kDkGEE+9upBPcN6yM0YKjTejf3uQZIhQKpAApIHWJXNyKNaD74t8JI4M1SSioNzPfDovNHuSBKVWxDeXwS77l/4Bo/zOWY4HPfkYZRK2JMqG8Jn5olHrQg1U1cV29KVzmX/aFJnbMIdHyi7mNq7JNyKU7nNpNsaLUyaNPwNQ4T8s1VJh7weIUNsZzULchWhRxEkDjCMjrUR3VYj92zCDp8buUHKlX5OH+mPF+lArX7dMtxo2h7VAA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 14 Oct
 2026 01:29:59 +0000
Received: from CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::cb31:7ebf:51e3:d9f6]) by CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::cb31:7ebf:51e3:d9f6%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 01:29:59 +0000
From: David Cemin <dcemin@nvidia.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH] watchdog: sbsa_gwdt: stop the watchdog across the whole system-sleep transition
Date: Tue, 13 Oct 2026 18:26:36 -0700
Message-ID: <20261014012635.2360555-2-dcemin@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <b17e7387-0de1-4b41-8955-6f66965a1126@roeck-us.net>
References: <20260912182107.1156221-1-dcemin@nvidia.com> <b17e7387-0de1-4b41-8955-6f66965a1126@roeck-us.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:303:dc::18) To CH0PR12MB5089.namprd12.prod.outlook.com
 (2603:10b6:610:bc::8)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5089:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb3776f-a939-4c9c-346b-08df2992a939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	166KhULRD6f6YRJ5n9JRUwhW67F/Gz/v0v5u7l+btFdB0I57zqti/WiZ3IKxo7hbLk4NY2hYk9YvHxPyGjh2KFX08aT34xs4q8qZkGuqz5khKb56mXlB1XBDv5lmi4HJwsbqsscYXH22e+2wXXmQ1KEM2OoPS1CfPYfW5XCpdvOyLIn0UNN6qVK6pG0iRDOO72gItUEoUyoK18odoLVhrjCXPJLtUzpftqkOv1N8ymD2XLFqEysX6WrZOB67Ed3h21PJ8bjnqbLwne3qK9J7oBtOgR6e/clSFNh3Rv+AEcWT5yFKHw6rVg8GqfumUXuAzpJaqaMV+LB8zHhPQ7LGlQL06SODCbtyAvJAamJzK7f++Yt8oaz7CFoISuYtA47UkcEjxmY88C+fhCx4/ezgZiRcnWXiNc7GfGHBYiBr2ruhJ5bOyV3Uz2mjPhzQYgdJEFvjneP/6rYtedVsBfMCtT3uA7fj21CSlyBipWLf5HeZTF6BaVgZPo4GYprVwbknTIQsLp0k+j3cNt9TNpPQUZmuhmYf1IHfLPStab/GMApSfPc5cJweECSrhgJ3ttrA6+I0ULGX0N30I+3eaXWVWkvJp8hky+Jw5XOtrftVr0IQC83Qyy7n0uuJYyywj57OhRE+/XDYJp2ZOCn5YBqw/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5089.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u0FFmmrJhI482oLZpNwfk0qKW/dPyul3lWyvSXnalUsCWNeKlwS2jLgRL56l?=
 =?us-ascii?Q?va5bbWIbgkCM95uM07ztyqAKALdBZ+ut27ktJazFVTtDyZ6XOazwsm0lwkIb?=
 =?us-ascii?Q?nwdiyyTJygaYslLGvhxPC8nVz/a36pF/buVfXQf71Ue3CS5U8MAO9osmrgK1?=
 =?us-ascii?Q?n9JsUghfEm8O286XdGfhrkI6iKL2vJOzHraBvvKqVefVEI7nT6elIRm37A4s?=
 =?us-ascii?Q?W6kjyeFr6Lov2Ch98Wl+lIy7kQoWKeA7IBsDdEu1el9zvDI45FiB2nEgA2Ky?=
 =?us-ascii?Q?EE2cH89L5R/gijW8601vB/ZaVnoGTX/Pu8WDw6jf6nblMpuCUziruMzFZZTw?=
 =?us-ascii?Q?23RsMxVRj+jIkeXd333PjzVCQyJ0eXiRz8Qy0PBOy60OGdKtYojfqz3npORg?=
 =?us-ascii?Q?kKJVGTIyJOBmhsu6uQq7ZmKqaknSmg/Nckl86JJJWfAWmW5m1jjqpPKtOHUB?=
 =?us-ascii?Q?tjXlc2YBYoGZtEQ1DUdfmnoYQ++E6UFe3QZRI6LG4RBvI2QHdcTHgcTNQD8Z?=
 =?us-ascii?Q?F4iFil9iACx4IK5NjUT1OXrdxGw4vLme2k/Dv7ttjcEU8Q7JZc/kGh5h7BW5?=
 =?us-ascii?Q?mpc37O+8pbsmLGG2kKvAO6+EmFHGpkEeaKJt13KgKB4e2F9xnGeX8I3jIfkv?=
 =?us-ascii?Q?bOsYHHUP1v3MIWaT0nROj8Bqx/ZPw4fxOf2jA0pIGurY1I9ZT3/TLDhLUlgB?=
 =?us-ascii?Q?fyOwMZ4FEqXZ5mYhXaQOQTCpXwQ/8RVZfnOOaEx5pxK3HhjJCfTn970ElYde?=
 =?us-ascii?Q?aoJvgXHiKxqME+BKW65FgGxjs8sHS7vpD7Vf36Ihnp6xy03wFb9ipeadZic7?=
 =?us-ascii?Q?PtHdJ8Tek8s5NZdQMh+J8D/TbdZzf2RtNYoqIecIjK9kKxxiLuC56qp0hDl4?=
 =?us-ascii?Q?54ovJW3g8CK9ECv2LcK65Np02slCH/ZYRvkpxNxLI2nWh/fY6qqlk9Nux0UE?=
 =?us-ascii?Q?hl2WuYDRgTyS9Qrrv2hoXaQp242VmNy5SlP8+4mg7qJLnLlPCkzx8vkgRoMC?=
 =?us-ascii?Q?MkQ1NRNwGw0KDek99z/niAuD6V+wT4Pf7iZ21vdHksg56KVT1zqcai9OA2vK?=
 =?us-ascii?Q?FzOgnAm/tVJzVLi5g+Hz6d7TUkpiPTQ65Y0zLgBrhL/zIetmE5LKfoWJ8miT?=
 =?us-ascii?Q?QSHLLxLsva8JXGJKOTZk61KRFST3Etq2vSJ+nQcfn+ptLq+kzcv/Wv8vlrtx?=
 =?us-ascii?Q?dksJRfaWdTSW9YQd92o+EBwMX4nPa8LBKkpr4sK+ALn2Dnc0JZGfKTOKZTK/?=
 =?us-ascii?Q?Sklzi/Md0d3jtmXlLiXMVeThIdRhR4eE9Uj71SEm95Gjmj03zWw3zRCzFmBq?=
 =?us-ascii?Q?hH1cUsS0aJbOqrHnufp8jgbxk+NS8GsVj8msQVrz6ju/pdvwYPCpZEyninn9?=
 =?us-ascii?Q?G170zQ+6FdgU1KDZ2whdwUZzi+blj5L1AFb40gQk+laoRux+vuT+jYrwnOLB?=
 =?us-ascii?Q?sFBhCY8p72es1EzC5oj95aZ7Gr5qY51Kvfj8rVKFCBLcYfxWwcmF6gEfwsSB?=
 =?us-ascii?Q?9tBQ4Uihv5URZTL/qRMefaicvtfUuh24MemC8JfnmTH8Y7jhUv6YHjQ5Zri4?=
 =?us-ascii?Q?Yzfv19LDdbrmB4kjbItltZEs8w3Yav0wcUJml1kVWariVfMe5x/1SN1hVWg+?=
 =?us-ascii?Q?xX+BxMfc64btFeF5v2dIdCgFpdajTkTWAcQ2tMCzEjFG/OQSos+QI789CxZG?=
 =?us-ascii?Q?rp9e/bFhLn94+U55Bf0VK2CEc921lzKm4w7+zo3yWHcgB45aRoQHABfZUHDf?=
 =?us-ascii?Q?SkxHwoXzxQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb3776f-a939-4c9c-346b-08df2992a939
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5089.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:29:59.2370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZpjsC0OiYEC53glzH4n66KUfBN66P3jvvqQgcApUoBJ5BCGpuIGmfu8w/8iITT0czkL241KgC5IURQBONZcuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967

On Wed, Sep 16, 2026 at 05:18:34PM -0700, Guenter Roeck wrote:
> After thinking about it, I concluded that this is the wrong solution.
> First of all, it is a solution in search of a problem: Simply increasing
> the watchdog timeout to be safe would solve it.

Agreed, and sorry for the long silence. Please consider this patch
withdrawn. The resets described in the commit message are handled on
our side by running the watchdog with a timeout that covers the suspend
path, as you suggested, and the watchdog now stays armed throughout.

While doing that we found a second, unrelated problem on the same
platform that I want to mention because it touches the same driver.
sbsa_gwdt never calls watchdog_stop_ping_on_suspend(), so the keepalive
hrtimer of the core can still be armed when the system enters suspend.
On this platform that pending timer wakes the SoC a few seconds after
it enters suspend. Calling watchdog_stop_ping_on_suspend() from probe
removed the spurious wakeups over repeated suspend/resume cycles on two
boards. I will send that as a separate one-line patch. Your core series
from 9/29 (3/8 in particular, the _WDOG_SUSPENDED gate) closes the
remaining race in that path, so the two go together.

Thanks,
David
