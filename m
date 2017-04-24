Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.163]:43905 "EHLO
        mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1168624AbdDXKh2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 24 Apr 2017 06:37:28 -0400
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Lee Jones <lee.jones@linaro.org>
CC: LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        DEVICETREE <devicetree@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Support Opensource" <Support.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH V7 4/7] mfd: da9061: MFD core support
Date: Mon, 24 Apr 2017 10:37:18 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CD71434@SW-EX-MBX02.diasemi.com>
References: <cover.1491230802.git.stwiss.opensource@diasemi.com>
 <b39c8c3f42a01a00f93292c569e8d30ce69ff3ab.1491230802.git.stwiss.opensource@diasemi.com>
 <20170404083902.ywo3pdxptgfcqvga@dell>
In-Reply-To: <20170404083902.ywo3pdxptgfcqvga@dell>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

T24gMDQgQXByaWwgMjAxNyAwOTozOSwgTGVlIEpvbmVzIHdyb3RlOg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIFY3IDQvN10gbWZkOiBkYTkwNjE6IE1GRCBjb3JlIHN1cHBvcnQNCj4gDQo+IE9uIE1v
biwgMDMgQXByIDIwMTcsIFN0ZXZlIFR3aXNzIHdyb3RlOg0KPiA+IEZyb206IFN0ZXZlIFR3aXNz
IDxzdHdpc3Mub3BlbnNvdXJjZUBkaWFzZW1pLmNvbT4NCj4gPiBNRkQgc3VwcG9ydCBmb3IgREE5
MDYxIGlzIHByb3ZpZGVkIGFzIHBhcnQgb2YgdGhlIERBOTA2MiBkZXZpY2UgZHJpdmVyLg0KPiA+
DQo+ID4gVGhlIHJlZ2lzdGVycyBoZWFkZXIgZmlsZSBhZGRzIHR3byBuZXcgY2hpcCB2YXJpYW50
IElEcyBkZWZpbmVkIGluIERBOTA2MQ0KPiA+IGFuZCBEQTkwNjIgaGFyZHdhcmUuIFRoZSBjb3Jl
IGhlYWRlciBmaWxlIGFkZHMgbmV3IHNvZnR3YXJlIGVudW1lcmF0aW9ucw0KPiA+IGZvciBsaXN0
aW5nIHRoZSB2YWxpZCBEQTkwNjEgSVJRcyBhbmQgYSBkYTkwNjJfY29tcGF0aWJsZV90eXBlcyBl
bnVtZXJhdGlvbg0KPiA+IGZvciBkaXN0aW5ndWlzaGluZyBiZXR3ZWVuIERBOTA2MS82MiBkZXZp
Y2VzIGluIHNvZnR3YXJlLg0KPiA+DQo+ID4gVGhlIGNvcmUgc291cmNlIGNvZGUgYWRkcyBhIG5l
dyAuY29tcGF0aWJsZSBvZl9kZXZpY2VfaWQgZW50cnkuIFRoaXMgaXMNCj4gPiBleHRlbmRlZCBm
cm9tIERBOTA2MiB0byBzdXBwb3J0IGJvdGggImRsZyxkYTkwNjEiIGFuZCAiZGxnLGRhOTA2MiIu
IFRoZQ0KPiA+IC5kYXRhIGVudHJ5IG5vdyBob2xkcyBhIHJlZmVyZW5jZSB0byB0aGUgZW51bWVy
YXRlZCBkZXZpY2UgdHlwZS4NCj4gPg0KPiA+IEEgbmV3IHJlZ21hcF9pcnFfY2hpcCBtb2RlbCBp
cyBhZGRlZCBmb3IgREE5MDYxIGFuZCB0aGlzIHN1cHBvcnRzIHRoZSBuZXcNCj4gPiBsaXN0IG9m
IHJlZ21hcF9pcnEgZW50cmllcy4gQSBuZXcgbWZkX2NlbGwgZGE5MDYxX2RldnNbXSBhcnJheSBs
aXN0cyB0aGUNCj4gPiBuZXcgc3ViIHN5c3RlbSBjb21wb25lbnRzIGZvciBEQTkwNjEuIFN1cHBv
cnQgaXMgYWRkZWQgZm9yIGEgbmV3IERBOTA2MQ0KPiA+IHJlZ21hcF9jb25maWcgd2hpY2ggbGlz
dHMgdGhlIGNvcnJlY3QgcmVhZGFibGUsIHdyaXRhYmxlIGFuZCB2b2xhdGlsZQ0KPiA+IHJhbmdl
cyBmb3IgdGhpcyBjaGlwLg0KPiA+DQo+ID4gVGhlIHByb2JlIGZ1bmN0aW9uIHVzZXMgdGhlIGRl
dmljZSB0cmVlIGNvbXBhdGlibGUgc3RyaW5nIHRvIHN3aXRjaCBvbiB0aGUNCj4gPiBkYTkwNjJf
Y29tcGF0aWJsZV90eXBlcyBhbmQgY29uZmlndXJlIHRoZSBjb3JyZWN0IG1mZCBjZWxscywgaXJx
IGNoaXAgYW5kDQo+ID4gcmVnbWFwIGNvbmZpZy4NCj4gPg0KPiA+IEtjb25maWcgaXMgdXBkYXRl
ZCB0byByZWZsZWN0IHN1cHBvcnQgZm9yIERBOTA2MSBhbmQgREE5MDYyIFBNSUNzLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogU3RldmUgVHdpc3MgPHN0d2lzcy5vcGVuc291cmNlQGRpYXNlbWku
Y29tPg0KPiANCj4gQWgsIGhlcmUgaXQgaXMuDQo+IA0KPiBBcHBsaWVkLCB0aGFua3MuDQoNCkhp
IExlZSwNCg0KSSBub3RpY2VkIHRoZSBEQTkwNjEgY29yZSBzdXBwb3J0IGhhcyBiZWVuIGFkZGVk
IGludG8gbGludXgtbmV4dCwgaG93ZXZlcg0KdGhlIGNvbW1pdCBtZXNzYWdlIHdhcyBjaGFuZ2Vk
IGZyb20gdGhlIG9yaWdpbmFsIHRpdGxlOg0KDQoibWZkOiBkYTkwNjE6IE1GRCBjb3JlIHN1cHBv
cnQiDQoNCnRvIGFkZCB0aGUgbWlzdGFrZToNCg0KIm1mZDogQWRkIHN1cHBmb3IgZm9yIERBOTA2
MSINCg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4
dC9saW51eC1uZXh0LmdpdC9jb21taXQvP2lkPWQzZmUwODA2MDI1Y2FjZGFiMTQ2MmQ1NzA0ZTFj
OThhYjlkYjQ1NjQNCg0KQ2FuIHRoaXMgYmUgZml4ZWQgcGxlYXNlPw0KVGhpcyBwYXRjaCBoYXMg
bm90IGJlZW4gdXBzdHJlYW1lZCBpbnRvIGxpbnV4LW1haW5saW5lIGFuZCBpcyBzdGlsbCBpbiBs
aW51eC1uZXh0Lg0KDQpSZWdhcmRzLA0KU3RldmUNCg==
