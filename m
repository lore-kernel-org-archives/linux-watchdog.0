Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:53398 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbbBQMFI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 17 Feb 2015 07:05:08 -0500
MIME-Version: 1.0
Date: Tue, 17 Feb 2015 13:05:07 +0100
Message-ID: <CAMuHMdUasUmnHRi5t3GStrt-WKw0Das4noTmZPNtcbqA7nmDvQ@mail.gmail.com>
Subject: ARM: shmobile: koelsch: da9210/da9063 interrupt storm (was: Re:
 [PATCH 3/4] ARM: shmobile: koelsch: Add DA9063 PMIC device node for system restart)
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
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Dec 22, 2014 at 2:21 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sun, Dec 21, 2014 at 11:52 AM, Simon Horman <horms@verge.net.au> wrote:
>> On Tue, Dec 09, 2014 at 12:22:48PM +0100, Geert Uytterhoeven wrote:
>>> Add a minimal device node for the DA9063 PMIC, which is connected to i2c6.
>>> This allows the system to be restarted when the watchdog timer times
>>> out, or when a system restart is requested.
>>>
>>> Regulator support is not yet included, as no DT support code nor DT
>>> binding documentation exists for the regulator functionality.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Cc: devicetree@vger.kernel.org
>>
>> I had this queued up for v3.20, however, when rebasing on top
>> of v3.19-rca (previous base was v3.18) I noticed that this patch
>> appears to cause booting koelsch with shmobile_defconfig to
>> stop at:

>> random: nonblocking pool is initializered

> What does happen on every boot is that the da9063-irq value in
> /proc/interrupts is increasing fast. After a while, the kernel complains:
>
>     irq 125: nobody cared (try booting with the "irqpoll" option)
>     ...
>     Disabling IRQ #125

After digging deeper into GPIO, PFC, IRQC, and regulators for which I have no
datasheets (da9210 and da9063), I managed to find out what's happening.

The r8a7791/koelsch development board has da9210 and da9063 regulators.
Both regulators have their interrupt request lines tied to the same interrupt
pin (IRQ2) on the SoC.

After boot-up, both the da9210 and da9063 seem to assert their interrupt
request lines (more technical details at the bottom of this email).  Hence as
soon as one driver (for now da9063; the da9210 driver doesn't have interrupt
support yet) requests this irq, it gets stuck in an interrupt storm, as it only
manages to deassert its own interrupt request line, and the other driver hasn't
installed an interrupt handler yet.

As I have the da9210 listed before the da9063 in the DTS, it is initialized
first. I added code to the da9210 driver to mask its interrupts in its probe
function, which deasserts its interrupt request line. Later, when the da9063
driver is initialized, it only has to handle its own interrupt, and the
interrupt storm no longer happens.

However, as soon as the da9210 driver will get interrupt support (I wrote
something, based on the da9211 driver) and the da9210 will have an interrupts
property in DTS, the interrupt storm will reappear, irrespectively of the order
in which the two drivers are initialized.

So far I see only two solutions:
  - Add platform code that matches against "renesas,koelsch" (and
    "renesas,lager"), and mask the interrupts in both the da9210 and da9063.
    This code has to run after the i2c master driver has been initialized,
    but before the i2c slave drivers are initialized.
  - Handle the masking in the bootloader (u-boot), which already knows how to
    reset the board by kicking the da9063. This requires everybody to upgrade
    his bootloader, though.

Does anyone have a better solution?

I only investigated this on r8a7791/koelsch, but based on the schematics, I
think the same issue exists on r8a7790/lager.
r8a7794/alt is probably not affected, as I believe it doesn't have the da9210.
>From the vague pictures of r8a7791/porter and r8a7794/silk, it looks like they
do have a da9063, but also lack a da9210? Still, the da9063 interrupt pin might
be shared with another device.

You can check the IRQC pin state at any time by reading the 32-bit register at
address 0xe61c0104. E.g. from U-Boot:

    => md 0xe61c0104 1
    e61c0104: 000003fb    ....
    =>

If bit 2 is cleared, IRQ2 is asserted, which is the case after a cold boot on
r8a7791/koelsch.

Thanks for your comments and suggestions!


1. da9210 details

Register values at the time of driver initialization:

    da9210 6-0068:  STATUS_A = 0x00000011       GPI0 | GPI4
    da9210 6-0068:  STATUS_B = 0x00000000
    da9210 6-0068:   EVENT_A = 0x00000011       GPI0 | GPI4
    da9210 6-0068:   EVENT_B = 0x00000002       NPWRGOOD
    da9210 6-0068:    MASK_A = 0x00000000
    da9210 6-0068:    MASK_B = 0x00000000
    da9210 6-0068: CONTROL_A = 0x00000013       (slew rate/debouncing)

Installing an IRQ handler and clearing the events (cfr. the da9211 driver)
doesn't help, as the da9063 is also asserting the interrupt line.

Hence, I masked the interrupts to deassert the interrupt line from the da9210
side:

    MASK_A = ~0
    MASK_B = ~0

Setting MASK_B doesn't seem to be needed though. Presumably the interrupt is
triggered only if the corresponding bit in the STATUS register is set?

Question: Is it really the default state of the regulator to not mask
any interrupts?
Or could this have been changed by the bootloader? I couldn't find code related
to that in U-Boot, but as I didn't compile the bootloader myself, I can't be
100% certain about the source code.


2. da9063 details

Register values at the time of driver initialization:

    da9063 6-0058:   STATUS_A = 0x00000000
    da9063 6-0058:   STATUS_B = 0x00000006      GPI1 | GPI2
    da9063 6-0058:   STATUS_C = 0x00000020      GPI13
    da9063 6-0058:   STATUS_D = 0x00000000
    da9063 6-0058:  FAULT_LOG = 0x00000002      POR
    da9063 6-0058:    EVENT_A = 0x00000030      E_SEQ_RDY | EVENTS_B
    da9063 6-0058:    EVENT_B = 0x00000020      E_DVC_RDY
    da9063 6-0058:    EVENT_C = 0x00000000
    da9063 6-0058:    EVENT_D = 0x00000000
    da9063 6-0058: IRQ_MASK_A = 0x00000000
    da9063 6-0058: IRQ_MASK_B = 0x00000001      M_WAKE
    da9063 6-0058: IRQ_MASK_C = 0x00000000
    da9063 6-0058: IRQ_MASK_D = 0x00000001      GPI8
    da9063 6-0058:  CONTROL_A = 0x00000003      SYSTEM_EN | POWER_EN
    da9063 6-0058:  CONTROL_B = 0x00000009      CHG_SEL | NRES_MODE
    da9063 6-0058:  CONTROL_C = 0x0000005b      AUTO_BOOT | OTPREAD_EN |...
    da9063 6-0058:  CONTROL_D = 0x00000068      (blink)
    da9063 6-0058:  CONTROL_E = 0x0000000c      RTC_EN | ECO_MODE
    da9063 6-0058:  CONTROL_F = 0x00000000
    da9063 6-0058:     PD_DIS = 0x00000040      OUT_32K_PAUSE

The da9063 driver uses regmap_irq. As soon as regmap_irq_thread() has
acknowledged the two events it encountered:

    status_buf[0] = 0x00000020 (EVENTS_B)
    status_buf[1] = 0x00000020 (DVC_RDY)

the interrupt request line is deasserted. Note that handle_nested_irq() is not
called by regmap_irq_thread().

Lacking documentation, I guess EVENTS_B just means "also look in the EVENT_B
register", and DVC_RDY means that the regulator is ready, so this looks like a
fairly normal state.

Same question: Is it really the default state of the regulator to not mask any
interrupts (except for M_WAKE)?


3. Warm reboot

After deasserting the da9210 and da9063 interrupt request lines, it stays
deasserted:
  - Pressing the reset button doesn't reassert IRQ2 (da9063 nRESET is always
    pulled up, and da9210 doesn't have a reset line?),
  - Restart by da9063 restart handler (setting DA9063_SHUTDOWN in
    DA9063_REG_CONTROL_F) reasserts IRQ2,
  - Restart by da9063 watchdog also reasserts IRQ2.

>> I have (hopefully temporarily) dropped this patch accordingly.
>>
>>> ---
>>> Restart by watchdog timeout is working now.
>>> Manual system restart depends on "[PATCH 1/4] watchdog: da9063: Add restart
>>> handler support".
>>> ---
>>>  arch/arm/boot/dts/r8a7791-koelsch.dts | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
>>> index 6938377d3798644b..a400c27a813f1a8b 100644
>>> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
>>> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
>>> @@ -524,6 +524,13 @@
>>>               regulator-boot-on;
>>>               regulator-always-on;
>>>       };
>>> +
>>> +     pmic@58 {
>>> +             compatible = "dlg,da9063";
>>> +             reg = <0x58>;
>>> +             interrupt-parent = <&irqc0>;
>>> +             interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
>>> +     };
>>>  };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
