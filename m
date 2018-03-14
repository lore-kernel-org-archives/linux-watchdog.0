Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:23683 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751005AbeCNLCM (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 14 Mar 2018 07:02:12 -0400
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will.deacon@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Simon Horman <horms@verge.net.au>,
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
Subject: RE: [PATCH v6 01/26] ARM: shmobile: Add watchdog support
Date: Wed, 14 Mar 2018 11:02:06 +0000
Message-ID: <TY1PR01MB1770D3BF20F440AAD9A1E5E5C0D10@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <CAMuHMdUx3A_8MeZmrwiBRqUS0oGjwrg13fy1QMsA2SUw+dR0Hg@mail.gmail.com>
 <1519839622-6109-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdVRxTCG0vCEEmhHm4XsZeJaPM1b_LOeZxqNdhRqsH0oZw@mail.gmail.com>
In-Reply-To: <CAMuHMdVRxTCG0vCEEmhHm4XsZeJaPM1b_LOeZxqNdhRqsH0oZw@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwMS8yNl0gQVJNOiBzaG1vYmls
ZTogQWRkIHdhdGNoZG9nIHN1cHBvcnQNCj4NCj4gSGkgRmFicml6aW8sDQo+DQo+IE9uIFdlZCwg
RmViIDI4LCAyMDE4IGF0IDY6NDAgUE0sIEZhYnJpemlvIENhc3Rybw0KPiA8ZmFicml6aW8uY2Fz
dHJvQGJwLnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBPbiBSLUNhciBHZW4yIGFuZCBSWi9HMSBw
bGF0Zm9ybXMsIHdlIHVzZSB0aGUgU0JBUiByZWdpc3RlcnMgdG8gbWFrZSBub24NCj4gPiBib290
IENQVXMgcnVuIGEgcm91dGluZSBkZXNpZ25lZCB0byBicmluZyB1cCBTTVAgYW5kIGRlYWwgd2l0
aCBob3QgcGx1Zy4NCj4gPiBUaGUgdmFsdWUgY29udGFpbmVkIGluIHRoZSBTQkFSIHJlZ2lzdGVy
cyBpcyBub3QgaW5pdGlhbGl6ZWQgYnkgYSBXRFQNCj4gPiB0cmlnZ2VyZWQgcmVzZXQsIHdoaWNo
IG1lYW5zIHRoYXQgYWZ0ZXIgYSBXRFQgdHJpZ2dlcmVkIHJlc2V0IHdlIGp1bXANCj4gPiB0byB0
aGUgU01QIGJyaW5nIHVwIHJvdXRpbmUsIHByZXZlbnRpbmcgdGhlIHN5c3RlbSBmcm9tIGV4ZWN1
dGluZyB0aGUNCj4gPiBib290cm9tIGNvZGUuDQo+ID4NCj4gPiBUaGUgcHVycG9zZSBvZiB0aGlz
IHBhdGNoIGlzIHRvIGp1bXAgdG8gdGhlIGJvb3Ryb20gY29kZSBpbiBjYXNlIG9mIGENCj4gPiBX
RFQgdHJpZ2dlcmVkIHJlc2V0LCBhbmQga2VlcCB0aGUgU01QIGZ1bmN0aW9uYWxpdHkgdW50b3Vj
aGVkLg0KPiA+IEluIG9yZGVyIHRvIHRlbGwgaWYgdGhlIGNvZGUgaGFkIGJlZW4gY2FsbGVkIGR1
ZSB0byB0aGUgV0RUIG92ZXJmbG93aW5nDQo+ID4gd2UgYXJlIHRlc3RpbmcgV09WRiBmcm9tIHJl
Z2lzdGVyIFJXVENTUkEuDQo+ID4NCj4gPiBUaGUgbmV3IGZ1bmN0aW9uIHNobW9iaWxlX2Jvb3Rf
dmVjdG9yX2dlbjIgaXNuJ3QgcmVwbGFjaW5nDQo+ID4gc2htb2JpbGVfYm9vdF92ZWN0b3IgZm9y
IGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgcmVhc29ucy4gVGhlIGtlcm5lbA0KPiA+IHdpbGwgaW5z
dGFsbCB0aGUgYmVzdCBvcHRpb24gKGVpdGhlciBzaG1vYmlsZV9ib290X3ZlY3RvciBvcg0KPiA+
IHNobW9iaWxlX2Jvb3RfdmVjdG9yX2dlbjIpIHRvIElDUkFNMSBhZnRlciBwYXJzaW5nIHRoZSBk
ZXZpY2UgdHJlZSwNCj4gPiBhY2NvcmRpbmcgdG8gdGhlIGFtb3VudCBvZiBtZW1vcnkgYXZhaWxh
YmxlLg0KPiA+DQo+ID4gU2luY2Ugc2htb2JpbGVfYm9vdF92ZWN0b3IgaGFzIGJlY29tZSBiaWdn
ZXIsICJyZWciIHByb3BlcnR5IG9mIG5vZGVzDQo+ID4gY29tcGF0aWJsZSB3aXRoICJyZW5lc2Fz
LHNtcC1zcmFtIiBub3cgbmVlZCB0byBiZSBzZXQgdG8gYSB2YWx1ZQ0KPiA+IGdyZWF0ZXIgb3Ig
ZXF1YWwgdG8gIjwwIDB4NjA+Ii4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEZhYnJpemlvIENh
c3RybyA8ZmFicml6aW8uY2FzdHJvQGJwLnJlbmVzYXMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFJhbWVzaCBTaGFubXVnYXN1bmRhcmFtIDxyYW1lc2guc2hhbm11Z2FzdW5kYXJhbUBicC5yZW5l
c2FzLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5l
c2FzQGdsaWRlci5iZT4NCj4gPiAtLS0NCj4gPiB2NS0+djY6DQo+ID4gKiB0YWtlbiBpZmRlZnMg
b3V0IGFzIHBlciBHZWVydCdzIHN1Z2dlc3Rpb24uDQo+DQo+IE15IGludGVudGlvbiB3YXMgdG8g
cmVtb3ZlIHRoZSAjaWZkZWZzIGZyb20gdGhlIGhlYWRlciBmaWxlIG9ubHksIG5vdA0KPiBmcm9t
IGFyY2gvYXJtL21hY2gtc2htb2JpbGUvaGVhZHNtcC5TLCBhcyB0aGUgbGF0dGVyIGlzIHVzZWQg
Zm9yDQo+IG90aGVyIFNvQyBmYW1pbGllcywgdG9vLg0KDQpBaCBvaywgSSdsbCBzZW5kIGFub3Ro
ZXIgdmVyc2lvbiB0byByZXN0b3JlIHRoZSBpZmRlZiB3aXRoaW4gaGVhZHNtcC5TIHRoZW4uDQoN
ClRoYW5rcywNCkZhYg0KDQo+DQo+IEdye29ldGplLGVldGluZ31zLA0KPg0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICBHZWVydA0KPg0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhl
cmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+
DQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNh
bGwgbXlzZWxmIGEgaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0
cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQoNCg0KDQpSZW5l
c2FzIEVsZWN0cm9uaWNzIEV1cm9wZSBMdGQsIER1a2VzIE1lYWRvdywgTWlsbGJvYXJkIFJvYWQs
IEJvdXJuZSBFbmQsIEJ1Y2tpbmdoYW1zaGlyZSwgU0w4IDVGSCwgVUsuIFJlZ2lzdGVyZWQgaW4g
RW5nbGFuZCAmIFdhbGVzIHVuZGVyIFJlZ2lzdGVyZWQgTm8uIDA0NTg2NzA5Lg0K
