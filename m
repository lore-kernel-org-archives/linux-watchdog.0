Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011017.outbound.protection.outlook.com [52.101.125.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA91DDA18;
	Fri, 25 Sep 2026 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790313115; cv=fail; b=HvS7h6q5hJtCNW2T8mzhsed47Zic6/OhkNIcHNV3T08KfuD4KZb9ok/tqBF3rjG0fIrd1NyUKy5LUibGo26TkyV1FClgr13oILMLwKVaH41HPwRc+hKYlhJQ23Jbheo2Zl2BOLMMZv/89hYojBfXVLl1TGz+dShyS0hjfOxlc2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790313115; c=relaxed/simple;
	bh=epLCXdrkivskGlKtP1i+ZZbuRbklomBpUC80PR7ODFc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qli35Z5US630pZE0+Rb69YSJiFiqfSoSEwcgStjQ0rpXwYCWZyPlhYpoxGB7JgzM264BqaLXFCgYMpDl9VVbhWxPceUXwZEOPLWstDCFMN8bjQ7mY301XgGIZi8UMxPjdflE9lXPhJTX1zGhp3vImXE2++7P1EJIUsdcc+zBgFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=NHndd/Ao; arc=fail smtp.client-ip=52.101.125.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="NHndd/Ao"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mr+862rt/36BYLeVnXx8Yh2PjP3b461uwE7HkL359t2aH9JUfw38bYgRXutyZXZtFdhIbt+86hHV0uNMbnkdTc305a+yrXj+/9aSXWLPFwi+qNUQ7gJR/ZjK4N5Nb5hX1HU1O82pkIegb9o7fmKABnXcEMjwZCfkHjb+2m8oUlP1IFTvo5mJ8NXk7W5adVxiZBeW2HR5qfjKUTav7VMUrghlsULjE4oQOW8ZHWUBiobUk0BzBKtL1dURvLYQVMM1TRpIOAX5eG7GENQe6BiBkOB0Qc/IhefrDbWI+xna4sA6bmn1JnJ0OjL/x42DMl6CnIpB/svL7sBbT8cT4ZEDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epLCXdrkivskGlKtP1i+ZZbuRbklomBpUC80PR7ODFc=;
 b=Drc0TkLZa2ikIsAYqPiIkWuqX63cblp18fXuvUEqHnZ42RcoWgHsDx2HqOfCFAT/un1KBZ/j+DVCSFuUgzM1FJspHgWwgHddugLyC1AnMypkBbBFBjaOSKpMjq/7wK1K0+IpmJ+TLrOPc3Kybc7CvntLwbfBL9yjXUGJSOnZUG0JAK7PJIlXrRR9vWFv4OsnFw+56J1HdYdzyCpazLsVVrRmTYcaoalFXwyaPqQAI+lI2X96093dgtMT/pDD9OGlLVS1LgEcOuMVYXLQw9eKp+vrpcC9+WN7xxO4ILbWmF77nKdw3+3NEUuk/BUowsJcZkrXzxny3zU23jByy9axTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epLCXdrkivskGlKtP1i+ZZbuRbklomBpUC80PR7ODFc=;
 b=NHndd/AoD4VfNOaO7Mi28heovXPJW75c7lic5NEvmRtHeXOJq1k+zFo2ilmzv2WqyKUkJquthtbFNGRVN9RBuGKfXbKDljn7fnD7wn2lwIzePJwtlyBiVLF2XOknaa/xJDYosdRIEBVTQiGDoswGul682iIGI+RlMlDwh0BzOg4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Fri, 25 Sep
 2026 05:11:46 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 05:11:46 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	wsa+renesas <wsa+renesas@sang-engineering.com>, "robh@kernel.org"
	<robh@kernel.org>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 6/8] watchdog: rzv2h: Add syscon support for WDTDCR
Thread-Topic: [PATCH v6 6/8] watchdog: rzv2h: Add syscon support for WDTDCR
Thread-Index: AQHdTCrXWsFavv0/7EqWKNI1uetVXbbeRKCAgABqooCAAAtJgIAAAniA
Date: Fri, 25 Sep 2026 05:11:45 +0000
Message-ID:
 <TY3PR01MB113461EFFC2B9B39A53ED1D3386802@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923104054.3324830-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923105237.7B87D1F00893@smtp.kernel.org>
 <CA+V-a8uD16uG8cc9m7NHVZXT5bU64TYfu+_1POuXeioRAy6Z+A@mail.gmail.com>
 <4f5aadf0-8f23-4871-918f-430a0c99900d@roeck-us.net>
 <TY3PR01MB11346CC8B3C7374C293E0F3EB86802@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <2d32d7f1-f87b-45b3-9ccd-95e9773ca658@roeck-us.net>
In-Reply-To: <2d32d7f1-f87b-45b3-9ccd-95e9773ca658@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB10545:EE_
x-ms-office365-filtering-correlation-id: 87e09af8-9d14-4153-26e9-08df1ac37ee7
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|23010399003|366016|376014|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 rTFkZxbnRSsVsQcRUy5JFPD9P13EpzQnQ6cX1/gWRYYJ913cqGG1xI8g2OnNHGV0wo8AV8JsLgIMJYlsYySRW1KO7V+kgErgsFwmRipiY97jLTflhB5DzTslgVQKGJoDaSD4nY9dV7t9oCFcsgkBNahk99vvqavISKtwfyA6Z/08t0bL7/r7XMPz9CKANEUXhlYcv7S55n/25rARPR/x2/7TOc0oXjif1HKn4hpseKSLI1rTqv/Vu1fUQkKUONfUTlSH1zIIfSyoirw5m4b567sUNd49cBM/P733w2Of2w/MsJKwOkm9LHFD0hjggbwHYVx8fIkN/dYN7NvlQpHQ5JWqaop7+V5o/4zjCnm5QSQq3XMo7qNbdtgNMaTJNCjvWVNisfRol5QuVHZbCN8G1mkTSBytd8mPNjpTAXv/e1hY21RDhSfVyNxPB4EpgiRBPZJjZI01zICGYVXrqSE9cjcBtqgsYcrGEIItoWQ0xILvmY/DyQuvNWGur6w3e3SljgKgtugHX+OVKSizOh0f3D+m124Tz1AbtzAwHfw5P8hXXvMRu7jg/oEjqKteaqjXjfTBybyel1QS4nc7T/a4P4Y/wEBgDfCPiw2k3dusmFnhxL9T2Fu5VEI9+QuD+Kew0Ot3dVZB/oMFFBMzKhW7gMNSOBUhoafXuTNBlyiIJ4hJfe3xbocRB6SfygtMsqWS0SVsNOVs6+nVthIA0QZQ+4YldF0d8vMQwpQKsghNCwA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ykIMyUyHsfB98rVqkpiKjH+dFrUtVdedffTk1SWJl9HcnV9KUHympk7Xz6kz?=
 =?us-ascii?Q?eweLLbbXu3Tg2laerF4mMv3yhZ7iEI89BsuYqQmGPJeCIPSIRYf2HgRSgP9U?=
 =?us-ascii?Q?BAznzyl35wjjgsfnOq171L4l/6ZLlRgM3AuOqIq2UJJy/7vtyUaQLdbr+wmN?=
 =?us-ascii?Q?dMA/XRo6OA05WsHgdG+qORrim++xAPcU204myhmJsw6EiVe2OWYjcTrxBEuC?=
 =?us-ascii?Q?JmMp3m+KCDcuTyFnwURko25wBYS90eDNzBL4bOecQ6kMPbjsWbdDOypzl4wm?=
 =?us-ascii?Q?V/lk2RoPn5qyVPbzgJ8jhXc65dCmZFOQMkuWoxXb/oh0BR5fV3FIGS85qaAs?=
 =?us-ascii?Q?V4i5xkOoSCDGAaUF0mALoIFju/0Y9/stu47jbhmlVf18kZPdcF3GlG6UP58i?=
 =?us-ascii?Q?mZLfah/OOOyNEagB8hpxk5wv1VHcqaam4J2oZNI00fQ/OiZ1RQvp4CniE/cM?=
 =?us-ascii?Q?FPzVygph3UccsF6SnWyZi3Vt+LGz6PhcmjL8TFZVPKZ0d/WZh8Baib+YZwhf?=
 =?us-ascii?Q?2E5oNgdhR++dYiaow7kcnPikCyIPRyYNFshCxusLz7EgPkEUsQEOHEXwt0xS?=
 =?us-ascii?Q?1qQ+KsB66GIzpb1YAPuCvN1z4de5DK4dTPUpkjCkWuEqDbCkjqVO5X284DQQ?=
 =?us-ascii?Q?BT0o/H6EuFwhGVd7iMIRXxCBju2wJl+sACbwNVtZvPBYPqxFv6w2iYfUM09/?=
 =?us-ascii?Q?hofPG8rFtcijgIGKVGekaNzZhK54hhNvvhKZfIUvrft+wiwcYILFKWDb2mzm?=
 =?us-ascii?Q?6WJtaGZxPFx90w1S3W1HwCkSQrHxdLQp9hx0ytRYb6cftoWUu0BrxDC/NGq7?=
 =?us-ascii?Q?b1Vh8BRjp6Pa3MDb1otGZ0lf/hL+BoThTTMcWzbt30v6E4h3sVcfWYe7/VeJ?=
 =?us-ascii?Q?DiucHxAOC6B5pYmRTgIGk3yOCfiIfChGgLv+CgQqNMHbjgMjnD1kCGz/+U2Y?=
 =?us-ascii?Q?/BASKRM4GFhgzLCyg1TKknT3n9y5BqxTboEvz3mk41GLbV8YNLwokma9Uih2?=
 =?us-ascii?Q?WsA0FKHtcj5hcpwcb9fDKEnZQb5jo6XAfbHISIrsW8r8hfKdeV1idTBFDyt9?=
 =?us-ascii?Q?8FS6Ty65LbxCBryQYQVpfAtOZ91DMVRDRHvdzpv7Pbg1RzV7eFwayF4mP4Lg?=
 =?us-ascii?Q?yHpJ2gtkopGDNN6Jm5Z+k5/gUALg4rlFGpIGBHYcLOsjTHm84gAiTF2U0uRq?=
 =?us-ascii?Q?GMutN6U2Q5a0peyhC/yb2ksJa1GMVCs/akDQm1BUcl10SOzyI4Px5elra6aw?=
 =?us-ascii?Q?an8CuT1hEzcic5TchSFuCY0vZ2GRCJnfPQwl61D8jLcGt7VghS++9c6/BJjM?=
 =?us-ascii?Q?PenCz3SS4UhHM02C7V5WkzbJXjsSIRjZEdIGdvLpYrGH2l+bpKrbo7zRgy8u?=
 =?us-ascii?Q?5buZnDsuulP6E10QQTvVJODUAtyY24MKZdOCRDxojQxqk7rePHyoW0HIqFWo?=
 =?us-ascii?Q?PJFnqP0BcpsKmoO0ACtJ2RZkK+BfGKsZsSLOZUY3s72APFq12v8afxq4bLhe?=
 =?us-ascii?Q?RHnLJheM8ZP+MQbVZ7GFPwXZciW162wLGKx+UYGaZtMlZmUo0MQw/ZvluRVI?=
 =?us-ascii?Q?jI/b7RZAL2FMGjEbRMEKkFSibMSMFhzeqnJIo5LmIfP0KO0viok6KEuV4Orn?=
 =?us-ascii?Q?s0RLS5ebw6/o4O3Pl8uSziPDWugcHzvioXKrXfgDAlXjXjgDfj/MvoGbjBte?=
 =?us-ascii?Q?2K5ZQy1nTMve9CFTJbZIyXriUe/y39iMj6n4liduPgueFmvDUhV8S4lr1OdF?=
 =?us-ascii?Q?vNMRHHEgOA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e09af8-9d14-4153-26e9-08df1ac37ee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 05:11:45.9882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eYbQGTykI/RouJze6A+//Uk/pooWXuhKTGcET5FB7c4DVP81YKMvQZzGTAqq2ryLe2O1czeI1TNcRe/qIAxt57YiGP7zlG9/8KTEMISuBOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

Hi Guenter,

> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: 25 September 2026 05:51
> Subject: Re: [PATCH v6 6/8] watchdog: rzv2h: Add syscon support for WDTDC=
R
>=20
> On Fri, Sep 25, 2026 at 04:13:24AM +0000, Biju Das wrote:
> > Hi Geunter/Prabhakar,
> >
> ...
> > Just a question,
> > For automatic software upgrade, if the reboot using PSCI fails, what
> > is the fallback for reboot, reset the board?
>=20
> That seems to be a bit theoretic. The reason for having the ability to re=
gister multiple restart handlers
> is not to have failure fallbacks, but to have fallbacks if preferred rest=
art handlers are not available.
> If the PSCI restart handler is present, it is expected to work.
> That is why it has higher priority. The idea is to use the highest priori=
ty restart handler, not to try
> one after another.
>=20
> Sure, the failure fallback works as well, but that doesn't mean that fall=
backs should be provided just to
> provide fallbacks.
>=20
> If you claim that the PSCI restart handler does not work on this system, =
provide evicence, and we can
> discuss this further.

I agree normal cases there won't be any failures

I never heard about PSCI restart fails. But have seen a case due to a bug i=
n
serial driver that made the PSCI restart to fail as it hangs the systems.

So, if this is the case, a memory corruption can cause the same.

Long back I worked on femto based product(single core), where we have norma=
l restart
and a fallback watchdog restart. But it does not have PSCI system handlers.
On some cases, we have seen automatic upgrade failed because of failure in
normal restart.

So, I just throw a question based on that's all.

Cheers,
Biju

