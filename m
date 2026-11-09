Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794223637;
	b=y6DUzRP7qeuX+JPnYYrgNkH41zGLRhqY4fEK3aFZC5j13nJc3whmmlXjx18VMs1PI+Q0
	 vwtmehAMfpJ74eGj93U10mRKrM7yVoYZArdpBt7xl1StsdrSAoryToOyFmvkFwwSWWO5g
	 C7QzPaNfDYTEJsN/2C9/bYeY/FFuho/rB/Altw6qdmg6viNh5uTDQUa8P8uiAMlpQBjCs
	 nGJFn0ymZfUxXE65dlfQEVYjHWyIAXGEMQ6b6GWSj1khkxKlwNeGVBjI3xS58P9NBb9rA
	 CrXeCmI0+HjJwHQSyS3BtzQ4SJxzwzOKGaoY03vzn1TUnMHyWEvq9ojTJ5K4pPEqJJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223637;
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
	bh=5PvSRBjYNi4rtyVCf5rB+IZHWhcp4uYqnd4XnWfKlkQ=;
	b=xRk20NhBZiBMJ7ZLckI026VfxWT4MeficDyTOJTEncp4vX7T3hcJwgR3u/cJgklepaXT
	 uJv+hvsoVIhuOl/WlBeFga/J2eZWzhbKL7DFCIM2UitFZSnRWurTLt/oMI7lHXO5G5nz2
	 pi3mM89M2NMpWyymAPRpBXBbTxWCwJHpCVsL+yBRx3r/EvvLzldwF+hj2upkCk61kA4KA
	 DMxHMJB1PAt90xB1MLyS4tVjiP5C6gc25iWi0GQC7X8YWvYUHR9E8tHK4p+wFOV4bTvd/
	 dp7D9/EuklwfOn5Rq5ThopCbneEbKUIPu5RRez7z8yl6FR1uKANVA4hmjsmUPOa6KeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ko+h0daN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.55
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06A2606A31C;
	Mon,  9 Nov 2026 11:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F06A2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ko+h0daN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAjieGIcnqDjy+Ob+aA5PbFFClI3wddpskTh5WPOtfulyMqoyu22y9VShgxmngY9fOkc0SfUtAIvL5DDmmb1xFxzO4SygNZ821CTXJrYsfgjrxnVwChYIZoVHum/UUvTWL/fUXjVoe9od80RciechEgPruPqPZBWmNLqGhzQmmKDzkIKqgr579IWuXrOdYEdqQrq3t12vxRi/EQgoWdbP/T9f3n0IpcszxzR6M0s7XMXn+p6izbI0oE00OLJrAm01hOtxC4E38e4/lk9dHiJszmJohlkSQG/5Xkj5n2mSozWKUBC5FXFeFc7Q0vmcEZb/LYSBgQ3jTaZ/buGVg4vaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PvSRBjYNi4rtyVCf5rB+IZHWhcp4uYqnd4XnWfKlkQ=;
 b=zBrz9+1V33Ute7pDDACNShBBbXI+VBCSa4/ItMxwYSlnOqcCxsUaI2Pjsg8SJp1WcwI7Hq27xzlH9DQ9K94nfOTcrq8BoOk8D4PLFIBGuQgGUWJ2gZ2u/F14udZPYRKAN5UUtrTKpjjUpyIiFBTdZO6ihL11FjNLQApe5/8J+kKUeCmz+F3GiZbq0Ph8RT4JsA0NrMOw7uN+CKdyEJl/sLt7mIuzZxZ/PCBkdxmKQbAj6K4jBt9CrOpo3OrkO3YZ9IH4mkmnTcOem/pfaJUiV2yexwI3U+jdV0nltBB3TCR5ZBai45mUVx0jHLbRMomZbp4Q9tRKDWGWj3imPOzsJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PvSRBjYNi4rtyVCf5rB+IZHWhcp4uYqnd4XnWfKlkQ=;
 b=ko+h0daNyrrI96PdsBKTRCbaE8Cgkk//RViddBl2zieCPugprojA7u8SxOtI9/OBPGZ1DOh3owa6J/SIB3elKxCxKBcHZrXYx4vwSN9/RaCMEYfUgsO1UTx1J0v0gjdhCJE2Y1ZNfpnA3SSf6DwAvjhDXgs6dNmxzIR+j3xEB8bIIx8FArkPCAW0+9JpROq0bdmNjXLmLU1LDTtYOap1KY5Wo/QBLiwTl1l8ymmaIWb6cWiv/zQdxErowu7jxH1FFaH7Yl8N9OlL889/GX2B1dKvTWZKiVVE1GyBgvYWwU6g+R2/AfwhzlhFb07XYx8DC/+eK6Xdu/6CTIIVTuQTNw==
Received: from DB8PR04CA0011.eurprd04.prod.outlook.com (2603:10a6:10:110::21)
 by GV2PR10MB6574.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Mon, 9 Nov 2026
 11:27:11 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::4) by DB8PR04CA0011.outlook.office365.com
 (2603:10a6:10:110::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 11:27:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 11:27:10 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 12:28:06 +0100
Received: from [192.168.8.15] (10.48.87.124) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 9 Nov
 2026 12:27:09 +0100
Message-ID: <c5cce09b63cbe9d96cab2dddbe9a651a3ea1bedc.camel@foss.st.com>
Subject: Re: [PATCH v3 02/13] watchdog: stm32_iwdg: detect whether the
 watchdog is running
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Guenter Roeck <linux@roeck-us.net>, <sashiko-reviews@lists.linux.dev>,
	<devicetree@vger.kernel.org>
CC: <linux-watchdog@vger.kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>
Date: Mon, 9 Nov 2026 12:27:07 +0100
In-Reply-To: <a6460db0-8df6-4427-9ecc-277f2f575d39@roeck-us.net>
References: <20261106163429.618392-1-antonio.borneo@foss.st.com>
	 <20261106163429.618392-3-antonio.borneo@foss.st.com>
	 <sashiko-outbox-201895@kernel.org>
	 <a6460db0-8df6-4427-9ecc-277f2f575d39@roeck-us.net>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF00008860:EE_|GV2PR10MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3efb37-ee6c-4174-2170-08df3e54652e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|22082099003|18002099003|3023799007|4143699003|11063799006|56012099006|10067099003|261028144727099003|261026121527099003|261022075727099003|261022105027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	+MdPS48335nfrHGZBBiwwyR+ZyHlXptbxQrEdyf56KAENTBxSThy5sDnzCNMlHT2aiqRQoru+j8MFdqPlSPPvPVMK2NlvLNPemUNNZ63PIipzxCNxXA+IyRJH4HJ7/CDbX30r2/Ld8UuTxuaYBxdRq2fOv0NJ6CPWMqI9jmeibBpDaLFilTf63WpPO0Pvn1lCqeMWBb1ZyWibywheZibAevhlDIlwz8bzPVqqqjhZE8W2Fu1Fe/r/CPiw+AwQeFUf77/Yv6i7K/uacIUlFxJUbHHWVm0TtFF39i3O6asGCvWBcInenRZSJCYVmGDi6i1bZwhM2g4mlwSnAdT9QVt6SbGJphbcl4C9MmVbspyA9zDZDlNuHWrPk+Egodx5vRsO5dE9M6OKNJ+f8x7TlCrBb7vH5i/++VHocRH6c4CuRGD5ABSKViGj9ekQtUDN7ztS6jbm6/I7ealyLXE+hz4AM4oSAIwWcKzHk0Kekl5z5M87Q7XNgg4WF+qRj1oAghM0RBFhihlbMIV8qc1Sx/0W4i/cqIA6Gqd2KelAvIHGW7kjQzMvhsTSYpqOmj2+RJduP1jEEyes/SNWZjGVoBZqrsAmw4HvAcHg7QNKiVaxs39kbUbMsMnpNATF+w4HqqbdHu8WlH2GuDHMbTBOHDB0rr4Ta1YcGbzA3NtNLfIDn+RC+lEhCBztndoIhsBsyORDgBXhw8uov/IsB9NvlRrTg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(3023799007)(4143699003)(11063799006)(56012099006)(10067099003)(261028144727099003)(261026121527099003)(261022075727099003)(261022105027099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dZPg61ZBmLUF5k/vy8Z+Lqidc42mc9Tj/ky3XLvf8hEx9UDyjwSPAx0pkgNCpiSKJZiVaUpbgUsaDb46yK4ephsBTn3lD73VYYicUV9Ue7+OHe92Utn1VnvezQv6hrGzqqu8AWheLXqe8/qTSzdCE+G+CPwVdvuzhx4KivD0Wl+KCOoADFqVvS0Hp3c3t1rWEh5E74BA3wYGcifvZBpNoJJrenxlZhfuR1zo+4DtbUElZP6ctDjUV0/YNURf0QWkZ+6aOmqyjWSM2fqhiIPQFZxToWG0MHnR4y9xw2fObFT7mGp+xXDEWaCIH0QpMPhm/7N88Ho4wCHhYgM47jGScF5phJpQCnGKhixyYGMj3UgcoCqxqibDk7s8laJTklV3BnMGfckulx3qGojrU0B5flBEPvGupZbyymz3mjJ0O6UjDAIHiYuecu4mtcl1xkI6
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:27:10.4392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3efb37-ee6c-4174-2170-08df3e54652e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6574

On Sun, 2026-11-08 at 09:56 -0800, Guenter Roeck wrote:
> On 11/6/26 09:05, sashiko-bot@kernel.org=C2=A0wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issues to consider:
> > - [High] watchdog: stm32_iwdg: unconfigured timeout in
> > =C2=A0=C2=A0 stm32_iwdg_probe()
> > - [Medium] watchdog: stm32_iwdg: WDOG_HW_RUNNING gated on Kconfig in
> > =C2=A0=C2=A0 stm32_iwdg_probe()
> > --
> >=20
> > commit 7c2acc17f93336becc29a7a139de848c3db25624
> > Author: Cl=C3=A9ment Le Goffic <clement.legoffic@foss.st.com>
> >=20
> > watchdog: stm32_iwdg: detect whether the watchdog is running
> >=20
> > This commit adds stm32_iwdg_is_running() to detect whether the watchdog
> > was already started by an earlier boot stage and sets WDOG_HW_RUNNING i=
n
> > stm32_iwdg_probe() only when it is running.
> >=20
> > [Severity: High]
> > In drivers/watchdog/stm32_iwdg.c at line 394 in stm32_iwdg_probe(), doe=
s
> > removing the call to stm32_iwdg_start(wdd) leave the hardware prescaler
> > (IWDG_PR), reload value (IWDG_RLR), and early-wakeup interrupt
> > (IWDG_EWCR) registers out of sync with wdd->timeout and wdd->pretimeout=
?
> >=20
> > When stm32_iwdg_is_running(wdt) returns true, stm32_iwdg_probe() now se=
ts
> > WDOG_HW_RUNNING without programming wdd->timeout into the hardware or
> > reading the bootloader's configured timeout back into wdd->timeout.
> > Because stm32_iwdg_ops provides stm32_iwdg_ping() (line 162), which onl=
y
> > writes KR_KEY_RELOAD to IWDG_KR, the watchdog core's keepalive worker
> > schedules pings at half of wdd->timeout while reloading the bootloader'=
s
> > counter value. If the bootloader configured a hardware timeout shorter
> > than wdd->timeout / 2, the watchdog expires and resets the system befor=
e
> > the next keepalive ping. Even after userspace opens /dev/watchdog,
> > watchdog_start() in drivers/watchdog/watchdog_dev.c (line 261) sees bot=
h
> > WDOG_HW_RUNNING and wdd->ops->ping set and calls __watchdog_ping(wdd)
> > instead of wdd->ops->start(wdd), leaving IWDG_PR, IWDG_RLR, and IWDG_EW=
CR
> > unconfigured.
> >=20
> > [Severity: Medium]
> > In drivers/watchdog/stm32_iwdg.c at line 394 in stm32_iwdg_probe(),
> > should setting WDOG_HW_RUNNING be unconditional when
> > stm32_iwdg_is_running(wdt) is true, rather than gated on
> > IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)?
> >=20
> > In drivers/watchdog/watchdog_dev.c at line 1099 in
> > watchdog_cdev_register(), the watchdog core checks watchdog_hw_running(=
)
> > to pin the module and device references and to evaluate the runtime
> > watchdog.handle_boot_enabled parameter. Gating the check on
> > IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED) in the driver prevents
> > the core from knowing the hardware is active when
> > CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=3Dn, breaking the
> > watchdog.handle_boot_enabled=3D1 kernel command-line override and skipp=
ing
> > the module/device reference pinning.
> >=20
>=20
> Sashiko has a point. CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is supposed to b=
e
> handled in the watchdog core, not in watchdog drivers, and it is supposed
> to be a default value that can be overwritten with a boot parameter.
>=20
> Having said that, please let me know if this is intentional. If so,
> I'll apply the patch anyway.

Sashiko is right on both points.
I will prepare a new version for this patch.

Regards,
Antonio


