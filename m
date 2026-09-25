Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011030.outbound.protection.outlook.com [40.107.74.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78E92D8385;
	Fri, 25 Sep 2026 04:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790309610; cv=fail; b=JvkG/7QiVFBRKiKO52pHQFsg9VIK9amJJuqOkRLZmPGfc1Vmo2p4xKsMSNDlq1cG8QsNvPUDaDWyuFSrqrYKbnb37etHd2fNqvR9ilYLbElqIbPszOQgqaSy9ZcdryIPIuL1FsDLPhN3LNy46kSFW/RVcMGyALG0XUXQNCajX44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790309610; c=relaxed/simple;
	bh=rTNzwIwbAb8omT01m0DWUcf6w4aD1DaWgBJsHeA+jlo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J9wRkXGuXY7mM09Z8aFdSC9vqEbfsf1UkIv2Hb5B+cbHh1MxKpZZpP+dWTnToPeO5fHwIHpmBF5t7WCj6PCwUkSdv8GFb75PLjt54wSRPj/o3kQ4k/CuKZRVhTgedQ7AK0OJW/ynWfJiih4ESjfbvMLRDzp5PMx3hWOPbSZoqjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ftu3Zx21; arc=fail smtp.client-ip=40.107.74.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ftu3Zx21"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmbM9WcrfoWx6vT1Uk7rsHzK2uaB2o6afCaNqAhEqkdc+oabsTHg7DF0BqxRkZ+OIBBDihpX1NocleH+aa5tRO7IPgAhSoDx4jlBa/mXx74L/mYckx9ezhJNsVWwaigj0SopjMT5ATPHITXvTkD4HVS7XGCQmrVZ1oNv7u1ApTF/aQ64TbVrH+82O99HCI3cjeSVfIeBDHQpSSh+Xxhdf4WVqRIOmmCx/qz368bLU4J2LItAb3MzCTmZrxTxWhjYsmJQiPHlOjKl2G89fTlbVkj21rTc6ZKdRTh1QL/ygRiyN8vQXOKRt7N6y6wBDbEpEpmxNo8GQTBx7hzuJN5Y/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTNzwIwbAb8omT01m0DWUcf6w4aD1DaWgBJsHeA+jlo=;
 b=sVIXqBxRvZZI6yFdRuJUDaV8UdKVlaX9AIuNSwASL6sJkycXcD5rg3ghdrh0vp9UumtTm8wgTLALgVVbHR+LfzyrV2rABk3eatnk70NaOb9J3PcGPSoOHSDDX0agFcelbMiV2ewnxK6ewFyZTaGAPJ1dcfS/nL4pxYbo/ZDriTvBMrPIhIf1MGRiRfYiJZqdz5/s17z9eJv4M9GIUDTkxjYl7c7u5E+IubYuhVMVjXGqaD+j/mLab+N4BMn5miOtcRVihGS3QCX0chiqb5Qobdjuevv7Ke0Qw9shfcH2pRzH2k4HqgvLpHTmMKwgYFWtl7S76dYLaqCd2hBpzDGHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTNzwIwbAb8omT01m0DWUcf6w4aD1DaWgBJsHeA+jlo=;
 b=ftu3Zx21G65baNjuP6b13Vp1Wb6CKe9ZcwhnsiesUPqWDSOTxZAw6UOSKsW1eJA0s1+ZBuIziB7INQTboV/e5W2kCAmbI8qP0g2ZcN72MSdYRi+SyWMqPV+CFz3hT++suHQIScg8pp5uoKFKWJYOjw530jVFV0hx/npNCPgFW04=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB13427.jpnprd01.prod.outlook.com (2603:1096:604:32d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 04:13:25 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 04:13:24 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Guenter Roeck <linux@roeck-us.net>, "Lad, Prabhakar"
	<prabhakar.csengg@gmail.com>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, wsa+renesas
	<wsa+renesas@sang-engineering.com>, "robh@kernel.org" <robh@kernel.org>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Linux-Renesas
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 6/8] watchdog: rzv2h: Add syscon support for WDTDCR
Thread-Topic: [PATCH v6 6/8] watchdog: rzv2h: Add syscon support for WDTDCR
Thread-Index: AQHdTCrXWsFavv0/7EqWKNI1uetVXbbeRKCAgABqooA=
Date: Fri, 25 Sep 2026 04:13:24 +0000
Message-ID:
 <TY3PR01MB11346CC8B3C7374C293E0F3EB86802@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923104054.3324830-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923105237.7B87D1F00893@smtp.kernel.org>
 <CA+V-a8uD16uG8cc9m7NHVZXT5bU64TYfu+_1POuXeioRAy6Z+A@mail.gmail.com>
 <4f5aadf0-8f23-4871-918f-430a0c99900d@roeck-us.net>
In-Reply-To: <4f5aadf0-8f23-4871-918f-430a0c99900d@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB13427:EE_
x-ms-office365-filtering-correlation-id: 2812d668-eaa9-41d6-7bb1-08df1abb580f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|11063799006|56012099006|18002099003|4143699003|22082099003|10067099003|38070700021|6133799003;
x-microsoft-antispam-message-info:
 8lEYuNRu2hT8RJUWvxqCVurC1tIDGy/yD2IBqcUN35Wrp5bZS+FGyn5tear3xPS1a0veW+q7FDM/z+BO3sQIgkH30cuESozo5TBlfDBQPQNAbqU8bQ9hhXmgTge5q+yPUEYsQHiqpQsrb4WmUlXicFx4J+hCneKuROsC9s7kXpuqhJStrT6yRlsEDOE9fAOo5qOvFwdF6dI6NwO0d6KJMKMi2ChunThq6H8BFz9OxR5QulHz3H+TlJQ3gDM5rtALsILa71+e07XbiIZ1Ur3OLP9NvjmrM8P3Y6HKwWwpWHzFebtOhWP/6Y3zhn9C/pcxEakt6O52THAqu99OMJ9aJHbDv7zQxJ61Zj6iH9o5ybQFY/6AK/LZnG4rTrEC2eesieo1wz9gEP0IoKPkG1TupSoimzleOasmtQjDlD8Dbe86eAP/I7qVvRPJgKzEdOWdN3aRyTDnXCAzG+rG//olrXMuCFiGVyyW8xrA/W9mLnjQ9qkG+D9XFYomP4jAwnAy0R66aie24WbFUqe7dCpGlqdHe0RA8pWQ8iS15xxI161uEOpQ14dQryV8yto5XTBPd+K8NhEmauc9rc7Ocna+oLchy8dD9vzQ1F5nn4qZIdQaq8oupVrNLjl3Elzh7tXYE50B08FrQO1NGabi1lpvNxConiaqzwJKImxSOP4BllQiXz5ooHQWVHe3/6umIJVVPJCZtMWbZUApBY7itF+IpUaMoUfGhfkGqEYzbh5AoEw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(11063799006)(56012099006)(18002099003)(4143699003)(22082099003)(10067099003)(38070700021)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHdUQmJoS2pUSWNucHgwSjNCZThLUDBBRlB5RmZPUlFyRnRXWnJOUytaeW4z?=
 =?utf-8?B?eXZsRFNxcW0vZXBDWk96WGlOVTZCMG5ibGhnZGJXRTlEMUd3T3BYU3dUVGhq?=
 =?utf-8?B?V2YzcExQY0dqaUNOeFJQREJiUmtZdEQxUkptZDB0TW9UVmpnV3MvS2pQSUkv?=
 =?utf-8?B?VXBVeUNEWXc5RXM2dE1Hdzg1aGlYK1gvZEkzL2FKNTRKaTIzMFpsQ2syWTRP?=
 =?utf-8?B?YzZuUGlQNThsSUcrTjBHQVkrclV6SU1MK2FiWGJSajNBeGsySXdJS1pLU0Mx?=
 =?utf-8?B?dVVITjdqcTdoLzBmQkpTTmRHWkpmMGpCdnQxeHJKM1E1NWVsUzVmMjVpdC9n?=
 =?utf-8?B?OVMvUW9QNkJvU2p1S3RBT3VrWkRScGFOV0diSUpUa0QzN05CQU1YY1RqbHB2?=
 =?utf-8?B?WnRDV1ZDVlVnYTcyOWFXd0ZKaTlhdm5URThEbGlNV3Z3VkVwSGwwYkcyeC8w?=
 =?utf-8?B?SzlzeVRLaW9pVlFNVStqWCs5czRVNTJlUjcxYmcyZ0NSM0JONzZlMnBHQWFZ?=
 =?utf-8?B?Mnk2aVc5aEtZbytBMmE1MHFmNC9XdE5JZU5kaVlOL3V4elJaN3F5Y2FDTEFu?=
 =?utf-8?B?V1FWdzkzM0JVaDQ2YkRISnZzMHJaNU9rU1dkSE5Eck11dEZpOGN1ZnZLNWVa?=
 =?utf-8?B?b0ZhV0FqRWozRmN1WFNaa2RyZzhHazFlN1I1UXpuRi9aMStFOHVmdEQzOE96?=
 =?utf-8?B?eGhTODdKUnAxcHNjVmRaeHJsdlR5OHhqcS85Wm1jU1I3ZFQrUFI2QTRwQlJW?=
 =?utf-8?B?VlA1ZUdqZW1yTUI3MjU1ME1FRjB2T3I4N21seGptKzd1NDBkWWw0YSsvOTZH?=
 =?utf-8?B?T3JoN21yVzBCQVZzbng3SzZXaTZiNWozYUM4cVdwQlBBdjVLVmcxNkxrTE1I?=
 =?utf-8?B?KzhTcU5VNnNUSTBTck5GN0RHb2dwZDhidTFRaEFSNjVOUnJ5SC90RVhlTXNM?=
 =?utf-8?B?UkNFUnd4UWpESmJoN3p5bkJvdmdyYlJiaktDUWRGSHFlVUFlWGJaVkYyWFZS?=
 =?utf-8?B?d2JIS2tKdi9TL2F1dTE3bUp5akdEOUZiUVZVVllheUFmTlZSYVVLdzF0dGpF?=
 =?utf-8?B?VVRTWm1NakUwVEFSRDRhUE9WOHVjZ001MEhQb2U0Q2NldkVTVHZRL0kvZmht?=
 =?utf-8?B?MWhKTEkydFBYZFI0ckZnM0VRaXRFejVLTWhOT01DQ3pNTnlKUWpmUVJ5V0dl?=
 =?utf-8?B?STRISnplbzRzOEk5VDkrVTBkVXFhdWgyVk5wQWsrQWZsM1dxVFZvbEhIdVJl?=
 =?utf-8?B?MHM1Q3N3Nk9UcjYyQUw0UDQyN2FSN2wwd0k2Q0FPcytoaU5XMkk4VENBVTU5?=
 =?utf-8?B?dWZNNGdiOGZUSExHeWR3bE5LQzBUL1NzQ01xcWJ1bmNmV0VSMTlJNXJNaU1h?=
 =?utf-8?B?VitTQk1IOTNVTVVFVEpCTVJ0Ui9hYS9YN2o1eEkxczYxbkNqNFh2M3hQK2NO?=
 =?utf-8?B?U1QzNjYzdFZra2M4NlZwSGU5d3ZCeDZIMC9DTUhWdm1sS2lEaDh0aEt6dkU1?=
 =?utf-8?B?amF0MDRSaWcrVXI5dHBDcVNpMG1pYXcyNHhka1ZRS2k4VXptM2V2K3B2NTQy?=
 =?utf-8?B?b214T3BNNHlIOXRkZ3E5Uld1TmdienpNNXVEbjlOQ21rT3JDT0IrOHVSenZN?=
 =?utf-8?B?M1BZSDBvNzhWYnRvQWY4RHhGdnh0bmRBektkZURTVTdVbS9UTTlQcWo5T1U1?=
 =?utf-8?B?U0lLSGlMSE5nbHBlMWJSSlZ5SWMySzdZM215REFJbGVwVkhSVVdNQ1B6TjVt?=
 =?utf-8?B?dmpZdG41b0xSa2pIclhMemxnUEhpVDdKcDI5dm53OHYzVDhHb1haZkdVRnd4?=
 =?utf-8?B?V3hXVUZ1dTlWcURiUjRMNVVPNUtxL01vVTdrTThMd2x5citQVitoZmQ1Tytu?=
 =?utf-8?B?bFpOeEFKTFRlbUZBbWRGTFdLa2wxZ2x4c3gyNWhaM0VOOEQra05PL2o3ellq?=
 =?utf-8?B?Uy9mUlRwYU11ek1EZGkzYjVVNENDQ3NWVGVuUXZIQVRSdW0za291cjJlem9Q?=
 =?utf-8?B?NGFtMThlL0N4Q1JpZG5odUxWczFOMSs1aE0ydmJUZWxST3Y4dWpzWlp0bFV6?=
 =?utf-8?B?bW91ZU1ZeGFzd2c4WUJVbzZsM2hDSUR5MjdobXpNcko5czNZSGFDOGh4Z3d1?=
 =?utf-8?B?VFE5K2V6cUt4Y0dHZ2dBM0JhbWtvQzlTWEVsL2FYdE51Ri9ISzh5a0Vrd1Bp?=
 =?utf-8?B?UU1EeFhVeHpGYWQ4TDVNMnppalJhSXdySHdTMGdmMUJZZFozQWZIRVo4TEdp?=
 =?utf-8?B?VHJMaUY5WGtjdkk3dHB2U0w5UGtMc1p6OXNjOEl6VFN5MjZNQTY3VGpCeFFk?=
 =?utf-8?B?YWl1T0ZYK0dncWlJMUFaYzRDcHpVTmxYdzdsOENaWFVhMGp1QVY4Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2812d668-eaa9-41d6-7bb1-08df1abb580f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 04:13:24.8007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vw8oQYfmOq89EI3p9ouW2fXmypJjH9iFWffEwMMbPPi2cV44q35wFxQOzluKtW9oBKhwu6CHN8qzNqyjzGH9WrJP/2pAFiMDNbv62rKRGNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13427

SGkgR2V1bnRlci9QcmFiaGFrYXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogR3VlbnRlciBSb2VjayA8Z3JvZWNrN0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBHdWVu
dGVyIFJvZWNrDQo+IFNlbnQ6IDI0IFNlcHRlbWJlciAyMDI2IDIyOjQ5DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjYgNi84XSB3YXRjaGRvZzogcnp2Mmg6IEFkZCBzeXNjb24gc3VwcG9ydCBmb3Ig
V0RURENSDQo+IA0KPiBPbiBUaHUsIFNlcCAyNCwgMjAyNiBhdCAwMjo0NDowN1BNICswMTAwLCBM
YWQsIFByYWJoYWthciB3cm90ZToNCj4gPiBIaSBHdWVudGVyLA0KPiA+DQo+ID4gT24gV2VkLCBT
ZXAgMjMsIDIwMjYgYXQgMTE6NTLigK9BTSA8c2FzaGlrby1ib3RAa2VybmVsLm9yZz4gd3JvdGU6
DQo+ID4gPg0KPiA+ID4gVGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1dGlvbiEgU2FzaGlrbyBB
SSByZXZpZXcgZm91bmQgMSBwb3RlbnRpYWwgaXNzdWUocykgdG8gY29uc2lkZXI6DQo+ID4gPiAt
IFtIaWdoXSB3YXRjaGRvZzogcnp2Mmg6IERlYWRsb2NrIGluIHJlc3RhcnQgaGFuZGxlciB2aWEg
c3lzY29uDQo+ID4gPiByZWdtYXAgbG9ja2luZw0KPiA+ID4gLS0NCj4gPiA+DQo+ID4gPiBjb21t
aXQgMWUxYjI2MDY5ZjcwNzM1YTUzNzc1MGIyMmE1MTI1N2JiNDIyYzJlNA0KPiA+ID4gQXV0aG9y
OiBMYWQgUHJhYmhha2FyIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+
DQo+ID4gPg0KPiA+ID4gd2F0Y2hkb2c6IHJ6djJoOiBBZGQgc3lzY29uIHN1cHBvcnQgZm9yIFdE
VERDUg0KPiA+ID4NCj4gPiA+IFRoZSBjb21taXQgYWRkcyBzdXBwb3J0IGZvciBhY2Nlc3Npbmcg
dGhlIFdEVERDUiByZWdpc3RlciB2aWEgYQ0KPiA+ID4gc3lzY29uIHJlZ21hcCBpbnRlcmZhY2Ug
Zm9yIFJaL1QySCBhbmQgUlovTjJIIFNvQ3MuIEl0IGxvb2tzIHVwIHRoZQ0KPiA+ID4gU1lTQyBy
ZWdtYXAgdXNpbmcgdGhlICJyZW5lc2FzLHN5c2MiIHByb3BlcnR5IG9yIGZhbGxzIGJhY2sgdG8g
TU1JTyBhY2Nlc3MgaWYgYWJzZW50Lg0KPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvd2F0Y2hkb2cvcnp2Mmhfd2R0LmMNCj4gPiA+ID4gYi9kcml2ZXJzL3dhdGNoZG9nL3J6djJo
X3dkdC5jIGluZGV4IDc2YzFkMzE1YjBlNzcuLjMwYjBiNzBmZWNhYTkNCj4gPiA+ID4gMTAwNjQ0
DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvd2F0Y2hkb2cvcnp2Mmhfd2R0LmMNCj4gPiA+ID4gKysr
IGIvZHJpdmVycy93YXRjaGRvZy9yenYyaF93ZHQuYw0KPiA+ID4NCj4gPiA+IFsgLi4uIF0NCj4g
PiA+DQo+ID4gPiA+IEBAIC05MywxOCArMTA0LDIyIEBAIHN0YXRpYyBpbnQgcnp2Mmhfd2R0X3Bp
bmcoc3RydWN0DQo+ID4gPiA+IHdhdGNoZG9nX2RldmljZSAqd2RldikNCj4gPiA+ID4NCj4gPiA+
ID4gIHN0YXRpYyBpbnQgcnp0Mmhfd2R0X3dkdGRjcl9jb3VudF9zdG9wKHN0cnVjdCByenYyaF93
ZHRfcHJpdg0KPiA+ID4gPiAqcHJpdikgIHsNCj4gPiA+ID4gLSAgICAgZ3VhcmQoc3BpbmxvY2tf
aXJxc2F2ZSkoJnByaXYtPnJlZ21hcF9sb2NrKTsNCj4gPiA+ID4gLSAgICAgcmV0dXJuIHJlZ21h
cF9zZXRfYml0cyhwcml2LT53ZHRkY3JfcmVnbWFwLCBXRFREQ1IsIFdEVERDUl9XRFRTVE9QQ1RS
TCk7DQo+ID4gPiA+ICsgICAgIHN0cnVjdCByenYyaF9zeXNjX3dkdGRjciAqc3lzYyA9ICZwcml2
LT5zeXNjOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgIGd1YXJkKHNwaW5sb2NrX2lycXNhdmUp
KCZzeXNjLT5yZWdtYXBfbG9jayk7DQo+ID4gPiA+ICsgICAgIHJldHVybiByZWdtYXBfc2V0X2Jp
dHMoc3lzYy0+cmVnbWFwLCBzeXNjLT5vZmZzZXQsDQo+ID4gPiA+ICsgV0RURENSX1dEVFNUT1BD
VFJMKTsNCj4gPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+ID4gPiBJ
cyB0aGUgZXh0ZXJuYWwgc3lzYy0+cmVnbWFwX2xvY2sgc3RpbGwgbmVjZXNzYXJ5IGhlcmU/DQo+
ID4gPg0KPiA+ID4gV2hlbiB1c2luZyB0aGUgc3lzY29uIHJlZ21hcCByZXR1cm5lZCBieQ0KPiA+
ID4gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfcGhhbmRsZV9hcmdzKCksDQo+ID4gPiB0aGUgcmVn
bWFwIGhhcyBpbnRlcm5hbCBsb2NraW5nIGVuYWJsZWQgYnkgZGVmYXVsdC4gU2luY2UNCj4gPiA+
IHJlZ21hcF9zZXRfYml0cygpIGFscmVhZHkgcGVyZm9ybXMgYW4gYXRvbWljIHJlYWQtbW9kaWZ5
LXdyaXRlIHVzaW5nDQo+ID4gPiB0aGUgc3lzY29uJ3MgaW50ZXJuYWwgbG9jaywgdGhpcyBleHRl
cm5hbCB3cmFwcGVyIGxvY2sgYXBwZWFycyByZWR1bmRhbnQgZm9yIHRoZSBzeXNjb24gcGF0aC4N
Cj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ICBzdGF0aWMgaW5saW5lIGludCByenQyaF93ZHRfd2R0
ZGNyX2NvdW50X3N0YXJ0X25vbG9jayhzdHJ1Y3QNCj4gPiA+ID4gcnp2Mmhfd2R0X3ByaXYgKnBy
aXYpICB7DQo+ID4gPiA+IC0gICAgIHJldHVybiByZWdtYXBfY2xlYXJfYml0cyhwcml2LT53ZHRk
Y3JfcmVnbWFwLCBXRFREQ1IsIFdEVERDUl9XRFRTVE9QQ1RSTCk7DQo+ID4gPiA+ICsgICAgIHN0
cnVjdCByenYyaF9zeXNjX3dkdGRjciAqc3lzYyA9ICZwcml2LT5zeXNjOw0KPiA+ID4gPiArDQo+
ID4gPiA+ICsgICAgIHJldHVybiByZWdtYXBfY2xlYXJfYml0cyhzeXNjLT5yZWdtYXAsIHN5c2Mt
Pm9mZnNldCwNCj4gPiA+ID4gKyBXRFREQ1JfV0RUU1RPUENUUkwpOw0KPiA+ID4gPiAgfQ0KPiA+
ID4NCj4gPiA+IFtTZXZlcml0eTogSGlnaF0NCj4gPiA+IENvdWxkIHRoaXMgbGVhZCB0byBhIGRl
YWRsb2NrIGR1cmluZyBhIHN5c3RlbSBwYW5pYyBvciByZXN0YXJ0Pw0KPiA+ID4NCj4gPiA+IFRo
aXMgZnVuY3Rpb24gaXMgY2FsbGVkIGJ5IHRoZSByenYyaF93ZHRfcmVzdGFydCgpIGhhbmRsZXIs
IHdoaWNoDQo+ID4gPiBleGVjdXRlcyBpbiBhdG9taWMgb3IgcGFuaWMgY29udGV4dCBhbmQgbXVz
dCByZW1haW4gc3RyaWN0bHkgbG9ja2xlc3MgdG8gcHJldmVudCBkZWFkbG9ja3MuDQo+ID4gPg0K
PiA+ID4gV2hpbGUgYnlwYXNzaW5nIHRoZSBkcml2ZXIncyBsb2NhbCBzeXNjLT5yZWdtYXBfbG9j
ayB3YXMgc2FmZSBpbiB0aGUNCj4gPiA+IGxlZ2FjeSBNTUlPIGZhbGxiYWNrIGNhc2UgKHdoZXJl
IHJ6djJoX3dkdGRjcl9yZWdtYXBfY29uZmlnIGRpc2FibGVzDQo+ID4gPiBsb2NraW5nKSwgdGhl
IHN5c2NvbiByZWdtYXAgaGFzIGludGVybmFsIGxvY2tpbmcgZW5hYmxlZC4NCj4gPiA+DQo+ID4g
PiBDYWxsaW5nIHJlZ21hcF9jbGVhcl9iaXRzKCkgdW5jb25kaXRpb25hbGx5IGF0dGVtcHRzIHRv
IGFjcXVpcmUgdGhlDQo+ID4gPiBzeXNjb24gcmVnbWFwJ3MgaW50ZXJuYWwgc3BpbmxvY2suIElm
IHRoZSBzeXN0ZW0gcGFuaWNzIHdoaWxlDQo+ID4gPiBhbm90aGVyIENQVSBpcyBhY2Nlc3Npbmcg
dGhlIHNoYXJlZCBzeXNjb24gYmxvY2ssIHRoZSByZXN0YXJ0DQo+ID4gPiBoYW5kbGVyIGNvdWxk
IGhhbmcgdHJ5aW5nIHRvIGFjcXVpcmUgdGhpcyBsb2NrLCBkZWZlYXRpbmcgdGhlIHB1cnBvc2Ug
b2YgdGhlIHdhdGNoZG9nIHJlc3RhcnQNCj4gcmVjb3ZlcnkuDQo+ID4gPg0KPiA+IEFncmVlZCwg
dGhlIHN5c2NvbiByZWdtYXAgbG9jayBjYW5ub3QgYmUgYnlwYXNzZWQgZnJvbSB0aGUgd2F0Y2hk
b2cNCj4gPiBkcml2ZXIsIHNvIHRoZSBfbm9sb2NrIHZhcmlhbnQgZG9lcyBub3QgYWNoaWV2ZSBh
bnl0aGluZyBmb3IgdGhlDQo+ID4gc3lzY29uIGNhc2UuDQo+ID4NCj4gPiBSYXRoZXIgdGhhbiB3
b3JraW5nIGFyb3VuZCB0aGlzLCBJIHRoaW5rIHRoZSByaWdodCBmaXggaXMgdG8gbm90DQo+ID4g
cmVnaXN0ZXIgYSB3YXRjaGRvZyByZXN0YXJ0IGhhbmRsZXIgb24gUlovVDJIIGF0IGFsbC4gT24g
UlovVDJILA0KPiA+IHN5c3RlbSByZXNldCBpcyBpbXBsZW1lbnRlZCBieSBURi1BIHRocm91Z2gg
UFNDSSBTWVNURU1fUkVTRVQsIHdoaWNoDQo+ID4gdHJpZ2dlcnMgYSBzb2Z0d2FyZSBzeXN0ZW0g
cmVzZXQgdmlhIHRoZSBTV1JTWVMgcmVnaXN0ZXIuIFRoZSBQU0NJDQo+ID4gZHJpdmVyIHJlZ2lz
dGVycyBpdHMgcmVzdGFydCBoYW5kbGVyIGF0IHByaW9yaXR5IDEyOSwgd2hpbGUgdGhlDQo+ID4g
d2F0Y2hkb2cgcmVzdGFydCBoYW5kbGVyIGlzIHJlZ2lzdGVyZWQgYXQgdGhlIGRlZmF1bHQgcHJp
b3JpdHkgb2YgMCwNCj4gPiBzbyBQU0NJIGFscmVhZHkgcmVzZXRzIHRoZSBzeXN0ZW0gZmlyc3Qg
YW5kIHRoZSB3YXRjaGRvZyByZXN0YXJ0DQo+ID4gaGFuZGxlciBpcyBuZXZlciByZWFjaGVkIG9u
IHRoaXMgU29DLg0KPiA+DQo+ID4gV2l0aCB0aGUgcmVzdGFydCBoYW5kbGVyIGdvbmUgb24gUlov
VDJILCBXRFREQ1IgaXMgb25seSBhY2Nlc3NlZA0KPiA+IGR1cmluZyBwcm9iZSBhbmQgZnJvbSB0
aGUgc3RhcnQvc3RvcCBjYWxsYmFja3MuDQo+ID4NCj4gPiBJcyB0aGlzIGFwcHJvYWNoIE9LPw0K
PiA+DQo+IE1ha2VzIHNlbnNlIHRvIG1lLg0KDQpKdXN0IGEgcXVlc3Rpb24sDQpGb3IgYXV0b21h
dGljIHNvZnR3YXJlIHVwZ3JhZGUsIGlmIHRoZSByZWJvb3QgdXNpbmcgUFNDSSBmYWlscywgd2hh
dCBpcyB0aGUgZmFsbGJhY2sNCmZvciByZWJvb3QsIHJlc2V0IHRoZSBib2FyZD8NCg0KQ2hlZXJz
LA0KQmlqdQ0KDQo=
