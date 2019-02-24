Return-Path: <SRS0=aOtl=Q7=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664D3C43381
	for <linux-watchdog@archiver.kernel.org>; Sun, 24 Feb 2019 17:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A90E20652
	for <linux-watchdog@archiver.kernel.org>; Sun, 24 Feb 2019 17:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="tbVNF5cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfBXR0X (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 24 Feb 2019 12:26:23 -0500
Received: from mail-eopbgr50084.outbound.protection.outlook.com ([40.107.5.84]:27593
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726458AbfBXR0X (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 24 Feb 2019 12:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3QVLWIYpxV21EHwGG4HMEcBX2K6PCg5O1YusXB0B8M=;
 b=tbVNF5cwICtHpvGoNQcCQZR5zXpylQ5+rIPDrweWvA1YYRD5fDezt87WexoxRAp1z+eU5+A00EYbaXg1xeH8Dhm1PgMitFBbSOAvRR4N+L87I3CmrcAmUeNO5XRD4MlHLYaTORmkfw9e31euXVwvY7pIlFnNcQaBdtUHLQuHLg4=
Received: from AM6PR05MB6168.eurprd05.prod.outlook.com (20.178.94.209) by
 AM6PR05MB5976.eurprd05.prod.outlook.com (20.179.1.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Sun, 24 Feb 2019 17:26:13 +0000
Received: from AM6PR05MB6168.eurprd05.prod.outlook.com
 ([fe80::3d75:bde1:291a:ca7b]) by AM6PR05MB6168.eurprd05.prod.outlook.com
 ([fe80::3d75:bde1:291a:ca7b%3]) with mapi id 15.20.1643.019; Sun, 24 Feb 2019
 17:26:13 +0000
From:   Michael Shych <michaelsh@mellanox.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
CC:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [PATCH v4 3/3] Documentation/watchdog: Add documentation mlx-wdt
 driver
Thread-Topic: [PATCH v4 3/3] Documentation/watchdog: Add documentation mlx-wdt
 driver
Thread-Index: AQHUyP+J7sgQwKvSkEWyWw8h5BEVEKXtpCOAgAGTekA=
Date:   Sun, 24 Feb 2019 17:26:13 +0000
Message-ID: <AM6PR05MB6168D76162EE5402DA8738D8D9790@AM6PR05MB6168.eurprd05.prod.outlook.com>
References: <20190220093424.5374-1-michaelsh@mellanox.com>
 <20190220093424.5374-4-michaelsh@mellanox.com>
 <da017855-5cde-97f3-5d5c-7d359adda740@roeck-us.net>
In-Reply-To: <da017855-5cde-97f3-5d5c-7d359adda740@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michaelsh@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc874d14-2120-4564-e306-08d69a7d2d18
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5976;
x-ms-traffictypediagnostic: AM6PR05MB5976:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA1TUI1OTc2OzIzOmc1dDAyZG16bTdVVUhKZi92a1plOUF2WFdp?=
 =?utf-8?B?U0hOV3ZCaXRIQkt0eU4zS1NCb1JadlU2M0dwUW5RZDc4WDltd0w0M0p2NUNW?=
 =?utf-8?B?VStmaGxsbGxEUFlpSU51UlZDWm1hU2x0OHd6UmJ4QmowNisrVUx1ZThXQy9Z?=
 =?utf-8?B?L2pONlF1OVZ1c2R1YmlCZEVkMUJvOXpPQytpWHpDemlEd2FKVElKaTBXMUQr?=
 =?utf-8?B?dzZEbythdkJyaTBlRFRxM0RCaGlsMkc2NEo0YkkwYWhHZkMwclNPdlJIVkph?=
 =?utf-8?B?VFlUWDZUWURkcktwUnMyYlhsVFRaUG9nL0Z2NUtQMTJsRWlsblkwdjYrR0JB?=
 =?utf-8?B?VURXcFhYTlB1YUh4WG9sUFN4U0FTRXpqOWRQM3E5cjZyZFEzYndIL255SHda?=
 =?utf-8?B?YVlRbXlhN3dCQ3ZPTEcrNzNDVHUrdE1HT2hITnM0dVVZVE56eWlQLzVkWHMv?=
 =?utf-8?B?K3gybUZoVmFCU2ZhUzBBbDlzUFlRK1YxV1p1TDc5cTIxL2hMVDRZbmdGekFZ?=
 =?utf-8?B?dllsVkdlMktldllWNUlQYXBJbEpCbUYwb3RkRW1ld2FxdURjTWFWVms4elVS?=
 =?utf-8?B?U29rRnBTM042eTloKzIvMnd6MjVVMlVqbXIwQjg5VURMNXpOSEIwWVVQY1BK?=
 =?utf-8?B?YUN1WmI3QXgzR3RjZ2Y2TmRaR2UxSUROTnpmYmt6ZHFPb2R3TTNUSllIdTQ2?=
 =?utf-8?B?L0NMbHRpZmU1ZC9OTHd0U1RudHhBcWlQV2xlNmpidU5VV3BKUUJpSEVyZlRt?=
 =?utf-8?B?b2d3eWpCSk1TZXpTU1NCSkFuTFB6S3hjazN0azNyNWRMa3ltajZGYmRrZkFS?=
 =?utf-8?B?WU5yNTE5Yjl6VWREVU5vRG5tM202Mk5sMUhUdG1IL3YwajFmSEdzQmc0L1lv?=
 =?utf-8?B?TUdidUw4cGJ0WEw2YmRaZlZha0JjaFYzV3pJWDhjZGxmak5pMmxhYVhsR3A4?=
 =?utf-8?B?M1NjeHlLdWRPUFp5blV6c20wNDZ0MWlWRVBXbnJDSkhzd3NPNER5U2JaS2dR?=
 =?utf-8?B?cGJEcndXTDlRb2Rud1ZxRnVNSVd2MTdsalVTNmsyVVNxMCtYU3hLSlpMZ0U1?=
 =?utf-8?B?bmxOeXhJYjN4MW5GQm9DVHRaZ2hjK1c1NWhWR3M0ZEZRSElUKytOOE1EN1Nx?=
 =?utf-8?B?WWdSdFdnUHRlTjBoM25NOTNkUE0zL1ByWFJZQ3dIcW9FelpqeFNVS3hMdlVj?=
 =?utf-8?B?a1hyRWdiS1NINEphNHYwVGthTGNkN1lIT0lTWXJSRTZBTC80czF1WllMKytE?=
 =?utf-8?B?QVNpMGwyQlRKSU81VUx6MVlpUUZwUGs4Zmp3aVRKZEgxcy9QbkxodmNzV0xm?=
 =?utf-8?B?RW1uaFlmTGRkS256WkZocWVBMTNIU3VidkFIdTQ0T1NRTURoMlM1TStMMDJp?=
 =?utf-8?B?TFdWUGxyQkl2K0U5RE9KVnBVVEc0aW9xQThGQTNZOVF1WnlYUkNWeFR6SUw2?=
 =?utf-8?B?VnhnNENjQlB4MkRhUzllenAyUUg1RWJXT1ZUSzBoaUFmL282OTBYSU02bHlP?=
 =?utf-8?B?ank2N0ZvREp5MGRiR0Ixd2N6Yyt1T3VCdm1FcnRrVUhyemIvNnl3UEYzWisv?=
 =?utf-8?B?RGZxYW9aTFJ4WW9FS3hKK2NSRTRGak5UZUZOT1ZGb09zL1NHRlNWdytjTzE3?=
 =?utf-8?B?MTc3b0ZhUnhRNm9WLzVtVTEwRFErS3RuMzFJT3NiMVNqaUJGS2FOU2IyQ2h0?=
 =?utf-8?B?ZUlnNUh0YVBGSFdCNmh1UXN0NmR1Tld6dE1IN0RFa3ZUb01JMkIvSHV4em1B?=
 =?utf-8?B?RXNCc0RoOFNnT1hyWmxNZTJIU2F5aW9EN0FvTnJnQkY4b3FhQ2g2ZXNBOWM1?=
 =?utf-8?Q?fm1ZHdpQ1uI37?=
x-microsoft-antispam-prvs: <AM6PR05MB5976EAC50FCBA044F1073755D9790@AM6PR05MB5976.eurprd05.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39850400004)(346002)(366004)(136003)(13464003)(199004)(189003)(6246003)(186003)(14444005)(5660300002)(14454004)(26005)(74316002)(6436002)(8676002)(2201001)(68736007)(86362001)(6506007)(256004)(107886003)(53546011)(316002)(478600001)(66066001)(3846002)(71200400001)(71190400001)(52536013)(2906002)(6116002)(33656002)(99286004)(102836004)(9686003)(81156014)(76176011)(55016002)(229853002)(54906003)(7736002)(110136005)(476003)(7696005)(2501003)(97736004)(53936002)(25786009)(105586002)(486006)(305945005)(8936002)(446003)(11346002)(81166006)(4326008)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5976;H:AM6PR05MB6168.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eDVEPALzxVWbOofxGmZPVzYnJ6ZYcwqmTfZPMNb3k72tD4CEkbmavpSDZNs5WGgD9tVq8OQ5eJSJtnWT4Qgtge7NfMHjRJJLSqO2Sk01RtLDz0LP0xBuFbB7XsTSYeqeYm/6Tjo73CJ1/aLKnN+rtlCSBhUzD4j0zl+eVcQwE4UsPoFSAvGVaJaFGKbmGSgy8Z6zXyjrksP2A4c+MKNduSLJ+Y04lDl3krRJAACJlWR0ArEvgbKy2PPeb50NGdwXFAJVwPpF6QC3OILoZvyEiuys+QFjUa7W2W1TW48/ZqEsDbWYo8q/Pt+v0d6wPcme1jmLR5Y8ay1NGMl6aKbFM2NbdxsKDWTReevroZTqgIvYMuBVkyiAvlNqE8WayeiJ1QuMGHijGta3pKB77gEtRy9WJsUHu9fECNVal5Un6qE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc874d14-2120-4564-e306-08d69a7d2d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 17:26:13.6698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5976
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2VjayBb
bWFpbHRvOmdyb2VjazdAZ21haWwuY29tXSBPbiBCZWhhbGYgT2YgR3VlbnRlcg0KPiBSb2Vjaw0K
PiBTZW50OiBTYXR1cmRheSwgRmVicnVhcnkgMjMsIDIwMTkgNzoxMyBQTQ0KPiBUbzogTWljaGFl
bCBTaHljaCA8bWljaGFlbHNoQG1lbGxhbm94LmNvbT47IHdpbUBsaW51eC13YXRjaGRvZy5vcmc7
DQo+IGFuZHlAaW5mcmFkZWFkLm9yZzsgZHZoYXJ0QGluZnJhZGVhZC5vcmcNCj4gQ2M6IGxpbnV4
LXdhdGNoZG9nQHZnZXIua2VybmVsLm9yZzsgcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5l
bC5vcmc7DQo+IFZhZGltIFBhc3Rlcm5hayA8dmFkaW1wQG1lbGxhbm94LmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NCAzLzNdIERvY3VtZW50YXRpb24vd2F0Y2hkb2c6IEFkZCBkb2N1bWVu
dGF0aW9uDQo+IG1seC13ZHQgZHJpdmVyDQo+IA0KPiBPbiAyLzIwLzE5IDE6MzQgQU0sIG1pY2hh
ZWxzaEBtZWxsYW5veC5jb20gd3JvdGU6DQo+ID4gRnJvbTogTWljaGFlbCBTaHljaCA8bWljaGFl
bHNoQG1lbGxhbm94LmNvbT4NCj4gPg0KPiA+IEFkZCBkb2N1bWVudGF0aW9uIHdpdGggZGV0YWls
cyBvZiBNZWxsYW5veCB3YXRjaGRvZyBkcml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBN
aWNoYWVsIFNoeWNoIDxtaWNoYWVsc2hAbWVsbGFub3guY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6
IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVzLm5ldD4NCj4NCg0KSGkgR3VlbnRlciwNCg0K
VGhhbmsgeW91IGZvciB5b3VyIHJldmlld3MuDQpTb3JyeSwgSSBsb29rZWQgdG9kYXkgb3ZlciB0
aGUgZG9jdW1lbnQgYW5kIG5vdGVkIG9uZSB0eXBvIA0KdGhhdCBJIG1hZGUgaW4gcGF0Y2hzZXQg
VjQuDQpJdCdzLCBob3dldmVyLCBjaGFuZ2VkIGV4cGxhbmF0aW9uIG9mIG5vd2F5b3V0Lg0KSW4g
dGhpcyBleHBsYW5hdGlvbiBtdXN0IGJlIGNhbid0IGluc3RlYWQgaW5jb3JyZWN0IGNhbi4NCkkn
bGwgcmVzZW5kIGp1c3QgdGhpcyBkb2N1bWVudCBhcyBwYXRjaCBWNS4NCg0KVGhhbmsgeW91LA0K
ICAgTWljaGFlbC4NCiANCj4gPiAtLS0NCj4gPiB2MS0+djQNCj4gPiAxLiBSZW1vdmUgc2VudGVu
Y2UgdGhhdCBub3cgZG9lc24ndCBjb3JyZXNwb25kIHRvIGNvZGUuDQo+ID4gMi4gQWRkIGV4cGxh
bmF0aW9ucyBhYm91dCBub3dheW91dCBhbmQgc3RhcnRfYXRfYm9vdCBvcHRpb25zLg0KPiA+IC0t
LQ0KPiA+ICAgRG9jdW1lbnRhdGlvbi93YXRjaGRvZy9tbHgtd2R0LnR4dCB8IDUyDQo+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwg
NTIgaW5zZXJ0aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
d2F0Y2hkb2cvbWx4LXdkdC50eHQNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L3dhdGNoZG9nL21seC13ZHQudHh0DQo+IGIvRG9jdW1lbnRhdGlvbi93YXRjaGRvZy9tbHgtd2R0
LnR4dA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi40
MzRlYWRlY2U0MWINCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi93
YXRjaGRvZy9tbHgtd2R0LnR4dA0KPiA+IEBAIC0wLDAgKzEsNTIgQEANCj4gPiArCQlNZWxsYW5v
eCB3YXRjaGRvZyBkcml2ZXJzDQo+ID4gKwkJZm9yIHg4NiBiYXNlZCBzeXN0ZW0gc3dpdGNoZXMN
Cj4gPiArDQo+ID4gK1RoaXMgZHJpdmVyIHByb3ZpZGVzIHdhdGNoZG9nIGZ1bmN0aW9uYWxpdHkg
Zm9yIHZhcmlvdXMgTWVsbGFub3gNCj4gPiArRXRoZXJuZXQgYW5kIEluZmluaWJhbmQgc3dpdGNo
IHN5c3RlbXMuDQo+ID4gKw0KPiA+ICtNZWxsYW5veCB3YXRjaGRvZyBkZXZpY2UgaXMgaW1wbGVt
ZW50ZWQgaW4gYSBwcm9ncmFtbWFibGUgbG9naWMNCj4gZGV2aWNlLg0KPiA+ICsNCj4gPiArVGhl
cmUgYXJlIDIgdHlwZXMgb2YgSFcgd2F0Y2hkb2cgaW1wbGVtZW50YXRpb25zLg0KPiA+ICsNCj4g
PiArVHlwZSAxOg0KPiA+ICtBY3R1YWwgSFcgdGltZW91dCBjYW4gYmUgZGVmaW5lZCBhcyBhIHBv
d2VyIG9mIDIgbXNlYy4NCj4gPiArZS5nLiB0aW1lb3V0IDIwIHNlYyB3aWxsIGJlIHJvdW5kZWQg
dXAgdG8gMzI3NjggbXNlYy4NCj4gPiArVGhlIG1heGltdW0gdGltZW91dCBwZXJpb2QgaXMgMzIg
c2VjICgzMjc2OCBtc2VjLiksDQo+ID4gK0dldCB0aW1lLWxlZnQgaXNuJ3Qgc3VwcG9ydGVkDQo+
ID4gKw0KPiA+ICtUeXBlIDI6DQo+ID4gK0FjdHVhbCBIVyB0aW1lb3V0IGlzIGRlZmluZWQgaW4g
c2VjLiBhbmQgaXQncyB0aGUgc2FtZSBhcw0KPiA+ICthIHVzZXItZGVmaW5lZCB0aW1lb3V0Lg0K
PiA+ICtNYXhpbXVtIHRpbWVvdXQgaXMgMjU1IHNlYy4NCj4gPiArR2V0IHRpbWUtbGVmdCBpcyBz
dXBwb3J0ZWQuDQo+ID4gKw0KPiA+ICtUeXBlIDEgSFcgd2F0Y2hkb2cgaW1wbGVtZW50YXRpb24g
ZXhpc3QgaW4gb2xkIHN5c3RlbXMgYW5kDQo+ID4gK2FsbCBuZXcgc3lzdGVtcyBoYXZlIHR5cGUg
MiBIVyB3YXRjaGRvZy4NCj4gPiArVHdvIHR5cGVzIG9mIEhXIGltcGxlbWVudGF0aW9uIGhhdmUg
YWxzbyBkaWZmZXJlbnQgcmVnaXN0ZXIgbWFwLg0KPiA+ICsNCj4gPiArTWVsbGFub3ggc3lzdGVt
IGNhbiBoYXZlIDIgd2F0Y2hkb2dzOiBtYWluIGFuZCBhdXhpbGlhcnkuDQo+ID4gK01haW4gYW5k
IGF1eGlsaWFyeSB3YXRjaGRvZyBkZXZpY2VzIGNhbiBiZSBlbmFibGVkIHRvZ2V0aGVyDQo+ID4g
K29uIHRoZSBzYW1lIHN5c3RlbS4NCj4gPiArVGhlcmUgYXJlIHNldmVyYWwgYWN0aW9ucyB0aGF0
IGNhbiBiZSBkZWZpbmVkIGluIHRoZSB3YXRjaGRvZzoNCj4gPiArc3lzdGVtIHJlc2V0LCBzdGFy
dCBmYW5zIG9uIGZ1bGwgc3BlZWQgYW5kIGluY3JlYXNlIHJlZ2lzdGVyIGNvdW50ZXIuDQo+ID4g
K1RoZSBsYXN0IDIgYWN0aW9ucyBhcmUgcGVyZm9ybWVkIHdpdGhvdXQgYSBzeXN0ZW0gcmVzZXQu
DQo+ID4gK0FjdGlvbnMgd2l0aG91dCByZXNldCBhcmUgcHJvdmlkZWQgZm9yIGF1eGlsaWFyeSB3
YXRjaGRvZyBkZXZpY2UsDQo+ID4gK3doaWNoIGlzIG9wdGlvbmFsLg0KPiA+ICtXYXRjaGRvZyBj
YW4gYmUgc3RhcnRlZCBkdXJpbmcgYSBwcm9iZSwgaW4gdGhpcyBjYXNlIGl0IHdpbGwgYmUNCj4g
PiArcGluZ2VkIGJ5IHdhdGNoZG9nIGNvcmUgYmVmb3JlIHdhdGNoZG9nIGRldmljZSB3aWxsIGJl
IG9wZW5lZCBieQ0KPiA+ICt1c2VyIHNwYWNlIGFwcGxpY2F0aW9uLg0KPiA+ICtXYXRjaGRvZyBj
YW4gYmUgaW5pdGlhbGlzZWQgaW4gbm93YXlvdXQgd2F5LCBpLmUuIG9uY3NlIHN0YXJ0ZWQNCj4g
PiAraXQgY2FuIGJlIHN0b3BwZWQuDQo+ID4gKw0KPiA+ICtUaGlzIG1seC13ZHQgZHJpdmVyIHN1
cHBvcnRzIGJvdGggSFcgd2F0Y2hkb2cgaW1wbGVtZW50YXRpb25zLg0KPiA+ICsNCj4gPiArV2F0
Y2hkb2cgZHJpdmVyIGlzIHByb2JlZCBmcm9tIHRoZSBjb21tb24gbWx4X3BsYXRmb3JtIGRyaXZl
ci4NCj4gPiArTWx4X3BsYXRmb3JtIGRyaXZlciBwcm92aWRlcyBhbiBhcHByb3ByaWF0ZSBzZXQg
b2YgcmVnaXN0ZXJzIGZvcg0KPiA+ICtNZWxsYW5veCB3YXRjaGRvZyBkZXZpY2UsIGlkZW50aXR5
IG5hbWUgKG1seC13ZHQtbWFpbiBvciBtbHgtd2R0LQ0KPiBhdXgpLA0KPiA+ICtpbml0aWFsIHRp
bWVvdXQsIHBlcmZvcm1lZCBhY3Rpb24gaW4gZXhwaXJhdGlvbiBhbmQgY29uZmlndXJhdGlvbiBm
bGFncy4NCj4gPiArd2F0Y2hkb2cgY29uZmlndXJhdGlvbiBmbGFnczogbm93YXlvdXQgYW5kIHN0
YXJ0X2F0X2Jvb3QsIGh3IHdhdGNoZG9nDQo+ID4gK3ZlcnNpb24gLSB0eXBlMSBvciB0eXBlMi4N
Cj4gPiArVGhlIGRyaXZlciBjaGVja3MgZHVyaW5nIGluaXRpYWxpemF0aW9uIGlmIHRoZSBwcmV2
aW91cyBzeXN0ZW0gcmVzZXQNCj4gPiArd2FzIGRvbmUgYnkgdGhlIHdhdGNoZG9nLiBJZiB5ZXMs
IGl0IG1ha2VzIGEgbm90aWZpY2F0aW9uIGFib3V0IHRoaXMgZXZlbnQuDQo+ID4gKw0KPiA+ICtB
Y2Nlc3MgdG8gSFcgcmVnaXN0ZXJzIGlzIHBlcmZvcm1lZCB0aHJvdWdoIGEgZ2VuZXJpYyByZWdt
YXAgaW50ZXJmYWNlLg0KPiA+DQoNCg==
