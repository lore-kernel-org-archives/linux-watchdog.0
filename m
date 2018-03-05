Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:64828 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933623AbeCEOCG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 5 Mar 2018 09:02:06 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Wim Van Sebroeck <wim@iguana.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Linux Watchdog Mailing List" <linux-watchdog@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "Ramesh Shanmugasundaram" <ramesh.shanmugasundaram@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v7 2/3] watchdog: renesas_wdt: Add R-Car Gen2 support
Date: Mon, 5 Mar 2018 14:02:01 +0000
Message-ID: <TY1PR06MB0895CF1661C1D2E84A3E28E4C0DA0@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1519928243-28596-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1519928243-28596-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdWmgLaOuj+_qBwf6=1RzQTCxs0To8Fu2sixRDAcuAT4qw@mail.gmail.com>
In-Reply-To: <CAMuHMdWmgLaOuj+_qBwf6=1RzQTCxs0To8Fu2sixRDAcuAT4qw@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

SGVsbG8gR2VlcnQsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAyLzNdIHdhdGNoZG9nOiBy
ZW5lc2FzX3dkdDogQWRkIFItQ2FyIEdlbjIgc3VwcG9ydA0KPg0KPiBIaSBGYWJyaXppbywNCj4N
Cj4gT24gVGh1LCBNYXIgMSwgMjAxOCBhdCA3OjE3IFBNLCBGYWJyaXppbyBDYXN0cm8NCj4gPGZh
YnJpemlvLmNhc3Ryb0BicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gRHVlIHRvIGNvbW1pdHM6
DQo+ID4gKiAiQVJNOiBzaG1vYmlsZTogQWRkIHdhdGNoZG9nIHN1cHBvcnQiLA0KPiA+ICogIkFS
TTogc2htb2JpbGU6IHJjYXItZ2VuMjogQWRkIHdhdGNoZG9nIHN1cHBvcnQiLCBhbmQNCj4gPiAq
ICJzb2M6IHJlbmVzYXM6IHJjYXItcnN0OiBFbmFibGUgd2F0Y2hkb2cgYXMgcmVzZXQgdHJpZ2dl
ciBmb3IgR2VuMiIsDQo+ID4gd2Ugbm93IGhhdmUgZXZlcnl0aGluZyB3ZSBuZWVkZWQgZm9yIHRo
ZSB3YXRjaGRvZyB0byB3b3JrIG9uIEdlbjIgYW5kDQo+ID4gUlovRzEuDQo+ID4NCj4gPiBUaGlz
IGNvbW1pdCBhZGRzICJyZW5lc2FzLHJjYXItZ2VuMi13ZHQiIGFzIGNvbXBhdGlibGUgc3RyaW5n
IGZvciBSLUNhcg0KPiA+IEdlbjIgYW5kIFJaL0cxLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
RmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm9AYnAucmVuZXNhcy5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogUmFtZXNoIFNoYW5tdWdhc3VuZGFyYW0gPHJhbWVzaC5zaGFubXVnYXN1bmRh
cmFtQGJwLnJlbmVzYXMuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4g
PGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiA+IFJldmlld2VkLWJ5OiBXb2xmcmFtIFNhbmcg
PHdzYStyZW5lc2FzQHNhbmctZW5naW5lZXJpbmcuY29tPg0KPg0KPiBUbyBhdm9pZCBuYXN0eSBz
dXJwcmlzZXMgb24gZWFybHkgUi1DYXIgR2VuMiBTb0NzLCAiW1BBVENIXSB3YXRjaGRvZzoNCj4g
cmVuZXNhc193ZHQ6IEJsYWNrbGlzdCBlYXJseSBSLUNhciBHZW4yIFNvQ3MiDQo+IChodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwMjMzMjk3Lykgc2hvdWxkIGJlIGZvbGRlZCBp
bnRvIHRoaXMNCj4gcGF0Y2guDQoNCkkgYWdyZWUsIEknbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIHdp
dGggeW91ciBibGFja2xpc3RpbmcgcGF0Y2ggZm9sZGVkIGludG8gdGhpcyBwYXRjaC4NCg0KVGhh
bmtzLA0KRmFiDQoNCj4NCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIEdlZXJ0DQo+DQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdz
IGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcNCj4NCj4g
SW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBt
eXNlbGYgYSBoYWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkg
anVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg0KDQoNClJlbmVzYXMg
RWxlY3Ryb25pY3MgRXVyb3BlIEx0ZCwgRHVrZXMgTWVhZG93LCBNaWxsYm9hcmQgUm9hZCwgQm91
cm5lIEVuZCwgQnVja2luZ2hhbXNoaXJlLCBTTDggNUZILCBVSy4gUmVnaXN0ZXJlZCBpbiBFbmds
YW5kICYgV2FsZXMgdW5kZXIgUmVnaXN0ZXJlZCBOby4gMDQ1ODY3MDkuDQo=
