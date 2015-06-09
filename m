Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <55769E0E.8060801@roeck-us.net>
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
	<CADyBb7vR-jP6ZjzMSnprrSXbNayk8umx+cXV3TsGypfhZcCwTw@mail.gmail.com>
	<55769E0E.8060801@roeck-us.net>
Date: Tue, 9 Jun 2015 18:46:16 +0800
Message-ID: <CADyBb7skpSZ=3_ByW-RHM99=nbs7Z5xXFXtsKzkxOXAGjxF=3Q@mail.gmail.com>
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

Thanks for your feedback

On 9 June 2015 at 16:04, Guenter Roeck <linux@roeck-us.net> wrote:
> On 06/08/2015 11:37 PM, Fu Wei wrote:
>
>>
>> I would like to stress that  pretimeout == 0 should not happen in a
>> real server system,  that is why we defined  a SBSA watchdog, but not
>> a normal one
>
>
> Clarification - In _your opinion_, a server should always use pretimeout.
>
>> But we still need to thinking about the situation that administrator
>> want to do this on a very special purpose.
>>
> I could as well argue that setting pretimeout is the special situation.
> Some administrators may not want to bother but just want the system to reset
> if  a watchdog timeout occurs. _Maybe_ if it happens multiple times,
> they might want to set up pretimeout to figure out why.

you are right,
before this driver and device are really used in some server, we don't
know How do administrators use this pretimeout,
and the percentage of using pretimeout, But here you did mention a
good usage of pretimeout: we can figure out what is wrong with system.

except the usages,  this two stage timeouts is a main feature of SBSA
watchdog, if we drop this feature, I don't think that is a  SBSA
watchdog driver. it becomes normal watchdog driver using SBSA watchdog
hardware.

>
> Declaring that one _has_ to configure pretimeout is just a personal
> opinion, nothing else. We don't know what server administrators want,
> and we should not dictate anything unless technically necessary.

yes, agree with you on "we should not dictate anything unless
technically necessary."

>
>> maybe we can set min_pretimeout = 1 for this driver. that is just a
>> suggestion.
>>
> No. It is not technically necessary.

it is just a thought. but I never do that , because min_pretimeout = 0
is technically doable in this driver.

>
>>
>>> if it must be set to a value > 0 I don't understand why
>>> setting it to 1 (instead of 1 second) would not be sufficient.
>>
>>
>> it don't have to be 1 second , it can be 0.1, 0.5 or 0.01 second. like
>> I said before, we just need a time slot to setup WCV in
>> sbsa_gwdt_start. I have commented this in sbsa_gwdt_set_pretimeout in
>> this patchset.
>
>
> I think what you really want to say is that you want to have time to
> handle the interrupt. But handling the interrupt is not asked for if
> pretimeout == 0.

No, that is not what I want to say. pretimeout == 0 but WOR can not be
0 is nothing to do with interrupt.
In another word,  pretimeout == 0 we should trigger WS1 ASAP, we don't
need to handle the interrupt.
I have explained this in  previous email:

"
we need WOR > 1, only when we enable the watchdog( write "1" to WCS,
this causes a ExplicitRefresh, see Line 7 "ExplicitRefresh == TRUE"
and Line 8 below).
in this cause , we just need a time slot to reload WCV, the driver
doesn't really spend 1s on this.
But If WOR ==0, (Line 1) TimeoutRefresh = TRUE in a very short time,
the minimum time depends on the implementation. Then The first timeout
stage occur(see Line 7 (TimeoutRefresh == TRUE and WS0 == FALSE), and
Line 8 below again ) and  WS0 was triggered(Line 16~18).  Because WOR
==0 too, (Line 1) TimeoutRefresh = TRUE occur in a very short time
again, then see Line 16, 17, 20
"
in one word, according to SBSA,  If we make WOR == 0, once we enable
watchdog, WS0 and WS1 will be triggered immediately, we have not
chance to set up WCV for (timeout - pretimeout).
In another word,  WOR == 0, we can not enable watchdog, enabling
become a warn reset button.

>
>> But I think the minimum time slot depend on implementation, the spec
>> doesn't mention about this.
>
>
> Yes, because a minimum value does not exist.
>
>> If pretimeout == 0, and we set up WOR a little bigger,  it *ONLY*
>> affect "the worst case" I mention above. in this case, a administrator
>> set up pretimeout == 0 which should not happen in a real server, then
>> the system goes very wrong. I don't think it is important that this
>> server system reset in 1 second or 0.0001 second, at this time, this
>> server can not provide any useful info anyway(because we don't use
>> pretimeout).
>> If system may go wrong,  the administrator should set up pretimeout >
>> 0 to figure out what is wrong with it just like he always should do.
>>
>
> Yes, exactly. But otherwise, if pretimeout is set to 0, we want
> to reset immediately as directed.

In this driver, if pretimeout is set to 0, we want to *trigger WS1*
immediately as directed.
Yes, If we could.

>
> As I interpret the specification, WOR=0 forces WS1 immediately after WS0.
>
> 1) if TimeoutRefresh = True:
>         CompareValue := SystemCounter + WOR (= SystemCounter
>         WS0 := True
> 2) TimeoutRefresh is True again, WS0 == True:
>         WS1 = True
>
> This is exactly the behavior we want if pretimeout == 0. In this situation,
> we don't want to handle the interrupt, we just want to reset the system as
> fast as possible.

Yes, if WOR only affect in TimeoutRefresh, we cat always make WOR == pretimeout
But the problem is  if we enable watchdog (write 0x01 to WCS will
cause an explicit watchdog refresh), then
1) if ExplicitRefresh = True:
         CompareValue := SystemCounter + WOR
         WS0 := True
2) TimeoutRefresh is True again, WS0 == True:
         WS1 = True

so once we enable watchdog, system reset, that is not what we want.
this behavior is following SBSA spec.

FYI:
-----
An explicit watchdog refresh occurs when one of a number of different
events occur:
 The Watchdog Refresh Register is written.
 The Watchdog Offset Register is written.
 The Watchdog Control and Status register is written.
-----

>
> Having said that, have you tested what happens in your system if you
> set WOR=0 ?

I have not HW, but I have tested it on Foundation model, the result is
just what I expect:
-------------------------------------
pretimeout=0 ,

and

static int sbsa_gwdt_set_pretimeout(struct watchdog_device *wdd,
                    unsigned int pretimeout)
{
    struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);

    wdd->pretimeout = pretimeout;

    /* refresh the WOR, that will cause an explicit watchdog refresh */
    sbsa_gwdt_cf_write(SBSA_GWDT_WOR,  pretimeout * gwdt->clk, wdd);

    return 0;
}
-------------------------------------
Once I enable watchdog, system down(there is a WS1 interrupter in
Foundation model, but not more info for that), there is not panic(if
ws0 is triggered).

>
> Thanks,
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
