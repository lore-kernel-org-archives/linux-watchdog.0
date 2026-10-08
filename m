Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011057.outbound.protection.outlook.com [52.103.72.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4390D47F3DC;
	Thu,  8 Oct 2026 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791498899; cv=fail; b=RTU8tzBtGnOC0uVQp7jKA2IpjgGgHXjijaoEcjvdhUKlhKOZOEnacJkeJ1UdkikZFo9mOm/vl2s4uHZjT9Hy0BNaYS0ANkhDGwTZQKwJQq/hx8XLMFuZKG7CRLt19CGIU/Q94KH96R+MmeyhshGraUgRTGZcko0YVGz7oRs5ai0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791498899; c=relaxed/simple;
	bh=T1tQ8YdFTRHlXGj+q85QOoLMzftZUypKd+99sLXDg4c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nO+ZBJomxFQnr6ghvpWNR2J+wRNejm+9CExBqi7qMFU9kCLPC5zaqVUgv+4734LS8zFSHtL5PoRImhY7J/6boWVJ36gMxemMTpg8CuIlGb4YdwNlyGlRcL6zyGHwqOASiZJJaAP5fN6+0/eepDD5OmGQWDjjhRRNClcHsNNzRzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=D7WIT6xQ; arc=fail smtp.client-ip=52.103.72.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="D7WIT6xQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CutrPqf+BgF56vThHvtTl+3lfDN1bMAw5FpllCtngkXzyC+OfbaQ1b2rtYowu1+kEjeUgfdNH509suBsUo04hxf0pCHZNbkIZJSJTvYuoc21B73Is6FUgVdeI1DkzrOfDzW//Sarhk1AJiHsK2JGmuVUEqs0Knk/vZf2fSZVHVTYlmiOfz6u4wU8bVEUtmUQGgHaRTKw9+9g37cgOKtlzL0d+vqHHs/i0Hfmmqv23vXDkHi6tLaCJneBJ9uQGLlfRKDWKppZLvu5gyvZgtXuzDutH28NdZf6o7Mi6elmq9biTvNB8nBV5+2zjduEMGrjjqusea20qFWrERvBZ2Ym8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZpfJBQi2hF2fAAI2MPv9C1AX8w036zR8SThrrc0odQ=;
 b=d786MCFBiyr0ng6OiRevPxShqIrgxOq7mS3Naiauip0UG5ZV0CoaWpDv0tUgrJ0BSnNChGcv8FcIwnvt5TUFSusu/XDTi0AWT22UszqAU0tEaa41vErPsoeoFdPNueWo3E9BY+605eNTUdIo28MOAGLJaUcBhBt+cMSisGxdTb1gUR45/RYUG7OTdE4ak6t9mbbeZhq/TBBmTM4jHloULDiNrfLufu7JT/4XvEM+Zhd/jDFZGos30RNargWQJ4d1Xp/VRkdyaS3OOmrWAya8TykRJBD9kTMjTLsc/G/Us/mj9i2O+q6fYfz4fMDIzlAacf1SXhwZ7yTfcRLFr5p0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZpfJBQi2hF2fAAI2MPv9C1AX8w036zR8SThrrc0odQ=;
 b=D7WIT6xQ0L9v3coF+g0oEuIwTvPbHMUaio+0idA354Gh9xlRu1gCDWxKn1pd0woCLp0lpJvW2CsxJLdGviRwG4VT5I8isl6HSivnpTgSMzjaYv0KYivFuxqZBXglpJKeH5x9ErJo8dlyqqayZwSxRzzyqCcaeW189URyPioOxYSM28PBfTWhGiOE2VLgxz4xj9h/c+Z6Q/34kYYQKpF3R/Swg8iYvNjtIkUa2rSHh4irNL1hZ5s/2CKC41DhJgTps+Xb1jkn2bfBBAigXhxtkUii43+xxNdWeI4diGSPr61EY066yW6ebk1DLnHOZJsA50tkXhdrF2Br/k+bhRDrKQ==
Received: from SY5PR01MB10600.ausprd01.prod.outlook.com (2603:10c6:10:32c::14)
 by SY3PPF346C5784E.ausprd01.prod.outlook.com (2603:10c6:18::40d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Thu, 8 Oct 2026
 22:34:46 +0000
Received: from SY5PR01MB10600.ausprd01.prod.outlook.com
 ([fe80::db5f:2818:b791:cc19]) by SY5PR01MB10600.ausprd01.prod.outlook.com
 ([fe80::db5f:2818:b791:cc19%3]) with mapi id 15.21.0522.002; Thu, 8 Oct 2026
 22:34:46 +0000
From: Zhang Jiaxi <Z1529105815@outlook.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
	<linux@roeck-us.net>
CC: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
	<konradybcio@kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] watchdog: gunyah: report system sleep operation failures
Thread-Topic: [PATCH] watchdog: gunyah: report system sleep operation failures
Thread-Index: AQHdV3U4qFP9P7L9hk6X/+qPQJNFFg==
Date: Thu, 8 Oct 2026 22:34:46 +0000
Message-ID:
 <SY5PR01MB10600A249F7E2CAE647EFD46FA1932@SY5PR01MB10600.ausprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY5PR01MB10600:EE_|SY3PPF346C5784E:EE_
x-ms-office365-filtering-correlation-id: 6538213d-dede-44ac-2790-08df258c5b3d
x-microsoft-antispam:
 BCL:0;ARA:14566002|39105399006|8062599012|19110799012|4140399003|31061999003|8060799015|25010399006|22121099003|25031999004|15080799012|41001999006|38102599003|24021099003|102099032|2607281247196008|440099028|26104999009|3412199025|40105399003|30101999006;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5ayw6nGRzRY/CRglqArxUBi135bLb+0o/liCragtnT82uJ7VeLhlmNn8Koeg?=
 =?us-ascii?Q?HV/2xtNNmP3Vtqf0o2MK89/kv/vAvjAk8GYLVgDD3REhdrA0FHTbPYFobR+s?=
 =?us-ascii?Q?IRNXu5YIdWDklInia7L8V5tSQwmCLr0/mruw216OIKsf5ec+Ks/GFVEpPwdy?=
 =?us-ascii?Q?Wl9or4nK2J6TZxb7Hyw6WSB2xS4O6jLdVNDO6f50Vm3xqTw4UG/feskMvhQX?=
 =?us-ascii?Q?I/kMTF3MSPqMQSFEFC4t7fMb+UFNe6x5+Buk4mfyg/tWkP/LvDQ+8WRJztTy?=
 =?us-ascii?Q?MyOS2+MLb+I4hW7e8wMfclaQ/UCzOL7UAqH5T6Z/LR51ujgpSwOfNNnbpMUE?=
 =?us-ascii?Q?JD27HF0xQjdl416zJJcM5Way6bPPNDlBsbrxVWnTOgp2xnHRtDAx1hh2JlU4?=
 =?us-ascii?Q?Mv3n4KTWG7Nvp5SiG2VNDU/soJU1na15blj+uuiqK/NGy37IybArC9h9mbPX?=
 =?us-ascii?Q?peubYyA0fYmQkklqMrMRU1OcW3mfspntY1dx3BXBFI+K39U5UPOpNH2TVgww?=
 =?us-ascii?Q?wUkuOERVoMGvAw7FUX6xkdHY+lXW46aqmVQq64OgQf6J5s2it842KJOlBqG2?=
 =?us-ascii?Q?+99fOJC7Qzo7FuwKe3fFilvxEMszs0n5MBT7wYw3Xeeh4x7dlZ/71w9Nf5zh?=
 =?us-ascii?Q?rqmOzy2ezcLdphsLdxUmA8eBV+le4HxLTw2nEk719yRO69UgFmHfcO5ikK//?=
 =?us-ascii?Q?i9E6gVQfO62e3oAFIbYrUHvVjiKTuk1vVgGVunRPHMrKPybEPzN4Ph/yICi6?=
 =?us-ascii?Q?uBxb5xsEcLd0X/WvFXI/PxGfVRmNLyMVj4IlrSk3Dp48Zou8h2HcsXVLVo9W?=
 =?us-ascii?Q?/ItmVOBx95sGg39uua+kMPG9M1cLGYNUj8/qASFyvhUMOL46+qEIKtfcvvfh?=
 =?us-ascii?Q?h9C7OHsTN+wlpMWANzYNgaC8tZkqIZGpdwJNZpuu1Zd79GqhrL/+1lR1eJAV?=
 =?us-ascii?Q?j4xEeQbijPsmts7ED6TdaDKpt8gO99vW4q0pSBOrAwyjRAPXZfeqGxlamh8f?=
 =?us-ascii?Q?WzXSoS0a9FJkqEGJFxxE0fz+LCe1e17KB+zhDW0u0dO4MoflGdOEBigtUKbB?=
 =?us-ascii?Q?a1fbu0tVdoQxS7uXFiTrRTY/yjMXQLGeWtCQRjoeu1bCyYSDcqI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ghZGxhqy5OZTONIembVm6Uc/twX8uKL3iBPF9ZPx6DbIlw48PqPSEjAdmPs2?=
 =?us-ascii?Q?rw0brgMhEGH9X0Q4/sUC+4FCuuNG73D4QBeC7f+6cErmsFqnQQdRxTmAxiLR?=
 =?us-ascii?Q?yn2l5iQHLiZyGnDignuwBP5bcYP+R/YM5ZhuJdznHyXeB3AOXB20XdC6wcKq?=
 =?us-ascii?Q?a9g8/2kQLWf/tjbuwg7DgzKfcCvaC9TsEut8Bpsy8skalYSsl4bIl/zxGD59?=
 =?us-ascii?Q?U77YEWO+BEjewy/zle0HuXM++0E4ZqdasQAjFuZUh2ceMzT89JGQDV9ccAni?=
 =?us-ascii?Q?bi5v6+rexlYda8K8IYiN70g5qvLeEQO2S/PSv0ExvygFR5ubmfn1dUuQ8E3H?=
 =?us-ascii?Q?aFEFy02vXjF8wy8k4KEzqd1JLabJ6UuUN3BWe+z1vy7+6WVR67ew0VdXxLKI?=
 =?us-ascii?Q?MCDVt4ckEBhEo53701yW8Ll9/M2UstZCzcG0saQn07qzoU9NVZ7HMFA82DnD?=
 =?us-ascii?Q?fEcvdDtHqRnBLTK47/DPeH98UBkQCIRvMLXb2MoBuSb0CzvU8Q+Og5t0hJTW?=
 =?us-ascii?Q?kk0uZdiwdIlAW6RXdVSxdO/k83Z5xYztFvWTib5cwFm/eGCnfBVxFE49VS8p?=
 =?us-ascii?Q?H7YJLIpka6d+BYp73gvoab+tsbqM0jZVifnwZtl7J7BE+7i4+UAB8MWxgcBv?=
 =?us-ascii?Q?4bJeYeLbYMLbPruqrYi0sB5kqWkT9nUI4QbHysogtfjBZ/G0w6/mvT3wiwp7?=
 =?us-ascii?Q?PjtjWvO4sTGia5AY5OyJ676AjA7zI8yCRaCrJ91xh3CRfku+1PW+v2Hw48gL?=
 =?us-ascii?Q?5hTRA6LKaFiBWUGRfeqNwSuN86hZqo26/OsJ5NONSg7aIYFueo+wF09Alws+?=
 =?us-ascii?Q?rlrs7s8BPmYEQnTPw8PKJ2m+5bjvbm4uWsOtH+igmKQixfyxdu+YiOJ8Gyhh?=
 =?us-ascii?Q?gpBtarDlwa18b/L1CNPDZOJsEafXYLuAXkfNyPlL1xFvYrKPmGsHLW8QzUnL?=
 =?us-ascii?Q?bw+jlOYPUYJj870MUiP0Dl1D+w/gcHqw5tECVS31KEhgt5OdESTVrpiaw6Cg?=
 =?us-ascii?Q?s1iUcUtGn9EoMAUtDDt226LYJbfadJk9NuFmU3Eu2nbNVDWs1mFELGc3grtC?=
 =?us-ascii?Q?NN7D/HBIfPPfnVtQOWGfxV0H8skvkxiYkrOsNgv12Q/VWdGeDzaC5e6FsYjx?=
 =?us-ascii?Q?D4JvzoqyH/R9CWF2e+wY/r8vVKWO59wYjZZoXW8OofGR3ZIT2dp/e085W7sV?=
 =?us-ascii?Q?RHy4MjDOiECFGHr1cyvdgJF5CYGg0rNvs6lD17CKANq+D+ZbJxCdZhgHviBE?=
 =?us-ascii?Q?39yToNdhglcX99rckJ7r14lYnoquR1pkgYqo1T5gpIc3iADEMophvgk77zRU?=
 =?us-ascii?Q?/+p4n2bYZD2Y/tCt6ksjCMQykoH+XY4Ufo7MuKueXTy8/C22wHgQPIHf65hA?=
 =?us-ascii?Q?5ZGvA57wbxEYz768QL0nsipFn3sU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6538213d-dede-44ac-2790-08df258c5b3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 22:34:46.4725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPF346C5784E

From: Jiaxi Zhang <z1529105815@outlook.com>=0A=
=0A=
The system-sleep callbacks discard the errors returned by the watchdog=0A=
start and stop operations and always report success. If stopping an=0A=
active watchdog fails, the PM core can proceed to suspend while the=0A=
watchdog is still counting. Failed restart on resume is also hidden from=0A=
the PM core's callback error reporting.=0A=
=0A=
Return the existing operation result when the watchdog is active. Keep=0A=
inactive callbacks as no-ops. The start/stop command sequence, initial=0A=
activation exception, probe registration and last-resort restart behavior=
=0A=
are unchanged. Reporting a resume error does not implement recovery or=0A=
guarantee that watchdog protection has been restored.=0A=
=0A=
Signed-off-by: Jiaxi Zhang <z1529105815@outlook.com>=0A=
---=0A=
Clang 22.1.8 compiled the changed object on torvalds/linux=0A=
6c377d19d4a5116d9bec5203aa3c6c11523e7898 without diagnostics.=0A=
Actual callback tests with modeled start/stop returns cover error propagati=
on=0A=
and inactive no-ops, including old-code negatives. No device PM or real=0A=
hypervisor-error injection is claimed.=0A=
=0A=
 drivers/watchdog/gunyah_wdt.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/watchdog/gunyah_wdt.c b/drivers/watchdog/gunyah_wdt.c=
=0A=
--- a/drivers/watchdog/gunyah_wdt.c=0A=
+++ b/drivers/watchdog/gunyah_wdt.c=0A=
@@ -214,7 +214,7 @@=0A=
 	struct watchdog_device *wdd =3D dev_get_drvdata(dev);=0A=
 =0A=
 	if (watchdog_active(wdd))=0A=
-		gunyah_wdt_stop(wdd);=0A=
+		return gunyah_wdt_stop(wdd);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
@@ -224,7 +224,7 @@=0A=
 	struct watchdog_device *wdd =3D dev_get_drvdata(dev);=0A=
 =0A=
 	if (watchdog_active(wdd))=0A=
-		gunyah_wdt_start(wdd);=0A=
+		return gunyah_wdt_start(wdd);=0A=
 =0A=
 	return 0;=0A=
 }=0A=
