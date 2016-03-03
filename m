Return-path: <hidehiro.kawai.ez@hitachi.com>
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
	<hidehiro.kawai.ez@hitachi.com>
To: "'Borislav Petkov'" <bp@alien8.de>, Michal Hocko <mhocko@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Thomas Mingarelli
	<thomas.mingarelli@hpe.com>,
        Wim Van Sebroeck <wim@iguana.be>, Corey Minyard
	<minyard@acm.org>,
        Javi Merino <javi.merino@arm.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "Steven
 Rostedt (Red Hat)" <rostedt@goodmis.org>,
        Rasmus Villemoes
	<linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        HATAYAMA Daisuke
	<d.hatayama@jp.fujitsu.com>,
        Gobinda Charan Maji <gobinda.cemk07@gmail.com>,
        Tejun Heo <tj@kernel.org>, Nicolas Iooss <nicolas.iooss_linux@m4x.org>,
        "openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>,
        Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: [v2 PATCH 1/3] panic: Change nmi_panic from macro to function
Date: Thu, 3 Mar 2016 01:28:53 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454B0B94E@GSjpTKYDCembx31.service.hitachi.net>
References: <20160302103624.5058.35844.stgit@softrs>
 <20160302103626.5058.74361.stgit@softrs>
 <20160302131824.GH26686@dhcp22.suse.cz> <20160302132251.GH16954@pd.tnic>
In-Reply-To: <20160302132251.GH16954@pd.tnic>
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

SGksDQoNCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IFttYWlsdG86YnBAYWxpZW44LmRlXQ0KPiBP
biBXZWQsIE1hciAwMiwgMjAxNiBhdCAwMjoxODoyNFBNICswMTAwLCBNaWNoYWwgSG9ja28gd3Jv
dGU6DQo+ID4gT24gV2VkIDAyLTAzLTE2IDE5OjM2OjI2LCBIaWRlaGlybyBLYXdhaSB3cm90ZToN
Cj4gPiBbLi4uXQ0KPiA+ID4gK3ZvaWQgbm1pX3BhbmljKHN0cnVjdCBwdF9yZWdzICpyZWdzLCBj
b25zdCBjaGFyICpmbXQsIC4uLikNCj4gPg0KPiA+IERvIHdlIHJlYWxseSBuZWVkIHZhcmdzPyBB
bGwgdGhlIGN1cnJlbnQgdXNlcnMgc2VlbSB0byBiZSBPSyB3aXRoIGENCj4gPiBzaW1wbGUgc3Ry
aW5nLiBUaGlzIG1ha2VzIHRoZSBjb2RlIHNsaWdodGx5IG1vcmUgY29tcGxpY2F0ZWQgd2l0aG91
dCBhbnkNCj4gPiBhcHBhcmVudCByZWFzb24uDQo+IA0KPiBJIHdhcyBqdXN0IHdvbmRlcmluZyB0
aGUgZXhhY3RseSBzYW1lIHRoaW5nLi4uDQo+IA0KPiBUaGUgY29udHJhLWFyZyB3b3VsZCBiZSB0
aGF0IGluIGNhc2Ugc29tZW9uZSB3YW50cyB0byBkbyBubWlfcGFuaWMoKQ0KPiB3aXRoIG1vcmUg
dGhhbiBhIHN0cmluZywgdGhlbiBpdCB3b24ndCB3b3JrLg0KDQpJdCdzIG5vdCBuZWNlc3Nhcnkg
dG8gdXNlIHZhcmdzIGF0IHRoaXMgcG9pbnQsIGFuZCBwYXNzaW5nIGEgc2ltcGxlDQpzdHJpbmcg
aXMgT0sgZm9yIG1lLiAgRXZlbiBpZiBzb21lb25lIHdhbnRzIHRvIHVzZSB2YXJncywgd2UgY2Fu
IG1vZGlmeQ0Kbm1pX3BhbmljKCkgd2l0aG91dCBhbnkgY2hhbmdlcyBpbiBjYWxsZXIgc2lkZS4g
IFNvLCBJJ2xsIHJlbW92ZSBpdC4NCg0KPiBUaGUgcXVlc3Rpb24gaXMsIGRvZXMgbm1pX3Bhbmlj
KCkgZXZlbiBuZWVkIHRvIGR1bXAgc29tZXRoaW5nIG1vcmUgdGhhbg0KPiByZWdzIGFuZCBhIHN0
cmluZz8NCg0KSG1tLCBwcmludGluZyByZWdzLCBlc3BlY2lhbGx5IGZvciBSSVAsIHdvdWxkIGJl
IHVzZWZ1bCBmb3IgaGFuZy11cA0KY2FzZXMsIGJ1dCBJIGRvbid0IHdhbnQgdG8gZG8gbXVjaCB0
aGluZ3MgaW4gbm1pX3BhbmljKCkgYXMgbG9uZyBhcw0KaXQgaXMgYWxyZWFkeSBkb25lIGJ5IGN1
cnJlbnQgY2FsbGVycy4gIG5taV9wYW5pYygpIGNhbiBiZSBjYWxsZWQNCmNvbmN1cnJlbnRseSBv
biBtdWx0aXBsZSBDUFVzLCBzbyBpdCBhbHNvIG5lZWRzIGFub3RoZXIgc2VyaWFsaXphdGlvbg0K
dG8gcHJpbnQgc29tZXRoaW5nLg0KDQpCeSB0aGUgd2F5LCBJIGhhdmUgYSBwYXRjaCBzZXQgdG8g
c2FmZWx5IGxlYXZlIGltcG9ydGFudCBpbmZvcm1hdGlvbg0KYnkga2V4ZWMncyBwdXJnYXRvcnku
Li5idXQgbm8gb25lIGlzIGludGVyZXN0ZWQgaW4/DQpodHRwOi8vdGhyZWFkLmdtYW5lLm9yZy9n
bWFuZS5saW51eC5rZXJuZWwua2V4ZWMvMTUzODINCg0KUmVnYXJkcywNCi0tDQpIaWRlaGlybyBL
YXdhaQ0KSGl0YWNoaSwgTHRkLiBSZXNlYXJjaCAmIERldmVsb3BtZW50IEdyb3VwDQoNCg0K
