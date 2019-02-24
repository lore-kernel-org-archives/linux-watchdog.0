Return-Path: <SRS0=aOtl=Q7=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB81C43381
	for <linux-watchdog@archiver.kernel.org>; Sun, 24 Feb 2019 11:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F1D20663
	for <linux-watchdog@archiver.kernel.org>; Sun, 24 Feb 2019 11:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Ei/dtT7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfBXLgd (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 24 Feb 2019 06:36:33 -0500
Received: from mail-eopbgr150088.outbound.protection.outlook.com ([40.107.15.88]:9795
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfBXLgd (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 24 Feb 2019 06:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1K95wn96FivFis8B3KLS4e9dbv7ObM53KT/Y6rpWL0=;
 b=Ei/dtT7/uAtuol3c6QUzkHsHr+9FCEINsps3ZRr0x8ByrpEAW4M5zvSbeWBsUkORtTTKO6uhVdgTJclkqMkWMom8areQNfw67qV1Z4SEgDMJyG+x/vJ9It5C9AiIrn87n5v/sM/SW7TomYVEJRdhBMOubBq7cumGaq4hfoIbaG0=
Received: from AM6PR05MB5224.eurprd05.prod.outlook.com (20.177.196.210) by
 AM6PR05MB5222.eurprd05.prod.outlook.com (20.177.191.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Sun, 24 Feb 2019 11:36:29 +0000
Received: from AM6PR05MB5224.eurprd05.prod.outlook.com
 ([fe80::195d:8821:cbf3:ca92]) by AM6PR05MB5224.eurprd05.prod.outlook.com
 ([fe80::195d:8821:cbf3:ca92%5]) with mapi id 15.20.1643.019; Sun, 24 Feb 2019
 11:36:29 +0000
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
Thread-Index: AQHUyP+IjS564SDcWE+VCarmqBR+o6Xto+0AgAEza7A=
Date:   Sun, 24 Feb 2019 11:36:29 +0000
Message-ID: <AM6PR05MB522419E0EF2BD6098A00FB8EA2790@AM6PR05MB5224.eurprd05.prod.outlook.com>
References: <20190220093424.5374-1-michaelsh@mellanox.com>
 <20190220093424.5374-3-michaelsh@mellanox.com>
 <a93993bf-cf72-83c0-0d44-d8f46230482c@roeck-us.net>
In-Reply-To: <a93993bf-cf72-83c0-0d44-d8f46230482c@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b316c4a-e4d1-4e41-c5ed-08d69a4c5177
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5222;
x-ms-traffictypediagnostic: AM6PR05MB5222:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA1TUI1MjIyOzIzOnpRVFpnVERMT3RKWjFKUFozS0tvK09ROFFT?=
 =?utf-8?B?WE9LSTBudDBKYkh2NXRGUnQ0VWNjbW5ZSVJqZFhWVERWYUxWZ0wvdklOeVo2?=
 =?utf-8?B?dDlhNllWZi9RTjVaek5Ra0kwdE8zQXo3Nk9RUEkvanpkQ0MwcjlHdmZvLzF2?=
 =?utf-8?B?TEZQRkRYRXBsaTNQZGdKWnp2enk5ZzgrTVgwdlNMYklVR3d3U2RvVkJkZU9n?=
 =?utf-8?B?d200S0ZxamJWQnpiaGtlajVXc28rV2tyV2hwV0MyZDUrZnlTMy83bDVxSGw0?=
 =?utf-8?B?TDl3aGJjZnJMcXVoVkF2cmo5cnRMK0lWdzJ5RzRGOUJIT3puT2hpMzBtTExj?=
 =?utf-8?B?QVR2R0kzUEFZVk14NEdIcC9nZlc5aWlWQzYrZEpubHF3b0JkakdHc0xuYUtl?=
 =?utf-8?B?cHhMRHNJb0J2NzRGRXRZTXFXdjRDL0p0eHhVTmpSTzYvWGFsd1ZvS2RyS1FM?=
 =?utf-8?B?UXJnNjJmUFQwQkZ4a09oWlN1S2JZRi9JOHVnc0YraUJVeVUrbG9sV3NxMnhv?=
 =?utf-8?B?N0tnYkhoZURoM2FzMnhSMW5odzB6ejBsa3dvZEFWNk9KYmk2WUpCd0syMjI1?=
 =?utf-8?B?YjhzSWI3S3BEWnZyTUR5UHRLcDFLbVJ0MHowbXVRUFhzQkJDN0twUDVsbnpu?=
 =?utf-8?B?SlRjaDJ2R2duWkxlVitVTzNIbWtHTEFlYjJ1V3dUM2syUmN0eVlBMmlpZDZE?=
 =?utf-8?B?NXlXUHZyVXZQYVc3aXhhKzA4L3FRTG9vc1EydXpzNHBuWFRVaHJTM2VIcE1H?=
 =?utf-8?B?d3JVMVl6RG82SXVyRjhnYmtBNkJoZy8yaFpkZENaWWRKcGZpcmlEL2dNSm4r?=
 =?utf-8?B?QmMycUpqZGgvbVNkRmZ0MllWQlFVTEN1VVM3bVFuTk51NDM5QnpnN0RKU0dU?=
 =?utf-8?B?Z09obGVOaUZJTGlibVZrUE1vTHB6bFhEOGdZRHZvcGxmTDNqV1Fkc1BCK3pu?=
 =?utf-8?B?Vk9OQkhKSGNOUENvZ29JaHFPUjRYVWF2blk1bSsxOG1QNnZYTzRraEsrYnp3?=
 =?utf-8?B?ZGZTK3Z5L1NwQzVpTXNaK3pjcnVBZXFNRSt3c21oeS9qb3d0RWsvS2dDVXMv?=
 =?utf-8?B?Q0J4dnBYbnB1akszbUpmSjdoMXo0OGJPeTRGa0lZU0t4VDkwNVN0Rk84dUlr?=
 =?utf-8?B?STNabjI3emhmMkkxeDFkT3NhTkJHTTBZaWtvMllzVWVkQjBmNS9iVW4wOVlK?=
 =?utf-8?B?U1NVdTJoSWhMV2o3a2pxSE1WcUIzREZCek9mVkhXK2tXaWVjNDJSajdRdDNH?=
 =?utf-8?B?aHFEV1M2c1V3dzBqZURyZTZuVmxYeVhoam9QcWF5VEN4YlJnYWQ0VnhmUXpv?=
 =?utf-8?B?OS9KZlEvUUFneUViTS91TUhpUGh0akg1cjV6aWU1RVpyRGlIZEhKbis5cU9T?=
 =?utf-8?B?dDBLTlRUeXhva05Qd0FnV3JTQWl0Y2xZOTVVbkEra24yaUZkTFFCdEZsaS8r?=
 =?utf-8?B?c3pReGNKMSsrTkJ6VDRwdzNqUHFxSGhSZmxwY3dhbjN6emtVR0VNS2Uza3Uz?=
 =?utf-8?B?Y0VHRHB6eWd4RkdNREx6TFJ2WVhiSlVxNTdxaXErcHprWjZSRzUrd25sSjVO?=
 =?utf-8?B?NDVJcWxPbEJ0VW5UUmZsdmc3ZFljUGpOUC9rVnEzNUFvRHpFZWNzWjUwd2F2?=
 =?utf-8?B?dDR1bGNhdTJ0cjZwbXJNU0FqRkJ5aDNmblltRGdHOFF4WW9HNlVrQVpjQ1o0?=
 =?utf-8?B?cVZnZXU3bFpOS0NQaXpNbGhWM0xJRnUzQmtYRTdPdlVwR0t1Y0x0RnA4bnBL?=
 =?utf-8?Q?LjWYfEGTWKnf1VNzd4vZcakgqiiJGeXl7/61I=3D?=
x-microsoft-antispam-prvs: <AM6PR05MB52221C39E91A69E4AB7E49E5A2790@AM6PR05MB5222.eurprd05.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39850400004)(346002)(376002)(189003)(13464003)(199004)(6116002)(71190400001)(71200400001)(3846002)(102836004)(486006)(446003)(53936002)(6506007)(305945005)(25786009)(54906003)(76176011)(2201001)(11346002)(229853002)(86362001)(316002)(55016002)(476003)(105586002)(6246003)(110136005)(7696005)(9686003)(106356001)(7736002)(4326008)(6436002)(53546011)(97736004)(2906002)(14444005)(256004)(81166006)(81156014)(8676002)(33656002)(14454004)(26005)(74316002)(68736007)(2501003)(52536013)(99286004)(66066001)(8936002)(478600001)(5660300002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5222;H:AM6PR05MB5224.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YVsxFI+BogcARO7U7ug4dFXI7XX8gyuFM++opGhRGdaVW+aTBOstkGCDtjCpWJa1+/ALDRW+cGLafCbn4wKiL1mwHQ5ax/3ro0blD53KbblW3wPVHz1dBQU4Tvi11zC2mfk8KrCqI01I7dTyqxlzJDGEEWNofDrYJGo40/GaXTHddCSXNJbmwQRlDH1KuBBDoudj5NLWZyhLAd8VPPUhqR5lxXiAjcl/X8lG5rar71cVdbXFCumIVuHJszzvb47RHmNzHMgppyNya8m6hYTVnUjFJJ6IQZ/pfO3fCc6MnuTV4Z4PaZS+EtaT552Hy9IwWQYNRjasozkFEjpCsC3RBXu9B7Y7jVzNZ3cVa/TRhgPoyGgn6Nu5EhUEvknetuITguSmbSnTSpuha6IAxf4L5bYBEdPeJZbqHHTUadNklEA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b316c4a-e4d1-4e41-c5ed-08d69a4c5177
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 11:36:29.3659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5222
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2VjayA8
Z3JvZWNrN0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQo+IFNlbnQ6IFNh
dHVyZGF5LCBGZWJydWFyeSAyMywgMjAxOSA3OjEzIFBNDQo+IFRvOiBNaWNoYWVsIFNoeWNoIDxt
aWNoYWVsc2hAbWVsbGFub3guY29tPjsgd2ltQGxpbnV4LXdhdGNoZG9nLm9yZzsNCj4gYW5keUBp
bmZyYWRlYWQub3JnOyBkdmhhcnRAaW5mcmFkZWFkLm9yZw0KPiBDYzogbGludXgtd2F0Y2hkb2dA
dmdlci5rZXJuZWwub3JnOyBwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZzsNCj4g
VmFkaW0gUGFzdGVybmFrIDx2YWRpbXBAbWVsbGFub3guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY0IDIvM10gd2F0Y2hkb2c6IG1seC13ZHQ6IGludHJvZHVjZSBhIHdhdGNoZG9nIGRyaXZl
ciBmb3INCj4gTWVsbGFub3ggc3lzdGVtcy4NCj4gDQo+IE9uIDIvMjAvMTkgMTozNCBBTSwgbWlj
aGFlbHNoQG1lbGxhbm94LmNvbSB3cm90ZToNCj4gPiBGcm9tOiBNaWNoYWVsIFNoeWNoIDxtaWNo
YWVsc2hAbWVsbGFub3guY29tPg0KPiA+DQo+ID4gSW50cm9kdWNlIHdhdGNoZG9nIGRyaXZlciBm
b3IgYSB2YXJpb3VzIHJhbmdlIG9mIE1lbGxhbm94IEV0aGVybmV0IGFuZA0KPiA+IEluZmluaWJh
bmQgc3dpdGNoIHN5c3RlbXMuDQo+ID4NCj4gPiBXYXRjaGRvZyBkcml2ZXIgZm9yIE1lbGxhbm94
IHdhdGNoZG9nIGRldmljZXMsIGltcGxlbWVudGVkIGluDQo+ID4gcHJvZ3JhbW1hYmxlIGxvZ2lj
IGRldmljZS4NCj4gPg0KPiA+IE1haW4gYW5kIGF1eGlsaWFyeSB3YXRjaGRvZyBkZXZpY2VzIGNh
biBleGlzdCBvbiB0aGUgc2FtZSBzeXN0ZW0uDQo+ID4gVGhlcmUgYXJlIHNldmVyYWwgYWN0aW9u
cyB0aGF0IGNhbiBiZSBkZWZpbmVkIGluIHRoZSB3YXRjaGRvZzoNCj4gPiBzeXN0ZW0gcmVzZXQs
IHN0YXJ0IGZhbnMgb24gZnVsbCBzcGVlZCBhbmQgaW5jcmVhc2UgYSBjb3VudGVyLg0KPiA+IFRo
ZSBsYXN0IDIgYWN0aW9ucyBhcmUgcGVyZm9ybWVkIHdpdGhvdXQgYSBzeXN0ZW0gcmVzZXQuDQo+
ID4gQWN0aW9ucyB3aXRob3V0IHJlc2V0IGFyZSBwcm92aWRlZCBmb3IgYXV4aWxpYXJ5IHdhdGNo
ZG9nIGRldmljZXMsDQo+ID4gd2hpY2ggaXMgb3B0aW9uYWwuDQo+ID4gQWNjZXNzIHRvIEhXIHJl
Z2lzdGVycyBpcyBwZXJmb3JtZWQgdGhyb3VnaCBnZW5lcmljIHJlZ21hcCBpbnRlcmZhY2UuDQo+
ID4NCj4gPiBUaGVyZSBhcmUgMiB0eXBlcyBvZiBIVyB3YXRjaGRvZyBpbXBsZW1lbnRhdGlvbnMu
DQo+ID4gVHlwZSAxOiBhY3R1YWwgSFcgdGltZW91dCBjYW4gYmUgZGVmaW5lZCBhcyBwb3dlciBv
ZiAyIG1zZWMuDQo+ID4gZS5nLiB0aW1lb3V0IDIwIHNlYyB3aWxsIGJlIHJvdW5kZWQgdXAgdG8g
MzI3NjggbXNlYy47IG1heGltdW0gdGltZW91dA0KPiA+IHBlcmlvZCBpcyAzMiBzZWMgKDMyNzY4
IG1zZWMuKTsgZ2V0IHRpbWUtbGVmdCBpc24ndCBzdXBwb3J0ZWQgVHlwZSAyOg0KPiA+IGFjdHVh
bCBIVyB0aW1lb3V0IGlzIGRlZmluZWQgaW4gc2VjLiBhbmQgaXQncyB0aGUgc2FtZSBhcyB1c2Vy
LWRlZmluZWQNCj4gPiB0aW1lb3V0OyBtYXhpbXVtIHRpbWVvdXQgaXMgMjU1IHNlYzsgZ2V0IHRp
bWUtbGVmdCBpcyBzdXBwb3J0ZWQ7DQo+ID4NCj4gPiBXYXRjaGRvZyBkcml2ZXIgaXMgcHJvYmVk
IGZyb20gdGhlIGNvbW1vbiBtbHhfcGxhdGZvcm0gZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTWljaGFlbCBTaHljaCA8bWljaGFlbHNoQG1lbGxhbm94LmNvbT4NCj4gDQo+IFJldmll
d2VkLWJ5OiBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+DQo+IA0KPiA+DQoNCkhp
IEd1ZW50ZXIsDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgcmV2aWV3cy4NCg0KSG93
IHdlIHNob3VsZCBwcm9jZWVkIGZvciB0aGlzIHBhdGNoc2V0Pw0KDQpXaG8gc2hvdWxkIHRha2Ug
aXQgdG8gdGhlIG5leHQsIHdhdGNoZG9nIG9yIHBsYXRmb3JtIG1haW5hdGFpbmVyPw0KDQpUaGFu
a3MsDQpWYWRpbS4NCiANCg0KDQo=
