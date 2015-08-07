Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.143]:47381 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751069AbbHGKUF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Aug 2015 06:20:05 -0400
From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC: Wim Van Sebroeck <wim@iguana.be>,
	Support Opensource <Support.Opensource@diasemi.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH 1/2] watchdog: da9063: Ping watchdog only during allowed
 time window
Date: Fri, 7 Aug 2015 10:13:35 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB569C3B@SW-EX-MBX01.diasemi.com>
References: <1438879019-12978-1-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1438879019-12978-1-git-send-email-p.zabel@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

T24gQXVndXN0IDA2LCAyMDE1IDE3OjM3LCBQaGlsaXBwIFphYmVsIHdyb3RlOg0KDQo+IFRoZXJl
IGlzIGEgY29vbGRvd24gcGVyaW9kIGFmdGVyIHdhdGNoZG9nIHRpbWVyIHNldHVwLCBhbmQgYWxz
byBhZnRlciBlYWNoDQo+IHdhdGNoZG9nIHBpbmcuIElmIGEgcGluZyBpcyBpc3N1ZWQgdG9vIGVh
cmx5LCB0aGUgd2F0Y2hkb2cgdHJpZ2dlcnMgdGhlDQo+IHdhdGNoZG9nIGVycm9yIGNvbmRpdGlv
biBhbmQgY2F1c2VzIGEgc3lzdGVtIHJlc2V0Lg0KPiANCj4gVGhlIDI1NiBtcyBwZXJpb2QgbGVu
Z3RoIGlzIGEgYmVzdCBndWVzcyBiYXNlZCBvbiB0aGUgc2FtZSB2YWx1ZSBiZWluZyB1c2VkDQo+
IGZvciB0aGUgREE5MDUzIHByZWRlY2Vzc29yIFBNSUMgYW5kIGV4cGVyaW1lbnRzIHRoYXQgaGF2
ZSBzaG93biAyMDAgbXMgYXJlDQo+IG5vdCBlbm91Z2ggdG8gYXZvaWQgdGhlIGVycm9yLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT4N
Cg0KTXkgY29sbGVhZ3VlIFN0ZXBoZW4gaXMgb3V0IG9mIG9mZmljZSBmb3IgdGhlIG5leHQgdHdv
IHdlZWtzLCBidXQgcmVhbGx5IEkNCnRoaW5rIGhlIHNob3VsZCByZXZpZXcgdGhlc2UgdHdvIHBh
dGNoZXMgZ2l2ZW4gaGlzIGtub3dsZWRnZSBvZiB0aGUgZGV2aWNlLiBJZg0KeW91IGNhbiBob2xk
IG9mZiB1bnRpbCB0aGVuLCBoZSBzaG91bGQgYmUgYWJsZSB0byBwcm92aWRlIGZlZWRiYWNrLg0K
