Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847548;
	b=x7jVz8P/WrUuSOomNIun/6iov/UCH3JnRE+hBU8kphBgcDebBPLUPtSO3LtXEiC01jVQ
	 Rc4KfIbMGRm/lnqeuTg8HjICBW67d0B2WsPUFkk9Ww8qBPmHNoXjzgrGBJk6rsWMoJliM
	 6Rgf/eUQlzkC5Ajz9tjF2GCxt7tK8NHfDV/p/YOaAQyyQsQKVH4zoU7cO5QJD+K+wjglC
	 uHXgvgF2TfonNsyW8bBDHEV/8tMMnAZk4+EGyDCymORXwuiSDlzC10bm4SZFADkEDbf+M
	 Ca0OPrqUb/QFC6BqvxOq4S0f4uQHCILYgZSZ+yn51RDcNSWOToi4GSPNnVZZkPL7xjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847548;
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
	bh=+X8BHr2ykvAEil+/DghWIKA0reftGlNGH6wzHyOsdOI=;
	b=egv/Ut8mTHSwwRFxsnzC0bzRshjnUENNRYbVc9Z9r9piUge+Mk+8SSoiuN7ceiq4yMv7
	 apc5NFJKGmPRtNRtgSdst3R9pMWflQ6YGEt1lrlcUGPX6FKTfYl2EeuolEi8mSNGbHsrZ
	 iPCOOPYTcJg+3pBNu92wD7oAUgBaCtqn5wRHqwwmrDR0L7AU/mqde1b+Bg+Jo+2sfYvTF
	 hAM8qAKUIEo3qPUr/JxIixoJgtwY4vIHd1ivrVNMTQ5Ltl3u0pKtEWmoi/XLqaEv958Ri
	 VXWdUH8p7Vhij6JPHFB2koD/pAC7kHxE/u4vB4V0MpYFU5eAd66aBftrWepcXsPXgAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b="f/CBtJmo";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.30
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F25F606A32A;
	Mon, 16 Nov 2026 16:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F25F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=f/CBtJmo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQq5Mdr4ngTj+6rIMmnK8y7K1603Bn4a82t5I9APTlU9fFWj57jOuzm/OeCUMp46KP3TTZYiKpLmX5WkEjSsKVFiOnNqDnA5kZUsUKB1oaY5BYeeIG6QD0o+YOnDR2SeP+4XN2QT0VKSXgHiq/gpFOvqePRTpgOtecG2SfqwQxEY/NUj7I5vjBoNAxS9NGrw6nYT9LpkuLbACgS5Subz0049yzborjLR/F2F+tWDypcS+mA3nudKNn5Fbmu+DqxDA3cVZFLf68anuSFfWYXr36J4Z5cAq8FM8RXm7TbhRb4/cSntctZPOByuPViwP54YiWgVO7z8q4pSIJhtrVssmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X8BHr2ykvAEil+/DghWIKA0reftGlNGH6wzHyOsdOI=;
 b=ZCrbMqonMbsKGoQGl+JcqMF/J7CU5uUH0NpE2q5lTx+NURmuWbeFKMqdPiBkNWBDzzlF1qZOT0810ZyUjmIvLSjzk1J+Z3hq0PpSi7o9AL3ZyYvjqL6bkqRqr0/cPVvckOaKYpVJ96UPHlBX4oF/OZvZUzq7bjRUVjEsN79qeHeX80p3sYc3gOHGg5euzBJpQzLdXm9whY6IIb7KvFcuUqOwB4J8//0uK+KeVRMxg92AVal4aeZSCsjtX7w5A7Ua0dRUT/q1gwhoIv3OppaOLo2xCtjcyhcjlzw7Ssx+x7iPPYRDJv1je5CP0qWDAI31rxiCqo1EESkGmMqlWt76FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X8BHr2ykvAEil+/DghWIKA0reftGlNGH6wzHyOsdOI=;
 b=f/CBtJmoN0+tCA22I3eCRIZppfw1OVg8UI3qe/3ljY69RWLXNLGtqb9IkXLlnofMNqS32TdjQ4R5PBYuY45GK264ONhwM1nu22/8wN5iwKrftKubqUNopechv9jgLtcpF4uUg+7Dm+7ftbDwlDAd+hFuyBmDMfY4SyjZSzd4qrv3N43JtkrLYCnDuXqFHwOcYuMBO+6H6qZ7FzigyXMrpbrVElawaV4i2IXHNOM+oriLmMNDDXAUpb5HAN/tguP6Ab1NqPQErLv3dOQkhY7Hcy2TgoOFuxwpoCKGEoKvwlpi3RGtkPTxRQJzt3yopx5cyMOgRpQmklYv8Z92RHKZXQ==
Received: from PR1P264CA0173.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:344::19)
 by VI0PR10MB8668.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:232::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 16:45:41 +0000
Received: from MI3PEPF00008491.eurprd03.prod.outlook.com
 (2603:10a6:102:344:cafe::8d) by PR1P264CA0173.outlook.office365.com
 (2603:10a6:102:344::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 16:45:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008491.mail.protection.outlook.com (10.167.240.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 16:45:41 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 17:46:24 +0100
Received: from [192.168.8.15] (10.48.87.124) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 17:45:39 +0100
Message-ID: <2628f6e623996cda73a8cad46d451a629e749462.camel@foss.st.com>
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
Date: Mon, 16 Nov 2026 17:45:38 +0100
In-Reply-To: <32157be8-28c1-403d-8485-96c1fe4543ef@roeck-us.net>
References: <20261116132416.1184447-1-antonio.borneo@foss.st.com>
	 <20261116132416.1184447-7-antonio.borneo@foss.st.com>
	 <32157be8-28c1-403d-8485-96c1fe4543ef@roeck-us.net>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF00008491:EE_|VI0PR10MB8668:EE_
X-MS-Office365-Filtering-Correlation-Id: 3142328a-d5ad-4a35-ab7b-08df44010ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|36860700016|82310400026|921020|261102123227099003|10067099003|4143699003|11063799006|56012099006|261026121527099003|261022075727099003|261021121427099003|261021135927099003|261009223027099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2O3l/zuXZNNrh5bnrG4aQzzz7gVNayELVi2xj0Pk68m5GfvuAwbHV4o1q2Mar2pQaErDgaDVR3u8GnK9Yx0MrmnwGVf0LrIuW1DedaWcU9LkGCtgnQvWwmxftReXEy66/JHyLoVYuxsqvWg4k/ct3v/SOfhpk2jEDmTcFZkIK8HxPqxuCeR2OtK3A3Y2ijVEVxwilu5ldljdzuylFjaHgDfyXNXWH7ojTW9YUjEOdUJzFy4O9ZkIjfWv/7wuCqWAPKS/clUEJwapyXBkhz/yhRrkM0YBp97eqi/B22mOuju3942DX6qq6+pMP+aM+hLAxlVO1js0RbcFFKKcrTkBXq9/1D3ISKUmJCRoe3XYXrAcXUbbk/ys6ONGBnZbPPnlzvGM3ZmFTGjj3lWCFGxy9sJcACEquJyVFlEeOChN98nKagpNWLii4oMw+VhhfcKxA0WBJTw2dXW5hX7T/ajGMEbRspDCtH13uuIJVnVmto3y0RhRDj7BTM0vUmtFwEg+WXe/iP1Rt/wQmrXGyxSX/chhrMLfVmzKMCmbZdM4bu9oNqT1tLUrMLq3q7kOMuLdNfUKfWWsrzH+OU1wimWeby/tjhiitu5h1uqwwc6+4grKCHwPjrTPiv7kmrcMIP8UddoJS5c6YYssLrmTX4ca2VZcQ+9MFYLytbZRCdnzBV/N0AJeJIO9GsQdW7ZJI0sVuO2eeFMp3HEyUuwBS+YC2ZmTzI/IfbLOYoNELLHcM7VbDTWyHauPmlkwJteGunNH
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(921020)(261102123227099003)(10067099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261022075727099003)(261021121427099003)(261021135927099003)(261009223027099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e4cGP726OU8CM09bL9O9NvpUd5HWytAKCqM9dVC8lu5txmgyh7aARQSJN1mONTmx5vZIIZ2xy8s2tMdxpYBU8DAqTCzm5HRkbctacL7bwMyma+pMB2CtwdOuQnX5Ba2GOluPG0qfKN9+jozMcJ2qPz9Fu2so3xXDOEFuRQeHFq2nfdEu/vkzFy+JT4JRZ4Gs7fgSD5yZtmq4hSl2fEgBZ+eQAiZcEkSb5RtN8GCIJ6ggOCSZtMgqmIck1wzBRfW+/aEqM8x5wblBlrCebAsYcpUmsEQqsv7e5211wo3VroW4ctInJcbmQ/mLRc+daEkv7FkpZW9usYLhBbHKPxjOCJtJnoSzJhKO0SLZ4fLcOhm+LbR9BbO8mx0Qqf9fTsD+dLiUdXt8HkniwhCN4+K+2PPnbIM+eJYv5V8pQ3VCojt1dq9vTi13gzjJ3d2lacIO
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:45:41.1070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3142328a-d5ad-4a35-ab7b-08df44010ce4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008491.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8668

On Mon, 2026-11-16 at 06:33 -0800, Guenter Roeck wrote:
> On 11/16/26 05:24, Antonio Borneo wrote:
> > The watchdog IWDG1 is secure by default on STM32MP1xx SoCs.
> > On boards that keep it secure, Linux must use the arm,smc-wdt
> > driver to ping it.
> >=20
> > Enable the driver for mach-stm32 when ARCH_MULTI_V7 is enabled.
> >=20
>=20
> As mentioned before, that doesn't just enable it for STM32MP1xx SoCs,
> it force-enables it for all boards running ARCH_MULTI_V7. It also
> goes well beyond the current scope of "if ARCH_MULTI_V7" configurations.
> I would suggest NACK for that reason, but that isn't my call to make.
>=20
> Guenter

Hi Guenter,

sorry if I take more of your time on this, but I haven't got your comments =
on
my reply to this patch as v3 04/13.

On platforms STM32MP1xx the trusted firmware starts the watchdog.
Since on such platforms the defconfig is multi_v7_defconfig, the upstream k=
ernel
configured with multi_v7_defconfig would need ARM_SMC_WATCHDOG to prevent a=
 reset
during kernel boot.

Clearly, my wish is to have an upstream kernel booting properly with defcon=
fig.

arch/arm/mach-stm32/Kconfig handles two series of ARCH_STM32:
- the deprecated ARMv7M platforms that use stm32_defconfig;
- the ARMv7A platforms that use multi_v7_defconfig.

In this patch the condition 'if ARCH_MULTI_V7' is to enable the watchdog on=
ly
on ARMv7A, not on ARMv7M.

Clearly any driver enabled for ARCH_STM32 will automatically be enabled for
the other SoC that rely on the same defconfig.

Also reworking this patch by moving the change in drivers/watchdog/Kconfig =
as

 config ARM_SMC_WATCHDOG
+	default y if (ARCH_STM32 && ARCH_MULTI_V7)

would still result in the arm SMC watchdog enabled for all the SoC that use
multi_v7_defconfig.

What would be your suggestion to progress on this topic?

Thanks,
Antonio


>=20
> > Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> > ---
> > =C2=A0 arch/arm/mach-stm32/Kconfig | 2 ++
> > =C2=A0 1 file changed, 2 insertions(+)
> >=20
> > diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
> > index 4ac3384e397aa..de09b2afa0f2e 100644
> > --- a/arch/arm/mach-stm32/Kconfig
> > +++ b/arch/arm/mach-stm32/Kconfig
> > @@ -13,6 +13,8 @@ menuconfig ARCH_STM32
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select RESET_CONTROLLER
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select STM32_EXTI if AR=
M_SINGLE_ARMV7M
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select STM32_FIREWALL
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select WATCHDOG if ARCH_MULT=
I_V7
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select ARM_SMC_WATCHDOG if A=
RCH_MULTI_V7
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Support for STMi=
croelectronics STM32MP1 processors using Cortex-A7
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cores. Note that=
 support for the earlier Cortex-M based variants
>=20

