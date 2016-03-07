Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44]:49614 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbcCGKx5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 7 Mar 2016 05:53:57 -0500
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
	<hidehiro.kawai.ez@hitachi.com>
To: "'Borislav Petkov'" <bp@alien8.de>
CC: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Corey Minyard <minyard@acm.org>,
	Javi Merino <javi.merino@arm.com>,
	Michal Hocko <mhocko@suse.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"Steven Rostedt (Red Hat)" <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Michal Nazarewicz" <mina86@mina86.com>,
	Michal Hocko <mhocko@kernel.org>,
	"Vitaly Kuznetsov" <vkuznets@redhat.com>,
	HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
	Gobinda Charan Maji <gobinda.cemk07@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Nicolas Iooss <nicolas.iooss_linux@m4x.org>,
	"openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: RE: [v3 PATCH 1/3] panic: Change nmi_panic from macro to function
Date: Mon, 7 Mar 2016 10:53:51 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454B18988@GSjpTKYDCembx31.service.hitachi.net>
References: <20160303105741.4587.49047.stgit@softrs>
 <20160303105744.4587.1001.stgit@softrs> <20160303131458.GD24621@pd.tnic>
In-Reply-To: <20160303131458.GD24621@pd.tnic>
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

PiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgW21haWx0bzpicEBhbGllbjguZGVdDQo+IE9uIFRodSwg
TWFyIDAzLCAyMDE2IGF0IDA3OjU3OjQ0UE0gKzA5MDAsIEhpZGVoaXJvIEthd2FpIHdyb3RlOg0K
PiA+IENoYW5nZSBubWlfcGFuaWMoKSBtYWNybyB0byBhIG5vcm1hbCBmdW5jdGlvbiBmb3IgdGhl
IHBvcnRhYmlsaXR5Lg0KPiANCj4gcG9ydGFiaWxpdHk/DQoNCkkgd2FudGVkIHRvIHNheSBlbmNh
cHN1bGF0aW5nIHRoaW5ncyBpbnRvIGEgZnVuY3Rpb24gbWFrZXMgbW9kdWxlcw0Kb25seSBoYXZl
IHRvIGtub3cgYWJvdXQgdGhlIGZ1bmN0aW9uLiBNb2R1bGVzIGRvbid0IG5lZWQgdG8ga25vdw0K
YWxsIHRoaW5ncyBpbiB0aGUgbWFjcm8uICBCdXQgSSB0aG91Z2h0IGFnYWluLCBhbmQgYHBvcnRh
YmlsaXR5Jw0Kd2FzIG5vdCBhcHByb3ByaWF0ZS4NCg0KSG93ZXZlciwgdGhpcyBwYXRjaCBzZXQg
aGFzIGJlZW4gcXVldWVkIGludG8gLW1tIG5vdy4gIFNvIEknbGwNCmxlYXZlIHRoaXMgaWYgbm90
IG5lY2Vzc2FyeS4NCg0KUmVnYXJkcywNCkhpZGVoaXJvIEthd2FpDQoNCj4gPiBBbHNvLCBleHBv
cnQgaXQgZm9yIG1vZHVsZXMuDQo+ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIHYyOg0KPiA+IC0gTWFr
ZSBubWlfcGFuaWMgcmVjZWl2ZSBhIHNpbmdsZSBzdHJpbmcgaW5zdGVhZCBvZiBwcmludGYgc3R5
bGUgYXJncw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGlkZWhpcm8gS2F3YWkgPGhpZGVoaXJv
Lmthd2FpLmV6QGhpdGFjaGkuY29tPg0KPiA+IENjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4
LWZvdW5kYXRpb24ub3JnPg0KPiA+IENjOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+DQo+
ID4gQ2M6IE1pY2hhbCBOYXphcmV3aWN6IDxtaW5hODZAbWluYTg2LmNvbT4NCj4gPiBDYzogTWlj
aGFsIEhvY2tvIDxtaG9ja29Ac3VzZS5jb20+DQo+ID4gQ2M6IFJhc211cyBWaWxsZW1vZXMgPGxp
bnV4QHJhc211c3ZpbGxlbW9lcy5kaz4NCj4gPiBDYzogTmljb2xhcyBJb29zcyA8bmljb2xhcy5p
b29zc19saW51eEBtNHgub3JnPg0KPiA+IENjOiBKYXZpIE1lcmlubyA8amF2aS5tZXJpbm9AYXJt
LmNvbT4NCj4gPiBDYzogR29iaW5kYSBDaGFyYW4gTWFqaSA8Z29iaW5kYS5jZW1rMDdAZ21haWwu
Y29tPg0KPiA+IENjOiAiU3RldmVuIFJvc3RlZHQgKFJlZCBIYXQpIiA8cm9zdGVkdEBnb29kbWlz
Lm9yZz4NCj4gPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+ID4g
Q2M6IFZpdGFseSBLdXpuZXRzb3YgPHZrdXpuZXRzQHJlZGhhdC5jb20+DQo+ID4gQ2M6IEhBVEFZ
QU1BIERhaXN1a2UgPGQuaGF0YXlhbWFAanAuZnVqaXRzdS5jb20+DQo+ID4gQ2M6IFRlanVuIEhl
byA8dGpAa2VybmVsLm9yZz4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9saW51eC9rZXJuZWwuaCB8
ICAgMjEgKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIGtlcm5lbC9wYW5pYy5jICAgICAgICAg
fCAgIDIwICsrKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5z
ZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQo+IA0KPiBBY2tlZC1ieTogQm9yaXNsYXYgUGV0
a292IDxicEBzdXNlLmRlPg0KPiANCj4gLS0NCj4gUmVnYXJkcy9HcnVzcywNCj4gICAgIEJvcmlz
Lg0KPiANCj4gRUNPIHRpcCAjMTAxOiBUcmltIHlvdXIgbWFpbHMgd2hlbiB5b3UgcmVwbHkuDQo=
