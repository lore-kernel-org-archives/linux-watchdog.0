Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:29384 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727609AbeIFRUG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Sep 2018 13:20:06 -0400
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: RE: [PATCH] watchdog: rza_wdt: Extend clock sources for RZ/A2
Date: Thu, 6 Sep 2018 12:44:42 +0000
Message-ID:
 <TY1PR01MB15628F6B1EE72F7CCB4307938A010@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20180905173743.47938-1-chris.brandt@renesas.com>
 <CAMuHMdUK7OSYwE85F-1Pw4gQfDR9JJ5-_cPCk=BRiV5pzt=DCw@mail.gmail.com>
In-Reply-To: <CAMuHMdUK7OSYwE85F-1Pw4gQfDR9JJ5-_cPCk=BRiV5pzt=DCw@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Message-ID: <20180906124442.Ox0KukL_zPV-N7h11hx_rt7eMa_rzR2YSKPj2UpC5Nk@z>

SGkgR2VlcnQsDQoNCk9uIFRodXJzZGF5LCBTZXB0ZW1iZXIgMDYsIDIwMTgsIEdlZXJ0IFV5dHRl
cmhvZXZlbiB3cm90ZToNCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KDQpUaGFuayB5b3UgZm9y
IHlvdXIgcmV2aWV3Lg0KDQo+ICJ0aW1lb3V0ICogcmF0ZSIgbWF5IG92ZXJmbG93DQo+IERJVl9S
T1VORF9VUCgpPw0KT0suDQoNCj4gPiArICAgICAgIHByX2RlYnVnKCIlczogdGltZW91dCBzZXQg
dG8gJWQgKFdUQ05UPSVkKVxuIiwgX19mdW5jX18sDQo+IA0KPiAldSBmb3IgdW5zaWduZWQuDQpP
Sy4NCg0KDQo+ID4gKyAgICAgICBpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUobnAsICJyZW5l
c2FzLHI3czkyMTAtd2R0IikpDQo+ID4gKyAgICAgICAgICAgICAgIHByaXYtPmV4dF9ja3MgPSB0
cnVlOw0KPiANCj4gVGhhdCdzIG5vdCB0aGUgcHJvcGVyIHdheSB0byBzdXBwb3J0IG11bHRpcGxl
IGRldmljZXMuDQo+IFBsZWFzZSBhZGQgYW4gZW50cnkgZm9yICJyZW5lc2FzLHI3czkyMTAtd2R0
IiB0byByemFfd2R0X29mX21hdGNoW10uDQo+ICJyZW5lc2FzLHI3czkyMTAtd2R0IiBtdXN0IGJl
IGRvY3VtZW50ZWQgaW4gdGhlIERUIGJpbmRpbmdzLg0KPiANCj4gSSBzdWdnZXN0IHN0b3Jpbmcg
Y2tzIGluIHJ6YV93ZHRfb2ZfbWF0Y2hbXS5kYXRhLCBhbmQgcmV0cmlldmluZyBpdCB3aXRoDQo+
IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgpIGluIHlvdXIgcHJvYmUgZnVuY3Rpb24sIHNvIHlv
dSBjYW4gdXNlIHRoYXQgdG8NCj4gZGlmZmVyZW50aWF0ZSwgDQoNCk9LLCBJIHdpbGwgY2hhbmdl
IHRvIHRoYXQuDQoNCj4gYW5kIGdldCByaWQgb2YgdGhlIGV4dF9ja3MgZmxhZy4NCg0KSSBzdGls
bCBuZWVkIHRvIGtlZXAgdHJhY2sgaWYgaXQncyBhIFJaL0ExIG9yIFJaL0EyIChleHRfY2tzKSBm
b3IgDQpmdW5jdGlvbnMgb3V0c2lkZSBvZiBwcm9iZSAocnphX3dkdF9jYWxjX3RpbWVvdXQpLg0K
DQo+IEJUVywgaXMgdGhlIFJaL0EyIFdEVCBjb21wYXRpYmxlIHdpdGggdGhlIFJaL0ExIFdEVCwg
aS5lLiBkb2VzIGl0IHdvcmsNCj4gd2l0aCB0aGUgdW5tb2RpZmllZCBkcml2ZXI/IElmIG5vdCwg
InJlbmVzYXMscnphLXdkdCIgbXVzdCBub3QgYmUgdXNlZCBhcw0KPiBhDQo+IGZhbGxiYWNrLg0K
DQpJIHdvdWxkIHNheSBpdCBpcyBub3QsIGJlY2F1c2UgdGhlIGRpdmlkZXJzIGFyZSBkaWZmZXJl
bnQgKG1lYW5pbmcgdGhlIA0KY2FsY3VsYXRlZCB0aW1lb3V0cyB3b3VsZCBub3QgYmUgY29ycmVj
dCkuDQoNClRoYW5rcywNCkNocmlzDQoNCg==
