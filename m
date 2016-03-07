Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44]:47769 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbcCGLHe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 7 Mar 2016 06:07:34 -0500
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
	<hidehiro.kawai.ez@hitachi.com>
To: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
	<hidehiro.kawai.ez@hitachi.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Corey Minyard <minyard@acm.org>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	"openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: RE: [Openipmi-developer] [v3 PATCH 3/3] hpwdt: Use nmi_panic()
 when kernel panics in NMI handler
Date: Mon, 7 Mar 2016 11:07:30 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454B189CD@GSjpTKYDCembx31.service.hitachi.net>
References: <20160303105741.4587.49047.stgit@softrs>
 <20160303105748.4587.70794.stgit@softrs>
In-Reply-To: <20160303105748.4587.70794.stgit@softrs>
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

PiBGcm9tOiBQaGlsIFBva29ybnkgW21haWx0bzpwcG9rb3JueUBwZW5ndWluY29tcHV0aW5nLmNv
bV0NCj4gDQo+IFdoaWxlIHlvdSBhcmUgaW4gZHJpdmVycy93YXRjaGRvZy9ocHdkdC5jIHJlcGxh
Y2luZyBwYW5pYygpIHdpdGgNCj4gbm1pX3BhbmljKCkgY2FuIHlvdSBhbHNvIGZpeCBhIGZldyBt
b3JlIG9mIHRoZSBicm9rZW4gc3RyaW5ncz8gIFRoZQ0KPiBMaW51eCBzdHlsZSBndWlkZSBzcGVj
ZmlpY2FsbHkgc2F5cyBOT1QgdG8gYnJlYWsgc3RyaW5ncyB0aGF0IGFyZSB1c2VyDQo+IHZpc2li
bGUgYmVjYXVzZSBpdCBicmVha3MgImdyZXAiLiAgU286DQoNCkFoaCwgeWVzLiAgSSBzaG91bGQg
aGF2ZSBmaXhlZCB0aGlzIGFzIHdlbGwgYXMgdGhlIGZvcm1lciBjYXNlLg0KQnV0IHRoaXMgcGF0
Y2ggc2V0IGhhcyBhbHJlYWR5IGJlZW4gcXVldWVkIGludG8gLW1tIHRyZWUsIHNvDQpJJ2xsIGxl
YXZlIHRoaXMgcGF0Y2ggaWYgdGhlIGZpeCBpcyBub3QgaW1wb3J0YW50Lg0KDQpSZWdhcmRzLA0K
SGlkZWhpcm8gS2F3YWkNCg0KPiANCj4gLSAgICAgICBwYW5pYygiQW4gTk1JIG9jY3VycmVkLiBE
ZXBlbmRpbmcgb24geW91ciBzeXN0ZW0gdGhlIHJlYXNvbiAiDQo+ICsgICAgICAgbm1pX3Bhbmlj
KHJlZ3MsICJBbiBOTUkgb2NjdXJyZWQuIERlcGVuZGluZyBvbiB5b3VyIHN5c3RlbSB0aGUgcmVh
c29uICINCj4gICAgICAgICAgICAgICAgICJmb3IgdGhlIE5NSSBpcyBsb2dnZWQgaW4gYW55IG9u
ZSBvZiB0aGUgZm9sbG93aW5nICINCj4gICAgICAgICAgICAgICAgICJyZXNvdXJjZXM6XG4iDQo+
ICAgICAgICAgICAgICAgICAiMS4gSW50ZWdyYXRlZCBNYW5hZ2VtZW50IExvZyAoSU1MKVxuIg0K
PiANCj4gU2hvdWxkIHByb2JhYmx5IGJlOg0KPiANCj4gLSAgICAgICBwYW5pYygiQW4gTk1JIG9j
Y3VycmVkLiBEZXBlbmRpbmcgb24geW91ciBzeXN0ZW0gdGhlIHJlYXNvbiAiDQo+IC0gICAgICAg
ICAgICAgICAgImZvciB0aGUgTk1JIGlzIGxvZ2dlZCBpbiBhbnkgb25lIG9mIHRoZSBmb2xsb3dp
bmcgIg0KPiAtICAgICAgICAgICAgICAgICJyZXNvdXJjZXM6XG4iDQo+ICsgICAgICAgbm1pX3Bh
bmljKHJlZ3MsICJBbiBOTUkgb2NjdXJyZWQuIERlcGVuZGluZyBvbiB5b3VyIHN5c3RlbSB0aGUN
Cj4gcmVhc29uIGZvciB0aGUgTk1JIGlzIGxvZ2dlZCBpbiBhbnkgb25lIG9mIHRoZSBmb2xsb3dp
bmcgcmVzb3VyY2VzOlxuIg0KPiAgICAgICAgICAgICAgICAgIjEuIEludGVncmF0ZWQgTWFuYWdl
bWVudCBMb2cgKElNTClcbiINCj4gDQo+IFNvIGl0J3Mgb2theSB0byBicmVhayBvbiAiXG4iLCBi
dXQgbm90IGluIHRoZSBtaWRkbGUgb2YgYSBsaW5lLg0KPiANCj4gLS0NCj4gUGhpbGlwIFBva29y
bnksIFJIQ0UNCj4gQ2hpZWYgVGVjaG5vbG9neSBPZmZpY2VyDQo+IFBFTkdVSU4gQ09NUFVUSU5H
LCBJbmMNCj4gd3d3LnBlbmd1aW5jb21wdXRpbmcuY29tDQo+IA0KPiBDaGFuZ2luZyB0aGUgd29y
bGQgdGhyb3VnaCB0ZWNobmljYWwgaW5ub3ZhdGlvbg0K
