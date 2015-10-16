Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1bbn0102.outbound.protection.outlook.com ([157.56.111.102]:63297
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751414AbbJPCpi (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Oct 2015 22:45:38 -0400
From: Hou Zhiqiang <B48286@freescale.com>
To: Stephen Boyd <sboyd@codeaurora.org>
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
	"wsa@the-dreams.de" <wsa@the-dreams.de>,
	"wim@iguana.be" <wim@iguana.be>, "corbet@lwn.net" <corbet@lwn.net>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	Hu Vincent <Mingkai.Hu@freescale.com>,
	Shaohui Xie <Shaohui.Xie@freescale.com>,
	"Scott Wood" <scottwood@freescale.com>,
	Sharma Bhupesh <bhupesh.sharma@freescale.com>,
	Wenbin Song <Wenbin.Song@freescale.com>
Subject: RE: [PATCH V4 5/6] clk: qoriq: Add ls1043a support.
Date: Fri, 16 Oct 2015 02:45:35 +0000
Message-ID: <CY1PR0301MB0780D9B0CF00A1CF72A9352C8B3D0@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1444911181-21696-1-git-send-email-B48286@freescale.com>
 <1444911181-21696-5-git-send-email-B48286@freescale.com>
 <20151015180148.GE4558@codeaurora.org>
In-Reply-To: <20151015180148.GE4558@codeaurora.org>
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBCb3lkIFtt
YWlsdG86c2JveWRAY29kZWF1cm9yYS5vcmddDQo+IFNlbnQ6IDIwMTXE6jEw1MIxNsjVIDI6MDIN
Cj4gVG86IEhvdSBaaGlxaWFuZy1CNDgyODYNCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207DQo+IHdpbGwuZGVhY29uQGFy
bS5jb207IGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiB3YXRjaGRvZ0B2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBjbGtAdmdl
ci5rZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgbGludXhAcm9lY2stdXMubmV0OyB3
c2FAdGhlLQ0KPiBkcmVhbXMuZGU7IHdpbUBpZ3VhbmEuYmU7IGNvcmJldEBsd24ubmV0OyBtdHVy
cXVldHRlQGJheWxpYnJlLmNvbTsgSHUNCj4gTWluZ2thaS1CMjEyODQ7IFhpZSBTaGFvaHVpLUIy
MTk4OTsgV29vZCBTY290dC1CMDc0MjE7IFNoYXJtYSBCaHVwZXNoLQ0KPiBCNDUzNzA7IFNvbmcg
V2VuYmluLUI1Mzc0Nw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDUvNl0gY2xrOiBxb3JpcTog
QWRkIGxzMTA0M2Egc3VwcG9ydC4NCj4gDQo+IE9uIDEwLzE1LCBaaGlxaWFuZyBIb3Ugd3JvdGU6
DQo+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxCNDgyODZAZnJlZXNjYWxlLmNvbT4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8QjQ4Mjg2QGZyZWVzY2FsZS5jb20+DQo+ID4g
LS0tDQo+ID4gVGhpcyBwYXRjaCBoYXMgYmVlbiBhY2tlZCBpbiBWMyBieSBTdGVwaGVuIEJveWQg
W3Nib3lkQGNvZGVhdXJvcmEub3JnXS4NCj4gDQo+IFllcywgcGxlYXNlIGFkZCBpdCBpbnRvIHRo
ZSBwYXRjaGVzIHRoYXQgeW91IHNlbmQgaW5zdGVhZCBvZiBwdXR0aW5nIGl0DQo+IGJlbG93IHRo
ZSAtLS0gbGluZS4NCg0KT2ssIHRoYW5rcy4NCg0KWmhpcWlhbmcNCg==
