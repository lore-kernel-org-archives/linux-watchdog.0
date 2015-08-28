Return-path: <Wenyou.Yang@atmel.com>
From: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
To: Guenter Roeck <linux@roeck-us.net>, "wim@iguana.be" <wim@iguana.be>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com"
	<pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>
CC: "sylvain.rochet@finsecur.com" <sylvain.rochet@finsecur.com>, "Ferre,
 Nicolas" <Nicolas.FERRE@atmel.com>, "boris.brezillon@free-electrons.com"
	<boris.brezillon@free-electrons.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH v6 1/2] drivers: watchdog: add a driver to support
 SAMA5D4 watchdog timer
Date: Fri, 28 Aug 2015 01:30:51 +0000
Message-ID: <B256D81BAE5131468A838E5D7A243641C9F967D2@penmbx01>
References: <1438856146-2459-1-git-send-email-wenyou.yang@atmel.com>
 <1438856206-2503-1-git-send-email-wenyou.yang@atmel.com>
 <55C4CDEB.9020505@roeck-us.net>
In-Reply-To: <55C4CDEB.9020505@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2VjayBb
bWFpbHRvOmxpbnV4QHJvZWNrLXVzLm5ldF0NCj4gU2VudDogMjAxNcTqONTCN8jVIDIzOjI2DQo+
IFRvOiBZYW5nLCBXZW55b3U7IHdpbUBpZ3VhbmEuYmU7IHJvYmgrZHRAa2VybmVsLm9yZzsgcGF3
ZWwubW9sbEBhcm0uY29tOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgaWpjK2RldmljZXRyZWVA
aGVsbGlvbi5vcmcudWs7IGdhbGFrQGNvZGVhdXJvcmEub3JnDQo+IENjOiBzeWx2YWluLnJvY2hl
dEBmaW5zZWN1ci5jb207IEZlcnJlLCBOaWNvbGFzOyBib3Jpcy5icmV6aWxsb25AZnJlZS0NCj4g
ZWxlY3Ryb25zLmNvbTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiB3YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2NiAxLzJdIGRyaXZlcnM6IHdhdGNoZG9nOiBhZGQgYSBkcml2ZXIg
dG8gc3VwcG9ydCBTQU1BNUQ0DQo+IHdhdGNoZG9nIHRpbWVyDQo+IA0KPiBPbiAwOC8wNi8yMDE1
IDAzOjE2IEFNLCBXZW55b3UgWWFuZyB3cm90ZToNCj4gPj5Gcm9tIFNBTUE1RDQsIHRoZSB3YXRj
aGRvZyB0aW1lciBpcyB1cGdyYXRlZCB3aXRoIGEgbmV3IGZlYXR1cmUsDQo+ID4gd2hpY2ggaXMg
ZGVzY3JpYmxlZCBhcyBpbiB0aGUgZGF0YXNoZWV0LCAiV0RUX01SIGNhbiBiZSB3cml0dGVuIHVu
dGlsDQo+ID4gYSBMT0NLTVIgY29tbWFuZCBpcyBpc3N1ZWQgaW4gV0RUX0NSIi4NCj4gPiBUaGF0
IGlzIHRvIHNheSwgYXMgbG9uZyBhcyB0aGUgYm9vdHN0cmFwIGFuZCB1LWJvb3QgZG9uJ3QgaXNz
dWUgYQ0KPiA+IExPQ0tNUiBjb21tYW5kLCBXRFRfTVIgY2FuIGJlIHdyaXR0ZW4gbW9yZSB0aGFu
IG9uY2UgaW4gdGhlIGRyaXZlci4NCj4gPg0KPiA+IFNvIHRoZSBTQU1BNUQ0IHdhdGNoZG9nIGRy
aXZlcidzIGltcGxlbWVudGF0aW9uIGlzIGRpZmZlcmVudCBmcm9tIHRoZQ0KPiA+IGF0OTFzYW05
MjYwIHdhdGNoZG9nIGRyaXZlciBpbXBsZW1lbnRlZCBpbiBmaWxlIGF0OTFzYW05X3dkdC5jLg0K
PiA+IFRoZSB1c2VyIGFwcGxpY2F0aW9uIG9wZW4gdGhlIGRldmljZSBmaWxlIHRvIGVuYWJsZSB0
aGUgd2F0Y2hkb2cgdGltZXINCj4gPiBoYXJkd2FyZSwgYW5kIGNsb3NlIHRvIGRpc2FibGUgaXQs
IGFuZCBzZXQgdGhlIHdhdGNoZG9nIHRpbWVyIHRpbWVvdXQNCj4gPiBieSBzZXRpbmcgV0RWIGFu
ZCBXREQgZmllbGRzIG9mIFdEVF9NUiByZWdpc3RlciwgYW5kIHBpbmcgdGhlIHdhdGNoZG9nDQo+
ID4gYnkgaXNzdWluZyBXRFJTVFQgY29tbWFuZCB0byBXRFRfQ1IgcmVnaXN0ZXIgd2l0aCBoYXJk
LWNvZGVkIGtleS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlbnlvdSBZYW5nIDx3ZW55b3Uu
eWFuZ0BhdG1lbC5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogR3VlbnRlciBSb2VjayA8bGludXhA
cm9lY2stdXMubmV0Pg0KDQpIaSBWaW0sDQoNCkNhbiB0aGlzIHBhdGNoIHNlcmllcyBiZSBtZXJn
ZWQ/IENvdWxkIHlvdSBwbGVhc2U/DQoNCkJlc3QgUmVnYXJkcywNCldlbnlvdSBZYW5nDQoNCg==
