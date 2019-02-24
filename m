Return-Path: <SRS0=aOtl=Q7=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5B4C43381
	for <linux-watchdog@archiver.kernel.org>; Sun, 24 Feb 2019 18:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417EE206B6
	for <linux-watchdog@archiver.kernel.org>; Sun, 24 Feb 2019 18:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="O5hVCDfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfBXSBx (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 24 Feb 2019 13:01:53 -0500
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:47789
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbfBXSBx (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 24 Feb 2019 13:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFBblPOyL09VvzugUw2JWfk5e5KVA7ISUnAjDdLu9yk=;
 b=O5hVCDflgk1zFe3KSV1yNAJPj74FJqQwkAbZpdi6SZFzqVdgj9C2MH7a87XQp7/az839gTRKNt6krSCudVb61VoD84o4zTNtJb1eZiSBS9CBgdCa9nw30WHU78WWh8thvXW2z0IKIK/ikZhvnHGEonP+cLTbTRTTxljkMG+AQUg=
Received: from AM6PR05MB5224.eurprd05.prod.outlook.com (20.177.196.210) by
 AM6PR05MB4806.eurprd05.prod.outlook.com (20.177.34.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Sun, 24 Feb 2019 18:01:46 +0000
Received: from AM6PR05MB5224.eurprd05.prod.outlook.com
 ([fe80::195d:8821:cbf3:ca92]) by AM6PR05MB5224.eurprd05.prod.outlook.com
 ([fe80::195d:8821:cbf3:ca92%5]) with mapi id 15.20.1643.019; Sun, 24 Feb 2019
 18:01:46 +0000
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Michael Shych <michaelsh@mellanox.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
CC:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v4 2/3] watchdog: mlx-wdt: introduce a watchdog driver for
 Mellanox systems.
Thread-Topic: [PATCH v4 2/3] watchdog: mlx-wdt: introduce a watchdog driver
 for Mellanox systems.
Thread-Index: AQHUyP+IjS564SDcWE+VCarmqBR+o6Xto+0AgAEza7CAAFWfAIAAFiPA
Date:   Sun, 24 Feb 2019 18:01:46 +0000
Message-ID: <AM6PR05MB52241830B0F86C68BC78F0D2A2790@AM6PR05MB5224.eurprd05.prod.outlook.com>
References: <20190220093424.5374-1-michaelsh@mellanox.com>
 <20190220093424.5374-3-michaelsh@mellanox.com>
 <a93993bf-cf72-83c0-0d44-d8f46230482c@roeck-us.net>
 <AM6PR05MB522419E0EF2BD6098A00FB8EA2790@AM6PR05MB5224.eurprd05.prod.outlook.com>
 <f6038e0f-107d-f04f-af5c-e7fd822f8436@roeck-us.net>
In-Reply-To: <f6038e0f-107d-f04f-af5c-e7fd822f8436@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com; 
x-originating-ip: [84.108.218.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e567bf07-6dbe-4575-e342-08d69a822483
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4806;
x-ms-traffictypediagnostic: AM6PR05MB4806:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA1TUI0ODA2OzIzOmJHa2ZEdnVUc0lDTzRadFNGaTNxWCtBM0l3?=
 =?utf-8?B?Vi9iOFVKYUxxMU5QVCt3NVMwdGoxWDMxVzFBY1FTeGloYXlSWGx2MmVtRy9K?=
 =?utf-8?B?TW5WS3JsNm5VbWlpV3pEMUJvV0FxaHZPakxucWxnY0xOay9KdnBXLzgyS2I2?=
 =?utf-8?B?SzBiUE84UW1kV2hTOUhPYWxZaUJKWFY5bDRaYURsaXdvd0RTOGNvb0FBdFB0?=
 =?utf-8?B?THF0MVVMMWJSeVRMK2VHd3lhVVl0UlVyajN2dklOd0VNdi8vRE5BQ0JyZXBn?=
 =?utf-8?B?dTNMeXFweGVwZEpjMFhxYXIwenNwTkVvSGh0MXdHSkwvQzlCbjdyZmRTVVJn?=
 =?utf-8?B?L3BsVE56dlMzbXovL21hYmdRR2RydHpzK0g3LzV2clJpUnBYemVtNkx3djJp?=
 =?utf-8?B?QUN0dGQrd25OZmpWQWdaV3VKd3JBT0FLbWdzbUtyem54TEFkV3B4dTgxbURW?=
 =?utf-8?B?MTViLzNnb0xXckUvYnVxcVIrZnI4OHJRd0hsZy9EaEZNWm9uQWkrSWh4ckJx?=
 =?utf-8?B?cFNYdXlJS3FLT2d5cjQ5QU1hVDFuWjZWR29DY0NCZCs2dkV2djIxakM4WktN?=
 =?utf-8?B?N1ZmakwvakNscFVjTUE2Um43Z0FMM1E0K3Znc2lRMG1TOG0wVksvM1RhQTZw?=
 =?utf-8?B?QzFHQnVGSFhEekV5UVFtS2RiQTZrQmJqRFFscDlxcnpqd1ZXbjQveTkyS2ZP?=
 =?utf-8?B?MXFxV2RzL1VhQlduelg5UHNrM3plZVNDRTc5Tm9PaFZROFY2UnRnbWovejJM?=
 =?utf-8?B?aFNMWjhodEVaRy9kaml4UHVLcjZNZSszWkNwalArMVpQaWdqajZ0RitKeXdC?=
 =?utf-8?B?MGU3NDVhWWsrZEZVenVGR0pxcUJQbG1lZENNSXluNmVpNmtwWkhOSkJYMGQ0?=
 =?utf-8?B?SWpITGpuVHZ4RzBtUzd3T2dFN0QwZmoxdkNvT253RGVLOHRWMGZaVkpCR3Nk?=
 =?utf-8?B?RU9lc1V1M0hML09TMHpCTCtRZzlhdWpwZHp0dkY5b1RWUk5YYUZlTW5WcUEr?=
 =?utf-8?B?TlgzT0JzbmlCNjljemwwM3JJbHZoWXd6b2RTMUxtUmFFeVpncFpuSnRpWEFu?=
 =?utf-8?B?dTRyNzJxbWRJQ2hZR2Fhdm5Ta3E3NVplQ2YzSzRqYUlNYUJDbW5SQzZYM0N3?=
 =?utf-8?B?a1ZKcEVSeGFIVCtFMXF6bWhOVkFHTjEwL2c4OFBZUVJOTkhJQjJwSWt6Q0Vj?=
 =?utf-8?B?TVY2ekY0ZHVTQTJua0Q1WnhOUkFyeDFOMGxldXdFZ3RuM1FETFdSRjBnbHlW?=
 =?utf-8?B?L1g2bHpRTjVZUi9CdDhrZXpRTDRMcURnQ2hsWFRZaFdzWFpwd3g4Y2xMV25C?=
 =?utf-8?B?RXJRazZwQ2JZZ1BFUmhEVEYrMkNMYURHVzFIVklTWGhQOEJ5cVJYdmhuemtN?=
 =?utf-8?B?Y1ZtZG5ZWTRVNE9FTjB5UFNINW1TY1lwMnhOdmtIYzN3enlMWVl1UFdNR0Uv?=
 =?utf-8?B?eHVSNTJRbHpvbU9kTzNzbjBtVmpoN2x5dCtZQnN0YnppaTJuVHJrK0MwK1lW?=
 =?utf-8?B?eXJwNnJSUmNaUlhWeWlhRGNmNDBRS2RFME13b2d5WWFlTmR6THduVk9yeFZn?=
 =?utf-8?B?MUluUnVjR3JGNkhzRE5JYnUvWHZmK1g5UFhvSVA4V2dJdUt1dVhrTW1GV3BX?=
 =?utf-8?B?OE02MGNkUlBTRlNiUTN2Wk1wVjJHRzFXZUpUMHBmQ1NjQzNiZHI0Q1FDekhW?=
 =?utf-8?B?dmtuUjZvNDRsOVlYVzBqT2hPVkVqcU1QL3d5YjVwc2dYemM0N3FzaTg5MFhs?=
 =?utf-8?B?T21MWVFNTUZyY0k4Q3c3alEvOXJoY0xCMEExWVNLZWt6UE1KM3prYXBCbUpw?=
 =?utf-8?Q?F8WWbPNdd52yz?=
x-microsoft-antispam-prvs: <AM6PR05MB48068D3A8442A306F878C826A2790@AM6PR05MB4806.eurprd05.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(376002)(39850400004)(199004)(189003)(13464003)(81166006)(476003)(8676002)(102836004)(7696005)(33656002)(6506007)(54906003)(186003)(14454004)(2906002)(99286004)(68736007)(106356001)(4326008)(25786009)(52536013)(11346002)(8936002)(305945005)(6116002)(110136005)(2501003)(3846002)(53936002)(81156014)(53546011)(5660300002)(446003)(26005)(76176011)(316002)(93886005)(486006)(256004)(6246003)(7736002)(14444005)(97736004)(478600001)(74316002)(66066001)(9686003)(105586002)(229853002)(55016002)(86362001)(71200400001)(71190400001)(2201001)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4806;H:AM6PR05MB5224.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7Gpm5ma3I6wb4c5FchVgGZpll4R3W4apiqdA2gjIL+7Kc/rQywgbA39l6FQd3r6RvfrnOXpKsdFRNTECI/H49GjpOdwEf6H/0MOuiDB0PUKDC+EX2sCPV8ozMJtTphJoXfwO4o3E5Q+53Ja9nxUSQV2AP7uFe7GbVqLaOTzxMjZhR8kPSfOK22CLvJThowrdEfa6c2eZQ6POZO2jM13DngI+L4NrvcyGy11TA/EfczyuD86wkIReOu5vnaRVXo1JJXv5l06ROah16VqhxlX/beDQ10Y2rcJWohQZFY2SBfcu0QtUO7MSoTastHUWdelfRmaJCcTCQm672xsCsOPXvZdslW6Dk5iYgZEqpPX5DpzKzYNKG3mD350DU9EmEV+OlX/pMDIyjQaicRbJX1zeVGIH2pbKNX7mTGSUMmozpgo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e567bf07-6dbe-4575-e342-08d69a822483
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 18:01:46.7542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4806
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2VjayA8
Z3JvZWNrN0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQo+IFNlbnQ6IFN1
bmRheSwgRmVicnVhcnkgMjQsIDIwMTkgNjozOSBQTQ0KPiBUbzogVmFkaW0gUGFzdGVybmFrIDx2
YWRpbXBAbWVsbGFub3guY29tPjsgTWljaGFlbCBTaHljaA0KPiA8bWljaGFlbHNoQG1lbGxhbm94
LmNvbT47IHdpbUBsaW51eC13YXRjaGRvZy5vcmc7IGFuZHlAaW5mcmFkZWFkLm9yZzsNCj4gZHZo
YXJ0QGluZnJhZGVhZC5vcmcNCj4gQ2M6IGxpbnV4LXdhdGNoZG9nQHZnZXIua2VybmVsLm9yZzsg
cGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NCAyLzNdIHdhdGNoZG9nOiBtbHgtd2R0OiBpbnRyb2R1Y2UgYSB3YXRjaGRvZyBkcml2ZXIg
Zm9yDQo+IE1lbGxhbm94IHN5c3RlbXMuDQo+IA0KPiBPbiAyLzI0LzE5IDM6MzYgQU0sIFZhZGlt
IFBhc3Rlcm5hayB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+IEZyb206IEd1ZW50ZXIgUm9lY2sgPGdyb2VjazdAZ21haWwuY29tPiBPbiBCZWhh
bGYgT2YgR3VlbnRlciBSb2Vjaw0KPiA+PiBTZW50OiBTYXR1cmRheSwgRmVicnVhcnkgMjMsIDIw
MTkgNzoxMyBQTQ0KPiA+PiBUbzogTWljaGFlbCBTaHljaCA8bWljaGFlbHNoQG1lbGxhbm94LmNv
bT47IHdpbUBsaW51eC13YXRjaGRvZy5vcmc7DQo+ID4+IGFuZHlAaW5mcmFkZWFkLm9yZzsgZHZo
YXJ0QGluZnJhZGVhZC5vcmcNCj4gPj4gQ2M6IGxpbnV4LXdhdGNoZG9nQHZnZXIua2VybmVsLm9y
ZzsNCj4gPj4gcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IFZhZGlt
IFBhc3Rlcm5hayA8dmFkaW1wQG1lbGxhbm94LmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NCAyLzNdIHdhdGNoZG9nOiBtbHgtd2R0OiBpbnRyb2R1Y2UgYSB3YXRjaGRvZw0KPiA+PiBk
cml2ZXIgZm9yIE1lbGxhbm94IHN5c3RlbXMuDQo+ID4+DQo+ID4+IE9uIDIvMjAvMTkgMTozNCBB
TSwgbWljaGFlbHNoQG1lbGxhbm94LmNvbSB3cm90ZToNCj4gPj4+IEZyb206IE1pY2hhZWwgU2h5
Y2ggPG1pY2hhZWxzaEBtZWxsYW5veC5jb20+DQo+ID4+Pg0KPiA+Pj4gSW50cm9kdWNlIHdhdGNo
ZG9nIGRyaXZlciBmb3IgYSB2YXJpb3VzIHJhbmdlIG9mIE1lbGxhbm94IEV0aGVybmV0DQo+ID4+
PiBhbmQgSW5maW5pYmFuZCBzd2l0Y2ggc3lzdGVtcy4NCj4gPj4+DQo+ID4+PiBXYXRjaGRvZyBk
cml2ZXIgZm9yIE1lbGxhbm94IHdhdGNoZG9nIGRldmljZXMsIGltcGxlbWVudGVkIGluDQo+ID4+
PiBwcm9ncmFtbWFibGUgbG9naWMgZGV2aWNlLg0KPiA+Pj4NCj4gPj4+IE1haW4gYW5kIGF1eGls
aWFyeSB3YXRjaGRvZyBkZXZpY2VzIGNhbiBleGlzdCBvbiB0aGUgc2FtZSBzeXN0ZW0uDQo+ID4+
PiBUaGVyZSBhcmUgc2V2ZXJhbCBhY3Rpb25zIHRoYXQgY2FuIGJlIGRlZmluZWQgaW4gdGhlIHdh
dGNoZG9nOg0KPiA+Pj4gc3lzdGVtIHJlc2V0LCBzdGFydCBmYW5zIG9uIGZ1bGwgc3BlZWQgYW5k
IGluY3JlYXNlIGEgY291bnRlci4NCj4gPj4+IFRoZSBsYXN0IDIgYWN0aW9ucyBhcmUgcGVyZm9y
bWVkIHdpdGhvdXQgYSBzeXN0ZW0gcmVzZXQuDQo+ID4+PiBBY3Rpb25zIHdpdGhvdXQgcmVzZXQg
YXJlIHByb3ZpZGVkIGZvciBhdXhpbGlhcnkgd2F0Y2hkb2cgZGV2aWNlcywNCj4gPj4+IHdoaWNo
IGlzIG9wdGlvbmFsLg0KPiA+Pj4gQWNjZXNzIHRvIEhXIHJlZ2lzdGVycyBpcyBwZXJmb3JtZWQg
dGhyb3VnaCBnZW5lcmljIHJlZ21hcCBpbnRlcmZhY2UuDQo+ID4+Pg0KPiA+Pj4gVGhlcmUgYXJl
IDIgdHlwZXMgb2YgSFcgd2F0Y2hkb2cgaW1wbGVtZW50YXRpb25zLg0KPiA+Pj4gVHlwZSAxOiBh
Y3R1YWwgSFcgdGltZW91dCBjYW4gYmUgZGVmaW5lZCBhcyBwb3dlciBvZiAyIG1zZWMuDQo+ID4+
PiBlLmcuIHRpbWVvdXQgMjAgc2VjIHdpbGwgYmUgcm91bmRlZCB1cCB0byAzMjc2OCBtc2VjLjsg
bWF4aW11bQ0KPiA+Pj4gdGltZW91dCBwZXJpb2QgaXMgMzIgc2VjICgzMjc2OCBtc2VjLik7IGdl
dCB0aW1lLWxlZnQgaXNuJ3Qgc3VwcG9ydGVkIFR5cGUgMjoNCj4gPj4+IGFjdHVhbCBIVyB0aW1l
b3V0IGlzIGRlZmluZWQgaW4gc2VjLiBhbmQgaXQncyB0aGUgc2FtZSBhcw0KPiA+Pj4gdXNlci1k
ZWZpbmVkIHRpbWVvdXQ7IG1heGltdW0gdGltZW91dCBpcyAyNTUgc2VjOyBnZXQgdGltZS1sZWZ0
IGlzDQo+ID4+PiBzdXBwb3J0ZWQ7DQo+ID4+Pg0KPiA+Pj4gV2F0Y2hkb2cgZHJpdmVyIGlzIHBy
b2JlZCBmcm9tIHRoZSBjb21tb24gbWx4X3BsYXRmb3JtIGRyaXZlci4NCj4gPj4+DQo+ID4+PiBT
aWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFNoeWNoIDxtaWNoYWVsc2hAbWVsbGFub3guY29tPg0KPiA+
Pg0KPiA+PiBSZXZpZXdlZC1ieTogR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pg0K
PiA+Pg0KPiA+Pj4NCj4gPg0KPiA+IEhpIEd1ZW50ZXIsDQo+ID4NCj4gPiBUaGFuayB5b3UgdmVy
eSBtdWNoIGZvciB5b3VyIHJldmlld3MuDQo+ID4NCj4gPiBIb3cgd2Ugc2hvdWxkIHByb2NlZWQg
Zm9yIHRoaXMgcGF0Y2hzZXQ/DQo+ID4NCj4gPiBXaG8gc2hvdWxkIHRha2UgaXQgdG8gdGhlIG5l
eHQsIHdhdGNoZG9nIG9yIHBsYXRmb3JtIG1haW5hdGFpbmVyPw0KPiA+DQo+IEdvb2QgcXVlc3Rp
b24uIEZvciBub3cgSSBhZGRlZCBpdCB0byBteSB3YXRjaGRvZy1uZXh0IGJyYW5jaC4gQnV0IHRo
ZW4gc3RyaWN0bHkNCj4gc3BlYWtpbmcgKGFuZCBhcyBmYXIgYXMgSSBrbm93KSB3ZSBkb24ndCBo
YXZlIGFuIEFjayBmcm9tIHRoZSBwbGF0Zm9ybQ0KPiBtYWludGFpbmVyLCBzbyBtYXliZSBJIHNo
b3VsZCBub3QgaGF2ZSBkb25lIHRoYXQuIE1heWJlIHdlIHNob3VsZCB3YWl0IGZvcg0KPiB0aGUg
cGxhdGZvcm0gcGFydCB0byBiZSBtZXJnZWQgYnkgdGhlIHBsYXRmb3JtIG1haW50YWluZXIuIFRo
b3VnaHRzLCBhbnlvbmUgPw0KPiANCg0KUmlnaHQuDQoNCkRhcnJlbiwgQW5keSwNCkluIGNhc2Ug
eW91IGFyZSBPSyB3aXRoIHRoZSBjaGFuZ2VzIGluIG1seHJlZy5oIGZyb20NCltQQVRDSCB2NCAx
LzNdIHBsYXRmb3JtX2RhdGEvbWx4cmVnOiBhZGRpdGlvbnMgZm9yIE1lbGxhbm94IHdhdGNoZG9n
IGRyaXZlci4NCmZyb20gdGhpcyBwYXRjaHNldCwgY291bGQgeW91IHBsZWFzZSBhY2s/DQoNClRo
YW5rcywNClZhZGltLg0KDQo+IEd1ZW50ZXINCg==
