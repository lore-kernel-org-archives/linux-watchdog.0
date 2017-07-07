Return-Path: <marc.2377@gmail.com>
Return-path: <marc.2377@gmail.com>
MIME-Version: 1.0
In-Reply-To: <21338590-400b-e1b3-1787-bd275a30c17c@pr.hu>
References: <20170621035349.4125-1-zboszor@pr.hu> <20170622132134.7200-1-zboszor@pr.hu>
 <21338590-400b-e1b3-1787-bd275a30c17c@pr.hu>
From: "Marcelo \"Marc\" Ranolfi" <marc.2377@gmail.com>
Date: Thu, 6 Jul 2017 23:09:55 -0300
Message-ID: <CAETC-g-0ZYiD=j_sAtYpfr0t-rciiTx3ruvpGuwEud+nbbpiBg@mail.gmail.com>
Subject: Re: [PATCH 0/5 v4] Fix sp5100_tco watchdog driver regression
To: Boszormenyi Zoltan <zboszor@pr.hu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org,
	Paul Menzel <paulepanter@users.sourceforge.net>, Christian Fetzer <fetzer.ch@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Nehal Shah <nehal-bakulchandra.shah@amd.com>,
	Tim Small <tim@seoss.co.uk>, Guenter Roeck <linux@roeck-us.net>, kernel@ekass.net, wim@iguana.be,
	jlayton@poochiereds.net, cshorler@googlemail.com, wsa@the-dreams.de,
	regressions@leemhuis.info, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="001a114021d4c73f220553b0ba2b"
List-ID: <linux-watchdog@vger.kernel.org>

--001a114021d4c73f220553b0ba2b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zolt=C3=A1n and all,

I _was_ testing the patch series (the latest version), system worked OK for
two days, but then I got a system crash (probably hardware related) and
lost my files in the main partition. Posted about it in the F2FS mailing
list (https://sourceforge.net/p/linux-f2fs/mailman/message/35928135/).

While I don't believe that the freeze/crash was caused by the watchdog
driver (many other things to blame: amdgpu driver on Southern Islands, CPU
voltage lower than recommended...), it's worth mentioning that the computer
was completely frozen for a little over 4 minutes, and did not reset as I'd
expect the watchdog to. Just mentioning because I'm not sure of the
implications.

Once I get my system back online this weekend I'll have a good look at the
code. Anyway, thanks again for the patches and I'm also expecting someone
more qualified (than me, at least) to review them.

Regards
Marcelo "Marc" Ranolfi

On Thu, Jul 6, 2017 at 4:50 AM, Boszormenyi Zoltan <zboszor@pr.hu> wrote:

> Hi,
>
> ping for the series.
>
> Adding Greg Kroah-Hartman to the cc: list, both for the USB core
> and stable series maintainership.
>
>
> 2017-06-22 15:21 keltez=C3=A9ssel, Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi=
 =C3=ADrta:
>
>> This patch series fixes a regression introduced by:
>>
>> commit 2fee61d22e606fc99ade9079fda15fdee83ec33e
>> Author: Christian Fetzer <fetzer.ch@gmail.com>
>> Date:   Thu Nov 19 20:13:48 2015 +0100
>>
>>      i2c: piix4: Add support for multiplexed main adapter in SB800
>>
>> The regression caused sp5100_tco fail to load:
>>
>> sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
>> sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x42
>> sp5100_tco: I/O address 0x0cd6 already in use
>>
>> Notable bugzilla links about this issue:
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D170741
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1369269
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1406844
>>
>> The previous two versions of this patch series introduced
>> a common mutex to synchronize access to the I/O port pair
>> 0xcd6 / 0xcd7 used by the AMD SB800 USB PCI quirk code and
>> the i2c-piix and sp5100_tco drivers. The common mutex was
>> criticized because it introduces an inter-dependency between
>> drivers.
>>
>> This approach modifies the request_muxed_region() semantics and
>> modifies the possible use cases.
>>
>> The first patch in the series adds a new IORESOURCE_ALLOCATED
>> flag that alloc_resource() sets and free_resource() considers.
>> The core of __request_region() is factored out into a new function
>> that doesn't allocate. With this change, drivers can use the
>> pre-existing DEFINE_RES_IO_NAMED() static initialized macro
>> to declare struct resource statically (e.g. on the stack)
>> and pass the address of it to the new __request_declared_region()
>> function. A new macro called request_declared_muxed_region()
>> was added to exploit this functionality. Because of the new
>> IORESOURCE_ALLOCATED resource flag, release_region() can still
>> be called with the old interface (the port region start and
>> end values) and it won't attempt to free a non-allocated resource.
>> This eliminated one failure case that can come from allocation
>> errors.
>>
>> The second patch modifies the behaviour of IORESOURCE_MUXED,
>> a.k.a. the request_*muxed_region() macros. When these macros
>> are called, the caller goes to sleep when there is any conflicting
>> regions, even if the conflicting region did not use the
>> IORESOURCE_MUXED flag. The kernel logs this inconsistent
>> flag usage with KERN_ERR. This change eliminates the second
>> failure case for IORESOURCE_MUXED and request_muxed_region()
>> can be used like mutex_lock(), i.e. it returns only in case it
>> could successfully request the region.
>>
>> The last three patches adds proper synchronization between the
>> USB PCI quirks code and the i2c-piix and sp5100_tco drivers.
>>
>> The result is that the sp5100_tco driver can load and works again:
>>
>> sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
>> sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x42
>> sp5100_tco: Using 0xfed80b00 for watchdog MMIO address
>> sp5100_tco: Last reboot was not triggered by watchdog.
>> sp5100_tco: initialized (0xffffba2f4192db00). heartbeat=3D60 sec
>> (nowayout=3D0)
>>
>> Signed-off-by: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@pr.hu>
>> ---
>>   drivers/i2c/busses/i2c-piix4.c | 41 ++++++++++++------------------
>> -------
>>   drivers/usb/host/pci-quirks.c  |  4 ++++
>>   drivers/watchdog/sp5100_tco.c  | 28 +++++++++++++------------
>>   include/linux/ioport.h         | 14 +++++++++++++
>>   kernel/resource.c              | 46 ++++++++++++++++++++++++++++++
>> ++++++++----
>>   5 files changed, 88 insertions(+), 45 deletions(-)
>>
>>
>>
> The synchronized access to the SB800 I/O ports seems to also have made a
> rare
> "disabled by hub (EMI?), re-enabling..." report from the kernel disappear=
.
>
> Can someone review the series?
>
> Thanks in advance,
> Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi
>

--001a114021d4c73f220553b0ba2b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi Zolt=C3=A1n and all,<br><br></div>I=
 _was_ testing the patch series (the latest version), system worked OK for =
two days, but then I got a system crash (probably hardware related) and los=
t my files in the main partition. Posted about it in the F2FS mailing list =
(<a href=3D"https://sourceforge.net/p/linux-f2fs/mailman/message/35928135/"=
>https://sourceforge.net/p/linux-f2fs/mailman/message/35928135/</a>).<br><b=
r></div><div>While I don&#39;t believe that the freeze/crash was caused by =
the watchdog driver (many other things to blame: amdgpu driver on Southern =
Islands, CPU voltage lower than recommended...), it&#39;s worth mentioning =
that the computer was completely frozen for a little over 4 minutes, and di=
d not reset as I&#39;d expect the watchdog to. Just mentioning because I&#3=
9;m not sure of the implications.<br></div><div><br></div>Once I get my sys=
tem back online this weekend I&#39;ll have a good look at the code. Anyway,=
 thanks again for the patches and I&#39;m also expecting someone more quali=
fied (than me, at least) to review them.<br><br></div>Regards<br></div>Marc=
elo &quot;Marc&quot; Ranolfi<br></div><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">On Thu, Jul 6, 2017 at 4:50 AM, Boszormenyi Zoltan <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:zboszor@pr.hu" target=3D"_blank">zbosz=
or@pr.hu</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
ping for the series.<br>
<br>
Adding Greg Kroah-Hartman to the cc: list, both for the USB core<br>
and stable series maintainership.<div><div class=3D"h5"><br>
<br>
2017-06-22 15:21 keltez=C3=A9ssel, Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi =
=C3=ADrta:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
This patch series fixes a regression introduced by:<br>
<br>
commit 2fee61d22e606fc99ade9079fda15f<wbr>dee83ec33e<br>
Author: Christian Fetzer &lt;<a href=3D"mailto:fetzer.ch@gmail.com" target=
=3D"_blank">fetzer.ch@gmail.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Thu Nov 19 20:13:48 2015 +0100<br>
<br>
=C2=A0 =C2=A0 =C2=A0i2c: piix4: Add support for multiplexed main adapter in=
 SB800<br>
<br>
The regression caused sp5100_tco fail to load:<br>
<br>
sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05<br>
sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x42<br>
sp5100_tco: I/O address 0x0cd6 already in use<br>
<br>
Notable bugzilla links about this issue:<br>
<a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D170741" rel=3D"nor=
eferrer" target=3D"_blank">https://bugzilla.kernel.org/sh<wbr>ow_bug.cgi?id=
=3D170741</a><br>
<a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1369269" rel=3D"no=
referrer" target=3D"_blank">https://bugzilla.redhat.com/sh<wbr>ow_bug.cgi?i=
d=3D1369269</a><br>
<a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1406844" rel=3D"no=
referrer" target=3D"_blank">https://bugzilla.redhat.com/sh<wbr>ow_bug.cgi?i=
d=3D1406844</a><br>
<br>
The previous two versions of this patch series introduced<br>
a common mutex to synchronize access to the I/O port pair<br>
0xcd6 / 0xcd7 used by the AMD SB800 USB PCI quirk code and<br>
the i2c-piix and sp5100_tco drivers. The common mutex was<br>
criticized because it introduces an inter-dependency between<br>
drivers.<br>
<br>
This approach modifies the request_muxed_region() semantics and<br>
modifies the possible use cases.<br>
<br>
The first patch in the series adds a new IORESOURCE_ALLOCATED<br>
flag that alloc_resource() sets and free_resource() considers.<br>
The core of __request_region() is factored out into a new function<br>
that doesn&#39;t allocate. With this change, drivers can use the<br>
pre-existing DEFINE_RES_IO_NAMED() static initialized macro<br>
to declare struct resource statically (e.g. on the stack)<br>
and pass the address of it to the new __request_declared_region()<br>
function. A new macro called request_declared_muxed_region(<wbr>)<br>
was added to exploit this functionality. Because of the new<br>
IORESOURCE_ALLOCATED resource flag, release_region() can still<br>
be called with the old interface (the port region start and<br>
end values) and it won&#39;t attempt to free a non-allocated resource.<br>
This eliminated one failure case that can come from allocation<br>
errors.<br>
<br>
The second patch modifies the behaviour of IORESOURCE_MUXED,<br>
a.k.a. the request_*muxed_region() macros. When these macros<br>
are called, the caller goes to sleep when there is any conflicting<br>
regions, even if the conflicting region did not use the<br>
IORESOURCE_MUXED flag. The kernel logs this inconsistent<br>
flag usage with KERN_ERR. This change eliminates the second<br>
failure case for IORESOURCE_MUXED and request_muxed_region()<br>
can be used like mutex_lock(), i.e. it returns only in case it<br>
could successfully request the region.<br>
<br>
The last three patches adds proper synchronization between the<br>
USB PCI quirks code and the i2c-piix and sp5100_tco drivers.<br>
<br>
The result is that the sp5100_tco driver can load and works again:<br>
<br>
sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05<br>
sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x42<br>
sp5100_tco: Using 0xfed80b00 for watchdog MMIO address<br>
sp5100_tco: Last reboot was not triggered by watchdog.<br>
sp5100_tco: initialized (0xffffba2f4192db00). heartbeat=3D60 sec (nowayout=
=3D0)<br>
<br>
Signed-off-by: Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi &lt;<a href=3D"mailto=
:zboszor@pr.hu" target=3D"_blank">zboszor@pr.hu</a>&gt;<br>
---<br>
=C2=A0 drivers/i2c/busses/i2c-piix4.c | 41 ++++++++++++------------------<w=
br>-------<br>
=C2=A0 drivers/usb/host/pci-quirks.c=C2=A0 |=C2=A0 4 ++++<br>
=C2=A0 drivers/watchdog/sp5100_tco.c=C2=A0 | 28 +++++++++++++------------<b=
r>
=C2=A0 include/linux/ioport.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 14 +++++++=
++++++<br>
=C2=A0 kernel/resource.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
46 ++++++++++++++++++++++++++++++<wbr>++++++++----<br>
=C2=A0 5 files changed, 88 insertions(+), 45 deletions(-)<br>
<br>
<br>
</blockquote>
<br></div></div>
The synchronized access to the SB800 I/O ports seems to also have made a ra=
re<br>
&quot;disabled by hub (EMI?), re-enabling...&quot; report from the kernel d=
isappear.<br>
<br>
Can someone review the series?<br>
<br>
Thanks in advance,<br>
Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi<br>
</blockquote></div><br></div>

--001a114021d4c73f220553b0ba2b--
