Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:63309 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751779AbeCEOIS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 5 Mar 2018 09:08:18 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        "Wim Van Sebroeck" <wim@iguana.be>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "Ramesh Shanmugasundaram" <ramesh.shanmugasundaram@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v7 1/3] watchdog: renesas_wdt: Add suspend/resume support
Date: Mon, 5 Mar 2018 14:08:12 +0000
Message-ID: <TY1PR06MB08952CAA1011D2DA8FCC268AC0DA0@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1519928243-28596-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1519928243-28596-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <6b8545fa-4f74-82df-76a2-8b0bbb44c67f@cogentembedded.com>
In-Reply-To: <6b8545fa-4f74-82df-76a2-8b0bbb44c67f@cogentembedded.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

SGVsbG8gU2VyZ2VpLA0KDQp0aGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2shDQoNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NyAxLzNdIHdhdGNoZG9nOiByZW5lc2FzX3dkdDogQWRkIHN1c3BlbmQv
cmVzdW1lIHN1cHBvcnQNCj4NCj4gSGVsbG8hDQo+DQo+IE9uIDMvMS8yMDE4IDk6MTcgUE0sIEZh
YnJpemlvIENhc3RybyB3cm90ZToNCj4NCj4gPiBPbiBSLUNhciBHZW4yIGFuZCBSWi9HMSB0aGUg
d2F0Y2hkb2cgSVAgY2xvY2sgbmVlZHMgdG8gYmUgYWx3YXlzIE9OLA0KPiA+IG9uIFItQ2FyIEdl
bjMgd2UgcG93ZXIgdGhlIElQIGRvd24gZHVyaW5nIHN1c3BlbmQuDQo+ID4NCj4gPiBUaGlzIGNv
bW1pdCBhZGRzIHN1c3BlbmQvcmVzdW1lIHN1cHBvcnQsIHNvIHRoYXQgdGhlIHdhdGNoZG9nIGNv
dW50aW5nDQo+ID4gInBhdXNlcyIgZHVyaW5nIHN1c3BlbmQgb24gYWxsIG9mIHRoZSBTb0NzIGNv
bXBhdGlibGUgd2l0aCB0aGlzIGRyaXZlcg0KPiA+IGFuZCBvbiB0aG9zZSB3ZSBhcmUgbm93IGFk
ZGluZyBzdXBwb3J0IGZvciAoUi1DYXIgR2VuMiBhbmQgUlovRzEpLg0KPg0KPiAgICAgV2h5IHRo
ZXNlIHBhcmVucyBoZXJlPw0KDQppdCdzIGR1ZSB0byB0aGUgY29udGV4dCwgdGhpcyBwYXRjaCBi
ZWxvbmdzIHRvIHRoZSB3YXRjaGRvZyBzdXBwb3J0IHNlcmllcw0KYnV0IGl0IGNvbWVzIGJlZm9y
ZSB0aGUgY29tbWl0IHdoZXJlIHdlIGFkZCBkcml2ZXIgc3VwcG9ydCBmb3IgUi1DYXIgR2VuMg0K
YW5kIFJaL0cxLiBBbnl3YXksIHdoYXQgd2UgZG8gd29ya3MgZm9yIFItQ2FyIEdlbjMgYXMgd2Vs
bC4NCg0KV291bGQgeW91IHByZWZlciBhIGRpZmZlcmVudCBtZXNzYWdlPw0KDQpUaGFua3MsDQpG
YWINCg0KPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEZhYnJpemlvIENhc3RybyA8ZmFicml6aW8uY2Fz
dHJvQGJwLnJlbmVzYXMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJhbWVzaCBTaGFubXVnYXN1
bmRhcmFtIDxyYW1lc2guc2hhbm11Z2FzdW5kYXJhbUBicC5yZW5lc2FzLmNvbT4NCj4gWy4uLl0N
Cj4NCj4gTUJSLCBTZXJnZWkNCg0KDQoNClJlbmVzYXMgRWxlY3Ryb25pY3MgRXVyb3BlIEx0ZCwg
RHVrZXMgTWVhZG93LCBNaWxsYm9hcmQgUm9hZCwgQm91cm5lIEVuZCwgQnVja2luZ2hhbXNoaXJl
LCBTTDggNUZILCBVSy4gUmVnaXN0ZXJlZCBpbiBFbmdsYW5kICYgV2FsZXMgdW5kZXIgUmVnaXN0
ZXJlZCBOby4gMDQ1ODY3MDkuDQo=
