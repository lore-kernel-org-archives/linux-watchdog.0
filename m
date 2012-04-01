Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:55433 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab2DAJHF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 1 Apr 2012 05:07:05 -0400
Received: by dake40 with SMTP id e40so1232202dak.11
        for <linux-watchdog@vger.kernel.org>; Sun, 01 Apr 2012 02:07:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACb=_tT1Wrx9C3=JDcQPEg-iHy_RERGZMQ+OPVQxu7+VX5BssA@mail.gmail.com>
References: <CAHgx9OfEQ1=CnW7SE12q2p_0xfCQYgm-4Wf6Mb1orV8LL12Nrw@mail.gmail.com>
	<CACb=_tS_ngh-tr4z3TFi29F6iTwe5L_ex_KDD63uPJV-89jb5g@mail.gmail.com>
	<CAHgx9OcM6WogbvNYFrjweLM4V6nxQ9749J7bdb6msz9++-OXMw@mail.gmail.com>
	<CACb=_tT1Wrx9C3=JDcQPEg-iHy_RERGZMQ+OPVQxu7+VX5BssA@mail.gmail.com>
Date: Sun, 1 Apr 2012 14:37:04 +0530
Message-ID: <CAHgx9Of-gHJGrWWULTd1Sa0=h6YP2Fundqp9v1DQr-YxEJ=TOQ@mail.gmail.com>
Subject: Re: Design ware Timer Source Code
From: Tushar K <tushark.kernel@gmail.com>
To: Jamie Iles <jamie@jamieiles.com>, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Jamie,

Thanks for reply.

I added support for DW Timer in my Linux BSP. I added code in below
fashion (not included OF related code). But after adding this code, my
kernel is not booting. It fails. I only see below print, and nothing
happens after that. I am not sure why its not going ahead and debug
this further.

Uncompressing Linux... done, booting the kernel.

Can you please provide me pointers if its possible for you? I think
integrated timer code is not working properly.
As per my understanding, Linux requires SYS Timer while its booting.
Can you please share what actually kernel requires at the time of
booting, i.e. how many timers, periodic mode / free running mode etc.

I have added below code.
Board specific timer_init function has below code

struct dw_apb_clock_event_device *ced;
       struct dw_apb_clocksource *cs;
       int irq =3D 32 + 39;
       int rate =3D 1000000;
       void __iomem *iobase =3D MMIO_P2V(0xF8002000);    // Address of Ti=
mer 0

       ced =3D dw_apb_clockevent_init(0, "dw-clk-event", 300, iobase, irq=
, rate);
       if(!ced)
               panic("Unable to initialise clockevent device");

       dw_apb_clockevent_register(ced);

       iobase =3D MMIO_P2V(0xF8002000 + 0x14);   // Address of Timer 1
       cs =3D dw_apb_clocksource_init(300, "dw-clk-src", iobase, rate);
 // Add timer 1 offset

       if(!cs)
               panic("Unable to initialise clocksource device");

       dw_apb_clocksource_start(cs);
       dw_apb_clocksource_register(cs);

I am working on ARM versatile express FPGA platform. Scheduler
function is used as of ARM Versatile express i.e.
versatile_sched_clock_init.

Last thing just wanted to understand, my Timer IP has 4 timers, but we
are just using 2 timers here. What about other two timers? Do I need
to make some provision in the Linux kernel BSP code, so that
applications can make use of it? I am not clear on this point.

Thanks & Reply,
Tushar

On Fri, Mar 30, 2012 at 3:49 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> On 29 March 2012 15:23, Tushar K <tushark.kernel@gmail.com> wrote:
>> Hi Jamie,
>>
>> Thanks for reply.
>> Is it possible for you to provide me the link on how to use the device
>> tree framework while writing a BSP code?
>> I tried to search but could not find concrete documentation on this.
>> If steps are given could be helpful for new comers.
>> Also please tell me if any ARM / non-ARM based SoC BSP which has
>> implemented device tree functionality. Would be helpful as a reference
>> code for my BSP.
>
> The documentation for this stuff is really still evolving. =A0I'd start
> by looking at the kernels Documentation/devicetree docs and some of
> the newer ARM platforms as a reference (zynq, highbank, picoxcell).
>
> Jamie
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
