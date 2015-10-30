Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2on0124.outbound.protection.outlook.com ([65.55.169.124]:22676
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757561AbbJ3CcA (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 29 Oct 2015 22:32:00 -0400
From: Hou Zhiqiang <B48286@freescale.com>
To: Li Leo <LeoLi@freescale.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Shaohui Xie <Shaohui.Xie@freescale.com>,
	"Jonathan Corbet" <corbet@lwn.net>,
	Sharma Bhupesh <bhupesh.sharma@freescale.com>,
	Michael Turquette <mturquette@baylibre.com>,
	"wsa@the-dreams.de" <wsa@the-dreams.de>,
	"sboyd@codeaurora.org" <sboyd@codeaurora.org>,
	"wim@iguana.be" <wim@iguana.be>,
	Wenbin Song <Wenbin.Song@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Hu Vincent <Mingkai.Hu@freescale.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>
Subject: RE: [PATCH V6 6/6] dts/ls1043a: add LS1043ARDB board support
Date: Fri, 30 Oct 2015 02:31:56 +0000
Message-ID: <CY1PR0301MB0780F778204F6D8A393B5BB38B2F0@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1445587282-29529-1-git-send-email-B48286@freescale.com>
	<1445587282-29529-6-git-send-email-B48286@freescale.com>
 <CADRPPNRKXDAQHijZtJOYo9wMPaciJnoQYhR1UWRgFGUXY=iAMg@mail.gmail.com>
In-Reply-To: <CADRPPNRKXDAQHijZtJOYo9wMPaciJnoQYhR1UWRgFGUXY=iAMg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcGt1Lmxlb0BnbWFpbC5j
b20gW21haWx0bzpwa3UubGVvQGdtYWlsLmNvbV0gT24gQmVoYWxmIE9mIExpIFlhbmcNCj4gU2Vu
dDogMjAxNeW5tDEw5pyIMzDml6UgNDozMw0KPiBUbzogSG91IFpoaXFpYW5nLUI0ODI4Ng0KPiBD
YzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBDYXRhbGluIE1hcmluYXM7
IFdpbGwgRGVhY29uOw0KPiBsaW51eC1pMmNAdmdlci5rZXJuZWwub3JnOyBsaW51eC13YXRjaGRv
Z0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBkb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1j
bGtAdmdlci5rZXJuZWwub3JnOyBNYXJrIFJ1dGxhbmQ7IFhpZQ0KPiBTaGFvaHVpLUIyMTk4OTsg
Sm9uYXRoYW4gQ29yYmV0OyBTaGFybWEgQmh1cGVzaC1CNDUzNzA7IE1pY2hhZWwgVHVycXVldHRl
Ow0KPiB3c2FAdGhlLWRyZWFtcy5kZTsgc2JveWRAY29kZWF1cm9yYS5vcmc7IHdpbUBpZ3VhbmEu
YmU7IFNvbmcgV2VuYmluLQ0KPiBCNTM3NDc7IFdvb2QgU2NvdHQtQjA3NDIxOyBIdSBNaW5na2Fp
LUIyMTI4NDsgbGludXhAcm9lY2stdXMubmV0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjYgNi82
XSBkdHMvbHMxMDQzYTogYWRkIExTMTA0M0FSREIgYm9hcmQgc3VwcG9ydA0KPiANCj4gT24gRnJp
LCBPY3QgMjMsIDIwMTUgYXQgMzowMSBBTSwgWmhpcWlhbmcgSG91IDxCNDgyODZAZnJlZXNjYWxl
LmNvbT4NCj4gd3JvdGU6DQo+ID4gRnJvbTogU2hhb2h1aSBYaWUgPFNoYW9odWkuWGllQGZyZWVz
Y2FsZS5jb20+DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFvaHVpIFhpZSA8U2hhb2h1aS5Y
aWVAZnJlZXNjYWxlLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaW5na2FpIEh1IDxNaW5na2Fp
Lkh1QGZyZWVzY2FsZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VuYmluIFNvbmcgPFdlbmJp
bi5Tb25nQGZyZWVzY2FsZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxC
NDgyODZAZnJlZXNjYWxlLmNvbT4NCj4gPiAtLS0NCj4gPiBWNjogVjUgVjQgVjMNCj4gPiAgLSBO
byBjaGFuZ2UuDQo+ID4NCj4gPiBWMjoNCj4gPiAgLSBSZW1vdmUgdGhlIHVzZWxlc3MgY29tcGF0
aWJsZSAic2ltcGxlLWJ1cyIgZnJvbSBjcGxkIG5vZGUuDQo+ID4NCj4gPiAgYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvTWFrZWZpbGUgICAgICAgICAgICB8ICAgMiArLQ0KPiA+ICBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQzYS1yZGIuZHRzIHwgMTE2DQo+ID4g
KysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDExNyBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBhcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQzYS1yZGIuZHRzDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvTWFrZWZpbGUNCj4gPiBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlDQo+ID4gaW5kZXggNTdiNDFjNy4uMzNi
MWU1NyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9NYWtl
ZmlsZQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlDQo+
ID4gQEAgLTEsNCArMSw0IEBADQo+ID4gLWR0Yi0kKENPTkZJR19BUkNIX0xBWUVSU0NBUEUpICs9
IGZzbC1sczIwODBhLXFkcy5kdGINCj4gPiBmc2wtbHMyMDgwYS1yZGIuZHRiIGZzbC1sczIwODBh
LXNpbXUuZHRiDQo+ID4gK2R0Yi0kKENPTkZJR19BUkNIX0xBWUVSU0NBUEUpICs9IGZzbC1sczIw
ODBhLXFkcy5kdGINCj4gPiArZnNsLWxzMjA4MGEtcmRiLmR0YiBmc2wtbHMyMDgwYS1zaW11LmR0
YiBmc2wtbHMxMDQzYS1yZGIuZHRiDQo+IA0KPiBJIHRyaWVkIHRvIGFwcGx5IHRoZSBwYXRjaCwg
YnV0IGl0IGNhbiBub3QgYmUgYXBwbGllZCBkdWUgdG8gdGhlIGNoYW5nZQ0KPiBmcm9tIGEgZGVw
ZW5kaW5nIGxzMjA4MCBwYXRjaC4gIEkgd2lsbCBoZWxwIHRvIHJlc3BpbiB0aGlzIHBhdGNoIGFu
ZA0KPiByZXNlbmQgdGhlIHRocmVlIGRldmljZSB0cmVlIHJlbGF0ZWQgcGF0Y2hlcy4NCg0Kb2su
DQoNClRoYW5rcywNClpoaXFpYW5nDQo=
