Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5]:49406 "EHLO
	mail4.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbcCAEYE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Feb 2016 23:24:04 -0500
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
	<hidehiro.kawai.ez@hitachi.com>
To: "'minyard@acm.org'" <minyard@acm.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>
CC: "openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>,
	Michal Hocko <mhocko@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] ipmi/watchdog: Use nmi_panic() when kernel panics
 in NMI handler
Date: Tue, 1 Mar 2016 04:23:59 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454B06310@GSjpTKYDCembx31.service.hitachi.net>
References: <20160301015035.4318.78677.stgit@softrs>
 <20160301015039.4318.58063.stgit@softrs> <56D4FEAE.7080909@acm.org>
In-Reply-To: <56D4FEAE.7080909@acm.org>
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

SGkgQ29yZXksDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KPiBTdXJlLCB0aGlzIGlzIGEg
Z29vZCBpZGVhLg0KPiANCj4gQWNrZWQtYnk6IENvcmV5IE1pbnlhcmQgPGNtaW55YXJkQG12aXN0
YS5jb20+DQo+IA0KPiBOb3RlIHRoYXQgbm1pX3BhbmljKCkgY2FtZSBpbiBjb21taXQgMTcxN2Yy
MDk2YjUgKHBhbmljLCB4ODY6IEZpeA0KPiByZS1lbnRyYW5jZSBwcm9ibGVtIGR1ZSB0byBwYW5p
YyBvbiBOTUkpIGFuZCB0aGVuIHRoZSByZWdzIGZpZWxkDQo+IHdhcyBhZGRlZCBpbiB0aGUgY29t
bWl0IHlvdSByZWZlcmVuY2UuDQoNClllcy4gU28sIEknbGwgY2hhbmdlIHRoZSBkZXNjcmlwdGlv
biB0byBtb3JlIHByb3BlciBvbmUuDQoNCj4gRG8geW91IHdhbnQgbWUgdG8gYWRkIHRoaXMgdG8g
dGhlIElQTUkgcXVldWUgb3IgZG8geW91IGhhdmUgYW5vdGhlcg0KPiB3YXkgdG8gZ2V0IHRoaXMg
cGF0Y2ggaW50byB0aGUga2VybmVsPw0KDQpJIGRvbid0IGhhdmUgYW5vdGhlciB3YXksIGFuZCBJ
IGRvbid0IGtub3cgaG93IGNyb3NzLXN1YnN5c3RlbQ0KcGF0Y2ggc2V0IHNob3VsZCBiZSBoYW5k
bGVkLg0KDQpJIHRoaW5rIGl0IHdvdWxkIGJlIGJldHRlciB0aGlzIHBhdGNoIHNldCBpcyBtYW5h
Z2VkIGJ5IG9uZSBwZXJzb24NCmJlY2F1c2UgYm90aCBQQVRDSCAyLzMgYW5kIDMvMyBkZXBlbmQg
b24gMS8zLg0KDQpUaGFua3MsDQoNCi0tDQpIaWRlaGlybyBLYXdhaQ0KSGl0YWNoaSwgTHRkLiBS
ZXNlYXJjaCAmIERldmVsb3BtZW50IEdyb3VwDQoNCg0KDQo=
