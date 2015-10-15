Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-by2on0132.outbound.protection.outlook.com ([207.46.100.132]:45643
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750880AbbJOHeQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Oct 2015 03:34:16 -0400
From: Hou Zhiqiang <B48286@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	Hu Vincent <Mingkai.Hu@freescale.com>,
	Shaohui Xie <Shaohui.Xie@freescale.com>,
	"Sharma Bhupesh" <bhupesh.sharma@freescale.com>,
	Li Leo <LeoLi@freescale.com>,
	"wsa@the-dreams.de" <wsa@the-dreams.de>,
	"wim@iguana.be" <wim@iguana.be>, "corbet@lwn.net" <corbet@lwn.net>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@codeaurora.org" <sboyd@codeaurora.org>,
	Wenbin Song <Wenbin.Song@freescale.com>
Subject: RE: [PATCH V3 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
Date: Thu, 15 Oct 2015 07:34:12 +0000
Message-ID: <CY1PR0301MB0780F8F64723E9FE9EFEB0DD8B3E0@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
	 <1444822498-16477-5-git-send-email-B48286@freescale.com>
 <1444881407.5185.232.camel@freescale.com>
In-Reply-To: <1444881407.5185.232.camel@freescale.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogMjAxNeW5tDEw5pyIMTXml6UgMTE6NTcNCj4gVG86IEhvdSBaaGlxaWFuZy1C
NDgyODYNCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgY2F0YWxp
bi5tYXJpbmFzQGFybS5jb207DQo+IHdpbGwuZGVhY29uQGFybS5jb207IGxpbnV4LWkyY0B2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiB3YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWRv
Y0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBjbGtAdmdlci5rZXJuZWwub3JnOyBtYXJrLnJ1
dGxhbmRAYXJtLmNvbTsgSHUgTWluZ2thaS1CMjEyODQ7IFhpZQ0KPiBTaGFvaHVpLUIyMTk4OTsg
U2hhcm1hIEJodXBlc2gtQjQ1MzcwOyBMaSBZYW5nLUxlby1SNTg0NzI7IHdzYUB0aGUtDQo+IGRy
ZWFtcy5kZTsgd2ltQGlndWFuYS5iZTsgY29yYmV0QGx3bi5uZXQ7IG10dXJxdWV0dGVAYmF5bGli
cmUuY29tOw0KPiBzYm95ZEBjb2RlYXVyb3JhLm9yZzsgU29uZyBXZW5iaW4tQjUzNzQ3DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggVjMgNC82XSBhcm02NC9sczEwNDNhOiBhZGQgRFRTIGZvciBGcmVl
c2NhbGUgTFMxMDQzQQ0KPiBTb0MNCj4gDQo+IE9uIFdlZCwgMjAxNS0xMC0xNCBhdCAxOTozNCAr
MDgwMCwgWmhpcWlhbmcgSG91IHdyb3RlOg0KPiA+IEZyb206IE1pbmdrYWkgSHUgPE1pbmdrYWku
SHVAZnJlZXNjYWxlLmNvbT4NCj4gPg0KPiA+IExTMTA0M2EgaXMgYW4gU29DIHdpdGggNCBBUk12
OCBBNTMgY29yZXMgYW5kIG1vc3Qgb3RoZXIgSVAgYmxvY2tzDQo+ID4gc2ltaWxhciB0byBMUzEw
MjFhIHdoaWNoIGNvbXBsaWVzIHRvIENoYXNzaXMgMi4xIHNwZWMuDQo+ID4NCj4gPiBGb2xsb3dp
bmcgbGV2ZWxzIG9mIERUU0kvRFRTIGZpbGVzIGhhdmUgYmVlbiBjcmVhdGVkIGZvciB0aGUgTFMx
MDQzQQ0KPiA+IFNvQyBmYW1pbHk6DQo+ID4NCj4gPiAtIGZzbC1sczEwNDNhLmR0c2k6DQo+ID4g
ICBEVFMtSW5jbHVkZSBmaWxlIGZvciBGU0wgTFMxMDQzQSBTb0MuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBMaSBZYW5nIDxsZW9saUBmcmVlc2NhbGUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEhvdSBaaGlxaWFuZyA8QjQ4Mjg2QGZyZWVzY2FsZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TWluZ2thaSBIdSA8TWluZ2thaS5IdUBmcmVlc2NhbGUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFdlbmJpbiBTb25nIDxXZW5iaW4uU29uZ0BmcmVlc2NhbGUuY29tPg0KPiA+IC0tLQ0KPiA+IFYz
Og0KPiA+ICAtIEFkZCBkZXZpY2UgdHJlZSBub2RlIGZvciBTQVRBLg0KPiA+ICAtIFJlbW92ZSBw
cm9wZXJpdHkgZW5hYmxlLW1ldGhvZCBmb3IgYWxsIGNwdSBub2RlLg0KPiA+ICAgIFJlbW92ZSBy
ZXNlcnZlZCBtZW1vcnkgcmVnaW9uIGZvciBzcGluLXRhYmxlLg0KPiA+DQo+ID4gVjI6DQo+ID4g
IC0gQWRkIHNlY29uZGFyeSBjb3JlIGJvb3QgbWV0aG9kLg0KPiA+ICAtIE1vdmUgb3V0IHRoZSBz
eXNjbGsgbm9kZSBmcm9tIHRoZSBjbG9ja2dlbiBub2RlLg0KPiA+ICAtIENvcnJlY3QgdGhlIHJl
ZyBzaXplIG9mIEdJQ0MuDQo+ID4NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
ZnNsLWxzMTA0M2EuZHRzaSB8IDUxMw0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDUxMyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQzYS5kdHNpDQo+IA0K
PiBPbiB0aGUgbHMyMDh4IGRldmljZSB0cmVlIHdlIHdlcmUgYXNrZWQgdG8gcHV0IGRldmljZXMg
dW5kZXIgYSBidXMgbm9kZSwNCj4gc3VjaCBhcyBhbiBzb2Mgbm9kZSB3aXRoIGEgc2ltcGxlLWJ1
cyBjb21wYXRpYmxlLg0KPiANCg0KVGhhbmtzLCB3aWxsIHJlZm9ybS4NCg0KVGhhbmtzLA0KWmhp
cWlhbmcNCg==
