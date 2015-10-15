Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-by2on0128.outbound.protection.outlook.com ([207.46.100.128]:17124
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751478AbbJODcn (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 14 Oct 2015 23:32:43 -0400
From: Hou Zhiqiang <B48286@freescale.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	Hu Vincent <Mingkai.Hu@freescale.com>,
	Shaohui Xie <Shaohui.Xie@freescale.com>,
	"Scott Wood" <scottwood@freescale.com>,
	Sharma Bhupesh <bhupesh.sharma@freescale.com>,
	Li Leo <LeoLi@freescale.com>,
	"wsa@the-dreams.de" <wsa@the-dreams.de>,
	"wim@iguana.be" <wim@iguana.be>, "corbet@lwn.net" <corbet@lwn.net>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@codeaurora.org" <sboyd@codeaurora.org>,
	Wenbin Song <Wenbin.Song@freescale.com>
Subject: RE: [PATCH V3 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
Date: Thu, 15 Oct 2015 03:32:40 +0000
Message-ID: <CY1PR0301MB07803635FF7E642C48EDE3648B3E0@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
 <1444822498-16477-5-git-send-email-B48286@freescale.com>
 <20151014124353.GC2150@leverpostej>
In-Reply-To: <20151014124353.GC2150@leverpostej>
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyayBSdXRsYW5kIFtt
YWlsdG86bWFyay5ydXRsYW5kQGFybS5jb21dDQo+IFNlbnQ6IDIwMTXE6jEw1MIxNMjVIDIwOjQ0
DQo+IFRvOiBIb3UgWmhpcWlhbmctQjQ4Mjg2DQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiB3aWxsLmRlYWNvbkBh
cm0uY29tOyBsaW51eC1pMmNAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gd2F0Y2hkb2dAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gY2xrQHZn
ZXIua2VybmVsLm9yZzsgSHUgTWluZ2thaS1CMjEyODQ7IFhpZSBTaGFvaHVpLUIyMTk4OTsgV29v
ZCBTY290dC0NCj4gQjA3NDIxOyBTaGFybWEgQmh1cGVzaC1CNDUzNzA7IExpIFlhbmctTGVvLVI1
ODQ3Mjsgd3NhQHRoZS1kcmVhbXMuZGU7DQo+IHdpbUBpZ3VhbmEuYmU7IGNvcmJldEBsd24ubmV0
OyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsNCj4gc2JveWRAY29kZWF1cm9yYS5vcmc7IFNvbmcg
V2VuYmluLUI1Mzc0Nw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDQvNl0gYXJtNjQvbHMxMDQz
YTogYWRkIERUUyBmb3IgRnJlZXNjYWxlIExTMTA0M0ENCj4gU29DDQo+IA0KPiBIaSwNCj4gDQo+
ID4gKwlwbXUgew0KPiA+ICsJCWNvbXBhdGlibGUgPSAiYXJtLGFybXY4LXBtdXYzIjsNCj4gPiAr
CQlpbnRlcnJ1cHRzID0gPDAgMTA2IDB4ND4sDQo+ID4gKwkJCSAgICAgPDAgMTA3IDB4ND4sDQo+
ID4gKwkJCSAgICAgPDAgOTUgMHg0PiwNCj4gPiArCQkJICAgICA8MCA5NyAweDQ+Ow0KPiA+ICsJ
fTsNCj4gDQo+IFlvdSBzaG91bGQgaGF2ZSBpbnRlcnJ1cHQtYWZmaW5pdHkgaGVyZS4gU2VlDQo+
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vcG11LnR4dA0KPiANCj4gT3Ro
ZXJ3aXNlIHRoaXMgbG9va3Mgb2suDQo+IA0KDQpUaGFua3MgZm9yIHlvdXIgY29ycmVjdGlvbi4N
Cg0KVGhhbmtzLA0KWmhpcWlhbmcNCg==
