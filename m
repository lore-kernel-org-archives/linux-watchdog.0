Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2on0148.outbound.protection.outlook.com ([65.55.169.148]:44304
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760062AbbIWDFZ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 Sep 2015 23:05:25 -0400
From: Hou Zhiqiang <B48286@freescale.com>
To: Li Leo <LeoLi@freescale.com>, Mark Rutland <mark.rutland@arm.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	Shaohui Xie <Shaohui.Xie@freescale.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"Sharma Bhupesh" <bhupesh.sharma@freescale.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"wsa@the-dreams.de" <wsa@the-dreams.de>,
	"sboyd@codeaurora.org" <sboyd@codeaurora.org>,
	"wim@iguana.be" <wim@iguana.be>,
	Wenbin Song <Wenbin.Song@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Hu Vincent <Mingkai.Hu@freescale.com>
Subject: RE: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
Date: Wed, 23 Sep 2015 03:05:20 +0000
Message-ID: <CY1PR0301MB07805FA01ACAF84648C806138B440@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-5-git-send-email-B48286@freescale.com>
 <20150922012403.GA1535@svinekod>
 <CY1PR0301MB078008B10188504C951076498B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
 <DM2PR0301MB07342356008C1A50AB26FEFFBA450@DM2PR0301MB0734.namprd03.prod.outlook.com>
In-Reply-To: <DM2PR0301MB07342356008C1A50AB26FEFFBA450@DM2PR0301MB0734.namprd03.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGkgWWFuZy1MZW8tUjU4
NDcyDQo+IFNlbnQ6IDIwMTXE6jnUwjIzyNUgMToyMw0KPiBUbzogSG91IFpoaXFpYW5nLUI0ODI4
NjsgTWFyayBSdXRsYW5kOyBtYXJjLnp5bmdpZXJAYXJtLmNvbQ0KPiBDYzogbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBDYXRhbGluIE1hcmluYXM7IFdpbGwgRGVhY29uOw0K
PiBsaW51eC1pMmNAdmdlci5rZXJuZWwub3JnOyBsaW51eC13YXRjaGRvZ0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LQ0KPiBkb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1jbGtAdmdlci5rZXJuZWwu
b3JnOyBYaWUgU2hhb2h1aS1CMjE5ODk7DQo+IGNvcmJldEBsd24ubmV0OyBTaGFybWEgQmh1cGVz
aC1CNDUzNzA7IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyB3c2FAdGhlLQ0KPiBkcmVhbXMuZGU7
IHNib3lkQGNvZGVhdXJvcmEub3JnOyB3aW1AaWd1YW5hLmJlOyBTb25nIFdlbmJpbi1CNTM3NDc7
IFdvb2QNCj4gU2NvdHQtQjA3NDIxOyBIdSBNaW5na2FpLUIyMTI4NA0KPiBTdWJqZWN0OiBSRTog
W1BBVENIIDQvNl0gYXJtNjQvbHMxMDQzYTogYWRkIERUUyBmb3IgRnJlZXNjYWxlIExTMTA0M0Eg
U29DDQo+IA0KPiA+ID4NCj4gPiA+IEhpLA0KPiA+ID4NCj4gPiA+ID4gKy9tZW1yZXNlcnZlLyAw
eDgwMDAwMDAwIDB4MDAwMTAwMDA7DQo+ID4gPg0KPiA+ID4gV2h5IGlzIHRoaXMgbmVjZXNzYXJ5
Pw0KPiA+DQo+ID4gVGhpcyBtZW1vcnkgcmVnaW9uIGlzIHByZS1yZXNlcnZlZCBmb3IgdGhlIHNw
aW4tdGFibGUvcHNjaSwgYWx0aG91Z2gNCj4gPiBkaWRuJ3QgYWRkIEVuYWJsZSBtZXRob2Qgb2Yg
c2Vjb25kYXJ5IGNvcmVzLg0KPiANCj4gQ2FuIHRoaXMgYmUgcmVzZXJ2ZWQgYnkgYm9vdGxvYWRl
cj8NCg0KWWVzLCB0aGUgbWVtb3J5IGZvciBwc2NpIHdhcyByZXNlcnZlZCBieSB1LWJvb3QgY29k
ZS4gQnV0IGR1ZSB0byBzcGluLXRhYmxlDQpuZWVkIHRoZSByZWxlYXNlIGFkZHJlc3MsIGlzIGl0
IGJldHRlciBhZGRpbmcgdGhlIC9tZW1yZXNlcnZlLyBpbiBkdHMgZmlsZT8NCk9yIGFkZCBpdCBi
eSBib290bG9hZGVyIGFuZCBmaXggdGhlIHJlbGVhc2UgYWRkcmVzcyBhY2NvcmRpbmdseT8NCg0K
PiANCj4gPg0KPiA+ID4gSWYgdGhpcyBpcyBuZWNlc3NhcnksIHBsZWFzZSBhZGQgYSBjb21tZW50
IHN0YXRpbmcgd2hhdCB0aGlzIGlzIGZvci4NCj4gPiA+DQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICBjcHVAMyB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldmljZV90eXBlID0g
ImNwdSI7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXJt
LGNvcnRleC1hNTMiOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgw
IDB4Mz47DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmY2xvY2tn
ZW4gMSAwPjsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIH07DQo+ID4gPg0KPiA+ID4gTWlzc2lu
ZyBlbmFibGUtbWV0aG9kIHByb3BlcnRpZXMgb24gYWxsIHRoZSBzZWNvbmRhcnkgQ1BVcy4NCj4g
PiA+DQo+ID4NCj4gPiBUaGVyZSBhcmUgdHdvIG1ldGhvZHMgKHNwaW4tdGFibGUgYW5kIHBzY2kp
IHRvIGJyaW5nIHVwIHNlY29uZGFyeQ0KPiA+IGNvcmVzLCB3aGljaCBvbmUgZG8geW91IHRoaW5r
IGlzIGJldHRlcj8NCj4gDQo+IERvIHdlIGhhdmUgdGhlIFBTQ0kgc3VwcG9ydCByZWFkeSBpbiBi
b3RoIFVFRkkgYW5kIHUtYm9vdD8gIElmIG5vdCwgd2UNCj4gc2hvdWxkIHVzZSBzcGluLXRhYmxl
IGZvciBub3cuDQo+DQoNCm91ciBpbnRlcm5hbCB1LWJvb3Qgc3VwcG9ydHMgUFNDSSBidXQgb3Bl
bnNvdXJjZSBkb2Vzbid0IHN1cHBvcnQgaXQgZm9yIEFSTXY4Lg0KDQpUaGFua3MsDQpaaGlxaWFu
Zw0K
