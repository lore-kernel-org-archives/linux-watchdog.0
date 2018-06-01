Return-Path: <stwiss.opensource@diasemi.com>
Return-path: <stwiss.opensource@diasemi.com>
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Guenter Roeck <linux@roeck-us.net>, Marco Felsch <m.felsch@pengutronix.de>
CC: "wim@linux-watchdog.org" <wim@linux-watchdog.org>, Support Opensource
	<Support.Opensource@diasemi.com>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH v8 3/4] watchdog: da9063: Fix timeout handling during
 probe
Date: Fri, 1 Jun 2018 14:12:18 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB701941ACF54@SW-EX-MBX02.diasemi.com>
References: <20180524115101.17097-1-m.felsch@pengutronix.de>
 <20180524115101.17097-4-m.felsch@pengutronix.de>
 <20180524180744.GA13327@roeck-us.net>
 <20180525064454.x3yn2eq4xuxvdtza@pengutronix.de>
 <03553172-0d10-013e-5809-55d490dff8e5@roeck-us.net>
 <20180525130934.zimcqmdtpkijlz4r@pengutronix.de>
 <62e8397e-bb92-d0b9-04e5-ebb1838d1af9@roeck-us.net>
 <20180525214157.GA12107@pengutronix.de> <20180525224230.GA4632@roeck-us.net>
 <20180526173934.GA12799@pengutronix.de>
 <a47d1a46-8675-5db3-b142-05ce16c78848@roeck-us.net>
In-Reply-To: <a47d1a46-8675-5db3-b142-05ce16c78848@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

T24gMjcgTWF5IDIwMTggMDA6MTIgR3VlbnRlciBSb2VjayB3cm90ZToNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2OCAzLzRdIHdhdGNoZG9nOiBkYTkwNjM6IEZpeCB0aW1lb3V0IGhhbmRsaW5nIGR1
cmluZyBwcm9iZQ0KPiANCj4gT24gMDUvMjYvMjAxOCAxMDozOSBBTSwgTWFyY28gRmVsc2NoIHdy
b3RlOg0KPiANCj4gPg0KPiA+IFllcywgSSd2ZSB0b3VnaHQgYWJvdXQgdGhpcyBhcHByb2FjaCB0
b28uIEFueXdheSwgaXMgaXQgb2theSB0byBzcGxpdA0KPiA+IHRoZSBzZXJpZXMgaW50byBhICJm
aXhlcyIgc2VyaWVzIGFuZCBhICJpbXByb3ZtZW50IiBzZXJpZXM/IEkgdGhpbmsgd2UNCj4gDQo+
IFllcw0KPiANCj4gPiBsb3Npbmcgc2lnaHQgb2YgdGhlIGluaXRpYWwgcHJvYmxlbSAiQ2hhbmdl
IHRoZSB0aW1lb3V0IHZhbHVlIG1vcmUgdGhhbg0KPiA+IG9uY2UuIiBBIG5leHQgaW1wcm92bWVu
dCBjb3VsZCBiZSB0byBzcXVhc2ggdGhlIGRhOTA2Mi8xIGFuZCBkYTkwNjMgaW50bw0KPiA+IG9u
ZSBpZiB0aGlzIGlzIHBvc3NpYmxlLg0KPiA+DQo+IFN1cmUuIE5leHQgc3RlcCwgdGhvdWdoLg0K
PiANCg0KVGhlcmUgaXMgYSBkaWZmZXJlbmNlIGJldHdlZW4gdGhlIHdhdGNoZG9nIElQIG9uIHRo
ZSBkYTkwNjIvNjEgYW5kIHRoYXQgb24NCnRoZSBkYTkwNjMuIFR5cGljYWxseSBob3dldmVyLCBh
bHRob3VnaCB0aGVyZSBpcyBhIGRpZmZlcmVuY2UgaW4gdGhlIElQIHRoZXJlIGlzDQpub3QgbXVj
aCBkaWZmZXJlbmNlIGJldHdlZW4gdGhlIGRyaXZlciBpbXBsZW1lbnRhdGlvbiAtLSBhdCB0aGUg
bW9tZW50Lg0KDQpJIGRpZCBzdWdnZXN0IHRoZXJlIHdvdWxkIGJlIGFuIGFkZGl0aW9uIHRvIHRo
ZSBkYTkwNjIvNjEgZGV2aWNlIGRyaXZlciB0bw0KaW5jbHVkZSB0aGUgbmV3IElQIGFuZCBkaWZm
ZXJlbnRpYXRlIGl0LCBidXQgSSBoYXZlIG5vdCBoYWQgdGltZSB0byByZWFjaCB0aGF0DQpwb2lu
dCB5ZXQuDQoNClJlZ2FyZHMsDQpTdGV2ZQ0K
