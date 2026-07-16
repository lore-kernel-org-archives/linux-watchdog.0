Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022079.outbound.protection.outlook.com [40.107.75.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7673CB577;
	Thu, 16 Jul 2026 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784189416; cv=fail; b=F4cASeARtvZkzDXPB4gB1JB8zpSpX+g3KUtaNp5NqiIehTfRlRjDCzhyO17X4R2t45qvgwo/uiUY98sbvCJaVTvTjmVymeVsQBNNzCk6WlhIWo+eI+K98120NAXGEmS93Y96udx0NUuxIcDyKuzQc53EMLAliUr3J5prP3JZM/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784189416; c=relaxed/simple;
	bh=8ryW3edDUWvoUr90NEO/Bo8eBOkCt3ee4FAqHcBXJ6o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HaFTKE5gAdFfF5OsIwNblM62LAUYjsMI7RPMdYFdxsH2g2D9R0EeEAQpdVFpR1aQASp99ox8E2qdKUDEyXw4JEEUS4D9ZfAH+oJaUKK3+xPo5ZqZy9yUuKPYyYpl0RnaOHqu7wZtvP/EbPIOvMKBPs7Gt1svANn5/cBg412jsBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=advantech.de; spf=pass smtp.mailfrom=advantech.de; dkim=pass (2048-bit key) header.d=advantech.de header.i=@advantech.de header.b=BIHt5hp2; arc=fail smtp.client-ip=40.107.75.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=advantech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=advantech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=advantech.de header.i=@advantech.de header.b="BIHt5hp2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkMxy0SFCt2rQD51Dg7fqu31BYK+EY8EeS2tIDwrI+LPt2FVqgWxNOAL/qN/ziZKxtCjCnmxBTRsBfuf3esNAJO2lxVxQSUqFsLob0AdfkITk4jDa8LRZv88CiQaNkbvdQsdiwiesaSaGKhvx/UktRIJxADSu/YGQSjFyGN9lTYk0g8hEgKlr6Sacn13+5U24ifyd4f5TcskXaqwsqrV+azjRPOnEB4c4jNy+0/qcdgsMq5N+us+AgWYT2aRD/VHrSSlfKbBy0jefsv+tmMcqTVKY+it6s50BavheLcNVL5s71KdholTJjqC+kRw0jaiVICRklspkVLBr7mNeEmrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ryW3edDUWvoUr90NEO/Bo8eBOkCt3ee4FAqHcBXJ6o=;
 b=WxGNRQwv+WMryxTJCWeOr3IHT2NV0a4OlegH0YPyNjvyDdOn8uwwW7IGEscNNKJg3iKaNMwjoaMRqbB88aDyp7eEC4CtsuRqr2C2tO/vQqNNS2Z/Vqq8m9GTXYihbWqkX7xTDsG1BK5Qd5xnzprufCQe5pSdhOqMRnMGKM8mNYkxzjzfkHcjtOia7edRWjGmAF7x7eh21uCj9ckMvfgqzTV7Gyipj9SuHgyab/f91Q/PeNsIXZ5FibK2UzuM709oLQj20M9XVrp9HVaq8YTrJK7ZFRrStkKmWHMtU2R+UXD6w3NGR9hYszoScfe3kpa+5Z9w46dRIytwdn2TbK6xmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=advantech.de; dmarc=pass action=none header.from=advantech.de;
 dkim=pass header.d=advantech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=advantech.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ryW3edDUWvoUr90NEO/Bo8eBOkCt3ee4FAqHcBXJ6o=;
 b=BIHt5hp22YLwWipueY+Gp2CTOjAoSGGykKqN8ZKwixskfbxSdOFOkZVteEbI21fWg8uMzPr/icJhTn3ZtJnKqjFzmWu4kgm5mh2Zo2wtmd9xAy9YTJD+PkLuYbhqwq/8CxqW8O5di7BNF4WeFnOcd6gaAR5QzSpo3ZTl2XauV53NzjouUm+HKoJf6nSVKivmF/c0Ui8n5cja/y2kJrSSwXQtBWuk+HoeIbQBmgjvH+/XqGVGdc62btsQLisCzLcyF4Bf8sQ3nTbo29HuSgcR08T8WavBDxR3YY9kndesFuheCcrkInVxgEOKW+XOJ6Pld2yJPWlWmy+FQHWeZ+0KQw==
Received: from PSAPR02MB4502.apcprd02.prod.outlook.com (2603:1096:301:21::6)
 by KUZPR02MB8851.apcprd02.prod.outlook.com (2603:1096:d10:4b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 08:10:08 +0000
Received: from PSAPR02MB4502.apcprd02.prod.outlook.com
 ([fe80::44e6:6433:8000:35aa]) by PSAPR02MB4502.apcprd02.prod.outlook.com
 ([fe80::44e6:6433:8000:35aa%3]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 08:10:08 +0000
From: Ramiro Manuel Silva Oliveira <Ramiro.Oliveira@advantech.de>
To: Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>, Linus
 Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Andi
 Shyti <andi.shyti@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, Wim Van Sebroeck
	<wim@linux-watchdog.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz
 Luba <lukasz.luba@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mfd@lists.linux.dev" <mfd@lists.linux.dev>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org"
	<linux-fbdev@vger.kernel.org>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Wenkai.Chung <Wenkai.Chung@advantech.com.tw>,
	Francisco Aragon-Trivino <Francisco.Aragon@advantech.de>, Hongzhi Wang
	<hongzhi.wang@advantech.de>, Mikhail Tsukerman
	<Mikhail.Tsukerman@advantech.de>, Thomas.Kastner
	<Thomas.Kastner@advantech.eu>
Subject: RE: [PATCH v2 3/8] Add Advantech EIO Hardware Monitor driver
Thread-Topic: [PATCH v2 3/8] Add Advantech EIO Hardware Monitor driver
Thread-Index: AQHdE6khkMz7/hggY0W6Zx06CTHzCrZvTOCAgAB3y4A=
Date: Thu, 16 Jul 2026 08:10:08 +0000
Message-ID:
 <PSAPR02MB4502BBD659D7C4FCDDCABB6294C72@PSAPR02MB4502.apcprd02.prod.outlook.com>
References: <20260714-upstream-v2-v2-0-76e5e41026db@advantech.com>
 <20260714-upstream-v2-v2-3-76e5e41026db@advantech.com>
 <b7171173-aa64-4393-b9cf-77d92f2ec932@roeck-us.net>
In-Reply-To: <b7171173-aa64-4393-b9cf-77d92f2ec932@roeck-us.net>
Accept-Language: en-DE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=advantech.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR02MB4502:EE_|KUZPR02MB8851:EE_
x-ms-office365-filtering-correlation-id: 77824c9d-6ed8-479c-8c2e-08dee311a6d1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|921020|10067099003|38070700021|22082099003|18002099003|55112099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 78KstKS+ZLlaMOMLF3s1fZwICc3Db5HRARxflmnPpYKYRsWk7apqkt/uWeQ4jhJbqYuvKtfIYxLBoOc7CeJQ9tSYkRgU8E/ldx/rKUDg2/GTBRH/Jp4Sv0g2njXmNrG6vmny6+rq58ibK+/RywWgwIcV0Acs4dDeN5C8P9VMQ3zaf48+JxSGAgg4DSFwaq7uLg5gIAQzeh96Jtzxcyi+puJu1RujA7FWvZPDalAyxd0LlS6BHUF7NeQUuCRO3h9phGrcptpl1bgh+mnn4nHfl4RDI4UdcG0E7VKcv2niymrD6nmtifC+HikyZ92eFXjo5EgsDCluvc+682gVtyTTKsLoqj6TRSOcSdjC2slhNzjw4tOd6W75IvfF/9AvtxNdgopS6BS/dwR1xqfA0Xxh3x5iA0BpEmAQl4Y1MEEhS+YcwntiXu+wOWRH1g4OLgXNpXN6b/fgLiz6RDec0UBPOe4yCPc5c/8iSlIERDlIMSoolNfHnffXC68sgMPWbBZPgRXGeL6B2g9+Zqrys2PQ2V59+hpVp/iNBzfW/aT/9a3Z4q6km6TiUxrFafMUC2LDRWrZP+barYeu4Njzbg5ANjV0bYOrUDAWK23OZNsV1TPxn4omE6cTnVSALjGTMa6plLJGPiLYEWQJEneS9lXcPq1swu9ygrtuLPqxIgZhcuLM5IxObn3D+hQEkcxBUwCDlmSK7J+8HqM6J7kT3anAkEvGVpO/rBqOwpyjnrqCC3x8LCCaq7/3+7Au/eHL2JS+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR02MB4502.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(921020)(10067099003)(38070700021)(22082099003)(18002099003)(55112099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkxaUmFScHJTaXNSUDZHVWo2NlVERnVIRGpLeDNRUi8zK3JlOWFiczQzWHEz?=
 =?utf-8?B?NS96UVhFRWNNVXlZRSs1M3BycDFPb1AxZmJWSTVQRFBpUUF4NmlMS2VaRnJL?=
 =?utf-8?B?eTZxU09LWHowRnF4b0FlYlFQd09kYjMyRE5EeXoybDAxMHRaSGNjSGN0Y3B2?=
 =?utf-8?B?MTZyc2h4WUZrS2RpdGdvd3VVWDZtTEM0R1htYU1HMnA1Sm1PeCtxKy9XRDZ3?=
 =?utf-8?B?M0Qwdjd3ZVFMWmp6ZHJ1U1F3UjVHa2JPRXpDSGltenB2SkJuSkxjenk1MEov?=
 =?utf-8?B?N1lGSUdka005dFJkcDRybTBFMExNYkRnSUc4aENDdVMwNnZZb3ZQZU1PZnpC?=
 =?utf-8?B?dUNVc3lFNm04RWdCM0FyQjh0czhRa0xzRUNrSlVOZ0ZKUWQzT0c5VUVyR0FQ?=
 =?utf-8?B?WTNlaWxsZDRXczRKbW9pMzJCYStLZU1Lc2FVMGhzMllWdm1aWk9DL2IwM0xY?=
 =?utf-8?B?QXhMQXlScEp5Rkc4emRwUmJoaWVJQjVQTHNkTm1ZWXJwREtmaTl4dlJ6ZXpn?=
 =?utf-8?B?K09TcTdTQ29JSVFTRXFTUGIrbUE0cCtqOEdzanM0c0hPUDhxQXRXeTZQYmJS?=
 =?utf-8?B?TUdsR1V4V0g3UEFsNm5JNVRVbWJldmN2OG5ob2NKc3N1U0w1dndUV2RMYVRH?=
 =?utf-8?B?VDZMNm41amtpUGdXWVkvMEMvQ0xrc2NwZHcrL0QvdjhyQ1RJa1dwajlyOU1z?=
 =?utf-8?B?ekIzQTRGMXgwL3pUWnZFcktBN0ZSaVoxanByMmdsV1hVT0hKUnpjU09PaGFK?=
 =?utf-8?B?YldvbjFRR2oxRjhSRTA5SDQ5NkJiY28zK09maVJQeDgvaFdEVGR3MXJRVUN5?=
 =?utf-8?B?My9wSUsyMmM4djJIMkRYVnhLSytYRnBOS1htdGtXdUY1RE5mLzZnaHpscUVC?=
 =?utf-8?B?bVpuVS9IbmtnWHBUMXJuSGpkZ29VVW5wMnpGdzVVdjJLQ01HN3N4QUJLSnQ1?=
 =?utf-8?B?N3NqTE5HNXF2NXhPelRXdWMzUlhoNWFlQWdWRnI0ZlF5dDVBdGNsamQ4R2F1?=
 =?utf-8?B?VzdUV3ExR0lHQldVZUlLMlJ6dGZxcGM5MWFjQkRvUVc2dVMwZTJZTzRTMjNP?=
 =?utf-8?B?VDM0a0g4L3dnem1lU1RTS0s5Mmp6VHlFWDlEN2FSNXF3aU5zQXNDZzZmcmhI?=
 =?utf-8?B?Smlqckp4MkI5Y1ozT3ZIb3lMd1c1ZHJ6TmgvU1c3bFFsNlYyQTFhZGRyUEZB?=
 =?utf-8?B?YStVN1UxMXJFSkxqQ2R6cEdSaVV6SEdDMEt1ZEZTaXNLZEJGM3lablRZa0ZN?=
 =?utf-8?B?VHJSdURxeWp2SjI0aXh3OVpmYkpxbTVDQVhMK2EzU2hScFFSZ2pZSWF1Skp5?=
 =?utf-8?B?cXV4TjdOZ2NUMHdlY2htdThYQUY3ZGFWR2t2RGNWcHhsQlV3b0tZTkJCc1hS?=
 =?utf-8?B?aXF1R041elVmbEJibjdNWmgyK21meTJzTzdiL2hsZUJ4VEE2OXNobnFmZC9Q?=
 =?utf-8?B?YTlEejZDNUc1cjRJcTVLU2NUL3RTWUFseFhPblhJRDBVWWwvWFZUZlQwWGla?=
 =?utf-8?B?WnJYM2VucGl3Si9rMHF0WHNmeGo0SUFBeDRkbjFZaWd2Q2pyK05TZE14Tzdp?=
 =?utf-8?B?NDRGbFFDZmFUS3hiMmYycFlGRkFoRFp2TmhmQTBCK2V1eU1yWm9hQjFRLzJH?=
 =?utf-8?B?L3QyTURSaXYxUlJUQndLV0lBZU1ZMjY0T0xDR2JyckJVQkw2ZnRqczVIUVIv?=
 =?utf-8?B?RVFZT3FQdEc0YnVLbWc0dUwrRWxJbXpiblQzTGtyZG9GQjQ4MjZxZXhWN1Ja?=
 =?utf-8?B?ZTJsOTNyS24vNUl1eVdvRm4xNDFqQ051RjlzSFJyTkNVZ2xueGI0M1llNjQ1?=
 =?utf-8?B?Y2prbmtHS3JDc1IveDA0Z1dOSEk2YTRhdytYK1VqMEN3Z0dqOEFreTc2WjFV?=
 =?utf-8?B?eUcwSDczbkpQM0s3TEpKMGExY3NXdVBLZlZaV0ZIcStFWTkramIzdFk3MVFO?=
 =?utf-8?B?d3FqMUlKZllkWjVUMlRYcVd0YWNJbGd5T1VZNkIxcTdKdmRwSkp2YUZBYmJC?=
 =?utf-8?B?K3FiZE94YmVHUDFydDFHaXcyYnQ2UXVkZDQwQ0NTN3BqQjkvY3hITFJVODkx?=
 =?utf-8?B?U2hIRCtuRGEvV0Y5cTU1WWNFUUhqQVpxcEl1UEhNQzd3V2xsQmp3L09CZU9P?=
 =?utf-8?B?cGR3K1FqbTluV1o2cW1oYWg2ZGZuVVVxb1R5eVBVK3NjZk1BNzBwOTd6MkJJ?=
 =?utf-8?B?K3VUdUpHb2x3RUoxNUkxUWVyL0hMNXMzTldLa29xSTFuWXFlOThBSjU2V2kz?=
 =?utf-8?B?MUpRS0dMVUNSMUhBSFhIZVdHTkVPaUtDTmtpckhYREZUcEdvR1BiaFdDbW5Q?=
 =?utf-8?B?UDRWLyt1MzZFditYUW45U25iM3FNQ3gySXU1R1Q5eU14K0o5LzVsUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: advantech.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4502.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77824c9d-6ed8-479c-8c2e-08dee311a6d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 08:10:08.5292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a77d40d9-dcba-4dda-b571-5f18e6da853f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TW+O6j8VTcitXVv/o/0TE94cbZwA3edD42MDyYW0D9LkTq1VGU6oyqjSjSOvGmRUg1wMQtYZ1KLsXa6dziyf/cIGbaWQYcDZPIl8B3/LvhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR02MB8851

PiBPbiA3LzE0LzI2IDA4OjU0LCBSYW1pcm8gT2xpdmVpcmEgd3JvdGU6DQo+ID4gVGhpcyBkcml2
ZXIgY29udHJvbHMgdGhlIEhhcmR3YXJlIE1vbml0b3IgYmxvY2sgb2YgdGhlIEFkdmFudGVjaCBF
SU8gY2hpcC4NCj4gPg0KPiA+IFRoZXJlIGlzIGEgc2VwYXJhdGUgZHJpdmVyIGZvciB0aGUgdGhl
cm1hbCBkZXZpY2UgZHJpdmVyIHNpbmNlIGl0J3MgYQ0KPiA+IHVzZSBjYXNlIHdlIHN1cHBvcnQg
Y3VycmVudGx5LCBidXQgaWYgaXQncyByZWFsbHkgbmVjZXNzYXJ5IHdlIGNhbg0KPiA+IG1vdmUg
aXQgdG8gdGhlIHNhbWUgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmFtaXJvIE9s
aXZlaXJhIDxyYW1pcm8ub2xpdmVpcmFAYWR2YW50ZWNoLmNvbT4NCj4gDQo+IE5vcm1hbGx5IHRo
ZXJlIHdvdWxkIGJlIGEgaHdtb24gZHJpdmVyIGluc3RhbnRpYXRpbmcgdGhlIHRoZXJtYWwgem9u
ZShzKQ0KPiB1c2luZyBIV01PTl9DX1JFR0lTVEVSX1RaLiBJZiB0aGUgZHJpdmVyIGFjdGl2ZWx5
IGNvbnRyb2xzIHRoZXJtYWwgem9uZXMNCj4gc2luY2UgaXQgYWxzbyBoYW5kbGVzIGZhbnMsIHRo
YXQgd291bGQgYmUgaW5zdGFudGlhdGVkIGZyb20gdGhlIGh3bW9uIGRyaXZlci4NCj4gDQo+IFNp
bmNlIHlvdSBoYXZlIGJvdGggdGhlcm1hbCB0ZW1wZXJhdHVyZSBhbmQgdGhlcm1hbCBmYW4gZHJp
dmVycywgSSBhbSB2ZXJ5DQo+IGNvbmNlcm5lZCB0aGF0IHRoZXJlIGlzIGZ1bmN0aW9uYWxpdHkg
b3ZlcmxhcCBhbmRvciBldmVuIGNvbmZsaWN0cy4gWW91IHNob3VsZA0KPiBkcm9wIHRoaXMgZHJp
dmVyIGFuZCBjb25maWd1cmUgdGhlIHRoZXJtYWwgdGVtcGVyYXR1cmUgZHJpdmVyIHRvIGluc3Rh
bnRpYXRlIGENCj4gaHdtb24gZGV2aWNlIGZyb20gaXQgaWYgc28gZGVzaXJlZC4NCg0KQnV0IHRo
aXMgaHdtb24gZHJpdmVyIGRvZXNuJ3QgY29udHJvbCBhbnkgc2V0dGluZywgaXQganVzdCBkaXNw
bGF5cyB2YWx1ZXMuIEZhbg0KYW5kIFRoZXJtYWwgWm9uZSBjb250cm9sIGlzIGhhbmRsZWQgaW4g
dGhlIHRoZXJtYWwgZmFuIGFuZCB0aGVybWFsIA0KdGVtcGVyYXR1cmUgZHJpdmVycy4NCg0KQWxz
byB0aGlzIGh3bW9uIHNob3dzIHZhbHVlcyBub3QgcmVsYXRlZCB0byB0ZW1wZXJhdHVyZSwgbGlr
ZSB2b2x0YWdlLA0KY3VycmVudCBhbmQgaW50cnVzaW9uLg0KDQpXb3VsZCBpdCBiZSBvayBpZiBJ
IGtlcHQgdGhlIEhXIE1vbml0b3Igc2luY2UgaXQgb25seSBkaXNwbGF5cyB2YWx1ZXMsIGFuZCBp
Zg0Kbm90IGNhbiBJIGtlZXAgaXQgdG8gc2hvdyB0aGUgb3RoZXIgbm9uLXRlbXBlcmF0dXJlIHZh
bHVlcz8NCg0KPiANCj4gVGhhbmtzLA0KPiBHdWVudGVyDQoNCg==
