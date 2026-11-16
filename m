Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794853608;
	b=fTnaWzwJG2WRa/tK44amR4f3w0lWVQ2CukoyvQ/nHLN68mL5E08x3waPrr31s13yldpA
	 TKNwADjTHSuhX0flXPWze/iv+XSksjXH7Feufg7dTTWNDYx+vTrsKBZmeY5JET4/EAGmp
	 PV+8zsxXN9RlEPkiifqL0l+ozEvMzu6OIIMbbfhT7S3f8dDGCegB51QPN5W217YkVV1St
	 HUAccCTCxY85vHjVub0V+Kojv7CNbBRBVBZ/lXeK5d6es+fuol19FU3pSNQFST6uYEOES
	 WUmqPPSXvVGH7VripDs4bHyEroaPgCq3llRvaW9wdlaI8enuWFQAM62j5EBeDflurGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853608;
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
	bh=vbRMaCGA+O1fovi6rqkP1NF7xo09Ndb5NQfqcxExMnc=;
	b=DXcTTpZirwFqeepKYfjIKvqilijLcfeg/aFbKYuPcrUsE+MbYQV/kWMyomqWkDT7ZZG0
	 jZqe+mjON1PRPRzZ1F6y7OXyBn0yXNaRShnh/yeEqc7ruKF9IncgG2B+lbI+5icK1Nh4t
	 fQzlpiVX/i/4guTAwBcsEcfQcfTsmKTZa0eFlKEJZgJOutzbomTo9KsDg3whIC4qbded3
	 DNM05S9JgzQdHFrhYJwsvXsKeSOnoPImwgDUxDNDaDhkrr8JDCkKW7ln4uXm8OG2biPQs
	 5SF3ocPQtxiQh2hHRlJtIbYqbylfBeQ7D5mmwVQgOwyUEG3SD+kdF8DhZgMMFrfs5UQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=KeqiSr8Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.66
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5A5606A334;
	Mon, 16 Nov 2026 18:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B5A5606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=KeqiSr8Y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0+70VOex3MA2XVrSPD/oltK6K+pn/gCORmddCePdr21IuvR6kpalzVZv8yQWAxM7pd54K18bJ7FpgztbspmbWizNHSPGrfiid0DK3mMWV6XgXa07wLZTpDF+wAlXSz47RB02qaPEhOk9yznG7p3nsXFOA2l+kYFylbFjbN7SJUTQPc2FUcY2GLOfwNgnDchYkZKVt2qe6twpFITOpPzmdDppI+sEHpu02faR2jQwobdttr2atZmPJxibD2cgT+1T5zUTfi2FEOyGEBZUliwgEWoG/Huf2COCwjGelrnl/debB9bAeekAcuQItM2MjnnVgnQc+fanPbeH8NAesMz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbRMaCGA+O1fovi6rqkP1NF7xo09Ndb5NQfqcxExMnc=;
 b=KzYEtfJLzOoYf6gjOvxnnU6QQctfSm53CHexptul5xz9z+PAw7XBhUjMCBDM0JzuR0j1NgHdVRQQNazBqvt/ZGf5N7+4/zVd8NX9g9QSTEKoY9lD9TZUhzcRcYO50T+v1avmnnYHNF5Vr5urDsWgH0EKdV2HQsPZr2RwFC54QJnCiZ4HuU9FXBxsV2AztbwhyymG5NeJi630xH9aDf1KXY53YUve1laeVO2XAx/9YSUAgcm/st9iqiryEt7JcBWODPKVeXNwo4JKr9Zl4I5/jJW2pG6rSCZcVj44Dzf2xeJJrauN5zyUVSNCokT/kFOefYpmcX9ZI3R3JPjyHRjLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbRMaCGA+O1fovi6rqkP1NF7xo09Ndb5NQfqcxExMnc=;
 b=KeqiSr8YOf5SQ/ppdYyIyVyA3t0fUNIkTei01XdTO4k7ptpEv6xeWE1X+0ivMzyKbyJg8ZYqXdmDtdntNpaH7Zuw994r6+nS45s9feox7LNbjDrRqihcGTd88/y1EdPUNVizXp810zF++WbKptRBlRFapBumcdzZSWsV6/DwWo/NwZW4jvAEweBykz3agg4dEr2KoXeAV2sDlsq1d9rs6cqxOx9Z3UQwDQOXa+8Smt3IJIcecWSfQfQSeDI9eH0uSzMX+7DSqKqoxD36IlcGvfmZIy18TxT+FPeB6VFh5EZIsxOqRSE80y4YwGYgRziqpdPZ0eutFjNY653z/ryKWg==
Received: from MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:44::20)
 by GVUPR10MB9702.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:360::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 18:26:43 +0000
Received: from MI3PEPF00008492.eurprd03.prod.outlook.com
 (2603:10a6:290:44:cafe::86) by MI0P293CA0012.outlook.office365.com
 (2603:10a6:290:44::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 18:26:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008492.mail.protection.outlook.com (10.167.240.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 18:26:42 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 19:27:42 +0100
Received: from [192.168.8.15] (10.252.15.73) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 19:26:40 +0100
Message-ID: <0d5b82927fa3bebd2e7c24de692faea553c3cf7b.camel@foss.st.com>
Subject: Re: [PATCH v4 06/15] ARM: stm32: enable arm smc watchdog on
 stm32mp1xx
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>, "Wim
 Van Sebroeck" <wim@linux-watchdog.org>, Yannick Fertre
	<yannick.fertre@foss.st.com>, Christophe Roullier
	<christophe.roullier@foss.st.com>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <linux-watchdog@vger.kernel.org>, =?ISO-8859-1?Q?Cl=E9ment?= Le Goffic
	<clement.legoffic@foss.st.com>, Amelie Delaunay
	<amelie.delaunay@foss.st.com>, Sashiko <sashiko-bot@kernel.org>
Date: Mon, 16 Nov 2026 19:26:39 +0100
In-Reply-To: <53492f71-9a31-4093-8c61-fb410cf44d5a@roeck-us.net>
References: <20261116132416.1184447-1-antonio.borneo@foss.st.com>
	 <20261116132416.1184447-7-antonio.borneo@foss.st.com>
	 <32157be8-28c1-403d-8485-96c1fe4543ef@roeck-us.net>
	 <2628f6e623996cda73a8cad46d451a629e749462.camel@foss.st.com>
	 <53492f71-9a31-4093-8c61-fb410cf44d5a@roeck-us.net>
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
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008492:EE_|GVUPR10MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: a362f860-09a5-404d-1721-08df440f29f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|7416014|1800799024|18002099003|22082099003|6133799003|261009223027099003|921020|11063799006|56012099006|10067099003|4143699003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	wJwn1tgvjbdgWNdAgZOnfoeAaWL0mcxoal5239YA7FqUDtEBlyPAw+ibEth0jM6hSI4IG+RCy+PHq3BnanO9xWW1Sya4v7gX8Dm+TVQuF3BgjqPM06GyeBY5pzB+Udmvzf5Erpg9qrs/iTEeovtgr6Y1lr1LhUFZFG10wL6PZbwlhftzV1Z6p1qfP0WtpvuQWFancUdUJLfWoZQh+oiE8oXM75NFepC71f/1XML8CX0CcuRudhMtnqeciNUkOIT8MzK+Bo5gSi0BDaE5RJCOai0TpnZur1ipoMPBRnVdJgvXYMIrGZ+opdukDrmCLFqpwvbi+KXTSpOxToaAWGomWGCs2dGjqnBoZNlYr/SZ26XCZGl8L/qrQEyHZVZIydqHXqeQlfOOZ6T2wIxLyku1DbbobmHz4UMOiFXFdiVYRlBxP+G5t3rLWEGBitmOju9zWUtdyOIwxt0/y0csnCu+UMFCl4rV03hED6edY9Q3k59M1i6pH0NNnwUPGHshajqyKFaKPL0LKWnn0vG/c8vOQDlJna5Xny4w4B51FKjlFJbevHJbyaarDmr0QPKrLvH3tuHdsXlnh7DN6upvEjiGcsBJcxK9X3D4dWg8iR4o0YobuH7AjkxZfGbH3zylCEzK318HsPmPxW5zuUDemCaU1TUHlO6w6EoFwLJxVz4IC0dvV0zYA2RzOo27xzELy8brWnojRSMLnHIqG1kqIyTAk1u2Atzdkl0M3ou/Vcg6hqElqSX+LVbloC0SBo1YuHRA
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(6133799003)(261009223027099003)(921020)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ayLO+UxZZFbVLZK9hWB83WNKoKH/wXnCR6KN6Dt0meLNn6Lo2Fju7kcqyEqHnyz/bBQ9UFDfzxvBvHpqtADUiwvbUpq49XxLR9yvntRsLkTPk9xxif8c34hbGXtrU1kI9bIkZqu2/F9T7Bx4MVTNz33cvTpToCZx8JBjl6foM65fYeA6bOp72ik9i7K9OC7aoRrkVAW6OSo7k5hUUdIJjDCcQTmgOwQuoBpAlwYXFoh+6Gml0aGf/Cv3s5qu44qF3uYC+zXjPx5TfGHOcrmKfecLVYmMSLMR7qKe2WUb5AzvQvhu7OWGHZMrfFvCXENUDCdVioEXNmYaT61+8ZyR5gLTWrbw4ax3jjxF4xaVLs+FCJB8CVc0cyvL4IOS+u+YWspd1jLVOhlSkWcQmtn+g/aE50UwlAq/pXx9O94LQvIxaaQlmdeKyckK/lNByjkz
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 18:26:42.8378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a362f860-09a5-404d-1721-08df440f29f1
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008492.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR10MB9702

On Mon, 2026-11-16 at 10:00 -0800, Guenter Roeck wrote:
> On 11/16/26 08:45, Antonio Borneo wrote:
> > On Mon, 2026-11-16 at 06:33 -0800, Guenter Roeck wrote:
> > > On 11/16/26 05:24, Antonio Borneo wrote:
> > > > The watchdog IWDG1 is secure by default on STM32MP1xx SoCs.
> > > > On boards that keep it secure, Linux must use the arm,smc-wdt
> > > > driver to ping it.
> > > >=20
> > > > Enable the driver for mach-stm32 when ARCH_MULTI_V7 is enabled.
> > > >=20
> > >=20
> > > As mentioned before, that doesn't just enable it for STM32MP1xx SoCs,
> > > it force-enables it for all boards running ARCH_MULTI_V7. It also
> > > goes well beyond the current scope of "if ARCH_MULTI_V7" configuratio=
ns.
> > > I would suggest NACK for that reason, but that isn't my call to make.
> > >=20
> > > Guenter
> >=20
> > Hi Guenter,
> >=20
> > sorry if I take more of your time on this, but I haven't got your comme=
nts on
> > my reply to this patch as v3 04/13.
> >=20
> > On platforms STM32MP1xx the trusted firmware starts the watchdog.
> > Since on such platforms the defconfig is multi_v7_defconfig, the upstre=
am kernel
> > configured with multi_v7_defconfig would need ARM_SMC_WATCHDOG to preve=
nt a reset
> > during kernel boot.
> >=20
> > Clearly, my wish is to have an upstream kernel booting properly with de=
fconfig.
> >=20
> > arch/arm/mach-stm32/Kconfig handles two series of ARCH_STM32:
> > - the deprecated ARMv7M platforms that use stm32_defconfig;
> > - the ARMv7A platforms that use multi_v7_defconfig.
> >=20
> > In this patch the condition 'if ARCH_MULTI_V7' is to enable the watchdo=
g only
> > on ARMv7A, not on ARMv7M.
> >=20
> > Clearly any driver enabled for ARCH_STM32 will automatically be enabled=
 for
> > the other SoC that rely on the same defconfig.
> >=20
> > Also reworking this patch by moving the change in drivers/watchdog/Kcon=
fig as
> >=20
> > =C2=A0 config ARM_SMC_WATCHDOG
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default y if (ARCH_STM32 && =
ARCH_MULTI_V7)
> >=20
> > would still result in the arm SMC watchdog enabled for all the SoC that=
 use
> > multi_v7_defconfig.
> >=20
> > What would be your suggestion to progress on this topic?
> >=20
>=20
> No. As you say yourself above, "the upstream kernel configured with
> multi_v7_defconfig would need ARM_SMC_WATCHDOG to prevent a reset during
> kernel boot". I fail to understand why you don't just add
> "CONFIG_ARM_SMC_WATCHDOG=3Dm" to multi_v7_defconfig and instead want to
> force every single platform using multi_v7_defconfig to build this driver
> into the kernel even though almost all of them won't need (or want) it.

Thanks for the clarification. Understand your point.
So let's drop this patch from this series.
I will send separately the proposal for multi_v7_defconfig.

Best Regards,
Antonio

