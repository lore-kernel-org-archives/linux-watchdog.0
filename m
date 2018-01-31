Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:9345 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752329AbeAaN66 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 Jan 2018 08:58:58 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will.deacon@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [RFC v3 11/25] watchdog: renesas_wdt: Add R-Car Gen2 support
Date: Wed, 31 Jan 2018 13:58:48 +0000
Message-ID: <TY1PR06MB0895F841A62728EF7C9F7BABC0FB0@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517343778-27902-12-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180130220504.GA16709@roeck-us.net>
 <TY1PR06MB0895ECB2936323F9D281C1EFC0FB0@TY1PR06MB0895.apcprd06.prod.outlook.com>
 <CAMuHMdViQgCjVFbs0kkBObAAoFTzvz8yPFUHPWHrtYzkbnYm_g@mail.gmail.com>
In-Reply-To: <CAMuHMdViQgCjVFbs0kkBObAAoFTzvz8yPFUHPWHrtYzkbnYm_g@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

SGkgR2VlcnQsDQoNCnRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayENCg0KPiBTdWJqZWN0OiBS
ZTogW1JGQyB2MyAxMS8yNV0gd2F0Y2hkb2c6IHJlbmVzYXNfd2R0OiBBZGQgUi1DYXIgR2VuMiBz
dXBwb3J0DQo+DQo+IEhpIEZhYnJpemlvLA0KPg0KPiBPbiBXZWQsIEphbiAzMSwgMjAxOCBhdCAx
MTo0NyBBTSwgRmFicml6aW8gQ2FzdHJvDQo+IDxmYWJyaXppby5jYXN0cm9AYnAucmVuZXNhcy5j
b20+IHdyb3RlOg0KPiA+PiBTdWJqZWN0OiBSZTogW1JGQyB2MyAxMS8yNV0gd2F0Y2hkb2c6IHJl
bmVzYXNfd2R0OiBBZGQgUi1DYXIgR2VuMiBzdXBwb3J0DQo+ID4+IE9uIFR1ZSwgSmFuIDMwLCAy
MDE4IGF0IDA4OjIyOjQ0UE0gKzAwMDAsIEZhYnJpemlvIENhc3RybyB3cm90ZToNCj4gPj4gPiBP
biBSLUNhciBHZW4yIGFuZCBSWi9HMSB0aGUgcndkdCBjbG9jayBuZWVkcyB0byBiZSBhbHdheXMg
T04sIHRoZXJlZm9yZQ0KPiA+PiA+IHdoZW4gc3VzcGVuZGluZyB0byBSQU0gd2UgbmVlZCB0byBl
eHBsaWNpdGx5IGRpc2FibGUgdGhlIGNvdW50aW5nIGJ5DQo+ID4+ID4gY2xlYXJpbmcgVE1FIGZy
b20gUldUQ1NSQS4NCj4gPj4gPiBBbHNvLCBvbiBzb21lIHN5c3RlbXMgUldEVCBpcyB0aGUgb25s
eSBwaWVjZSBvZiBIVyB0aGF0IGFsbG93cyB0aGUgU29DDQo+ID4+ID4gdG8gYmUgcmVzdGFydGVk
LCB0aGVyZWZvcmUgdGhpcyBwYXRjaCBpbXBsZW1lbnRzIHRoZSByZXN0YXJ0IGNhbGxiYWNrLg0K
PiA+PiA+DQo+ID4+ID4gU2lnbmVkLW9mZi1ieTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5j
YXN0cm9AYnAucmVuZXNhcy5jb20+DQo+ID4+ID4gU2lnbmVkLW9mZi1ieTogUmFtZXNoIFNoYW5t
dWdhc3VuZGFyYW0gPHJhbWVzaC5zaGFubXVnYXN1bmRhcmFtQGJwLnJlbmVzYXMuY29tPg0KPiA+
PiA+IC0tLQ0KPiA+PiA+IFdvbGZyYW0sIHdhcyB0aGUgcmVzdGFydCBjYWxsYmFjayBpbXBsZW1l
bnRhdGlvbiBtaXNzaW5nIGZvciBhIHJlYXNvbj8NCj4gPj4gPiBJcyBpdHMgaW1wbGVtZW50YXRp
b24gZ29pbmcgdG8gYnJlYWsgYW55IEdlbjMgcGxhdGZvcm0/DQo+ID4+DQo+ID4+IFRoZSBjaGFu
Z2VzIGNsZWFybHkgYXJlIHdheSBtb3JlIHRoYW4gY2xhaW1lZCBpbiB0aGUgc3ViamVjdC4gQWRk
aW5nDQo+ID4+IHJlc3RhcnQgaGFuZGxlciBhbmQgUE0gc3VwcG9ydCBtYXkgYmUgcHJlcmVxdWlz
aXRlcyBmb3IgR2VuMiwgYnV0IHRoZQ0KPiA+PiBjaGFuZ2VzIGFwcGx5IHRvIEdlbjMgYXMgd2Vs
bC4gV2hhdCBoYXBwZW5lZCB0byAib25lIHBhdGNoIHBlciBsb2dpY2FsDQo+ID4+IGNoYW5nZSIg
Pw0KPiA+DQo+ID4gVGhlIFBNIGltcGxlbWVudGF0aW9uIHNob3VsZCBiZSBvayBmb3IgR2VuMyB0
b28sIHdpdGhvdXQgdGhpcyBwYXRjaCBzZXJpZXMgdGhlIGtlcm5lbA0KPiA+IHdvdWxkIGRpc2Fi
bGUgdGhlIHJ3ZHQgY2xvY2sgd2hlbiBzdXNwZW5kaW5nIHRvIFJBTSwgdGhpcyB3b3VsZCAicGF1
c2UiIHRoZSBjb3VudGluZy4NCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBkZWNsYXJlcyB0aGUgcndk
dCBjbG9jayBhcyBjcml0aWNhbCBmb3IgR2VuMiBhbmQgUlovRzEsIHdoaWNoIG1lYW5zIHdlDQo+
ID4gbmVlZCB0byBleHBsaWNpdGx5IGRpc2FibGUgdGhlIGNvdW50aW5nIHRvIGtlZXAgdGhlIHNh
bWUgYmVoYXZpb3VyIGluIHBsYWNlLg0KPg0KPiBOb3RlIHRoYXQgaWYgdGhlIGtlcm5lbCBjcmFz
aGVzIGFmdGVyIHJ3ZHRfc3VzcGVuZCgpLCB0aGUgd2F0Y2hkb2cgd29uJ3QNCj4gcmVzdGFydCB0
aGUgc3lzdGVtLiBCdXQgdGhhdCdzIGFuIGlzc3VlIGNvbW1vbiB0byBtYW55IHdhdGNoZG9nIGRy
aXZlciwgcmlnaHQ/DQoNCnllYWgsIHRoZXJlIGlzbid0IG11Y2ggd2UgY2FuIGRvIGFib3V0IHRo
aXMuIEV2ZW4gd2l0aG91dCByd2R0X3N1c3BlbmQgaW4gcGxhY2UsIGlmIHRoZQ0Ka2VybmVsIGNy
YXNoZXMgYWZ0ZXIgZGlzYWJsaW5nIHRoZSByd2R0IGNsb2NrIHRoZSB3YXRjaGRvZyB3b24ndCBy
ZXN0YXJ0IHRoZSBzeXN0ZW0uDQoNCj4NCj4gPiBXaXRoIHJlc3BlY3QgdG8gdGhlIHJlc3RhcnQg
Y2FsbGJhY2sgaW1wbGVtZW50YXRpb24sIHRoYXQgbWF5IHdlbGwgaGF2ZSBjb25zZXF1ZW5jZXMg
b24NCj4gPiBHZW4zLCBob3BlZnVsbHkgV29sZnJhbSB3aWxsIGdpdmUgdXMgYSBmZWVkYmFjayBv
biB0aGlzLg0KPiA+IEluIHBhcnRpY3VsYXIgSSB3b3VsZCBsaWtlIHRvIGtub3cgaWYgd2Ugc2hv
dWxkIGJlIGluc3RhbGxpbmcgdGhlIHJlc3RhcnQgY2FsbGJhY2sgb25seSB3aGVuDQo+ID4gd2Ug
dXNlICJyZW5lc2FzLHJjYXItZ2VuMi13ZHQiIGFzIGNvbXBhdGlibGUgc3RyaW5nLCBvciBpdCdz
IG9rIHRvIG1ha2UgaXQgYXZhaWxhYmxlIGZvcg0KPiA+IEdlbjMgYXMgd2VsbC4NCj4NCj4gSUlS
QywgdGhlIHJlYXNvbiB3ZSBkb24ndCBoYXZlIHRoZSByZXN0YXJ0IGNhbGxiYWNrIG9uIFItQ2Fy
IEdlbjMgaXMgdGhlDQo+IGFybTY0IG1haW50YWluZXJzIGluc2lzdGluZyBvbiB1c2luZyBQU0NJ
LCBhbmQgdmV0b2luZyBvdGhlciBtZWFucywNCj4gdG8gcmVzdGFydCB0aGUgc3lzdGVtLg0KPg0K
PiBXaGljaCBsZWF2ZXMgdXMgd2l0aCBhIGZldyBib2FyZHMgd2hlcmUgd2UgaGF2ZSB0byB1c2Ug
dGhlIHdhdGNoZG9nLCBhbmQNCj4gd2FpdCB1bnRpbCB0aGUgdGltZW91dCB0cmlnZ2Vycy4uLg0K
DQpvaywgZm9yIHRoZSBuZXh0IHZlcnNpb24gSSdsbCByZWdpc3RlciB0aGUgcmVzdGFydCBjYWxs
YmFjayBvbmx5IHdoZW4gd2UgbWF0Y2gNCiJyZW5lc2FzLHJjYXItZ2VuMi13ZHQiLiBTaW5jZSBj
dXJyZW50bHkgdGhlcmUgaXMgbm8gd2F0Y2hkb2cgc3VwcG9ydCBvbiBHZW4yDQpJIGJlbGlldmUg
c3VjaCBhIGNoYW5nZSBpcyBwZXJmZWN0bHkgc2FmZS4NCg0KPg0KPiA+IFRoZSBvbmx5IHdheSB0
byByZWJvb3QgaVdhdmUncyBib2FyZHMgaXdnMjBkIGFuZCBpd2cyMmQgaXMgdG8gdXNlIHRoZSBp
bnRlcm5hbCB3YXRjaGRvZywNCj4gPiB0aGF0J3Mgd2h5IHRoZSByZXN0YXJ0IGltcGxlbWVudGF0
aW9uIHdhcyBtZXJnZWQgaW50byB0aGlzIHBhdGNoLg0KPiA+IEkgY2FuIHNwbGl0IHRoaXMgcGF0
Y2ggaW4gdHdvLCBvbmUgZm9yIFBNIHN1cHBvcnQgYW5kIG9uZSBmb3IgcmVzdGFydCBzdXBwb3J0
IGZvciB0aGUgbmV4dA0KPiA+IHZlcnNpb24sIHdoYXQgZG8geW91IHRoaW5rIGFib3V0IHRoaXM/
DQo+DQo+IFNwbGl0dGluZyBpbiBpbmRpdmlkdWFsIGxvZ2ljYWwgY2hhbmdlcyBzb3VuZHMgbGlr
ZSBhIGdvb2QgaWRlYSB0byBtZS4NCg0KYWdyZWVkIHRoZW4sIEknbGwgc3BsaXQgdGhlIGNvbW1p
dCBpbiB0d28gZm9yIHRoZSBuZXh0IHZlcnNpb24uDQoNClRoYW5rcywNCkZhYg0KDQo+DQo+IEdy
e29ldGplLGVldGluZ31zLA0KPg0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPg0K
PiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9u
ZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+DQo+IEluIHBlcnNvbmFsIGNvbnZlcnNh
dGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQN
Cj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVy
IiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIC0tIExpbnVzIFRvcnZhbGRzDQoNCg0KDQpSZW5lc2FzIEVsZWN0cm9uaWNzIEV1cm9wZSBM
dGQsIER1a2VzIE1lYWRvdywgTWlsbGJvYXJkIFJvYWQsIEJvdXJuZSBFbmQsIEJ1Y2tpbmdoYW1z
aGlyZSwgU0w4IDVGSCwgVUsuIFJlZ2lzdGVyZWQgaW4gRW5nbGFuZCAmIFdhbGVzIHVuZGVyIFJl
Z2lzdGVyZWQgTm8uIDA0NTg2NzA5Lg0K
