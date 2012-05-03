Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:43501 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab2ECFYT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 May 2012 01:24:19 -0400
Received: from epcpsbge1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M3F00G3CLO768K0@mailout2.samsung.com> for
 linux-watchdog@vger.kernel.org; Thu, 03 May 2012 14:24:18 +0900 (KST)
Date: Thu, 03 May 2012 05:24:18 +0000 (GMT)
From: =?euc-kr?B?x9S47cHW?= <myungjoo.ham@samsung.com>
Subject: Re: Re: [PATCH] watchdog: s3c2410-wdt: Use of_match_ptr().
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	=?euc-kr?Q?=C1=A4=C0=E7=C8=C6?= <jh80.chung@samsung.com>,
	BANAJIT GOSWAMI <banajit.g@samsung.com>,
	Ben Dooks <ben-linux@fluff.org>, Ben Dooks <ben@simtec.co.uk>,
	Wolfram Sang <w.sang@pengutronix.de>
Reply-to: myungjoo.ham@samsung.com
MIME-version: 1.0
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <26374439.134981336022657739.JavaMail.weblogic@epml09>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

PiBIaSwNCj4gDQo+ID4gDQo+ID4gPiBVc2Ugb2ZfbWF0Y2hfcHRyIGRlZmluaXRpb24gZm9yIHRo
ZSBvZl9tYXRjaF90YWJsZS4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogV2ltIFZhbiBT
ZWJyb2VjayA8d2ltQGlndWFuYS5iZT4NCj4gPiA+IA0KPiA+ID4gLS0tDQo+ID4gPiANCj4gPiA+
IENhbiBzb21lb25lIGNvbXBpbGUgdGVzdCB0aGlzPw0KPiA+ID4gDQo+ID4gPiBUaGFua3MsDQo+
ID4gPiBXaW0uDQo+ID4gDQo+ID4gDQo+ID4gSSBnZXQgdGhpcyBlcnJvci4gWW91IHByb2JhYmx5
IG5lZWQgdG8gYWRkICNpbmNsdWRlLg0KPiA+IA0KPiA+IHNjcmlwdHMva2NvbmZpZy9jb25mIC0t
c2lsZW50b2xkY29uZmlnIEtjb25maWcNCj4gPiAgIENISyAgICAgaW5jbHVkZS9saW51eC92ZXJz
aW9uLmgNCj4gPiAgIENISyAgICAgaW5jbHVkZS9nZW5lcmF0ZWQvdXRzcmVsZWFzZS5oDQo+ID4g
bWFrZVsxXTogYGluY2x1ZGUvZ2VuZXJhdGVkL21hY2gtdHlwZXMuaCcgaXMgdXAgdG8gZGF0ZS4N
Cj4gPiAgIENBTEwgICAgc2NyaXB0cy9jaGVja3N5c2NhbGxzLnNoDQo+ID4gICBDSEsgICAgIGlu
Y2x1ZGUvZ2VuZXJhdGVkL2NvbXBpbGUuaA0KPiA+ICAgQ0MgICAgICBkcml2ZXJzL3dhdGNoZG9n
L3dhdGNoZG9nX2NvcmUubw0KPiA+ICAgQ0MgICAgICBkcml2ZXJzL3dhdGNoZG9nL3dhdGNoZG9n
X2Rldi5vDQo+ID4gICBDQyAgICAgIGRyaXZlcnMvd2F0Y2hkb2cvczNjMjQxMF93ZHQubw0KPiA+
ICAgTEQgICAgICBkcml2ZXJzL3dhdGNoZG9nL3dhdGNoZG9nLm8NCj4gPiBkcml2ZXJzL3dhdGNo
ZG9nL3MzYzI0MTBfd2R0LmM6NTE3OjM6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBm
dW5jdGlvbiChrm9mX21hdGNoX3B0cqGvDQo+ID4gZHJpdmVycy93YXRjaGRvZy9zM2MyNDEwX3dk
dC5jOjUxNzozNDogZXJyb3I6IKGuczNjMjQxMF93ZHRfbWF0Y2ihryB1bmRlY2xhcmVkIGhlcmUg
KG5vdCBpbiBhIGZ1bmN0aW9uKQ0KPiA+IG1ha2VbMl06ICoqKiBbZHJpdmVycy93YXRjaGRvZy9z
M2MyNDEwX3dkdC5vXSBFcnJvciAxDQo+ID4gbWFrZVsyXTogKioqIFdhaXRpbmcgZm9yIHVuZmlu
aXNoZWQgam9icy4uLi4NCj4gPiBtYWtlWzFdOiAqKiogW2RyaXZlcnMvd2F0Y2hkb2ddIEVycm9y
IDINCj4gPiBtYWtlOiAqKiogW2RyaXZlcnNdIEVycm9yIDINCj4gDQo+IENhbiB5b3UgdHJ5IHdp
dGg6ICNpbmNsdWRlIDxsaW51eC9vZi5oPiA/DQoNClN1cmUsIGl0IGNvbXBpbGVzIHN1Y2Nlc3Nm
dWxseSBpZiAjaW5jbHVkZSA8bGludXgvb2YuaD4gaXMgYWRkZWQuDQoNCg0KV2l0aCB0aGUgI2lu
Y2x1ZGUgZXhwcmVzc2lvbiwNCkFja2VkLWJ5OiBNeXVuZ0pvbyBIYW0gPG15dW5nam9vLmhhbUBz
YW1zdW5nLmNvbT4NCg0KVGhhbmsgeW91Lg0KDQoNCkNoZWVycyENCk15dW5nSm9vLg0KDQoNCj4g
DQo+IFRoYW5rcywNCj4gV2ltLg0KPiANCj4gDQo=


