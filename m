Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15386 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbbLTMxM (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 20 Dec 2015 07:53:12 -0500
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Guenter Roeck <linux@roeck-us.net>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	"Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next v2 7/7] watchdog: mei_wdt: re-register device
 on event
Date: Sun, 20 Dec 2015 12:53:07 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B540EEC58@hasmsx108.ger.corp.intel.com>
References: <1450363780-30008-1-git-send-email-tomas.winkler@intel.com>
	<1450363780-30008-8-git-send-email-tomas.winkler@intel.com>
	<56743CD9.3000708@roeck-us.net>
	<20151218171939.57bf5621@lxorguk.ukuu.org.uk>
	<56744757.2060101@roeck-us.net> <20151218181412.49357bfe@lxorguk.ukuu.org.uk>
In-Reply-To: <20151218181412.49357bfe@lxorguk.ukuu.org.uk>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

PiANCj4gPiA+IFRoYXQgYnJlYWtzIHRoZSBleGlzdGluZyBiZWhhdmlvdXIgb2YgaG90IHBsdWdn
YWJsZSB3YXRjaGRvZyBpbnRlcmZhY2VzDQo+ID4gPiBhbmQgaXMgZGlmZmVyZW50IHRvIGp1c3Qg
YWJvdXQgYW55IG90aGVyIGRldmljZSBpbiB0aGUga2VybmVsLiBUb2RheSB3aXRoDQo+ID4gPiBh
bnkgZGVza3RvcCBvciBzZXJ2ZXIgZGlzdHJpYnV0aW9uIHlvdSBjYW4gYWxyZWFkeSB0cml2aWFs
bHkgYXJyYW5nZSBmb3INCj4gPiA+IHdhdGNoZG9nIGRhZW1vbnMgdG8gc3RhcnQgYXQgdGhlIHBv
aW50IGEgd2F0Y2hkb2cgaXMgZGV0ZWN0ZWQgZHluYW1pY2FsbHkuDQo+ID4gPg0KPiA+DQo+ID4g
T2ssIHlvdSBoYXZlIGEgcG9pbnQuIFdvbmRlciBpZiBhbnkgZGlzdHJpYnV0aW9ucyBhcmUgZG9p
bmcgdGhhdCwgdGhvdWdoLg0KPiA+IEFueSBpZGVhID8NCj4gDQo+IEkgZG9uJ3Qga25vdyBmb3Ig
YW55IG9mIHRoZSBvdXQgb2YgdGhlIGJveCBtYWluc3RyZWFtIG9uZXMuDQo+IA0KPiBUaGVyZSBp
cyBhIHNlY29uZCBwcm9ibGVtIGlmIHlvdSByZWdpc3RlciB0aGUgd2F0Y2hkb2cgYnV0IGRvbid0
IGFjdHVhbGx5DQo+IGhhdmUgaXQgZW5hYmxlZC4gQ29uc2lkZXIgdGhlIGNhc2Ugd2hlcmUgYSB1
c2VyIGhhcyB0aGUgbWVpIHdhdGNoZG9nDQo+IGRpc2FibGVkIGFuZCBhIG1vcmUgYWR2YW5jZWQg
d2F0Y2hkb2cgY2FyZCBwbHVnZ2VkIGluIC0gaW4gdGhhdCBjYXNlIHRoZQ0KPiBuYcOvdmVseSBp
bXBsZW1lbnRlZCBleGlzdGluZyB3YXRjaGRvZyBhcHAgbWF5IGJpbmQgdG8gdGhlIG5vbi1mdW5j
dGlvbmFsDQo+IHdhdGNoZG9nLCBub3QgdGhlIGNvcnJlY3Qgb25lLg0KDQpUaGF0J3MgY29ycmVj
dCwgdGhvdWdoICBXRElPRl9BTEFSTU9OTFkgb3IgZGV2aWNlIGlkZW50aXR5IGhhcyB0byBiZSBj
aGVja2VkLiANCkFuZCBpZiBtZWkgaXMgZGlzYWJsZWQgb25lIHdvdWxkIHByb2JhYmx5IGhpdCBF
Tk9ERVYsIHN0aWxsIHRoZXJlIHdpbGwgYmUgbm8gdWV2ZW50IHRvIHRoZSB1c2VyIHNwYWNlDQp3
aGVuIHRoZSBkZXZpY2UgaXMgcHJvdmlzaW9uZWQgYWdhaW4sIHNvIHN0aWxsIEkgcHJlZmVyIGFk
ZC9yZW1vdmluZyB0aGUgd2F0Y2hkb2cgZGV2aWNlLiANCg0KVGhhbmtzDQpUb21hcw0KDQo=
