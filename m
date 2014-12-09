Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.117]:47826 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756643AbaLIMrI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Dec 2014 07:47:08 -0500
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <wsa@the-dreams.de>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>
CC: Support Opensource <Support.Opensource@diasemi.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lee Jones <lee.jones@linaro.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/4] DT: i2c: Add devices handled by the da9063 MFD
 driver
Date: Tue, 9 Dec 2014 12:40:16 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7D0B4C12B@SW-EX-MBX02.diasemi.com>
References: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
 <1418124169-7123-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1418124169-7123-3-git-send-email-geert+renesas@glider.be>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

T24gMDkgRGVjZW1iZXIgMjAxNCAxMToyMywgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlIA0KDQo+
IFN1YmplY3Q6IFtQQVRDSCAyLzRdIERUOiBpMmM6IEFkZCBkZXZpY2VzIGhhbmRsZWQgYnkgdGhl
IGRhOTA2MyBNRkQgZHJpdmVyDQo+IA0KPiBUaGlzIGFsbG93cyBjaGVja3BhdGNoIHRvIHZhbGlk
YXRlIG1vcmUgRFRTZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4g
PGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL3RyaXZp
YWwtZGV2aWNlcy50eHQgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMv
dHJpdmlhbC1kZXZpY2VzLnR4dA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9pMmMvdHJpdmlhbC1kZXZpY2VzLnR4dA0KPiBpbmRleCBlMGJlZWY0ZjhjZmY1Y2RmLi4zYmM0
ZWEzYzVjNDg0MmZmIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaTJjL3RyaXZpYWwtZGV2aWNlcy50eHQNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2kyYy90cml2aWFsLWRldmljZXMudHh0DQo+IEBAIC00Nyw2ICs0Nyw3
IEBAIGRhbGxhcyxkczMyMzIJCUV4dHJlbWVseSBBY2N1cmF0ZSBJwrJDIFJUQw0KPiB3aXRoIElu
dGVncmF0ZWQgQ3J5c3RhbCBhbmQgU1JBTQ0KPiAgZGFsbGFzLGRzNDUxMAkJQ1BVIFN1cGVydmlz
b3Igd2l0aCBOb252b2xhdGlsZSBNZW1vcnkgYW5kDQo+IFByb2dyYW1tYWJsZSBJL08NCj4gIGRh
bGxhcyxkczc1CQlEaWdpdGFsIFRoZXJtb21ldGVyIGFuZCBUaGVybW9zdGF0DQo+ICBkbGcsZGE5
MDUzCQlEQTkwNTM6IGZsZXhpYmxlIHN5c3RlbSBsZXZlbCBQTUlDIHdpdGggbXVsdGljb3JlDQo+
IHN1cHBvcnQNCj4gK2RsZyxkYTkwNjMJCURBOTA2Mzogc3lzdGVtIFBNSUMgZm9yIHF1YWQtY29y
ZSBhcHBsaWNhdGlvbg0KPiBwcm9jZXNzb3JzDQo+ICBlcHNvbixyeDgwMjUJCUhpZ2gtU3RhYmls
aXR5LiBJMkMtQnVzIElOVEVSRkFDRSBSRUFMIFRJTUUgQ0xPQ0sNCj4gTU9EVUxFDQo+ICBlcHNv
bixyeDg1ODEJCUkyQy1CVVMgSU5URVJGQUNFIFJFQUwgVElNRSBDTE9DSyBNT0RVTEUNCj4gIGZz
bCxtYWczMTEwCQlNQUczMTEwOiBYdHJpbnNpYyBIaWdoIEFjY3VyYWN5LCAzRCBNYWduZXRvbWV0
ZXINCg0KQWNrZWQtYnk6IFN0ZXZlIFR3aXNzIDxzdHdpc3Mub3BlbnNvdXJjZUBkaWFzZW1pLmNv
bT4NCg==
