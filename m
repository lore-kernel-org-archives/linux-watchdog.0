Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:46080 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeABQsY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 2 Jan 2018 11:48:24 -0500
Date: Tue, 02 Jan 2018 17:48:18 +0100
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 5/8] MIPS: jz4740: dts: Add bindings for the jz4740-wdt
 driver
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Message-Id: <1514911698.3623.1@smtp.crapouillou.net>
In-Reply-To: <CANc+2y5ZUM_ZzXaGgbx9b7O1GF4GrbaYsv97G+akvhP2d2VVUA@mail.gmail.com>
References: <20171228162939.3928-2-paul@crapouillou.net>
        <20171230135108.6834-1-paul@crapouillou.net>
        <20171230135108.6834-5-paul@crapouillou.net>
        <CANc+2y5ZUM_ZzXaGgbx9b7O1GF4GrbaYsv97G+akvhP2d2VVUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi PrasannaKumar,

Le mar. 2 janv. 2018 =E0 17:37, PrasannaKumar Muralidharan=20
<prasannatsmkumar@gmail.com> a =E9crit :
> Hi Paul,
>=20
> On 30 December 2017 at 19:21, Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>  Also remove the watchdog platform_device from platform.c, since it
>>  wasn't used anywhere anyway.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   arch/mips/boot/dts/ingenic/jz4740.dtsi |  8 ++++++++
>>   arch/mips/jz4740/platform.c            | 16 ----------------
>>   2 files changed, 8 insertions(+), 16 deletions(-)
>>=20
>>   v2: No change
>>=20
>>  diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi=20
>> b/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>  index cd5185bb90ae..26c6b561d6f7 100644
>>  --- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>  +++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
>>  @@ -45,6 +45,14 @@
>>                  #clock-cells =3D <1>;
>>          };
>>=20
>>  +       watchdog: watchdog@10002000 {
>>  +               compatible =3D "ingenic,jz4740-watchdog";
>>  +               reg =3D <0x10002000 0x10>;
>>  +
>>  +               clocks =3D <&cgu JZ4740_CLK_RTC>;
>>  +               clock-names =3D "rtc";
>>  +       };
>>  +
>=20
> The watchdog driver calls jz4740_timer_enable_watchdog and
> jz4740_timer_disable_watchdog which defined in
> arch/mips/jz4740/timer.c. It accesses registers iomapped by timer
> code. Declaring register size as 0x10 does not show the real picture.
> Better use register size as 0x100 and let timer, wdt, pwm drivers to
> share them.

As you said, it accesses registers iomapped by timer code. So the=20
watchdog
driver doesn't need to iomap them.

> Code from one of your branches
> (https://github.com/OpenDingux/linux/blob/for-upstream-clocksource/arch/m=
ips/boot/dts/ingenic/jz4740.dtsi)
> does it. Can you prepare a patch series and send it?
> I have a patch set that moves timer code out of arch/mips/jz4740/ and
> does a similar thing for watchdog and pwm. As your new timer driver is
> better than the existing one I have not sent my patches yet. I would
> like to see it getting mainlined as it paves way for removing most of
> code in arch/mips/jz4740.

The whole 'for-upstream-clocksource' branch is supposed to go upstream,
but I can't do it in one big patchset without having lots of breakages=20
with
my other patchsets (jz4770 SoC support, and jz4740 watchdog updates)
currently under review. That also makes it simpler to upstream than=20
having
one single patchset that touches 6 different frameworks (MIPS, irq,=20
clocks,
clocksource, watchdog, PWM).

So I will submit it in two steps, first the irq/clocks/clocksource=20
drivers
(this patchset) hopefully for 4.16, and then the platform/watchdog/PWM=20
fixes
for 4.17.

Kind regards,
-Paul
=

