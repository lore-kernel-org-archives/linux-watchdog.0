Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1on0134.outbound.protection.outlook.com ([157.56.110.134]:64486
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751380AbbJPCo3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Oct 2015 22:44:29 -0400
From: Hou Zhiqiang <B48286@freescale.com>
To: Guenter Roeck <linux@roeck-us.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC: "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"wsa@the-dreams.de" <wsa@the-dreams.de>,
	"wim@iguana.be" <wim@iguana.be>, "corbet@lwn.net" <corbet@lwn.net>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@codeaurora.org" <sboyd@codeaurora.org>,
	Hu Vincent <Mingkai.Hu@freescale.com>,
	Shaohui Xie <Shaohui.Xie@freescale.com>,
	"Scott Wood" <scottwood@freescale.com>,
	Sharma Bhupesh <bhupesh.sharma@freescale.com>,
	Wenbin Song <Wenbin.Song@freescale.com>
Subject: RE: [PATCH V4 2/6] watchdog: Add support for Freescale Layerscape
 platforms
Date: Fri, 16 Oct 2015 02:44:25 +0000
Message-ID: <CY1PR0301MB0780DF1B1E70E26836DD261A8B3D0@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1444911181-21696-1-git-send-email-B48286@freescale.com>
 <1444911181-21696-2-git-send-email-B48286@freescale.com>
 <561FB74F.5000302@roeck-us.net>
In-Reply-To: <561FB74F.5000302@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2VjayBb
bWFpbHRvOmxpbnV4QHJvZWNrLXVzLm5ldF0NCj4gU2VudDogMjAxNcTqMTDUwjE1yNUgMjI6MjUN
Cj4gVG86IEhvdSBaaGlxaWFuZy1CNDgyODY7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVhY29uQGFybS5jb207
IGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXdhdGNoZG9nQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGNsa0B2Z2VyLmtlcm5l
bC5vcmcNCj4gQ2M6IG1hcmsucnV0bGFuZEBhcm0uY29tOyB3c2FAdGhlLWRyZWFtcy5kZTsgd2lt
QGlndWFuYS5iZTsNCj4gY29yYmV0QGx3bi5uZXQ7IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBz
Ym95ZEBjb2RlYXVyb3JhLm9yZzsgSHUNCj4gTWluZ2thaS1CMjEyODQ7IFhpZSBTaGFvaHVpLUIy
MTk4OTsgV29vZCBTY290dC1CMDc0MjE7IFNoYXJtYSBCaHVwZXNoLQ0KPiBCNDUzNzA7IFNvbmcg
V2VuYmluLUI1Mzc0Nw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDIvNl0gd2F0Y2hkb2c6IEFk
ZCBzdXBwb3J0IGZvciBGcmVlc2NhbGUNCj4gTGF5ZXJzY2FwZSBwbGF0Zm9ybXMNCj4gDQo+IE9u
IDEwLzE1LzIwMTUgMDU6MTIgQU0sIFpoaXFpYW5nIEhvdSB3cm90ZToNCj4gPiBGcm9tOiBTaGFv
aHVpIFhpZSA8U2hhb2h1aS5YaWVAZnJlZXNjYWxlLmNvbT4NCj4gPg0KPiA+IE1vZGlmeSB3YXRj
aGRvZy9LY29uZmlnIGZpbGUgdG8gc3VwcG9ydCBMYXllcnNjYXBlIHBsYXRmb3Jtcy4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFNoYW9odWkgWGllIDxTaGFvaHVpLlhpZUBmcmVlc2NhbGUuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlbmJpbiBTb25nIDxXZW5iaW4uU29uZ0BmcmVlc2NhbGUu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8QjQ4Mjg2QGZyZWVzY2FsZS5j
b20+DQo+ID4gLS0tDQo+ID4gVGhpcyBwYXRjaCBoYXMgYmVlbiBhY2tlZCBpbiBWMyBieSBHdWVu
dGVyIFJvZWNrIFtsaW51eEByb2Vjay11cy5uZXRdLg0KPiA+DQo+IEhlcmUgaXQgaXMgYWdhaW4s
IGJ1dCBpZiB0aGVyZSBpcyBubyBjaGFuZ2UsIHBsZWFzZSBqdXN0IGFkZCB0aGUgQWNrIHRvDQo+
IHN1YnNlcXVlbnQgdmVyc2lvbnMgb2YgdGhlIHBhdGNoLg0KPiANCg0KT2ssIHRoYW5rcy4NCg0K
PiBBY2tlZC1ieTogR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pg0KPiANCj4gDQo+
ID4gVjQ6IFYzIFYyDQo+ID4gICAtIE5vIGNoYW5nZS4NCj4gPg0KPiA+ICAgZHJpdmVycy93YXRj
aGRvZy9LY29uZmlnIHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy93YXRjaGRvZy9L
Y29uZmlnIGIvZHJpdmVycy93YXRjaGRvZy9LY29uZmlnIGluZGV4DQo+ID4gNzllMWFhMS4uNDQ4
ZGJhZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3dhdGNoZG9nL0tjb25maWcNCj4gPiArKysg
Yi9kcml2ZXJzL3dhdGNoZG9nL0tjb25maWcNCj4gPiBAQCAtNDQ2LDcgKzQ0Niw3IEBAIGNvbmZp
ZyBNQVg2M1hYX1dBVENIRE9HDQo+ID4NCj4gPiAgIGNvbmZpZyBJTVgyX1dEVA0KPiA+ICAgCXRy
aXN0YXRlICJJTVgyKyBXYXRjaGRvZyINCj4gPiAtCWRlcGVuZHMgb24gQVJDSF9NWEMNCj4gPiAr
CWRlcGVuZHMgb24gQVJDSF9NWEMgfHwgQVJDSF9MQVlFUlNDQVBFDQo+ID4gICAJc2VsZWN0IFJF
R01BUF9NTUlPDQo+ID4gICAJc2VsZWN0IFdBVENIRE9HX0NPUkUNCj4gPiAgIAloZWxwDQo+ID4N
Cg0KVGhhbmtzLA0KWmhpcWlhbmcNCg==
