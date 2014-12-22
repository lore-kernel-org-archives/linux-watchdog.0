Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:39624 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbaLVNVk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Dec 2014 08:21:40 -0500
MIME-Version: 1.0
In-Reply-To: <20141221105133.GA30697@verge.net.au>
References: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
	<1418124169-7123-4-git-send-email-geert+renesas@glider.be>
	<20141221105133.GA30697@verge.net.au>
Date: Mon, 22 Dec 2014 14:21:37 +0100
Message-ID: <CAMuHMdXtYT9LnDm4-PUw=oU_ixi0L7hMO6yS3uAjN-sH7qus_g@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: shmobile: koelsch: Add DA9063 PMIC device node
 for system restart
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <wsa@the-dreams.de>,
	Magnus Damm <magnus.damm@gmail.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lee Jones <lee.jones@linaro.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Linux I2C <linux-i2c@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Simon,

On Sun, Dec 21, 2014 at 11:52 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Dec 09, 2014 at 12:22:48PM +0100, Geert Uytterhoeven wrote:
>> Add a minimal device node for the DA9063 PMIC, which is connected to i2c6.
>> This allows the system to be restarted when the watchdog timer times
>> out, or when a system restart is requested.
>>
>> Regulator support is not yet included, as no DT support code nor DT
>> binding documentation exists for the regulator functionality.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: devicetree@vger.kernel.org
>
> Hi,
>
> I had this queued up for v3.20, however, when rebasing on top
> of v3.19-rca (previous base was v3.18) I noticed that this patch
> appears to cause booting koelsch with shmobile_defconfig to
> stop at:
>
> rcar_sound ec500000.rcar_sound: can't get dma channel
> rcar_sound ec500000.rcar_sound: src[3] (Gen2) failed
> rcar_sound ec500000.rcar_sound: ssi[1] fallback to PIO mode
> rcar_sound ec500000.rcar_sound: probed
> TCP: cubic registered
> NET: Registered protocol family 10
> da9063 6-0058: Failed to read IRQ status: -6
> sit: IPv6 over IPv4 tunneling driver
> NET: Registered protocol family 17
> Key type dns_resolver registered
> random: nonblocking pool is initializered

I could reproduce the issue on both renesas-devel-20141221-v3.19-rc1
and renesas-drivers-2014-12-22-v3.19-rc1.
It doesn't happen on every boot, though.

What does happen on every boot is that the da9063-irq value in
/proc/interrupts is increasing fast. After a while, the kernel complains:

    irq 125: nobody cared (try booting with the "irqpoll" option)
    ...
    Disabling IRQ #125

None of the above happen in my local development branch...

It turns out I don't see the problem because I (still) have code to disable all
unused MSTP clocks during startup.
If MSTP407 (IRQC) is disabled, everything works fine.
If it's left enabled, spurious interrupts are coming in.

Changing the interrupt to IRQ_TYPE_LEVEL_HIGH doesn't help, and
irq-renesas-irqc.c does use irq_domain_xlate_twocell, so I'm a bit lost...

> I have (hopefully temporarily) dropped this patch accordingly.
>
>> ---
>> Restart by watchdog timeout is working now.
>> Manual system restart depends on "[PATCH 1/4] watchdog: da9063: Add restart
>> handler support".
>> ---
>>  arch/arm/boot/dts/r8a7791-koelsch.dts | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
>> index 6938377d3798644b..a400c27a813f1a8b 100644
>> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
>> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
>> @@ -524,6 +524,13 @@
>>               regulator-boot-on;
>>               regulator-always-on;
>>       };
>> +
>> +     pmic@58 {
>> +             compatible = "dlg,da9063";
>> +             reg = <0x58>;
>> +             interrupt-parent = <&irqc0>;
>> +             interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
>> +     };
>>  };
>>
>>  &pci0 {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
