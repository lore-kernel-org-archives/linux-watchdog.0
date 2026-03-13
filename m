Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEA21DF75B;
	Fri, 13 Mar 2026 06:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382038; cv=fail; b=VT4e0I2XOk2trRMrUqIEw7fFjagiVpm2+jczXKORLIV80tRpsF0/UOaGz58lvSlNzig4N8DtT9qF4yki9e6vPcr+QNLBmY8EaoV/B6rlSLj1W9imZQVxyrNDlIAOtG1gmTN7qongpOYMIrMMblGnqJ2r1K9NBjuMljJDvXyC0eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382038; c=relaxed/simple;
	bh=UapO0FouQ1f5sdgCWUBn/ZoGp0GwV6jgqqmr3kYhKtE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuQ2ZnuYqz2IgKDmxZ9elMeoJY8oUxwWEm+YwXoOQK8dnCf5g0ghcyf3lCfDItyRD15FqfNCuFp6Swl5fnka83Ipf27cxcRLA9zxyJaTcuJvic2nceu3z9GIOZ41SXUVd51dMz7uFZ+I5awj7bEL67lDORnmGbAlGt8YQUsZP/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=u0x8bo8k; arc=fail smtp.client-ip=52.101.56.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u0x8bo8k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPrNYc2/X7Gl0Dwx1dqP8hnEqROCTrHb7ZlZ4fAnQxVyW0tjnHeNjDAt5chRvRPa2Jrd9AXYIxjUnchvWj7X5LC4tIBcfXyfGJ3Qpzi2nuGv85foCGESPDakK6YradEYelGMnG2tMU0hJENZ+dpuUEgwcEi+30/or4ylkPRzdU568oyqgphBBo1+8yo4Fw4UBXMRr0cBMSJh6p+IMAg25i5p3eZN+o643GEhlQm1ywz/0JNplW6i5YKIiOhjIidlAMQlfYrPRx7uweiDfxRLkhgPBX0wbEnflDNci75GpjYDu7E1kJrs42ZEoeqRngDfnuTVVn/dUP23mg5VrxJe0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXD2JRDr5V9JWlg2JzephIkXYDzuEQjtdPwGj7BTQho=;
 b=sa0lNbBoVzQsO69GVJHqjE3nw6etJPP0X3Zos6aDoVnlnC4/yt1CxPfUksu8/fDxXR7AIedVjb7j1WZ1tUILUkd+Gi/8ctTu97SypBAL3Nm5isxSLs8WAA6t3CT9BANJKr40n+ba7T8yb9xxZEHNIuc8EY8lC9LxmtOmJ8VY7tA2+vfej1TnvP4Dt8RMm49dpPwma9qA/gvLIpXxScpfYKwbx6jVn09rLG55rggfVJLv1QuThmizfbOUj+AMOjJ9L0FXGyniR8BThHmbEQmgUg8yIkTdwWW1ybyLgHnkzOH9TySZN1JViBrIp8YWDiGGUQPWuT3dMU3TYlkWp8WJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXD2JRDr5V9JWlg2JzephIkXYDzuEQjtdPwGj7BTQho=;
 b=u0x8bo8k39cZLUzlk8kAV6Qx73btlszDcIt+OXMiFBgIbPYP5slARQxOznHhYwqEJxv3/e64SdXdEJw1S6jpLNgfYjjZH0VFC5xeef2ydvlbgSFaImxg1PJhtVgEUHkU1g2okqJK21ATkF5MzqCxAV3aa7XqSBcImogdABdAPM0=
Received: from PH7PR13CA0009.namprd13.prod.outlook.com (2603:10b6:510:174::12)
 by PH3PPFAE1A1621A.namprd10.prod.outlook.com (2603:10b6:518:1::7bd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 06:07:14 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::14) by PH7PR13CA0009.outlook.office365.com
 (2603:10b6:510:174::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 06:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 06:07:14 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 01:07:12 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 01:07:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 01:07:12 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62D677Vg028074;
	Fri, 13 Mar 2026 01:07:07 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>, "Srinivas
 Kandagatla" <srini@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: (subset) [PATCH v2 0/7] Remove the Kontron SMARC-sAM67 board
Date: Fri, 13 Mar 2026 11:37:02 +0530
Message-ID: <177338196940.240421.4339975635292028486.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260302122540.1377444-1-mwalle@kernel.org>
References: <20260302122540.1377444-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|PH3PPFAE1A1621A:EE_
X-MS-Office365-Filtering-Correlation-Id: 86400f32-ed97-40df-8340-08de80c6c5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	NkDswy5GgstntDhDwZ83UoTN9A2HFgLSaQW+ZeJzo2jl4qHvitlPSE5vdBeLSDRILxjaEVqQ32HHsibjOLzf1fLFkNGnyFeivJpLhIKfWp+S0EquSywXeEu55teBMczNt1355rwjaccYEo+D9ZNY9l3zsUKrB2muR+Fejtu0T+zP+4Mjv8hxoqKr3oW7KXmtp9gsRvPxQnOygKVPzyMfmzHQ6snJPb4zPdPfHvcsYY60T/9NER2gRkDEcmdT1irIz+uIxPC+VzDQWrO9WXao/BqONyIeA7GFcGF7ibyCyl4rK9rM40kd2jzSguPN6yWkypMhqNBhqdYQYdloIs6E2SCCNePewElt1TTsggdcBFIc2IfOQjpDjry+UlLgBk1D1JgMzol+mTLCJ5QKy45KwKAXOAXo9MXKyk08dhzObSgKQULcoWWl2z/9Z0iRWmwhFnd6IhPIxN/BmJD98GRWCV1iaMNXyMJi2TjR5OScoy8R/MvusF+yMqMCPyfuwr3n/mFUxczNlID42U5rFFawCgxmyDdnmJ4OTdx/aJKkh1JRH24RYSGgQJrdRZwbFKIvZ9gA2YAW5dMz0BIFOBGAd5XRT31wVrfat2Mjd+EQZ5CCEK8tbBvT29DtpWookw9yENzIFcEEpI7pX/StnxbSEx+Yxg37BWJfoMs2hKOp7F/SAjHPx2Ey+mjDgXwUuAhYHKUXmSFmDiSaZJaJj8bBlf2UO0cpLfoje3cWqpyOwsQa+ZsmWQFxSv8780TDBQ080qCb3w7jhqjRgBofpHxP4w==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7PG2IBt0KX+BWJ2wAn8RiSzxzOdXJjxsvebVFXpzQv7ngVnEzFkxMlM1jM6anDFarSD6/cSfecFwnKb5ha1AzIso8xBoIm8c8r8VcMyOpUCNzquJ+zM8e6e7ZRaQ2wYHbZOp+J/yK8CKb+sSm7oSCLAblSSlTLrw24/LkBixtmmnZLsYcHAtBNSMGo3LqNfyXuansrnyL9QxPtQfRmKUfmx6S4Ugb53mZorj9zzHeBrBgasX4tEH/XIr24UcvYsvJ/fl09bevzfIhEvMK8AJWY2fSy4PnACvJLfAOHvqeeClG53XKCV0FDfBUkGy+BvsXGPu7ZqF4aaXV5z7j9XLKNnEb21hsAciC5VKEjBtG4/TQ3j6uS1UcojjuQ4zQIQCurVxeGazpNxe5KV++YVfEAWiLOMsC+3gw+mvqktjoqjoCW1JgxOEqLmAh/Bv8vZA
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 06:07:14.4643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86400f32-ed97-40df-8340-08de80c6c5e1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAE1A1621A

Hi Michael Walle,

On Mon, 02 Mar 2026 13:24:45 +0100, Michael Walle wrote:
> I was informed two weeks ago that this product is discontinued
> (without being ever released to the market). Unfortunately, this
> collided with the merge window and I had to wait two more weeks.
> 
> Pull the plug and let's not waste any more maintainers time.
> 
> On the bright side, the board upstreaming brought some driver fixes,
> too. I'm really sorry for any wasted time.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/7] arm64: dts: ti: remove the Kontron SMARC-sAM67
      commit: 852d2c0cc231806b9a3e9cd9e965c08342a27d66
[3/7] dt-bindings: mfd: sl28cpld: Drop sa67mcu compatible
      commit: 8b0260457b0bced7e782f000c1d4c10668bf7cb2
[4/7] dt-bindings: arm: ti: Drop Kontron SMARC-sAM67 module
      commit: 41a7b57152ffbf3ab8ab1110f831b1f53c2f9b88

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh

