Return-Path: <SRS0=sDHB=QO=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1519AC282C2
	for <linux-watchdog@archiver.kernel.org>; Thu,  7 Feb 2019 21:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEA92175B
	for <linux-watchdog@archiver.kernel.org>; Thu,  7 Feb 2019 21:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="VgdPHBNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfBGVEA (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:04:00 -0500
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:5189
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfBGVEA (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 7 Feb 2019 16:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKqNQqOOy7f6lC5q3eXlx/PkxvULP0z5LkYZat/Wvv8=;
 b=VgdPHBNjWtq+A8f01pjRm6iyLXlbREw4zPr5DwtUigZSb2fwcAVC45c2Z6vCyYKvMWZC8Q7Ywlsj78zZVB1+/HeU5MqcDTqxYgnwzk4NEDQ0wL+4hZna7UfS5pteqB4btSV6t9WTwHHTBJD2P7bPcwErRcJ9hyDtZSvtrnM2UQ8=
Received: from AM6PR05MB6168.eurprd05.prod.outlook.com (20.178.94.209) by
 AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.36.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 21:03:46 +0000
Received: from AM6PR05MB6168.eurprd05.prod.outlook.com
 ([fe80::3d75:bde1:291a:ca7b]) by AM6PR05MB6168.eurprd05.prod.outlook.com
 ([fe80::3d75:bde1:291a:ca7b%3]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 21:03:46 +0000
From:   Michael Shych <michaelsh@mellanox.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
CC:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [PATCH v1 0/3] introduce watchdog driver for Mellanox systems.
Thread-Topic: [PATCH v1 0/3] introduce watchdog driver for Mellanox systems.
Thread-Index: AQHUvjwgxQ/Ot2ErU0SbsvLcoNjOgaXTiRqAgAES+aA=
Date:   Thu, 7 Feb 2019 21:03:46 +0000
Message-ID: <AM6PR05MB61683E3B35EFF239B867086BD9680@AM6PR05MB6168.eurprd05.prod.outlook.com>
References: <20190206165037.4346-1-michaelsh@mellanox.com>
 <4ed5ec2d-02e6-956a-124d-f0bb409bf31f@roeck-us.net>
In-Reply-To: <4ed5ec2d-02e6-956a-124d-f0bb409bf31f@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michaelsh@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB4968;6:N8+C0esxitbVaUr8bqOkplaTOCtzcJGWpUwKA/E7jnsSKgryuz8bcvMW1Msp4Bvd2gY81ypGTszsqP2JRRQRuQu1dEWu7hVWTCfigtlJowvndHzJuhe2Afv4GwX1voc+vSSubbSnx/vvLz5/lJFqU22u8nRCvRxgwz6kI3k9x++118BmGL0fe7Y3ldkrP7Cn1dkacSiQl59AetYZgVtonyeWYgf8jZeiZKQPxZ0cBYCjGrVnqvfM+7L/vP1MMS52J+Dfemsb3hprN58msqCGQ7KM2pHF9L6PdqumW5/O9c8kbBcfI2OcNLHNUhk+74DFYQU3eXRnTFGYaxUmZpVjYqJm3p432eQsHbMW+XPe5vTrBh2XAKvPa8bEG7qULqQHoA74pO/Wls43w1blGowEjrIhfWJRMw+58YL+Bz3kfifZ28cQZ6Sn0/a/qQfVH1+mUhxTUpZ0l5Cc9bOnublaOw==;5:1GnlwGYw3zVdjogYrfTavg4LuUxnqcsRVTXblSyIRpYxvlMpdQlHEErKicWW44CTNAgqKuVNWggPj/qvpBvqayydMUxJEY1eWDSfInin/Cr5zLPgb7uDqFrOdvcAxGEJTTbzhLCRMLspEWWM8YKIRMKmf0ofOVuPL/NAIEn08BtxJGmZLk3aEd2rFYt1PDvIDrNjH/2byqvxEqEMY8js9w==;7:ZaiHaOPtJXOSzr5gYKh0AFFscVb+h95LADyKHv5lCdzS8Mw72VoKQh/iOxCcE6qUU+KFDNr5oKndn82klH+pah4PdwKATImJm6OJEBOH9kSXx9CvDkkvGdZ9HKxsKUd9CsIBP6Q1w1p4WuPh9FdnTw==
x-ms-office365-filtering-correlation-id: 5d656527-5ef7-4238-64b7-08d68d3fc024
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4968;
x-ms-traffictypediagnostic: AM6PR05MB4968:
x-microsoft-antispam-prvs: <AM6PR05MB49681D2F39026BD577B33109D9680@AM6PR05MB4968.eurprd05.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(13464003)(478600001)(74316002)(486006)(256004)(446003)(55016002)(11346002)(14454004)(33656002)(186003)(25786009)(2501003)(229853002)(6436002)(2906002)(476003)(97736004)(81156014)(107886003)(4326008)(71200400001)(99286004)(6506007)(7736002)(7696005)(8676002)(102836004)(81166006)(53546011)(3846002)(8936002)(26005)(71190400001)(54906003)(86362001)(305945005)(105586002)(316002)(110136005)(106356001)(9686003)(2201001)(53936002)(68736007)(66066001)(6246003)(6116002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4968;H:AM6PR05MB6168.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xHbzjvgDglSOtEIQFq04Bp2WZsaYXF4a2UCNToSP9pTuxdagAej91QbSF7CSbFhrtX4pXYxfwOK9aPCKL7jT2N7DWLm/6vdfpqrN/C/0LlIJbu1R/V1+/aYEZVo+QrfTh8eFAEqXNkCzSaZSo+1ANsCw67QKnBfc79mDbvyaGHnjV8PqCrBNIqkSBqYSO9eQlXPQkcoKUz5Evhsig+NnsHSlG4QpT8N7nBMMi+2KPn9Tbb3rKOOWs+a2kn75svjTYHnHVG3KkLYQqgj/zAd4Uyyc+5ysY2Au2wMRpD0pinvxLXi/9vcJ1mfwDw5TPQdCgeFTHBga/iEJ7Qi9ejEUXixiwL48cJW52MQIjUv+ocidz/WHzTUki/YmuMPnGQXPtw99Ae0K5nDO9FOpwMnp2hYrryNrZ8fG5bBtP1atraU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d656527-5ef7-4238-64b7-08d68d3fc024
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 21:03:46.4439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4968
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2VjayBb
bWFpbHRvOmdyb2VjazdAZ21haWwuY29tXSBPbiBCZWhhbGYgT2YgR3VlbnRlcg0KPiBSb2Vjaw0K
PiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgNywgMjAxOSAzOjE3IEFNDQo+IFRvOiBNaWNoYWVs
IFNoeWNoIDxtaWNoYWVsc2hAbWVsbGFub3guY29tPjsgd2ltQGxpbnV4LXdhdGNoZG9nLm9yZzsN
Cj4gYW5keUBpbmZyYWRlYWQub3JnOyBkdmhhcnRAaW5mcmFkZWFkLm9yZw0KPiBDYzogbGludXgt
d2F0Y2hkb2dAdmdlci5rZXJuZWwub3JnOyBwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVs
Lm9yZzsNCj4gVmFkaW0gUGFzdGVybmFrIDx2YWRpbXBAbWVsbGFub3guY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYxIDAvM10gaW50cm9kdWNlIHdhdGNoZG9nIGRyaXZlciBmb3IgTWVsbGFu
b3ggc3lzdGVtcy4NCj4gDQo+IE9uIDIvNi8xOSA4OjUwIEFNLCBtaWNoYWVsc2hAbWVsbGFub3gu
Y29tIHdyb3RlOg0KPiA+IEZyb206IE1pY2hhZWwgU2h5Y2ggPG1pY2hhZWxzaEBtZWxsYW5veC5j
b20+DQo+ID4NCj4gPiBUaGlzIHBhdGNoc2V0IGludHJvZHVjZXMgd2F0Y2hkb2cgZHJpdmVyIGZv
ciBhIHZhcmlvdXMgcmFuZ2Ugb2YgTWVsbGFub3gNCj4gPiBFdGhlcm5ldCBhbmQgSW5maW5pYmFu
ZCBzd2l0Y2ggc3lzdGVtcy4NCj4gPiBNZWxsYW5veCB3YXRjaGRvZyBkZXZpY2UgaXMgaW1wbGVt
ZW50ZWQgaW4gcHJvZ3JhbW1hYmxlIGxvZ2ljIGRldmljZS4NCj4gPiBUaGVyZSBhcmUgMiB0eXBl
cyBvZiBIVyB3YXRjaGRvZyBpbXBsZW1lbnRhdGlvbnMgd2l0aCBkaWZlcmVudA0KPiBjYXBhYmls
aXRpZXMuDQo+ID4gVGhpcyBtbHgtd2R0IGRyaXZlciBzdXBwb3J0cyBib3RoIEhXIHdhdGNoZG9n
IGltcGxlbWVudGF0aW9ucy4NCj4gPiBNZWxsYW5veCBzeXN0ZW0gY2FuIGhhdmUgMiB3YXRjaGRv
Z3M6IG1haW4gYW5kIGF1eGlsaWFyeS4NCj4gPiBNYWluIGFuZCBhdXhpbGlhcnkgd2F0Y2hkb2cg
ZGV2aWNlcyBjYW4gYmUgZW5hYmxlZCB0b2dldGhlciBvbiB0aGUgc2FtZQ0KPiBzeXN0ZW0uDQo+
ID4gVGhlcmUgYXJlIHNldmVyYWwgYWN0aW9ucyB0aGF0IGNhbiBiZSBkZWZpbmVkIGluIHRoZSB3
YXRjaGRvZzoNCj4gPiBzeXN0ZW0gcmVzZXQsIHN0YXJ0IGZhbnMgb24gZnVsbCBzcGVlZCBhbmQg
aW5jcmVhc2UgcmVnaXN0ZXIgY291bnRlci4NCj4gPg0KPiANCj4gSSBhc3N1bWUgeW91IHN1Ym1p
dHRlZCB0aGlzIHR3aWNlLiBJZiB0aGVyZSBhcmUgZGlmZmVyZW5jZXMsIHBsZWFzZSBkZXNjcmli
ZQ0KPiB0aGUgZGlmZmVyZW5jZXMgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KRXhhY3RseS4gVGhp
cyBwYXRjaHNldCBpbmNsdWRlcyBhbHNvIHBsYXRmb3JtX2RhdGEvbWx4cmVnLmggZmlsZQ0KQW5k
IGluIDFzdCBzZW50IEkgZGlkbid0IGFkZGVkIGFsbCBwbGF0Zm9ybS1kcml2ZXIgbWFpbnRhaW5l
cnMuDQoNClRoYW5rcywNCiAgICAgTWljaGFlbC4NCj4gDQo+IEd1ZW50ZXINCj4gDQo+ID4gTWlj
aGFlbCBTaHljaCAoMyk6DQo+ID4gICAgcGxhdGZvcm1fZGF0YS9tbHhyZWc6CWFkZGl0dGlvbnMg
Zm9yIG1lbGxhbm94IHdhdGNoZG9nIGRyaXZlci4NCj4gPiAgICB3YXRjaGRvZzogbWx4LXdkdDog
aW50cm9kdWNlIHdhdGNoZG9nIGRyaXZlciBmb3IgTWVsbGFub3ggc3lzdGVtcy4NCj4gPiAgICBE
b2N1bWVudGF0aW9uL3dhdGNoZG9nOiBBZGQgZG9jdW1lbnRhdGlvbiBtbHgtd2R0IGRyaXZlcg0K
PiA+DQo+ID4gICBEb2N1bWVudGF0aW9uL3dhdGNoZG9nL21seC13ZHQudHh0ICAgfCAgNDggKysr
KysNCj4gPiAgIGRyaXZlcnMvd2F0Y2hkb2cvS2NvbmZpZyAgICAgICAgICAgICB8ICAxNiArKw0K
PiA+ICAgZHJpdmVycy93YXRjaGRvZy9NYWtlZmlsZSAgICAgICAgICAgIHwgICAxICsNCj4gPiAg
IGRyaXZlcnMvd2F0Y2hkb2cvbWx4X3dkdC5jICAgICAgICAgICB8IDQwNg0KPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9k
YXRhL21seHJlZy5oIHwgICA2ICsNCj4gPiAgIDUgZmlsZXMgY2hhbmdlZCwgNDc3IGluc2VydGlv
bnMoKykNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL3dhdGNoZG9nL21s
eC13ZHQudHh0DQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy93YXRjaGRvZy9tbHhf
d2R0LmMNCj4gPg0KDQo=
