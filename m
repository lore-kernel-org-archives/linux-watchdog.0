Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5]:56243 "EHLO
	mail4.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbcCAHsO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Mar 2016 02:48:14 -0500
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
	<hidehiro.kawai.ez@hitachi.com>
To: "'Borislav Petkov'" <bp@alien8.de>
CC: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Corey Minyard <minyard@acm.org>,
	Michal Hocko <mhocko@suse.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
	Tejun Heo <tj@kernel.org>,
	"openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH 1/3] panic: Export panic_cpu and nmi_panic_self_stop
Date: Tue, 1 Mar 2016 07:48:10 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454B0661B@GSjpTKYDCembx31.service.hitachi.net>
References: <20160301015035.4318.78677.stgit@softrs>
 <20160301015037.4318.33155.stgit@softrs> <20160301072456.GA2997@nazgul.tnic>
In-Reply-To: <20160301072456.GA2997@nazgul.tnic>
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

SGkgQm9yaXNsYXYsDQoNCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IFttYWlsdG86YnBAYWxpZW44
LmRlXQ0KPiBPbiBUdWUsIE1hciAwMSwgMjAxNiBhdCAxMDo1MDozN0FNICswOTAwLCBIaWRlaGly
byBLYXdhaSB3cm90ZToNCj4gPiBFeHBvcnQgcGFuaWNfY3B1IGFuZCBubWlfcGFuaWNfc2VsZl9z
dG9wIHN5bWJvbHMgZm9yIG1vZHVsZXMgd2hpY2gNCj4gPiB1c2Ugbm1pX3BhbmljKCkgbWFjcm8u
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIaWRlaGlybyBLYXdhaSA8aGlkZWhpcm8ua2F3YWku
ZXpAaGl0YWNoaS5jb20+DQo+ID4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRh
dGlvbi5vcmc+DQo+ID4gQ2M6IEJvcmlzbGF2IFBldGtvdiA8YnBAc3VzZS5kZT4NCj4gPiBDYzog
VGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+ID4gQ2M6IE1pY2hhbCBIb2Nr
byA8bWhvY2tvQHN1c2UuY29tPg0KPiA+IENjOiBIQVRBWUFNQSBEYWlzdWtlIDxkLmhhdGF5YW1h
QGpwLmZ1aml0c3UuY29tPg0KPiA+IENjOiBWaXRhbHkgS3V6bmV0c292IDx2a3V6bmV0c0ByZWRo
YXQuY29tPg0KPiA+IENjOiBUZWp1biBIZW8gPHRqQGtlcm5lbC5vcmc+DQo+ID4gLS0tDQo+ID4g
IGtlcm5lbC9wYW5pYy5jIHwgICAgMiArKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL3BhbmljLmMgYi9rZXJuZWwvcGFu
aWMuYw0KPiA+IGluZGV4IGQ5NjQ2OWQuLmY0ZTgwMzUgMTAwNjQ0DQo+ID4gLS0tIGEva2VybmVs
L3BhbmljLmMNCj4gPiArKysgYi9rZXJuZWwvcGFuaWMuYw0KPiA+IEBAIC02OSw4ICs2OSwxMCBA
QCB2b2lkIF9fd2VhayBubWlfcGFuaWNfc2VsZl9zdG9wKHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0K
PiA+ICB7DQo+ID4gIAlwYW5pY19zbXBfc2VsZl9zdG9wKCk7DQo+ID4gIH0NCj4gPiArRVhQT1JU
X1NZTUJPTChubWlfcGFuaWNfc2VsZl9zdG9wKTsNCj4gPg0KPiA+ICBhdG9taWNfdCBwYW5pY19j
cHUgPSBBVE9NSUNfSU5JVChQQU5JQ19DUFVfSU5WQUxJRCk7DQo+ID4gK0VYUE9SVF9TWU1CT0wo
cGFuaWNfY3B1KTsNCj4gDQo+IENhbiB3ZSBtYWtlIG5taV9wYW5pYygpIGF0IGxlYXN0IGEgcHJv
cGVyIGZ1bmN0aW9uIGFuZCBleHBvcnQgdGhhdA0KPiBpbnN0ZWFkIG9mIGV4cG9ydGluZyBhbGwg
dGhvc2UgaW1wbGVtZW50YXRpb24gZGV0YWlscy4uLj8NCg0KVGhlIHJlYXNvbiBJIGltcGxlbWVu
dGVkIG5taV9wYW5pYygpIGFzIGEgbWFjcm8gaXMgdG8gcGFzcw0KdmFyaWFibGUgYXJndW1lbnRz
IGRpcmVjdGx5IHRvIHBhbmljKCkuICBGb3J0dW5hdGVseSwgc2luY2UgYWxsDQppbnZvY2F0aW9u
cyBvZiBubWlfcGFuaWMoKSBqdXN0IHBhc3MgYSBmaXhlZCBzdHJpbmcsIEkgY2FuIGNoYW5nZSBp
dA0KdG8gYSBub3JtYWwgZnVuY3Rpb24gbGlrZToNCg0KaW50IG5taV9wYW5pYyhzdHJ1Y3QgcHRf
cmVncyAqcmVncywgY29uc3QgY2hhciAqbXNnKQ0Kew0KLi4uDQoJcGFuaWMoIiVzIiwgbXNnKTsN
Cg0KSWYgcGVvcGxlIGRvbid0IG1pbmQgaWYgdGhhdCwgSSdsbCBjaGFuZ2UgaXQuDQoNClJlZ2Fy
ZHMsDQoNCi0tDQpIaWRlaGlybyBLYXdhaQ0KSGl0YWNoaSwgTHRkLiBSZXNlYXJjaCAmIERldmVs
b3BtZW50IEdyb3VwDQoNCg==
