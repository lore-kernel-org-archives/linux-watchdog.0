Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:19970 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932503AbeB1Rhu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Feb 2018 12:37:50 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [PATCH v5 01/26] ARM: shmobile: Add watchdog support
Date: Wed, 28 Feb 2018 17:37:39 +0000
Message-ID: <TY1PR06MB089598E10BB2D1719BD05C7AC0C70@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1518457475-4480-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdUx3A_8MeZmrwiBRqUS0oGjwrg13fy1QMsA2SUw+dR0Hg@mail.gmail.com>
In-Reply-To: <CAMuHMdUx3A_8MeZmrwiBRqUS0oGjwrg13fy1QMsA2SUw+dR0Hg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

SGkgR2VlcnQsDQoNCnRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayENCg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHY1IDAxLzI2XSBBUk06IHNobW9iaWxlOiBBZGQgd2F0Y2hkb2cgc3VwcG9ydA0K
Pg0KPiBIaSBGYWJyaXppbywNCj4NCj4gT24gTW9uLCBGZWIgMTIsIDIwMTggYXQgNjo0NCBQTSwg
RmFicml6aW8gQ2FzdHJvDQo+IDxmYWJyaXppby5jYXN0cm9AYnAucmVuZXNhcy5jb20+IHdyb3Rl
Og0KPiA+IE9uIFItQ2FyIEdlbjIgYW5kIFJaL0cxIHBsYXRmb3Jtcywgd2UgdXNlIHRoZSBTQkFS
IHJlZ2lzdGVycyB0byBtYWtlIG5vbg0KPiA+IGJvb3QgQ1BVcyBydW4gYSByb3V0aW5lIGRlc2ln
bmVkIHRvIGJyaW5nIHVwIFNNUCBhbmQgZGVhbCB3aXRoIGhvdCBwbHVnLg0KPiA+IFRoZSB2YWx1
ZSBjb250YWluZWQgaW4gdGhlIFNCQVIgcmVnaXN0ZXJzIGlzIG5vdCBpbml0aWFsaXplZCBieSBh
IFdEVA0KPiA+IHRyaWdnZXJlZCByZXNldCwgd2hpY2ggbWVhbnMgdGhhdCBhZnRlciBhIFdEVCB0
cmlnZ2VyZWQgcmVzZXQgd2UganVtcA0KPiA+IHRvIHRoZSBTTVAgYnJpbmcgdXAgcm91dGluZSwg
cHJldmVudGluZyB0aGUgc3lzdGVtIGZyb20gZXhlY3V0aW5nIHRoZQ0KPiA+IGJvb3Ryb20gY29k
ZS4NCj4gPg0KPiA+IFRoZSBwdXJwb3NlIG9mIHRoaXMgcGF0Y2ggaXMgdG8ganVtcCB0byB0aGUg
Ym9vdHJvbSBjb2RlIGluIGNhc2Ugb2YgYQ0KPiA+IFdEVCB0cmlnZ2VyZWQgcmVzZXQsIGFuZCBr
ZWVwIHRoZSBTTVAgZnVuY3Rpb25hbGl0eSB1bnRvdWNoZWQuDQo+ID4gSW4gb3JkZXIgdG8gdGVs
bCBpZiB0aGUgY29kZSBoYWQgYmVlbiBjYWxsZWQgZHVlIHRvIHRoZSBXRFQgb3ZlcmZsb3dpbmcN
Cj4gPiB3ZSBhcmUgdGVzdGluZyBXT1ZGIGZyb20gcmVnaXN0ZXIgUldUQ1NSQS4NCj4gPg0KPiA+
IFRoZSBuZXcgZnVuY3Rpb24gc2htb2JpbGVfYm9vdF92ZWN0b3JfZ2VuMiBpc24ndCByZXBsYWNp
bmcNCj4gPiBzaG1vYmlsZV9ib290X3ZlY3RvciBmb3IgYmFja3dhcmQgY29tcGF0aWJpbGl0eSBy
ZWFzb25zLiBUaGUga2VybmVsDQo+ID4gd2lsbCBpbnN0YWxsIHRoZSBiZXN0IG9wdGlvbiAoZWl0
aGVyIHNobW9iaWxlX2Jvb3RfdmVjdG9yIG9yDQo+ID4gc2htb2JpbGVfYm9vdF92ZWN0b3JfZ2Vu
MikgdG8gSUNSQU0xIGFmdGVyIHBhcnNpbmcgdGhlIGRldmljZSB0cmVlLA0KPiA+IGFjY29yZGlu
ZyB0byB0aGUgYW1vdW50IG9mIG1lbW9yeSBhdmFpbGFibGUuDQo+ID4NCj4gPiBTaW5jZSBzaG1v
YmlsZV9ib290X3ZlY3RvciBoYXMgYmVjb21lIGJpZ2dlciwgInJlZyIgcHJvcGVydHkgb2Ygbm9k
ZXMNCj4gPiBjb21wYXRpYmxlIHdpdGggInJlbmVzYXMsc21wLXNyYW0iIG5vdyBuZWVkIHRvIGJl
IHNldCB0byBhIHZhbHVlDQo+ID4gZ3JlYXRlciBvciBlcXVhbCB0byAiPDAgMHg2MD4iLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm9AYnAu
cmVuZXNhcy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmFtZXNoIFNoYW5tdWdhc3VuZGFyYW0g
PHJhbWVzaC5zaGFubXVnYXN1bmRhcmFtQGJwLnJlbmVzYXMuY29tPg0KPg0KPiA+IC0tLSBhL2Fy
Y2gvYXJtL21hY2gtc2htb2JpbGUvY29tbW9uLmgNCj4gPiArKysgYi9hcmNoL2FybS9tYWNoLXNo
bW9iaWxlL2NvbW1vbi5oDQo+ID4gQEAgLTcsNiArNywxMiBAQCBleHRlcm4gdm9pZCBzaG1vYmls
ZV9pbml0X2RlbGF5KHZvaWQpOw0KPiA+ICBleHRlcm4gdm9pZCBzaG1vYmlsZV9ib290X3ZlY3Rv
cih2b2lkKTsNCj4gPiAgZXh0ZXJuIHVuc2lnbmVkIGxvbmcgc2htb2JpbGVfYm9vdF9mbjsNCj4g
PiAgZXh0ZXJuIHVuc2lnbmVkIGxvbmcgc2htb2JpbGVfYm9vdF9zaXplOw0KPiA+ICsjaWZkZWYg
Q09ORklHX0FSQ0hfUkNBUl9HRU4yDQo+DQo+IEkgdGhpbmsgdGhpcyAjaWZkZWYgY2FuIGJlIHJl
bW92ZWQuDQoNCkknbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2ggd2l0aG91dCBp
ZmRlZnMuDQoNClRoYW5rcywNCkZhYg0KDQo+DQo+ID4gK2V4dGVybiB2b2lkIHNobW9iaWxlX2Jv
b3RfdmVjdG9yX2dlbjIodm9pZCk7DQo+ID4gK2V4dGVybiB1bnNpZ25lZCBsb25nIHNobW9iaWxl
X2Jvb3RfZm5fZ2VuMjsNCj4gPiArZXh0ZXJuIHVuc2lnbmVkIGxvbmcgc2htb2JpbGVfYm9vdF9j
cHVfZ2VuMjsNCj4gPiArZXh0ZXJuIHVuc2lnbmVkIGxvbmcgc2htb2JpbGVfYm9vdF9zaXplX2dl
bjI7DQo+ID4gKyNlbmRpZiAvKiBDT05GSUdfQVJDSF9SQ0FSX0dFTjIgKi8NCj4gPiAgZXh0ZXJu
IHZvaWQgc2htb2JpbGVfc21wX2Jvb3Qodm9pZCk7DQo+ID4gIGV4dGVybiB2b2lkIHNobW9iaWxl
X3NtcF9zbGVlcCh2b2lkKTsNCj4gPiAgZXh0ZXJuIHZvaWQgc2htb2JpbGVfc21wX2hvb2sodW5z
aWduZWQgaW50IGNwdSwgdW5zaWduZWQgbG9uZyBmbiwNCj4NCj4gQXBhcnQgZnJvbSB0aGF0Og0K
PiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5i
ZT4NCj4NCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IEdlZXJ0DQo+DQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2Yg
TGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcNCj4NCj4gSW4gcGVyc29u
YWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBo
YWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkg
InByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg0KDQoNClJlbmVzYXMgRWxlY3Ryb25p
Y3MgRXVyb3BlIEx0ZCwgRHVrZXMgTWVhZG93LCBNaWxsYm9hcmQgUm9hZCwgQm91cm5lIEVuZCwg
QnVja2luZ2hhbXNoaXJlLCBTTDggNUZILCBVSy4gUmVnaXN0ZXJlZCBpbiBFbmdsYW5kICYgV2Fs
ZXMgdW5kZXIgUmVnaXN0ZXJlZCBOby4gMDQ1ODY3MDkuDQo=
