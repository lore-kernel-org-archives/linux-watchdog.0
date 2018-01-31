Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:44466 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752532AbeAaK1g (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 Jan 2018 05:27:36 -0500
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
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [RFC v3 10/25] dt-bindings: watchdog: renesas-wdt: Add R-Car Gen2
 support
Date: Wed, 31 Jan 2018 10:27:29 +0000
Message-ID: <TY1PR06MB089525525DC23EEAEAE97795C0FB0@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517343778-27902-11-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdXkHF9R0XfcG++s0RRup+Mdtam5p=FXw26z86wAOJhZfQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXkHF9R0XfcG++s0RRup+Mdtam5p=FXw26z86wAOJhZfQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gU3ViamVjdDogUmU6IFtSRkMgdjMgMTAvMjVdIGR0LWJpbmRpbmdzOiB3
YXRjaGRvZzogcmVuZXNhcy13ZHQ6IEFkZCBSLUNhciBHZW4yIHN1cHBvcnQNCj4NCj4gSGkgRmFi
cml6aW8sDQo+DQo+IE9uIFR1ZSwgSmFuIDMwLCAyMDE4IGF0IDk6MjIgUE0sIEZhYnJpemlvIENh
c3Rybw0KPiA8ZmFicml6aW8uY2FzdHJvQGJwLnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBUaGlz
IGNvbW1pdCBkb2N1bWVudHMgdGhlIGNvbXBhdGliaWxpdHkgd2l0aCBSLUNhciBHZW4yIGFuZCBS
Wi9HDQo+ID4gZGV2aWNlcyBieSBkZWZpbmluZyB0aGUgZ2VuZXJpYyBjb21wYXRpYmxlIHN0cmlu
ZyAicmVuZXNhcyxyY2FyLWdlbjItd2R0Ii4NCj4gPiBBbHNvLCB0aGlzIHBhdGNoIGV4cGFuZHMg
dGhlIGxpc3Qgb2YgU29DLXNwZWNpZmljIGNvbXBhdGlibGUgc3RyaW5ncyB0bw0KPiA+IGluY2x1
ZGUgUlovRyBhbmQgUi1DYXIgR2VuMiBkZXZpY2VzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
RmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm9AYnAucmVuZXNhcy5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogUmFtZXNoIFNoYW5tdWdhc3VuZGFyYW0gPHJhbWVzaC5zaGFubXVnYXN1bmRh
cmFtQGJwLnJlbmVzYXMuY29tPg0KPg0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQoNClRoYW5r
cyBmb3IgeW91ciBmZWVkYmFjayENCg0KPg0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy93YXRjaGRvZy9yZW5lc2FzLXdkdC50eHQNCj4gPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cvcmVuZXNhcy13ZHQudHh0DQo+ID4g
QEAgLTEsMTcgKzEsMjUgQEANCj4gPiAgUmVuZXNhcyBXYXRjaGRvZyBUaW1lciAoV0RUKSBDb250
cm9sbGVyDQo+ID4NCj4gPiAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiAtLSBjb21wYXRpYmxl
IDogU2hvdWxkIGJlICJyZW5lc2FzLDxzb2N0eXBlPi13ZHQiLCBhbmQNCj4gPiAtICAgICAgICAg
ICAgICAicmVuZXNhcyxyY2FyLWdlbjMtd2R0IiBvciAicmVuZXNhcyxyemEtd2R0IiBhcyBmYWxs
YmFjay4NCj4gPiArIC0gY29tcGF0aWJsZSA6IE11c3QgYmUgInJlbmVzYXMsPHNvY3R5cGU+LXdk
dCIsIGZvbGxvd2VkIGJ5IGEgZ2VuZXJpYw0KPiA+ICsgICAgICAgICAgICAgICBmYWxsYmFjayBj
b21wYXRpYmxlIHN0cmluZyB3aGVuIGNvbXBhdGlibGUgd2l0aCB0aGUgZ2VuZXJpYw0KPiA+ICsg
ICAgICAgICAgICAgICB2ZXJzaW9uLg0KPiA+ICAgICAgICAgICAgICAgIEV4YW1wbGVzIHdpdGgg
c29jdHlwZXMgYXJlOg0KPiA+ICsgICAgICAgICAgICAgICAgLSAicmVuZXNhcyxyOGE3NzQzLXdk
dCIgKFJaL0cxTSkNCj4gPiArICAgICAgICAgICAgICAgIC0gInJlbmVzYXMscjhhNzc0NS13ZHQi
IChSWi9HMUUpDQo+ID4gKyAgICAgICAgICAgICAgICAtICJyZW5lc2FzLHI4YTc3OTAtd2R0IiAo
Ui1DYXIgSDIpDQo+ID4gKyAgICAgICAgICAgICAgICAtICJyZW5lc2FzLHI4YTc3OTEtd2R0IiAo
Ui1DYXIgTTItVykNCj4gPiArICAgICAgICAgICAgICAgIC0gInJlbmVzYXMscjhhNzc5Mi13ZHQi
IChSLUNhciBWMkgpDQo+ID4gKyAgICAgICAgICAgICAgICAtICJyZW5lc2FzLHI4YTc3OTMtd2R0
IiAoUi1DYXIgTTItTikNCj4gPiArICAgICAgICAgICAgICAgIC0gInJlbmVzYXMscjhhNzc5NC13
ZHQiIChSLUNhciBFMikNCj4gPiAgICAgICAgICAgICAgICAgIC0gInJlbmVzYXMscjhhNzc5NS13
ZHQiIChSLUNhciBIMykNCj4gPiAgICAgICAgICAgICAgICAgIC0gInJlbmVzYXMscjhhNzc5Ni13
ZHQiIChSLUNhciBNMy1XKQ0KPiA+ICAgICAgICAgICAgICAgICAgLSAicmVuZXNhcyxyOGE3Nzk5
NS13ZHQiIChSLUNhciBEMykNCj4gPiAgICAgICAgICAgICAgICAgIC0gInJlbmVzYXMscjdzNzIx
MDAtd2R0IiAoUlovQTEpDQo+ID4gKyAgICAgICAgICAgICAgIFRoZSBnZW5lcmljIGNvbXBhdGli
bGUgc3RyaW5nIG11c3QgYmU6DQo+ID4gKyAgICAgICAgICAgICAgICAtICJyZW5lc2FzLHJjYXIt
Z2VuMi13ZHQiIGZvciBSLUNhciBHZW4yIGFuZCBSWi9HDQo+ID4gKyAgICAgICAgICAgICAgICAt
ICJyZW5lc2FzLHJjYXItZ2VuMy13ZHQiIGZvciBSLUNhciBHZW4zDQo+DQo+IFlvdSd2ZSBsb3N0
IHRoZSBnZW5lcmljICJyZW5lc2FzLHJ6YS13ZHQiLg0KDQpPb29wcywgSSdsbCBmaXggdGhhdC4N
Cg0KQ2hlZXJzLA0KRmFiDQoNCj4NCj4gV2l0aCB0aGF0IGZpeGVkOg0KPiBSZXZpZXdlZC1ieTog
R2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4NCj4gR3J7b2V0
amUsZWV0aW5nfXMsDQo+DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+DQo+IC0t
DQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlh
MzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcNCj4NCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9u
cyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dA0KPiB3
aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9y
IHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
LS0gTGludXMgVG9ydmFsZHMNCg0KDQoNClJlbmVzYXMgRWxlY3Ryb25pY3MgRXVyb3BlIEx0ZCwg
RHVrZXMgTWVhZG93LCBNaWxsYm9hcmQgUm9hZCwgQm91cm5lIEVuZCwgQnVja2luZ2hhbXNoaXJl
LCBTTDggNUZILCBVSy4gUmVnaXN0ZXJlZCBpbiBFbmdsYW5kICYgV2FsZXMgdW5kZXIgUmVnaXN0
ZXJlZCBOby4gMDQ1ODY3MDkuDQo=
