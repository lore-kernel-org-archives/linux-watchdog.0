Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011028.outbound.protection.outlook.com [52.103.72.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86E83D5C31;
	Fri,  9 Oct 2026 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535811; cv=fail; b=gxFeRtQYZJvryPPMgBuyetu4QAHixF+tBsjHzIglVI1LGJxhUSg/G5qJK5Moy1LRSbYw82eEAmSH/8WutnNzopjGwEDCUEfG6a+HAn0yx7WHCbiJO7mLKWGop5Mv/5xsDZm0tM1iNvImQBNNkYAgGgjj7t2KTrL4CPA9YDfBhBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535811; c=relaxed/simple;
	bh=uxPyAnJiLU0n7wDGuV8xmj8brBb+/BNGStUsx3tcjlA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RAbvGF8ITtoPSOTf7D4QbWvVvBYgQHVb5hfIBAmay7/rg1R8I6xm5FZy+lPeKZeBKpoRbw/W21eJ1Gc+YtCWgGbihffbirLUHibyffFUwRoW2gK2nH0GjJxw1Xv12Yg4zNYjgp7w2+4Y9ZQYZ71iGrO9GGE+FJ8E3wesTFp/NUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=e/89IPaK; arc=fail smtp.client-ip=52.103.72.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="e/89IPaK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUIceVcoHHglEvDeNV/meSwb4UWKFgbQUxZ3sXgND0uIuJIZHSmN+4Va/9iXxYDihl3viDGeRPeOuHkbaFGaTA6g50/JFgN2HqN0gRoePhN5gszQEn2P7BFjsKpnNINyRzespIqam5Jsgi3Tm+/AjN/5HLmp8j1tiFxxq7l6D9aNzVaRwZGGiRPRR57eqcUK1gG+pGklT+rqA9e6B3UlPzIOKlg4uZTcUqE8ToheoChTPuRGEvt/E1QXGIXhRjD5eigJnrCF8pqaf3Fm3B1RpTJi5XFk/x5v+mo66FKQsVDLJ53aQRsMYlszsTEfdSfUwQD3twHNJFMIsIHQnyK0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxPyAnJiLU0n7wDGuV8xmj8brBb+/BNGStUsx3tcjlA=;
 b=XxEnZO3vjnaM1OziqwYAe6sox9IBWWMc4yvgmVPQO3diZa5A6jLS5CD8OTKb4vTGKZPN4IWHTEdWv3ZEofJPPlgYVbENn0WwZA4FD26idjfdXWUMm/q4HzRUssUQwUEaQyamHSRXvqy/UnxttUhlcFQGz9dW4sthaysLAbNpim8NeCjbXSf/d7AECPF4RBgq3lqnvWVpu0Hp54RSxxixoGQ4LJtegVfBLvy2uOR9XpQ/F0iF3jc14PrJ8OmDDz5zkzQaz8RB4v75jLbjRvpQtZuxR1ioB4TDSKoCTV7YhtHBpmJ+pHz+K00zzqj6SN23NVPOsYFh91bHRdrDxYFiig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxPyAnJiLU0n7wDGuV8xmj8brBb+/BNGStUsx3tcjlA=;
 b=e/89IPaKk9i04wRpO60MtW3bgAGOM3TBDyRa5zsOr/9ScAckgSUG24bZByvzNG0XZ4wAkQDtA8S0s2oZAVO5X0N9uqCtv7D9xNBkBXkYE0+elun4JoxDSKbsy/FQEF5FRqT61UsGfwgGgAQJKzMhNt7eKjsTxY8e4QDFLVuUgcmjDHlN4E3yE7I2n4VOfsH80O/s0W9PAXUOuic/2AV5972BtDHv1jTi7hMXW5zzT8YnuzCj0HiJLVCkwaUNCE7PGv/vAZVzvsSJqbK7nDNFp/BgyZ7a1+7mOcx7IjYLJtz7f2jcu/Rubq6CzYouxNqtUcYUqy+GhlMvfjGc2G5Gwg==
Received: from SY5PR01MB10600.ausprd01.prod.outlook.com (2603:10c6:10:32c::14)
 by ME3PR01MB8211.ausprd01.prod.outlook.com (2603:10c6:220:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Fri, 9 Oct 2026
 08:50:01 +0000
Received: from SY5PR01MB10600.ausprd01.prod.outlook.com
 ([fe80::db5f:2818:b791:cc19]) by SY5PR01MB10600.ausprd01.prod.outlook.com
 ([fe80::db5f:2818:b791:cc19%3]) with mapi id 15.21.0522.002; Fri, 9 Oct 2026
 08:50:01 +0000
From: Zhang Jiaxi <Z1529105815@outlook.com>
To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>, Wim Van Sebroeck
	<wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
CC: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
	<konradybcio@kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] watchdog: gunyah: report system sleep operation failures
Thread-Topic: [PATCH] watchdog: gunyah: report system sleep operation failures
Thread-Index: AQHdV3U4qFP9P7L9hk6X/+qPQJNFFrb0ZheAgACBU8k=
Date: Fri, 9 Oct 2026 08:50:01 +0000
Message-ID:
 <SY5PR01MB106001D68141E8C0BDEAB254BA1922@SY5PR01MB10600.ausprd01.prod.outlook.com>
References:
 <SY5PR01MB10600A249F7E2CAE647EFD46FA1932@SY5PR01MB10600.ausprd01.prod.outlook.com>
 <ec393b82-912e-4f85-8f30-b3b8cbe948b9@oss.qualcomm.com>
In-Reply-To: <ec393b82-912e-4f85-8f30-b3b8cbe948b9@oss.qualcomm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY5PR01MB10600:EE_|ME3PR01MB8211:EE_
x-ms-office365-filtering-correlation-id: 584464a8-0bec-4cd1-03c1-08df25e24e77
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|8060799015|24021099003|20031999006|2604032031799003|25031999004|22091999003|39105399006|24121999003|41001999006|31061999003|8062599012|19110799012|4140399003|38102599003|24071999003|15080799012|40105399003|2607281247196008|25131999003|26121999007|102099032|440099028|3412199025|26104999009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Tk5w8h5MlWlHHJKLtsxyll4hphvnKwsaw8KPpbrTkXx6mQIq7uryDDm/CqJo?=
 =?us-ascii?Q?HZDLhoPKfVlXkxe1pXL7ERX8kA1zXPxCMJzTElYqPZWz/oLnjUbX/3f5i/lS?=
 =?us-ascii?Q?oaFlNFx1AW+NvODaL3RPy1422ymcmJ88y2c8ms+F+CYDGSydQKywKUOe66cF?=
 =?us-ascii?Q?A5AOkLJzW97hJkCgStsW2H9TwozYcvxF+xw0b3kg0Ob4RGWFJs/TE5NHoxKp?=
 =?us-ascii?Q?0TjnMVldb+7SwPR+eCDKIpye/+CuQ9XmMbr7mHmcIUAJXMxCvLhFhZ3ucCN/?=
 =?us-ascii?Q?EMbEyjwzuy/yGzGjQoMPvv8XU65TwmT7iJTPUtyonu/EuU/hfkm2RGVpOajE?=
 =?us-ascii?Q?XzfRiEiKxXITwOgtcvK3Etv2G2gj1KApv7fw/h0QdoP6wtmwWK0wI6sn1vUi?=
 =?us-ascii?Q?q/MJcZnpQMBMYjyrdkopuuy7ke//Vkx0H1iuQ0dTAz3qeRiVRwdQlzISXIl8?=
 =?us-ascii?Q?O2pXsDJYmJEXCPt2M/D9lEgWAlIxMKZSkCxIlU5a0awXxWjPEguhhVRgIcfc?=
 =?us-ascii?Q?UFekuQwaPdByl1wwTeu3IwUr5+E6lHYQ63WL9Eism5egwdvMNZ13VSTVS+mW?=
 =?us-ascii?Q?GTXzczpF2DdfuQCtL+1XBNfnht/ufRHOORyQi/GJRt144+u5rKaMSfXKwy49?=
 =?us-ascii?Q?eOXeFtkQO6z4PcggoVixj+rqDDhuOtcaSk+tbiSaLHU8zrW7xtd/KZPNZxVn?=
 =?us-ascii?Q?g1gn10bQWeImKF3nwnVJki7SCMo2Bj7JwrLE0YwP5SXF4m353knenxYSOuw9?=
 =?us-ascii?Q?LGujztbHbGh60m5n9tT8HcE3by0sVODJ4mMPDE8S66StzAhQ22cWX6DNE8uH?=
 =?us-ascii?Q?gjlEFM4U0BLoWYUNAvOUPpXu2mwft8TZRS5V1YocOtDdpvkjVBojqT9PBGNL?=
 =?us-ascii?Q?uXKarmxpyrfYdHFcX4c0dFXPzHV7k4X1fXqeO9w6594CLHnu8vJc0NGZ6uv7?=
 =?us-ascii?Q?EXc72zLqaG5+oIN0HE790tX/ZlqpyCQB42WwbSJsCFeXINYl2CjOmtR+jN9I?=
 =?us-ascii?Q?doKQFnl2V/+j7P6eRE/BNckbbjzTJWs272/VMgWR2OLekISFAF6vN5L3QKjf?=
 =?us-ascii?Q?8CVV28RsyA+IWnAhA9FZNECqKTvClNFAlOarHoMiQ1HQYpbubF8KtO7psHYm?=
 =?us-ascii?Q?R0ujxGcaooJoJXo/XY0nLuBLmzZTFHpFh8+nOKRSb6qXfwKAvUvJEP/abGJu?=
 =?us-ascii?Q?JblB9CYSKe1aCfM9k8Q5XjdXwD/uJ9pZALA8YHFaZ2jpKgyF/OWpWTx96VEr?=
 =?us-ascii?Q?vXMWZzpAuHdtEiFJOqdLs5/4PBQ8ZkVmvpXzSepd3Q=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WgDM1sGl3DKB8NLdxTaLDvPs2Wz5E6JCNvw4RKGVyNsH75WKGMlA4VYC3Y5Q?=
 =?us-ascii?Q?EUa8jInjHwcYQmwJCr1VfM9NL7+vHqBx4R7muCHS/9AYDAdISebewSMzC90Z?=
 =?us-ascii?Q?CgPT4++mvIUNN+mF9rXkB93olOkD3vItPSfpjiwiuWg2mSJxbN18IiIQPhMm?=
 =?us-ascii?Q?xnz2HfD4Uy0eECPmy0+xuIZ4CkVepGsXx+2gNfTePV0sFNYfsj7EhKOoqmYa?=
 =?us-ascii?Q?Q3nz0DrFPIeKRbWTRdNSPqQ/E5X/dT9dK93uKZ35p3mBnMBvUdgKr4POgpMc?=
 =?us-ascii?Q?D5ZO1SSlRkmRyxeJpc/j1M5GzsMkAjNxuSzi75nxiBgABqGAH5O1u+FV/iqr?=
 =?us-ascii?Q?My0S/VbXLlU23UNrL8a4dBfoXW0b+putJBkljEPEAbFy1iuNdKz5RctzVb5K?=
 =?us-ascii?Q?eHUKGay1C7o4028hbTIMEfuFB2UbZd7wodMFuz9vhjgpp8iMSBurQ2mSOG75?=
 =?us-ascii?Q?a9UoZRpITqhgvVz6R8LK642W7HgY7YBTC7FJNH82dex5MuBFiY99HtRSMhFj?=
 =?us-ascii?Q?pVsoxXZHYknAC7ZvOXNTNHbOafMWL9iAf+j4+LCNMVFfZyAZ+tKlrQ0eAgpf?=
 =?us-ascii?Q?fuZCKVjGoTHB/k11skvfo3vecUKZWIRncGrnbN6hm+R0oeEq8TY9E7m9qkrG?=
 =?us-ascii?Q?xmGAr9ID/eNK3sTRzYj5E+luHjYu0dkPAldZsfzxqWbUDmXJYs/uG/j41VE/?=
 =?us-ascii?Q?W50Am8uyfJoTePh6RyW8n3NUn2s1f+Fn7/RCuU+1uFFn/LCko4gO5i48CPVS?=
 =?us-ascii?Q?VCsjCQy3d6DKGZ1h4H443lp9ABQPPqGBkbUgpUvmuiX/+YPY6HQdWuXr5lfN?=
 =?us-ascii?Q?YiZX18QFRfqIsq7YO5IwzRreRaxpKIgdoMhR8Fddaq3XCiZC3cRv1xt9rbcO?=
 =?us-ascii?Q?rSO8IYKjF0tnWIHePgug2h0uRe2q3gu/gylC+LaqewjAZF+WLHFAtZ8vO16/?=
 =?us-ascii?Q?D5ugcUxT21pYWeBfVg483HRekYJx8xHlAnpdkNbsK3jlbOQjTJytzPOboXR9?=
 =?us-ascii?Q?jPa6LKa5wPEnjbH6BONJfrjvNiqLFJF3Y0FX4mSBrGxzKexnRL/w7DzzmQOP?=
 =?us-ascii?Q?rnHbR7NXe3c6FkpgblOAmdLLAdCCFvXXvDUbjmetaSDXxYB6yXoEvk7/guKb?=
 =?us-ascii?Q?/ZR5heetDMxIUonLV0abzVSxQJqkC1z+jLI30JF3JhKolr77MPEqO3/l/EsZ?=
 =?us-ascii?Q?E+hHCZD0FLMIDmDbAn5eO0jHxXYse3XlEO/IEy36OQxPmjOmLwAVUQ8qTRM6?=
 =?us-ascii?Q?GpV4fKCLKxLj++gstoao2SNYrqa+Wl5sXfV2PNaefWd9wQq4u2lL5FlqA09g?=
 =?us-ascii?Q?66Am4YFG3Acgdct/erYkToA6U2X4AF0XiHRGC/YQx9CMnvHetTKtN700MOxu?=
 =?us-ascii?Q?PVDWPNXofh0DWI4k0GpX2mjJlhWL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY5PR01MB10600.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 584464a8-0bec-4cd1-03c1-08df25e24e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 08:50:01.9149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3PR01MB8211

Hi Trilok,=0A=
=0A=
Yes, I used Codex/LLM assistance for source analysis, patch drafting, and=
=0A=
preparation of the host-side tests. I remain responsible for the submission=
=0A=
and its DCO sign-off. I should have disclosed this assistance explicitly,=
=0A=
and I will include the appropriate Assisted-by attribution in any revision.=
=0A=
=0A=
These patches arose from separate issues encountered while bringing up=0A=
native Linux on Xiaomi Warsaw/SM8750. However, that device work does not=0A=
establish hardware validation of this Gunyah watchdog change.=0A=
=0A=
For this patch, the tests used functions and SMCCC definitions extracted=0A=
from upstream Linux, with simulated SMC return values. Ten host-side cases=
=0A=
passed under Clang ASan/UBSan, including negative controls demonstrating=0A=
the original callbacks' error-handling behavior.=0A=
=0A=
The modified gunyah_wdt.o also compiled against torvalds/linux at=0A=
6c377d19d4a5 without compiler diagnostics.=0A=
=0A=
I have not tested actual Gunyah SMC failures, device suspend/resume, or=0A=
watchdog recovery. The evidence supports the source-level error-propagation=
=0A=
change, not hardware PM validation.=0A=
=0A=
Regarding the Signed-off-by line, my intended identity is:=0A=
=0A=
Signed-off-by: Jiaxi Zhang <z1529105815@outlook.com>=0A=
=0A=
The earlier email displayed my name in Chinese order (family name first)=0A=
as "Zhang Jiaxi", while the patch uses "Jiaxi Zhang" in Western order. Both=
=0A=
refer to the same person and email address (z1529105815@outlook.com).=0A=
=0A=
If you were referring to another issue with the sign-off, please let me=0A=
know and I will correct it in the next revision.=0A=
=0A=
Thank you for your review.=0A=
=0A=
Best regards,=0A=
Jiaxi=0A=
