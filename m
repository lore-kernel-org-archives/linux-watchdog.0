Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <55766D74.2060401@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1433217907-928-1-git-send-email-fu.wei@linaro.org>
	<1433217907-928-6-git-send-email-fu.wei@linaro.org>
	<556DCC95.806@codeaurora.org>
	<CADyBb7sXiMNtrH+Eu1Qj00TPNLMMr5cCTPObzFmKnHLsbWH79Q@mail.gmail.com>
	<556DE2D5.3090906@roeck-us.net>
	<CADyBb7uT=gFJkK8s-QF1n4Z+Zov9Lurp1nvBO-C-qszTqbMYXQ@mail.gmail.com>
	<5575DE48.8010308@roeck-us.net>
	<CADyBb7sYPnvDVEJYVQm65B1JV=yvq10+ezs2x3f8F=TJCZ+OJA@mail.gmail.com>
	<55766D74.2060401@roeck-us.net>
Date: Tue, 9 Jun 2015 14:37:53 +0800
Message-ID: <CADyBb7vR-jP6ZjzMSnprrSXbNayk8umx+cXV3TsGypfhZcCwTw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Timur Tabi <timur@codeaurora.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org, wim@iguana.be,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

Thanks for reply so quickly.

On 9 June 2015 at 12:37, Guenter Roeck <linux@roeck-us.net> wrote:
> On 06/08/2015 08:59 PM, Fu Wei wrote:
>>
>> Hi Guenter,
>>
>>
>> On 9 June 2015 at 02:26, Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> On 06/08/2015 09:05 AM, Fu Wei wrote:
>>>>
>>>>
>>>> Hi Gurnter
>>>>
>>>> On 3 June 2015 at 01:07, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>
>>>>>
>>>>> On 06/02/2015 09:55 AM, Fu Wei wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> Hi Timur,
>>>>>>
>>>>>> Thanks , feedback inline
>>>>>>
>>>>>> On 2 June 2015 at 23:32, Timur Tabi <timur@codeaurora.org> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 06/01/2015 11:05 PM, fu.wei@linaro.org wrote:
>>>>>>>
>>>>>>>> +/*
>>>>>>>> + * help functions for accessing 32bit registers of SBSA Generic
>>>>>>>> Watchdog
>>>>>>>> + */
>>>>>>>> +static void sbsa_gwdt_cf_write(unsigned int reg, u32 val,
>>>>>>>> +                              struct watchdog_device *wdd)
>>>>>>>> +{
>>>>>>>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>>>>>>>> +
>>>>>>>> +       writel_relaxed(val, gwdt->control_base + reg);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void sbsa_gwdt_rf_write(unsigned int reg, u32 val,
>>>>>>>> +                              struct watchdog_device *wdd)
>>>>>>>> +{
>>>>>>>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>>>>>>>> +
>>>>>>>> +       writel_relaxed(val, gwdt->refresh_base + reg);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static u32 sbsa_gwdt_cf_read(unsigned int reg, struct
>>>>>>>> watchdog_device
>>>>>>>> *wdd)
>>>>>>>> +{
>>>>>>>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>>>>>>>> +
>>>>>>>> +       return readl_relaxed(gwdt->control_base + reg);
>>>>>>>> +}
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> I still think you should get rid of these functions and just call
>>>>>>> readl_relaxed() and writel_relaxed() every time, but I won't complain
>>>>>>> again
>>>>>>> if you keep them.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> yes, that make sense, and will reduce the size of code, and I think
>>>>>> the code's readability will be OK too.
>>>>>> will try in my next patch,
>>>>>>
>>>>>>>
>>>>>>>> +static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
>>>>>>>> +{
>>>>>>>> +       struct sbsa_gwdt *gwdt = (struct sbsa_gwdt *)dev_id;
>>>>>>>> +       struct watchdog_device *wdd = &gwdt->wdd;
>>>>>>>> +
>>>>>>>> +       if (wdd->pretimeout)
>>>>>>>> +               /* The pretimeout is valid, go panic */
>>>>>>>> +               panic("SBSA Watchdog pre-timeout");
>>>>>>>> +       else
>>>>>>>> +               /* We don't use pretimeout, trigger WS1 now*/
>>>>>>>> +               sbsa_gwdt_set_wcv(wdd, 0);
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> I don't like this.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> If so, what is your idea ,if pretimeout == 0?
>>>>>>
>>>>>> the reason of using WCV as (timout - pretimeout): it can provide the
>>>>>> longer timeout period,
>>>>>> (1)If we use WOR, it can only provide 10s @ 400MHz(max).
>>>>>> as Guenter said earlier, the default timer out for most watchdog will
>>>>>> be 30s, so I think 10s limit will be a little short
>>>>>> (2)we can always program WCV just like ping.
>>>>>> (3)if a timeout arrives, WOR will be use, so use it as pretimeout, but
>>>>>> we still can make this pretimeout longer by programming WCV(I don't
>>>>>> think it's necessary)
>>>>>>
>>>>>>
>>>>>>> The triggering of the hardware reset should never depend
>>>>>>> on an interrupt being handled properly.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> if this fail, system reset in 1S, because WOR == (1s)
>>>>>>
>>>>> So ?
>>>>
>>>>
>>>>
>>>> Even the interrupt routine isn't triggered,  (WOR + system counter) -->
>>>> WCV,
>>>> then, sy system reset in 1S.
>>>>
>>>> the hardware reset doesn't depend on an interrupt.
>>>>
>>>>
>>>>>
>>>>>>> You should always program WCV
>>>>>>> correctly in advance.  This is especially true since pre-timeout will
>>>>>>> probably rarely be used.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> always programming WCV is doable.  But I absolutely can not agree "
>>>>>> pre-timeout will probably rarely be used"
>>>>>> If so, SBSA watchdog is just a normal watchdog,  This use case just
>>>>>> makes this HW useless.
>>>>>> If so, go to use SP805.
>>>>>> you still don't see the importance of this warning and pretimeout to a
>>>>>> real server.
>>>>>>
>>>>>
>>>>> If pretimeout isn't used, why not just set WCV = timeout, WOR = 0 ?
>>>>
>>>>
>>>>
>>>> Because if WOR = 0 , according to SBSA,  once you want to enable
>>>> watchdog,
>>>> (0 + system counter) --> WCV , then , WS0 and WS1 will be triggered
>>>> immediately.
>>>> we have not a chance(a time slot) to update WCV.
>>>>
>>>
>>> I would have thought that this is exactly what we want if pretimeout is
>>> not
>>> used.
>>
>>
>> Although pretimeout == 0 is not good for a server, but If
>> administrator set up pretimeout == 0. *I thinks we should trigger WS1
>> ASAP* . Because  WS1 maybe a interrupter or a reboot signal, that is
>> why we can not reboot system directly.
>>
>> This driver is SBSA watchdog driver, that means we need to follow SBSA
>> spec:
>> (1) SBSA watchdog has two stage timeouts --> timeout and pretimeout is
>> the best solution in watchdog framework, at least for now.
>> (2) The watchdog has the following output signals:
>>      Watchdog Signal 0 (WS0)---> "The initial signal is typically wired
>> to an interrupt and alerts the system."(original word from spec), I
>> thinks the key work should be "interrupt" and "alerts". So in WS0
>> interrupt routine, reset is absolutely a wrong operation. Although I
>> think we should make this "alerts" more useful. But for the first
>> version of driver, I thinks panic is useful enough.
>>      Watchdog Signal 1 (WS1). ---> "The signal is fed to a higher agent
>> as an interrupt or reset for it to take executive action." (original
>> word from spec) . The key work should be "interrupt", "or" and "reset"
>> . So  WS1 maybe a interrupt.
>> so even in the WS0 interrupt routine, if  pretimeout == 0 , we need to
>> trigger WS1(that is what my patch is doing now, set WCV to 0, so WCV
>> is always less than SystemCounter, and in this situation(WS0 = TRUE),
>> WS1 will be trigger immediately), but definitely not a reset too.
>>
>> But in worst case,  if the WS0 is triggered, but the interrupt routine
>> doesn't work(can not set up WCV), it doesn't matter, we just need to
>> wait for a WOR(1s in my driver) timeout, then WS1 will be triggered.
>> That is hardware mechanism, once we config SBSA watchdog correctly,
>> that should work.  If it doesn't, I think the chip design doesn't
>> follow the SBSA spec.
>>
>> Make a summary here, for SBSA watchdog driver,  it need to support two
>> stage timeouts and need to trigger WS0/1 when timeouts occur(can not
>> simply reset system in interrupt routines).
>> If a driver doesn't do these above, the driver can not be called SBSA
>> watchdog driver.
>>
>> But according to SBSA, even pretimeout == 0, we can not setup WOR = 0.
>> if we make WOR = 0 , once we set up WCS(enabling watchdog), that cause
>> a explicit watchdog refresh, then WCV = (0 + system counter), so WS0
>> and WS1 will be triggered serially and immediately(in theory, the
>
>
> I still don't understand why this would be a problem.

that 20+ lines pseudocode from the page 23 of SBSA spec 2.3 can
explain this well.
Please let me know which line confuse you, I will explain them one by one below.

>
>> "delay" also depend on implementation). So in my patchset , if
>> pretimeout == 0, WOR will be 1s at least to make sure we have time to
>> setup WCV. I have made comments in the patch for explaining this.
>>
>> Maybe some people want to ask: if we can not set up WOR = 0, but
>> pretimeout can be 0 and timeout can not, why I still want to use WOR
>> for pretimeout and using WCV as (timout - pretimeout) ??
>> For this:
>> (1)WCV can provide the longer timeout period, If we use WOR, it can
>> only provide 10s @ 400MHz(max). The default timer out for most
>> watchdog will be 30s, so I think 10s limit will be a little short.
>> (2)we can always program(write) WCV just like ping.
>> (3)if the first timeout occurs, WOR will be loaded to WCV(WOR + system
>> counter)  automatically , so why not just use WOR as pretimeout?
>> Although we still can make this pretimeout longer by programming WCV,
>> I don't think it's necessary for now.
>>
>
> Too bad I don't have an arm64 system to test myself. I am not sure
> I understand why WOR must be set to > 0 if pretimeout == 0, and even

Although SBSA spec has published for years(2.2 was published at 15th
Jan 2014), but this is still a relatively new spec of hardware, for
now . I only has Foundation model and FAST model for testing.
But I would like to suggest: this driver should follow the SBSA spec
first, but not a specific hardware, even some of hardware has this
watchdog, but there maybe some hardware bug in it(at least I know
there is one).

I am using 1 second, just because I think 1 second is safe enough to
reload WCV. (from write "1" in WCS  to reload WCV[31:0] and WCV[63:32]
)
Actually,  in most of case , we need WOR > 1, only when we enable the
watchdog( write "1" to WCS, this causes a ExplicitRefresh, see Line 7
"ExplicitRefresh == TRUE" and Line 8 below).
in this cause , we just need a time slot to reload WCV, the driver
doesn't really spend 1s on this.
But If WOR ==0, (Line 1) TimeoutRefresh = TRUE in a very short time,
the minimum time depends on the implementation. Then The first timeout
stage occur(see Line 7 (TimeoutRefresh == TRUE and WS0 == FALSE), and
Line 8 below again ) and  WS0 was triggered(Line 16~18).  Because WOR
==0 too, (Line 1) TimeoutRefresh = TRUE occur in a very short time
again, then see Line 16, 17, 20

In worst case, if pretimeout is 0, First timeout stage occur(see Line
7 (TimeoutRefresh == TRUE and WS0 == FALSE), and Line 8 below,  then
Line 16~18)   but the interrupt routine doesn't work, we can still got
WS1 in the time we configured in WOR. (Line 1) TimeoutRefresh = TRUE
occur when SystemCounter[63:0] > SystemCounter[63:0] +
ZeroExtend(WOR[31:0]), then  Line 16, 17, 20

---------------------------------------------------
CompareValue : WCV
WatchdogOffsetValue : WOR


1    TimeoutRefresh = (SystemCounter[63:0] > CompareValue[63:0])

2    If WatchdogColdReset
3            WatchdogEnable = DISABLED
4    Endif

5    If LoadNewCompareValue
6            CompareValue = new_value
7    ElseIf ExplicitRefresh == TRUE or (TimeoutRefresh == TRUE and WS0 == FALSE)
8           CompareValue = SystemCounter[63:0] +
ZeroExtend(WatchdogOffsetValue[31:0])
9    Endif

10  If WatchdogEnable == DISABLED
11          WS0 = FALSE
12          WS1 = FALSE
13  ElseIf ExplicitRefresh == TRUE
14         WS0 = FALSE
15         WS1 = FALSE
16  ElseIf TimeoutRefresh == TRUE
17         If WS0 == FALSE
18                   WS0 = TRUE
19         Else
20                   WS1 = TRUE
21         Endif
22  Endif
---------------------------------------------------

I would like to stress that  pretimeout == 0 should not happen in a
real server system,  that is why we defined  a SBSA watchdog, but not
a normal one
But we still need to thinking about the situation that administrator
want to do this on a very special purpose.

maybe we can set min_pretimeout = 1 for this driver. that is just a suggestion.


> if it must be set to a value > 0 I don't understand why
> setting it to 1 (instead of 1 second) would not be sufficient.

it don't have to be 1 second , it can be 0.1, 0.5 or 0.01 second. like
I said before, we just need a time slot to setup WCV in
sbsa_gwdt_start. I have commented this in sbsa_gwdt_set_pretimeout in
this patchset.
But I think the minimum time slot depend on implementation, the spec
doesn't mention about this.
If pretimeout == 0, and we set up WOR a little bigger,  it *ONLY*
affect "the worst case" I mention above. in this case, a administrator
set up pretimeout == 0 which should not happen in a real server, then
the system goes very wrong. I don't think it is important that this
server system reset in 1 second or 0.0001 second, at this time, this
server can not provide any useful info anyway(because we don't use
pretimeout).
If system may go wrong,  the administrator should set up pretimeout >
0 to figure out what is wrong with it just like he always should do.

>
> Guenter
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
