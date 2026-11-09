Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794220350;
	b=4BykJ4DnoF8l4gtmNd9qrzEdaPRpy3oVhs8c6qj6kkoC/HfemoCPddJo51ptzGwvfX5i
	 LM+JohrObUVDDNcQbO4YAekgQTNPfBBh1TTifXXFPIinBcptudeBq4wOCz2k810mkplzi
	 +LaO+m8EKrlL7f13CagGCKSlxKjeokLVQu/Fe+aQ5R6ELSql0XwXI9T73do5vhlNbXJzh
	 al3wTGGYFxzsdUSz+qhGRAVS5orPZMxlr9ECqJo+07yrX2+vgE9zEq5d/y/+HJMoKWSaF
	 Yy5Us4YxmNAAu0YbjF99qnCn/Evsr7EJZjEneLSauTRV88f45ImKnGzGQBq7fzLL9Dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220350;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=gmFqsqyWnW7YKrrZGGP3gVz3TTkdhCyOsxnQAOyZ1N0=;
	b=tH4aqrYyGCT82Nlk6wkB/TqsAMy0BoDmEoNJFx2tZcqVCmeo/kBwPY0vjBIxPQwclemy
	 O3eec8R4eBgndaUBmXNzjhpIlS0VTNouGo8yppAyGeX1KYVzGBL7oN8aqfFtvf+GqyPvo
	 u51hbMiBG8fPxiI/Rv0k9IR2xFWY9jcOabb9Gp21Mfc3nABNv9JvjiYB38lm9oAW+8NZ1
	 GEgloLLryRiyc4I6kye0cAM+NsW4j8VnImJSyWqkV9ivVGS8j8HgXqKqbTxfLm0QOVlrs
	 Zzt3DAbSGCgMA5fk+p4U4fjeNdKOsntuG8Bmg7whku18k7Hjvk0Idxnz7Oo6IBcYNRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=MnSqivOS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.71
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF53B606A31C;
	Mon,  9 Nov 2026 10:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF53B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=MnSqivOS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVDwOyQow0kLvwT4eurfRV0e3FL1e+hHw8FcjbIqAVeYCkUsgUSrdsubyNVgY97ix2G9rnVRyYdjcN2xz++pqelGtDj3FPheZG5xCXa9WNcEB6+HGm9j3iJ6qgO2NX95P4v7t4OU4gtLaoF0ZoQDu7ikbYD4aU5zbYxb6a2NI/mNGJ0rxGnabI/v1tcsJxCOXi7qaCKe03mOn8TcBAOen2EE68W7Ff1RNyzkuVk9jmNYThOIKT7axADPVMn5nkPmjuk2VI17Zp6gLcApWgKpP3bxwQ+ty6+poVYrYLz/bPpCfCZu+7n+8o8TWBwxSdxVm+12P/+zRn7NqFEpREgZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmFqsqyWnW7YKrrZGGP3gVz3TTkdhCyOsxnQAOyZ1N0=;
 b=Ny1llnwAIdhzWeFE169y48A0EqOtBErJmB1HB2QfB3vNM3HgyU1OEqZer1A05FsjWgnCbeKM945PDBBM0zQ9u6iTiJDhhHHWLJKqJB9l7nEr/e+z/WslfirU5YFoTshFSeLcxSep6MM3l1GyN+IE18Po6DnwRY3tVIXGCOn6T+5ZWB5GePIvzBNTi0Lzqq4TkmH4VxDIOP65bbzQ3orBnm9gCNfUZj3mGpNFMMoy0opmBN47kI8x1nBs59fiIJE2+YSzzkmM8W0f/rLdnnrgoiAThsRBNeF4cDDKcf5+RZonQ1/vZNDXkRRQuL8Y9Sk/zwFrtKyghxsu8NaseOd6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmFqsqyWnW7YKrrZGGP3gVz3TTkdhCyOsxnQAOyZ1N0=;
 b=MnSqivOSvc8B52AnzKLahdO2GuzzGhO3NY8yRvvlkUfPcU3TKTOU01qTdKFvf0UwDx8uEIDoalHFjiBXGVS01IDYJ97A7jvb19bsvS3Gi/HOubwCIxASC5hi1wrMJIQlE/tZ65Xgi25ZqafBOYecHBAMbRHLspMrAAuIEOZdYLTYxDXcWCLhiWUdrCO+hWrzk32HBBBWp+H8sMdm34aB83ByRkvCXlcjhP5x2CrDuExdxuVxAVv9VCeVhzw8vRt9c4cvyic1OCBCcpMohcAgH/nYLE1eHSvJ4l4xOiB4uuffIoq3lvkbI0Uqe6j3M0eAIo75q+SZYOjG4MTzxk5w1w==
Received: from PA7P264CA0386.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:399::18)
 by GV4PR10MB920511.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:416::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Mon, 9 Nov 2026
 10:32:26 +0000
Received: from MI3PEPF00008499.eurprd03.prod.outlook.com
 (2603:10a6:102:399:cafe::ab) by PA7P264CA0386.outlook.office365.com
 (2603:10a6:102:399::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 10:32:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008499.mail.protection.outlook.com (10.167.240.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 10:32:25 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 11:33:21 +0100
Received: from [192.168.8.15] (10.48.87.124) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 9 Nov
 2026 11:32:24 +0100
Message-ID: <6a898ce8036a37af9f1cc2791852dc93f893e13e.camel@foss.st.com>
Subject: Re: [PATCH v3 04/13] ARM: stm32: enable arm smc watchdog on
 stm32mp1xx
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Guenter Roeck <linux@roeck-us.net>, <sashiko-reviews@lists.linux.dev>,
	<devicetree@vger.kernel.org>
CC: <linux-watchdog@vger.kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>
Date: Mon, 9 Nov 2026 11:32:22 +0100
In-Reply-To: <bf99b912-7a98-4d97-852b-45cb3c3c58be@roeck-us.net>
References: <20261106163429.618392-1-antonio.borneo@foss.st.com>
	 <20261106163429.618392-5-antonio.borneo@foss.st.com>
	 <sashiko-outbox-201910@kernel.org>
	 <bf99b912-7a98-4d97-852b-45cb3c3c58be@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008499:EE_|GV4PR10MB920511:EE_
X-MS-Office365-Filtering-Correlation-Id: 892da7e4-a66b-498c-960c-08df3e4cbf06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|11063799006|4143699003|56012099006|261021121427099003|261021135927099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	NHbIKCwd6XO18OKMNWfRptWmkWRytJKttRt2D88u36ouRjTrqFDnFTlxVVOnlpcOd4UPCboJHmt3zH1aXkk0zZNFI8sREn2+Hw+6n8y8d1qB7Q2GfhymWcZMVl1HI2kujpr+5vH4ixGy1S6XlEBL0/cPxHkfoKuTBy/9weAaQKeERjQEH493GJxqMyVgN3c1YeICocY04rG12lDEWQy3foaCYN7Npvt83tMejK8KaJTNhWIBCZM9veVBlUMto215wAcpNoma3Yn3DL04NkmNOcp3B4yFRDydBweVbQG43dULpkfIKo5maJwDjyEawc8bDsZBVgAYrjV24w36voke969qb4OHQ3ci3TOvD+fjB/o3mCzwxpQ5KC7eK5lQb0SfyTVHC9hARPPJB24jrE/gwq+GGzZ1BOQSvv8UzTYlBhphe2odUu40pbs71VbESEhfR3KvhK4XPvyaQsJxOFFa8hzV00vfE+MXtz85R7TaOB1PVSXRUXfQyhXHaKYBdSra8JDSR56Mc92DfjeFMPiJY/Zk9QRTaW0Z/AU6BLUOQJwoilDIA4XvFzc+kQsnADeoA4nA308xB2h35jpvTivRaqzwAFDR3MRd19pw+qNiRHzJ5giASCHkceeX2bO2JCZjyHEFbFgEhwakACUG9XE8ZBTfuukpRCg2j3g1xkkQmGWhVBqzeSTf4bCSyDnESv6jmt6LI1PNWaVvb694CZBtbw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FLrzNmTTwrReP40zcwXyKHAQAvBy8VJkFTzdhjRQIo6erU1Cqw09WUnALx/cQEGFYxFvmfDbzJwxIDOoeciby07T0h1n9c6FA6zwXZPj2wDpWaFU6IOktRH5RaAG4TL39/vJSqltbkI9pf7l7szhlhUSQx+d62U+NlzJSXWehESW8zXm3GCdprG1S0lU9cFuGFX5AZyYjRmBEPVJcKJHP66nbicrZmPsexh0ehZmg+HeLVUfqhQeTet2PnzLSvGWimrLygzAMqrjnCc1Bf7Opd7CjL57CJT1q7wPPp3csOJ4lNXQMffjFgbGY4B7dTJzOWVnPgsWlvUnO9AeEPa+P2ycH/3VqSkV8XF1AQhci8A12UvgiVPCifVptdYxaPrzTJnjkcFITFHwxUFCMy69rEBdCygufmR1GCvDvkUj2fVBQnjOmmZbcnRB050PM3DY
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 10:32:25.2477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 892da7e4-a66b-498c-960c-08df3e4cbf06
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008499.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR10MB920511

On Fri, 2026-11-06 at 14:18 -0800, Guenter Roeck wrote:
> On 11/6/26 09:19, sashiko-bot@kernel.org=C2=A0wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue to consider:
> > - [Low] ARM: stm32: selecting WATCHDOG and ARM_SMC_WATCHDOG forces
> > =C2=A0=C2=A0 built-in config
> > --
> >=20
> > commit 4450302b23f46b760d6b23f33c853eaddb3d821b
> > Author: Antonio Borneo <antonio.borneo@foss.st.com>
> >=20
> > ARM: stm32: enable arm smc watchdog on stm32mp1xx
> >=20
> > This commit selects WATCHDOG and ARM_SMC_WATCHDOG from ARCH_STM32 when
> > ARCH_MULTI_V7 is enabled.
> >=20
> > > diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfi=
g
> > > index 4ac3384e397aa..de09b2afa0f2e 100644
> > > --- a/arch/arm/mach-stm32/Kconfig
> > > +++ b/arch/arm/mach-stm32/Kconfig
> > > @@ -13,6 +13,8 @@ menuconfig ARCH_STM32
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select RESET_CONTROLL=
ER
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select STM32_EXTI if =
ARM_SINGLE_ARMV7M
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select STM32_FIREWALL
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select WATCHDOG if ARCH_MU=
LTI_V7
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select ARM_SMC_WATCHDOG if=
 ARCH_MULTI_V7
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Support for ST=
Microelectronics STM32MP1 processors using Cortex-A7
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cores. Note th=
at support for the earlier Cortex-M based variants
> >=20
> > [Severity: Low]
> > Does selecting WATCHDOG and the tristate ARM_SMC_WATCHDOG from the bool=
ean
> > ARCH_STM32 force both symbols to y whenever ARCH_MULTI_V7 is enabled?=
=C2=A0 That
> > prevents building arm_smc_wdt as a loadable module or disabling the dri=
ver
> > and watchdog subsystem on multi-platform ARMv7 kernels with ARCH_STM32
> > enabled.
> >=20
> > Could ARM_SMC_WATCHDOG instead use a default in drivers/watchdog/Kconfi=
g
> > (the way STM32_WATCHDOG uses default ARCH_STM32) or be enabled in the
> > relevant defconfig?
> >=20
>=20
> ARCH_ASPEED and ARCH_S3C64XX also use select, but those architectures dep=
end
> on the watchdog driver's board reset capabilities. The smc watchdog does =
not
> support board resets, and select should not be used here. As far as I can
> see this patch is simply unnecessary: Both WATCHDOG and ARM_SMC_WATCHDOG
> can be enabled in the configuration file if needed/desired.
>=20
> Guenter
>=20

Hi Guenter,

on platforms STM32MP1xx the trusted firmware starts the watchdog.
On such platforms the upstream kernel configured with multi_v7_defconfig ne=
eds
ARM_SMC_WATCHDOG to prevent a reset during kernel boot.

The same boot constraint is present on arm64 platforms STM32MP2xx, but ther=
e
the defconfig already enables ARM_SMC_WATCHDOG thanks to 72a9e7fea586
("watchdog: Add new arm_smc_wdt watchdog driver").

I considered as too invasive patching directly multi_v7_defconfig as too ma=
ny
platforms use it. Plus here I would have to select 'y' or 'm' for all the u=
sers.

I also considered adding in drivers/watchdog/Kconfig

config ARM_SMC_WATCHDOG
	...
	default y if (ARCH_STM32 && ARCH_MULTI_V7)

but it looks strange to me to have, inside the watchdog Kconfig, such link
between a generic watchdog and a specific platform.
Anyway, this option has the advantage to not impact the other platforms whe=
n
ARCH_STM32 is not selected.

At the end decided for placing it in the platform specific mach-stm32/Kconf=
ig.

Please advice what should be the preferred way to select it.

Thanks,
Antonio
