Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011065.outbound.protection.outlook.com [40.93.194.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B0408000;
	Wed, 27 May 2026 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887097; cv=fail; b=e+uxXcxoRGQNi2ZvtFA/8ilbYlyblHtOwqJYYSN4uK1QKGiExlWtp9B0bu1d8nKL/HztSpZNti4VP7Klxc6kPxOUMqVdXddRGEIjUmDOcD++4RDqsNYy2k6xCGnNkqAYTvdBZ24Ws0zOdPYTRMY3Y7DrzKyzYSEwvOjqJkWxVpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887097; c=relaxed/simple;
	bh=oXGs9OhHmO2H5hcUflkjht9pknJny/TqBznFEg8L0+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lz6uZtzmEit1VOgieXiw4LnPzb3Ni62uGFdHIARMtI89r6HjLSOCJA3FeizkLWgjfJq0aC18BPUFWuREg+LP/LNOLUui+GaPnzbvzQqgZlJafjhHrwX0KJ23UHdMZubvuBhhb8BLlgkILEe6l+piFtqQrWo1CKe9DxKV6Fi+ggE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=6L78Jrlm; arc=fail smtp.client-ip=40.93.194.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="6L78Jrlm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkglV+WGYm42SeVRVlHClpn9GzM6hbZjbv5fp6aAwVDpuOdHMyq1pdAzlsOHnZvz8seHJFFwYtHALwRbNdbxGss0udZB0deoCr0HmzGH6BGPiOrCUOtoTDjUdLn2dsXFRqJAL0kcbbRIqAwKRNVcShEm+qJA0GO1yIi7kd+cEtn2cn/5DUcKhKFC5t8bBPxgfs+oe7q/dkH0g4AXDinvxFUdd6etz2z8jOK/86XHIkUKYAUv56FmKyiJJkmv8h4OYFQGRPBJCFUcQ2LWpfw/09v8tmt6zr4BE8L82YZLoC+hq40iDKV8s0S/xxt85o6rT/Qbi5WHfCwGHWN81cV7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXGs9OhHmO2H5hcUflkjht9pknJny/TqBznFEg8L0+Q=;
 b=xxibCSoKqX8ME4jzt7mg73/4n51I0Ituz7dzDJ0n+Azwfpsx2OT+G7LrkDtWHdUDpc2NqB732rw3mH5C1uPxQjf94+W3wmt0PiAcO1BBLU/hm21uN0hZAv91zElYm0k57oNRsQB8Hu6K17mBOSxhoUYDc01ljiNLZcfPAM5sskrshbheV3fv8He1iDAejSSy9iM5AdmHQF9nEGHd5RNvYNeQXU8szl50uRTiMSvaEBes7OF87HIRmJvs/MHc5LFecBpEQTm+YXqzzw4Sffnr6L4LqAafE9p+s/TGSygE1FQBTVdfq3nVfcINOpj00EUGcQCR8twKr8lXEnaYrrcP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXGs9OhHmO2H5hcUflkjht9pknJny/TqBznFEg8L0+Q=;
 b=6L78Jrlm3Op3oxemO4zZoeCbqmf2znrWM8Mf9gz7cHeBc+GKiXrC63bYcdTlyBXx8DZhpoSnVeR8OeQusQ2QTH3s83KZBUk7wQSihLRFL+TqQ+8wK5UsI4wuQPVAcglyWFLuqUhPgSwurS0QI0C/8O3Ux9YafiLKXkBccOk/vpsJyY0uA8qZopIGYFLvC7WSwGGKQTam4jS0AnwdQaS83LOouZ2+9e7sbyryCnJbX6b6kCSxOjK5tiWnZTHNE/0GjZJSaKZqCivQOqaM2SBp0VtvCFC2vW4KQdweFhkZuF0pQ4/EWnSIfdvZ/kIBXkqlJqS4gUAcb+3oFboLgWpr6g==
Received: from SA2PR11MB4905.namprd11.prod.outlook.com (2603:10b6:806:117::7)
 by DS4PPF6CF7B12C6.namprd11.prod.outlook.com (2603:10b6:f:fc02::2c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 13:04:52 +0000
Received: from SA2PR11MB4905.namprd11.prod.outlook.com
 ([fe80::5062:2:b851:5337]) by SA2PR11MB4905.namprd11.prod.outlook.com
 ([fe80::5062:2:b851:5337%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 13:04:52 +0000
From: <Balakrishnan.S@microchip.com>
To: <linux-watchdog@vger.kernel.org>
CC: <wim@linux-watchdog.org>, <linux@roeck-us.net>,
	<alexandre.belloni@bootlin.com>, <andrei.simion@microchip.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/2] watchdog: sama5d4_wdt: Fix WDDIS handling for
 SAM9X60 and SAMA7G5
Thread-Topic: [PATCH v2 0/2] watchdog: sama5d4_wdt: Fix WDDIS handling for
 SAM9X60 and SAMA7G5
Thread-Index: AQHcqjhX6UKbz9317kO7ow3/dTG40rYiXl2A
Date: Wed, 27 May 2026 13:04:52 +0000
Message-ID: <322c623a-0da8-4821-b0d9-ba2c96bf62ca@microchip.com>
References: <20260302113310.133989-1-balakrishnan.s@microchip.com>
In-Reply-To: <20260302113310.133989-1-balakrishnan.s@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4905:EE_|DS4PPF6CF7B12C6:EE_
x-ms-office365-filtering-correlation-id: f3b18984-6bd7-430f-981d-08debbf08a81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 ku7vWtlEnGP+rt0Pd4aUgY9oQoH9XAVHP8WVVYqJ3dKHE7JuKP2Z6Te6wAlPnxnFk+KfTyrqCLjcAw8h8m1ZhqHhl1bFIkhIV5+cSTlZrrNWdUCriGww0FlEFNSvwhDLkQH3vNoo43Dr2y/fZqV1zdSOsWkjoLJkBJAZ3lUiZazdmyfNFk52/cPkkmsRfc7GmaAu8RdRXF/RbR5NAk3cBFGMP0PbArSKeXOfzxDKYCVS39r3kksNayJlED7sNervIE+cg8Bw3AZdmAImJ80KKEADeJDQgIc1jER3dtrxJe4iaSnY9yLNwjjswzsZVFavjqZCjEzu2ERuBhpc9oEIUmtov6N9ELfl9V6MfjN2Zbs2mJa/q0r5G+C5BILA3/kptsz7U7KaR106Ay7RjciLEl8tPDj3pMBrdJt/9yVxQB/njseVjjAIcwsJIUvLhkcnQOKK1L/ZjyvUPgGzN+yUXGIxSjpNeIccjHBCuKd9sUajexuhgI5eUAxdMdcrwHrBTKDG6kQPOpid1FQrZ+gtIkCT74VDhPMBVRH6YkJnK4+GTE9I+a64gxuMWD3w41fvhOJeb2nqNgSTx8mvM3dKJpy47xUFPTtv1tBgy5sGlolKIZT6u1YtTErnm5gPmTd9s+3hwi3tIBzVHFRecD9dqPpZGZBAj1nQfm/+w5Z67Qgyeh3nA5UajZSzEAPjSKOF947bfhaYThINECGQQ0kBD5oJWhfyZcpx0AwPO7hjWX8WMjTe3qlmHJ3rSco/FnDA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4905.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THUrTHAxOCtacG5CVjVCWFRZaEFMT3l1emZDaVhoZTl5RWJBZVlDck85aXBo?=
 =?utf-8?B?cThOeWtXSWp6MEhPZlhseXZidUp6RDVYZXNvbXpDVlgyNC8xQTkyUnVaQkYw?=
 =?utf-8?B?ejYva1RFTFZLcDNqYkU1Q2FBN0NqVk1lbS81UDVTdWhhS2d3RkM4b1RENkRE?=
 =?utf-8?B?UU5mK281N1UwVEdlS0NBUllkc0Rndm9UNmQya2lkV1AwS3NwamlpNjdYS2xN?=
 =?utf-8?B?b1ZKaXNIRVNYczRleUc1bGllTk1GSDZuZ0I5cnhGWjJvdm1yRWhrZFJpSWtL?=
 =?utf-8?B?NjBibHAvQk10OWNETlRYckxCUW5ZY1JnSXNuYnZyUEQrTzhmeEJtMkRLc05y?=
 =?utf-8?B?OTRzY29aUWZUaytDUFJ1ekgwbnlIQ1JsYWQ0d2R4R1RlZ0h6RWs1V201bmZy?=
 =?utf-8?B?ODc4VnllTGRlbkF1b0MrNXVCanZ2ajdrRzNaMk1TalBzbmo5Skd5cGZjNjZp?=
 =?utf-8?B?Q3pPbys0VVp4cWJGMjJjRG1leFhrQzBTYm1wMXZHZXVuY1l1NEVNWjlZUG1B?=
 =?utf-8?B?OGVWOHJaM2ovbWx4b0ljTzNHTzRJSWhsNG9uNERsNDcxelgwOC84V2p3dDdv?=
 =?utf-8?B?aGJCZnUxRGxkZDZwam9tcFNEdlBZY2RCUVRUS0x5WmRvZTk0QkFVMXRSSWsw?=
 =?utf-8?B?Z2ZBV3JqcmdNVTNGSGY2Y1dNaVlha280TmYwVEdmM3lMcnVJOFNJWDhRNnVL?=
 =?utf-8?B?a0RsK3g2aVdEN3I0M3FLUDRvaDZhdjlqYW93TVA4NENFdlpqN2lUYVh1SEgz?=
 =?utf-8?B?NWJsd1pnQjF2Z0pmd1R2b2gyQkdvamJjVGMwYTd1TzV0Zy92NjFuVDUydmlH?=
 =?utf-8?B?T1k2d3hCZGE4ZGFFbTFrNVpzN2xkUDNVN3VTVGFPKzM0bFE2MlM3VXlwMTQ5?=
 =?utf-8?B?VmpmYU5aWllzMndDOW9KMGhkN3V4RitrYlZHYVI2dk4rMVIzQjVIWm8rQXRx?=
 =?utf-8?B?ZHlBYmk3VnY1WFUwREJpUFR2WmNORXExNHhEbncxV0dPY3dyM1JEWXI3UHRu?=
 =?utf-8?B?SGt4TWFCbmtlRG0wVGU2U1lWdmtrdU9CRnR5MkMvS3pnR0sxWmZGMXJUNUFm?=
 =?utf-8?B?VmhaSlhYZE9FMmVMM0UvZERwQk0wcUd0YnFlTEpWVkt1Y25WemtuNkY1dmFH?=
 =?utf-8?B?cVpTVmRSOEhyYmkzaS9aWW9vZWNORmpacE9wSldBT1FUYkRqcTBRanpWZWIx?=
 =?utf-8?B?Q05nblVrMXBoT2ZoKzFydEdtYkhJT3FhVVp6SGc1V0ZmQ0xjZGkyY0FuN3BN?=
 =?utf-8?B?MEhKQXdrTTI4NG1lcnNDTXFwRlh5MndaL09OZ3lTYkhRQk1hMWpEQlFwMTFi?=
 =?utf-8?B?Z0RLQUwzSldUYVc1RUVoMUpmQXJkbE10a29pZWVHK0dFbVhtbXZZT1R0aWM0?=
 =?utf-8?B?Rmt6WnFnL04zakQ5UXNDcTJxUDVKVlc5VlZVSVBPVTJzSkUxb3RSZE1qRnJz?=
 =?utf-8?B?QTFNY2QxcHhvNnc2dHpwN3JxTVdqNGJUMkdpQmdpSG5ITjdnakhSTlFQUUd2?=
 =?utf-8?B?MG9Ld3NSNGd2aVgyM0JQUHE3ekxCc3pPWU15ZGlMOXIva0d3c2xsMXdKVFVm?=
 =?utf-8?B?b29JRW9SR0pqUFlGL0JsbkdjZmZlcHcvUmVBMWNQY3pJTHZnZ2x5UXBVUjh2?=
 =?utf-8?B?bTR1bGI5SC9uTmZKK3o0NjlLbHV5aHBpVVlFSnk2cndva3hBdm0vZ2taVWhF?=
 =?utf-8?B?NC9lamhSQVI3RnBhUXFqazRvOUdaQy9KUVZBZEZ4TVh1Y1BpMUhYTzRvTmtJ?=
 =?utf-8?B?VnRpR0ZiVytLRTNOSEVjNU45TVhDVEVwMHI0V2hMQjdxY2FxOU5kWExBK1FP?=
 =?utf-8?B?Qzg1NUkvZWY2UVB4bjRIMjlIRCswaFhtZ0UzMzJDT0lIc1d0VTJsL3ZZNlhr?=
 =?utf-8?B?OU9KTVB2MW05UmxNVVcvNy9jVXhycDRkaXZpR1l1UW5WTjMxNkFoenpBdmd5?=
 =?utf-8?B?bWRBQytsTGRWcFVvQTBqcG1qdHdDc0VsQlVaellXQXZxUU9aYU9ONkc3ODdB?=
 =?utf-8?B?R1lWL2RUd3RmdGw1K0Ezc1lOSjFQVEkwUmJ5MjdQUnNoNTBYNEpFWE9nZ3RT?=
 =?utf-8?B?MDk0cFNOdHVhVm9ib2c2bzREaDlPbzBTN2xTbEU1OVR0VndLci9iL3V6dUJ2?=
 =?utf-8?B?RHorNW0yK28xSm5VRStXT3JibFh6Rzg2alNPS1JkYU4vWjhGLzl4SEVHaEs4?=
 =?utf-8?B?TmdwdFhkbnRMS0NzcmRZZHNaUFdWcUpCMi9qSlJGMHp2Y0NVUTNCNGN4TVVO?=
 =?utf-8?B?QlJWZkNqOCttMjhnWjRJY29SSTMwQzMyQ1NnRUpqRjNWUC9mTzVhR2NNTnBW?=
 =?utf-8?B?VEtJdkhCOENmSFNGc29DTDc4WHBVWTY2cExJWVVqTlBLVzRmMG0vZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <434A083F3757C742B0C86741106933DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4905.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b18984-6bd7-430f-981d-08debbf08a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 13:04:52.3060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1BwTGeuAXjwHNVyu9OMvAnWnQweGqSX7wXshyYKucenNV9OhOlu06qKGRbDx90jq03wdiPcaKoU3REHF7wa6BcbqnkCvg8nJmOEpFxDRtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6CF7B12C6

SGkgV2ltLA0KDQpHZW50bGUgcGluZyDigJQgYm90aCBwYXRjaGVzIGhhdmUgYmVlbiByZXZpZXdl
ZC4gQ291bGQgdGhpcyBiZSBxdWV1ZWQgZm9yIA0KdGhlIG5leHQgY3ljbGU/DQoNClRoYW5rcywN
CkJhbGFrcmlzaG5hbg0KDQpPbiAwMi8wMy8yNiA1OjAzIHBtLCBCYWxha3Jpc2huYW4gU2FtYmF0
aCB3cm90ZToNCj4gVGhlIHNhbWE1ZDRfd2R0IGRyaXZlciBoYXJkY29kZXMgQVQ5MV9XRFRfV0RE
SVMgKGJpdCAxNSkgZm9yIFdERElTDQo+IGRldGVjdGlvbiwgd2hpY2ggaXMgaW5jb3JyZWN0IGZv
ciBTQU05WDYwIGFuZCBTQU1BN0c1IHRoYXQgdXNlIGJpdCAxMg0KPiAoQVQ5MV9TQU05WDYwX1dE
RElTKS4gVGhpcyBzZXJpZXMgZml4ZXMgdGhlIGRldGVjdGlvbiBieSBpbnRyb2R1Y2luZw0KPiBh
IHBlci1kZXZpY2Ugd2RkaXNfbWFzayBhbmQgZG9jdW1lbnRzIHRoZSBiaXQgcG9zaXRpb24gZGlm
ZmVyZW5jZSBpbg0KPiB0aGUgaGVhZGVyLg0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBSZW9y
ZGVyIHBhdGNoZXM6IGZpeCBmaXJzdCwgZG9jdW1lbnRhdGlvbiBzZWNvbmQNCj4gLSBEcm9wIHBh
dGNoIDMvMywgbm90IG5lZWRlZCB3aXRoIHdkZGlzX21hc2sgYXBwcm9hY2gNCj4gLSBLZWVwIEFU
OTFfU0FNOVg2MF8qIHJlZ2lzdGVyIG5hbWVzLCBkcm9wIF9MRUdBQ1kvX01PREVSTiBuYW1pbmcN
Cj4gLSBMaW1pdCBoZWFkZXIgY2hhbmdlcyB0byBXRERJUyBjb21tZW50cyBhbmQgZGF0YXNoZWV0
IHJlZmVyZW5jZXMNCj4gDQo+IEJhbGFrcmlzaG5hbiBTYW1iYXRoICgyKToNCj4gICAgd2F0Y2hk
b2c6IHNhbWE1ZDRfd2R0OiBGaXggV0RESVMgZGV0ZWN0aW9uIG9uIFNBTTlYNjAgYW5kIFNBTUE3
RzUNCj4gICAgd2F0Y2hkb2c6IGF0OTFzYW05X3dkdC5oOiBEb2N1bWVudCBXRERJUyBiaXQgcG9z
aXRpb24gcGVyIFNvQyBmYW1pbHkNCj4gDQo+ICAgZHJpdmVycy93YXRjaGRvZy9hdDkxc2FtOV93
ZHQuaCB8ICA2ICsrKy0tDQo+ICAgZHJpdmVycy93YXRjaGRvZy9zYW1hNWQ0X3dkdC5jICB8IDQ4
ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwg
MjUgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pDQo+IA0KDQo=
