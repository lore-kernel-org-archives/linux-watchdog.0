Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx.socionext.com ([202.248.49.38]:16424 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161750AbdEYFzc (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 25 May 2017 01:55:32 -0400
From: <yamada.masahiro@socionext.com>
To: <hayashibara.keiji@socionext.com>, <wim@iguana.be>,
        <linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <masami.hiramatsu@linaro.org>, <jaswinder.singh@linaro.org>,
        <hayashi.kunihiko@socionext.com>, <owada.kiyoshi@socionext.com>,
        <hayashibara.keiji@socionext.com>
Subject: RE: [PATCH 1/2] watchdog: uniphier: add UniPhier watchdog driver
Date: Thu, 25 May 2017 05:45:39 +0000
Message-ID: <24780eb20b3c4aecb1f5112e1827d5e1@SOC-EX01V.e01.socionext.com>
References: <1495607692-657-1-git-send-email-hayashibara.keiji@socionext.com>
 <1495607692-657-2-git-send-email-hayashibara.keiji@socionext.com>
In-Reply-To: <1495607692-657-2-git-send-email-hayashibara.keiji@socionext.com>
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

SGkgSGF5YXNoaWJhcmEtc2FuDQoNCg0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy93YXRjaGRvZy91bmlwaGllci13ZHQudHh0DQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3dhdGNoZG9nL3VuaXBoaWVyLXdkdC50eHQNCj4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uYTU5ZDFiYQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy91bmlwaGllci13ZHQu
dHh0DQo+IEBAIC0wLDAgKzEsMjAgQEANCj4gK1VuaVBoaWVyIHdhdGNoZG9nIHRpbWVyIGNvbnRy
b2xsZXINCj4gKw0KPiArVGhpcyBVbmlQaGllciB3YXRjaGRvZyB0aW1lciBjb250cm9sbGVyIG11
c3QgYmUgdW5kZXIgc3lzY3RybCBjb21wYXRpYmxlDQo+IG5vZGUuDQo+ICsNCj4gK1JlcXVpcmVk
IHByb3BlcnRpZXM6DQo+ICstIGNvbXBhdGlibGU6IHNob3VsZCBiZSAic29jaW9uZXh0LHVuaXBo
aWVyLXdkdCINCj4gKw0KPiArRXhhbXBsZToNCj4gKw0KPiArCXN5c2N0cmxANjE4NDAwMDAgew0K
PiArCQljb21wYXRpYmxlID0gInNvY2lvbmV4dCx1bmlwaGllci1sZDExLXN5c2N0cmwiLA0KPiAr
CQkJICAgICAic2ltcGxlLW1mZCIsICJzeXNjb24iOw0KPiArCQlyZWcgPSA8MHg2MTg0MDAwMCAw
eDQwMDA+Ow0KPiArDQo+ICsJCXN5c193ZHQ6IHdhdGNoZG9nIHsNCj4gKwkJCWNvbXBhdGlibGUg
PSAic29jaW9uZXh0LHVuaXBoaWVyLXdkdCI7DQo+ICsJCX0NCj4gKw0KPiArCQlvdGhlciBub2Rl
cyAuLi4NCj4gKwl9Ow0KDQoNCk5leHQgdGltZSwgcGxlYXNlIGluY2x1ZGUNCmRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnDQooYW5kIFJvYikgaW4geW91ciBDQyBsaXN0IGZvciBiaW5kaW5nIHJl
dmlldy4NCg0KSSB0aGluayBzY3JpcHRzL2dldF9tYWludGFpbmVyLnBsIHdpbGwgZG8gaXQgY29y
cmVjdGx5IGZvciB5b3UuDQoNCg0KDQoNCg0KPiArI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQoN
CklzIHRoaXMgdXNlZD8NCg0KDQpUaGFua3MuDQo=
