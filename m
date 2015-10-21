Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2on0115.outbound.protection.outlook.com ([65.55.169.115]:22752
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750698AbbJUEKn (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 21 Oct 2015 00:10:43 -0400
From: Hou Zhiqiang <B48286@freescale.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	"wim@iguana.be" <wim@iguana.be>, "corbet@lwn.net" <corbet@lwn.net>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@codeaurora.org" <sboyd@codeaurora.org>,
	Hu Vincent <Mingkai.Hu@freescale.com>,
	Shaohui Xie <Shaohui.Xie@freescale.com>,
	"Scott Wood" <scottwood@freescale.com>,
	Sharma Bhupesh <bhupesh.sharma@freescale.com>,
	Wenbin Song <Wenbin.Song@freescale.com>
Subject: RE: [PATCH V5 1/6] i2c: Add i2c support to Freescale Layerscape
 platforms
Date: Wed, 21 Oct 2015 04:10:39 +0000
Message-ID: <CY1PR0301MB078061870608C21CEA37B4288B380@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1445255774-32887-1-git-send-email-B48286@freescale.com>
 <20151020155258.GM5379@katana>
In-Reply-To: <20151020155258.GM5379@katana>
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29sZnJhbSBTYW5nIFtt
YWlsdG86d3NhQHRoZS1kcmVhbXMuZGVdDQo+IFNlbnQ6IDIwMTXE6jEw1MIyMMjVIDIzOjUzDQo+
IFRvOiBIb3UgWmhpcWlhbmctQjQ4Mjg2DQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiB3aWxsLmRlYWNvbkBhcm0u
Y29tOyBsaW51eC1pMmNAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gd2F0Y2hkb2dAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gY2xrQHZnZXIu
a2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IGxpbnV4QHJvZWNrLXVzLm5ldDsNCj4g
d2ltQGlndWFuYS5iZTsgY29yYmV0QGx3bi5uZXQ7IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOw0K
PiBzYm95ZEBjb2RlYXVyb3JhLm9yZzsgSHUgTWluZ2thaS1CMjEyODQ7IFhpZSBTaGFvaHVpLUIy
MTk4OTsgV29vZCBTY290dC0NCj4gQjA3NDIxOyBTaGFybWEgQmh1cGVzaC1CNDUzNzA7IFNvbmcg
V2VuYmluLUI1Mzc0Nw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY1IDEvNl0gaTJjOiBBZGQgaTJj
IHN1cHBvcnQgdG8gRnJlZXNjYWxlIExheWVyc2NhcGUNCj4gcGxhdGZvcm1zDQo+IA0KPiBPbiBN
b24sIE9jdCAxOSwgMjAxNSBhdCAwNzo1NjowOVBNICswODAwLCBaaGlxaWFuZyBIb3Ugd3JvdGU6
DQo+ID4gRnJvbTogU2hhb2h1aSBYaWUgPFNoYW9odWkuWGllQGZyZWVzY2FsZS5jb20+DQo+ID4N
Cj4gPiBNb2RpZnkgdGhlIEkyQ19JTVggY29uZmlnIHRvIHN1cHBvcnQgdG8gTGF5ZXJzY2FwZSBw
bGF0Zm9ybXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaW5na2FpIEh1IDxNaW5na2FpLkh1
QGZyZWVzY2FsZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VuYmluIFNvbmcgPFdlbmJpbi5T
b25nQGZyZWVzY2FsZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxCNDgy
ODZAZnJlZXNjYWxlLmNvbT4NCj4gDQo+IFRocmVlIHNpZ25lZCBvZmZzIGZvciBhIHNpbXBsZSBL
Y29uZmlnIGNoYW5nZT8gQW5kIHRoZSBwZXJzb24gZG9pbmcgdGhlDQo+IHBhdGNoIGhhcyBubyBz
aWduZWQgb2ZmPz8gVGhhdCBsb29rcyB3cm9uZy4gTWF5YmUgdGhlIGFib3ZlIHNpZ25lZCBvZmZz
DQo+IHNob3VsZCBiZSBhY2tlZCBieT8NCj4gDQoNCldpbGwgYWRkIHRoZSBzaWduZWQtb2ZmIG9m
IHRoZSBhdXRob3IuDQoNClRoYW5rcywNClpoaXFpYW5nDQo=
