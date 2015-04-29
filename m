Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.146]:18966 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753506AbbD2L05 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Apr 2015 07:26:57 -0400
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Lee Jones <lee.jones@linaro.org>,
	"Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
CC: DEVICETREE <devicetree@vger.kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"David Dajun Chen" <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	"Mark Brown" <broonie@kernel.org>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	"Samuel Ortiz" <sameo@linux.intel.com>,
	Support Opensource <Support.Opensource@diasemi.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: RE: [PATCH V1 6/6] devicetree: da9062: Add bindings for DA9062
 driver
Date: Wed, 29 Apr 2015 11:26:53 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B217AE3@SW-EX-MBX02.diasemi.com>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <94535acf974274822c5ac16d6427299778e11ccf.1429280614.git.stwiss.opensource@diasemi.com>
 <20150429105415.GX9169@x1>
In-Reply-To: <20150429105415.GX9169@x1>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

DQpPbiAyOSBBcHJpbCAyMDE1IDExOjU0IExlZSBKb25lcyB3cm90ZSA6DQoNCj4gT24gRnJpLCAx
NyBBcHIgMjAxNSwgUyBUd2lzcyB3cm90ZToNCj4gPiBGcm9tOiBTIFR3aXNzIDxzdHdpc3Mub3Bl
bnNvdXJjZUBkaWFzZW1pLmNvbT4NCj4gPg0KPiA+IEFkZCBkZXZpY2UgdHJlZSBiaW5kaW5ncyBm
b3IgdGhlIERBOTA2MiBkcml2ZXINCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZXZlIFR3aXNz
IDxzdHdpc3Mub3BlbnNvdXJjZUBkaWFzZW1pLmNvbT4NCj4gPg0KPiA+IC0tLQ0KPiA+DQo+ID4g
VGhpcyBwYXRjaCBhcHBsaWVzIGFnYWluc3QgbGludXgtbmV4dCBhbmQgdjQuMA0KPiA+DQo+ID4g
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvZGE5MDYyLnR4dCB8IDEwNw0K
PiArKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTA3IGluc2Vy
dGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZmQvZGE5MDYyLnR4dA0KPiANCj4gSSBkb24ndCBzZWUgYW55dGhpbmcgZ3Jv
dW5kYnJlYWtpbmcgb3Igb2ZmZW5zaXZlLg0KPiANCj4gQWNrZWQtYnk6IExlZSBKb25lcyA8bGVl
LmpvbmVzQGxpbmFyby5vcmc+DQo+IA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcgYW5kIEFj
ay4NCg0KSSBhbSBpbiB0aGUgcHJvY2VzcyBvZiB1cGRhdGluZyB0aGUgREE5MDYzIE9uS2V5IGRy
aXZlciBpbiBhIGRpZmZlcmVudCB0aHJlYWQuDQpUaGlzIGRyaXZlciBpcyBmdW5jdGlvbmFsbHkg
c2ltaWxhciB0byB0aGUgREE5MDYyIE9uS2V5IGRyaXZlciBhcyB3YXMgZGlzY3Vzc2VkIGluDQph
biBlYXJsaWVyIHRocmVhZCBmcm9tIERBOTA2My4NCg0KaHR0cDovL3d3dy5zcGluaWNzLm5ldC9s
aXN0cy9saW51eC1pbnB1dC9tc2czODEzNy5odG1sDQoNCkFsdGhvdWdoIHRoZSA2MyBhbmQgNjIg
Y2hpcHMgaGF2ZSBzZXF1ZW50aWFsIG51bWJlcnMgdGhleSBhcmUgbm90IHRoZSBzYW1lLA0KaG93
ZXZlciB0aGUgT25LZXkgZHJpdmVyIGlzIGZ1bmN0aW9uYWxseSB2ZXJ5IHNpbWlsYXIgYW5kIHNv
IEkgYW0gZ29pbmcgdG8gdHJ5IGFuZA0KbWVyZ2UgdGhlIGNvZGUgZm9yIGJvdGggZHJpdmVycyBp
biB0aGUgY2FzZSBvZiB0aGUgT25LZXkuDQoNCkR1ZSB0byB0aGUgREE5MDYzIGJlaW5nIGN1cnJl
bnRseSByZXZpZXdlZCwgcGVyaGFwcyBpdCB3b3VsZCBiZSBwcnVkZW50IG5vdA0KdG8gYWRkIHRo
aXMgZGV2aWNlIHRyZWUgYmluZGluZ3MgZm9yIERBOTA2MiB0byB0aGUga2VybmVsIGp1c3QgeWV0
IC0tIHRoZSBkZXZpY2UgdHJlZQ0KYmluZGluZ3MgY291bGQgY2hhbmdlIGZvciB0aGUgT25LZXkg
aW4gbXkgREE5MDYzIHN1Ym1pc3Npb24gYW5kIHRoaXMgd291bGQgYWZmZWN0DQp0aGUgREE5MDYy
IGRyaXZlciB3aGVuIEkgbWVyZ2UgdGhlIHR3byBPbktleSBkcml2ZXJzLg0KDQpJIHdpbGwgcHV0
IGEgZnVsbCB2ZXJzaW9uIGhpc3RvcnkgaW4gbXkgbmV4dCBwYXRjaCBzZXQgdG8gZGVzY3JpYmUg
d2hhdCBjaGFuZ2VzIEkgaGF2ZQ0KbWFkZSB0byB0aGlzIGZpbGUgc28gdGhpcyByZXZpZXcgaXMg
bm90IGRlZW1lZCBhIHdhc3RlZCBlZmZvcnQuDQoNClJlZ2FyZHMsDQpTdGV2ZQ0KDQpbLi4uXQ0K
DQoNCg==
