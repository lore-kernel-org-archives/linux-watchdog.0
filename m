Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:58007 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752497AbeAaP1K (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 Jan 2018 10:27:10 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
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
Date: Wed, 31 Jan 2018 15:27:02 +0000
Message-ID: <TY1PR06MB0895EDD2AEE12D4CA53994C9C0FB0@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517343778-27902-12-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180130220504.GA16709@roeck-us.net>
 <TY1PR06MB0895ECB2936323F9D281C1EFC0FB0@TY1PR06MB0895.apcprd06.prod.outlook.com>
 <CAMuHMdViQgCjVFbs0kkBObAAoFTzvz8yPFUHPWHrtYzkbnYm_g@mail.gmail.com>
 <007dd1e3-70fd-69ad-fd02-4719e958b41c@roeck-us.net>
In-Reply-To: <007dd1e3-70fd-69ad-fd02-4719e958b41c@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

SGVsbG8gR3VlbnRlciwgR2VlcnQNCg0KdGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrIQ0KDQo+
ID4NCj4gPiBJSVJDLCB0aGUgcmVhc29uIHdlIGRvbid0IGhhdmUgdGhlIHJlc3RhcnQgY2FsbGJh
Y2sgb24gUi1DYXIgR2VuMyBpcyB0aGUNCj4gPiBhcm02NCBtYWludGFpbmVycyBpbnNpc3Rpbmcg
b24gdXNpbmcgUFNDSSwgYW5kIHZldG9pbmcgb3RoZXIgbWVhbnMsDQo+ID4gdG8gcmVzdGFydCB0
aGUgc3lzdGVtLg0KPiA+DQo+DQo+IFlvdSBjb3VsZCBqdXN0IGdpdmUgaXQgbG93ZXIgcHJpb3Jp
dHkgdGhhbiBQU0NJLg0KDQpJIGFtIGxvb2tpbmcgYXQgdGhlIGltcGxlbWVudGF0aW9uIG9mIG1h
Y2hpbmVfcmVzdGFydCgpIGZvciBib3RoIGFybSBhbmQgYXJtNjQsDQphbmQgaXQgbG9va3MgbGlr
ZSB0aGF0IGlmIGFybV9wbV9yZXN0YXJ0IGdldHMgc2V0LCB0aGVuIGFybV9wbV9yZXN0YXJ0IGhh
cyB0aGUNCmhpZ2hlc3QgcHJpb3JpdHkgb2YgYWxsLiBJZiBhcm1fcG1fcmVzdGFydCBpcyBub3Qg
c2V0LCB0aGVuIHRoZSBrZXJuZWwgd2lsbCBnbyB0aHJvdWdoDQp0aGUgcmVzdGFydF9oYW5kbGVy
X2xpc3QsIGFuZCB0aGUgcmVnaXN0ZXJlZCBwcmlvcml0eSBmb3IgdGhlIHJlc3RhcnQgbWV0aG9k
IHdpbGwgbWF0dGVyDQphdCB0aGF0IHBvaW50Lg0KTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IEdl
bjMgZG9lcyBzZXQgYXJtX3BtX3Jlc3RhcnQgZHVlIHRvDQpkcml2ZXJzL2Zpcm13YXJlL3BzY2ku
YywgYW5kIHRoZXJlZm9yZSBvdGhlciByZXN0YXJ0IGhhbmRsZXJzIHNob3VsZG4ndCBtYXR0ZXIg
dG9vDQptdWNoLCBidXQgSSBhbSBub3QgZmFtaWxpYXIgd2l0aCBHZW4zIGF0IGFsbC4NClNoYWxs
IEkganVzdCBzZXQgdGhlIHJlc3RhcnQgcHJpb3JpdHkgdG8gMTI4IGFuZCBsZWF2ZSB0aGUgY2Fs
bGJhY2sgaW4gcGxhY2UgZm9yIGJvdGggR2VuMg0KYW5kIEdlbjM/DQoNClRoYW5rcywNCkZhYg0K
DQo+DQo+ID4gV2hpY2ggbGVhdmVzIHVzIHdpdGggYSBmZXcgYm9hcmRzIHdoZXJlIHdlIGhhdmUg
dG8gdXNlIHRoZSB3YXRjaGRvZywgYW5kDQo+ID4gd2FpdCB1bnRpbCB0aGUgdGltZW91dCB0cmln
Z2Vycy4uLg0KPiA+DQo+DQo+IFdoaWNoIG1lYW5zIHRoZSB2ZXRvIGlzIGNvdW50ZXItcHJvZHVj
dGl2ZSBhbmQgdGh1cyBtZWFuaW5nbGVzcy4NCj4NCj4gR3VlbnRlcg0KPg0KDQoNCg0KUmVuZXNh
cyBFbGVjdHJvbmljcyBFdXJvcGUgTHRkLCBEdWtlcyBNZWFkb3csIE1pbGxib2FyZCBSb2FkLCBC
b3VybmUgRW5kLCBCdWNraW5naGFtc2hpcmUsIFNMOCA1RkgsIFVLLiBSZWdpc3RlcmVkIGluIEVu
Z2xhbmQgJiBXYWxlcyB1bmRlciBSZWdpc3RlcmVkIE5vLiAwNDU4NjcwOS4NCg==
