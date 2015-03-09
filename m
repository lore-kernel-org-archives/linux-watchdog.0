Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:35884 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbbCILN5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 Mar 2015 07:13:57 -0400
Received: by wghk14 with SMTP id k14so23400335wgh.3
        for <linux-watchdog@vger.kernel.org>; Mon, 09 Mar 2015 04:13:56 -0700 (PDT)
Message-ID: <54FD8072.5010803@linaro.org>
Date: Mon, 09 Mar 2015 12:13:54 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lee Jones <lee.jones@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 8/9] clocksource: atmel-st: use syscon/regmap
References: <1425570594-13124-1-git-send-email-alexandre.belloni@free-electrons.com> <1425570594-13124-9-git-send-email-alexandre.belloni@free-electrons.com> <54F96896.6040204@linaro.org> <20150306084727.GH3989@piout.net>
In-Reply-To: <20150306084727.GH3989@piout.net>
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/06/2015 09:47 AM, Alexandre Belloni wrote:
> On 06/03/2015 at 09:43:02 +0100, Daniel Lezcano wrote :
>> On 03/05/2015 04:49 PM, Alexandre Belloni wrote:
>>> The register range from the system timer is also used by the watchd=
og driver.
>>> Use a regmap to handle concurrent accesses.
>>>
>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.=
com>
>>> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>>> ---
>>>   drivers/clocksource/timer-atmel-st.c | 99 ++++++++++++++---------=
-------------
>>>   1 file changed, 37 insertions(+), 62 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clockso=
urce/timer-atmel-st.c
>>> index 7d062ab32674..c4a52e32675e 100644
>>> --- a/drivers/clocksource/timer-atmel-st.c
>>> +++ b/drivers/clocksource/timer-atmel-st.c
>>> @@ -24,19 +24,19 @@
>>>   #include <linux/irq.h>
>>>   #include <linux/clockchips.h>
>>>   #include <linux/export.h>
>>> -#include <linux/of.h>
>>> -#include <linux/of_address.h>
>>> +#include <linux/mfd/syscon.h>
>>> +#include <linux/mfd/syscon/atmel-st.h>
>>>   #include <linux/of_irq.h>
>>> +#include <linux/regmap.h>
>>>
>>>   #include <asm/mach/time.h>
>>>
>>> -#include <mach/at91_st.h>
>>> -#include <mach/hardware.h>
>>> -
>>>   static unsigned long last_crtr;
>>>   static u32 irqmask;
>>>   static struct clock_event_device clkevt;
>>> +static struct regmap *regmap_st;
>>>
>>> +#define AT91_SLOW_CLOCK		32768
>>>   #define RM9200_TIMER_LATCH	((AT91_SLOW_CLOCK + HZ/2) / HZ)
>>>
>>>   /*
>>> @@ -46,11 +46,11 @@ static struct clock_event_device clkevt;
>>>    */
>>>   static inline unsigned long read_CRTR(void)
>>>   {
>>> -	unsigned long x1, x2;
>>> +	unsigned int x1, x2;
>>>
>>> -	x1 =3D at91_st_read(AT91_ST_CRTR);
>>> +	regmap_read(regmap_st, AT91_ST_CRTR, &x1);
>>>   	do {
>>> -		x2 =3D at91_st_read(AT91_ST_CRTR);
>>> +		regmap_read(regmap_st, AT91_ST_CRTR, &x2);
>>>   		if (x1 =3D=3D x2)
>>>   			break;
>>>   		x1 =3D x2;
>>> @@ -63,7 +63,10 @@ static inline unsigned long read_CRTR(void)
>>>    */
>>>   static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_=
id)
>>>   {
>>> -	u32	sr =3D at91_st_read(AT91_ST_SR) & irqmask;
>>> +	u32 sr;
>>> +
>>> +	regmap_read(regmap_st, AT91_ST_SR, &sr);
>>> +	sr &=3D irqmask;
>>>
>>>   	/*
>>>   	 * irqs should be disabled here, but as the irq is shared they a=
re only
>>> @@ -96,7 +99,7 @@ static struct irqaction at91rm9200_timer_irq =3D =
{
>>>   	.name		=3D "at91_tick",
>>>   	.flags		=3D IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
>>>   	.handler	=3D at91rm9200_timer_interrupt,
>>> -	.irq		=3D NR_IRQS_LEGACY + AT91_ID_SYS,
>>> +	.irq		=3D 0,
>>
>> Is this change related to regmap ?
>>
>
> It is related to the removing of hardware.h. I can do that in a separ=
ate
> patch if you prefer.

Yeah, because it is not obvious to see a connection between the removal=
=20
of hardware.h and the syscon/regmap changes.

I would suggest you create a patch to replace setup_irq with=20
register_irq so that will remove this structure and the irq=20
initialization to zero.

>> By the way, perhaps take the opportunity to replace setup_irq by req=
uest_irq
>> (and check the return value) ?
>>
>
> I tried and it fails, I didn't investigate yet.

It shouldn't be a big deal, register_irq is more or less a wrapper to=20
setup_irq.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
