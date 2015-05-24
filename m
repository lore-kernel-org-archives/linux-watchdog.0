Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <5560DA3F.3070707@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>
	<555F4236.7040206@linaro.org>
	<4095167.UOriXdSu53@wuerfel>
	<556097D5.9050103@codeaurora.org>
	<CADyBb7svbV6QdhzCsa9DiBLfyNpAJHkgm73VSKCieJioPwWHsw@mail.gmail.com>
	<5560C85B.8040100@roeck-us.net>
	<5560C8D3.40708@codeaurora.org>
	<5560DA3F.3070707@roeck-us.net>
Date: Sun, 24 May 2015 17:58:13 +0800
Message-ID: <CADyBb7sW8GTJmRR2ysUAYtZ=mkSCFZBzXuor=puLck0Q983NMw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Timur Tabi <timur@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>, vgandhi@codeaurora.org, wim@iguana.be,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

Great thanks for your suggestion and review,
I have some questions below , would you please help me out?

On 24 May 2015 at 03:51, Guenter Roeck <linux@roeck-us.net> wrote:
> On 05/23/2015 11:37 AM, Timur Tabi wrote:
>>
>> Guenter Roeck wrote:
>>>
>>> I think it is quite unfortunate that the specification is not public.
>>> We have heard many statements about what is in the spec or not.
>>
>>
>> All you need to do is go to
>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0029b/index.html,
>> get a free ARM account, and download the spec.
>>
> That helps - thanks a lot!
>
> Folks, please correct me if my understanding of the specification
> is wrong.
>
> 1) Pretimeout
>
> The document suggests that
>         WS1 = WS0 * 2

Are you saying: the first timeout == the second timeout

|-------------WS0
                  |-------------WS1

Sorry, could you let me know where is that suggestion??
I have checked the SBSA again, but I can not find it.
Maybe I really miss this part.

> is in fact correct. In essence, there is just one counter,
> not two. This means that a separate pretimeout does not really
> make sense, since in practice the timeout would always be
> twice the pretimeout,

Yes, you are right, if we only use "WOR", then the first timeout ==
the second timeout

> and changing just one without affecting
> the other is not really possible.

although there is only one counter, and it is 32 bits wide.
In SBSA,  we can see this:
-------
Note: the watchdog offset register is 32 bits wide. This gives a
maximum watch period of around 10s at a system counter frequency of
400MHz.
If a larger watch period is required then the compare value can be
programmed directly into the compare value register.
-------
So for the first timeout, we can set the compare value register(WCV).
Then the two timeouts are different. and the first timeout has not
10s(@400MHz) limit.
just the the second timeout must use "WOR".

>
> 2) 64 bit WCV register
>
> The specification is not clear on how to read this register.
> It clearly states that it is comprised of two 32-bit registers,
> but it does not specify if a single 64-bit read would be atomic,
> or if it would be split into two separate 32-bit operations.
> This leaves room for interpretation by the implementer, and
> may result in bad values if the implementation changes the
> counter from, say, 0x000010000 to 0x0000ffff while the value
> is read.
>
> My interpretation of this is that it would be safer to read two
> 32-bit values and ensure that the values are consistent
> instead of relying on the assumption that a single 64-bit read
> would be atomic.

yes, thanks for pointing it out.

I found this problem in my first upstream patchset.
So in this patchset, there is not that problem now:

-------
    do {
        wcv_hi = sbsa_gwdt_cf_read(SBSA_GWDT_WCV_HI, wdd);
        wcv_lo = sbsa_gwdt_cf_read(SBSA_GWDT_WCV_LO, wdd);
    } while (wcv_hi != sbsa_gwdt_cf_read(SBSA_GWDT_WCV_HI, wdd));

-------

>
> 3) ACPI vs. FDT
>
> The specification does not say anything about ACPI or FDT support
> except that it assumes that there are "System description data
> structures such as ACPI or FDT". Given that, the driver should
> support both.

yes, this patchset has fully support ACPI and FDT, and has been
successfully tested on
(1)Foundation model
(2)AMD Seattle B0 Soc

>
> 4) ARM vs. ARM64
>
> SBSA clearly states that any CPU supporting it shall be ARM v8
> compliant (4.1.1, CPU architecture). Personally I think the
> discussion around supporting the driver on ARM/ARM64 or ARM64
> only is a bit pointless, especially since being able to build
> it on ARM doesn't really hurt, even though there is currently
> no HW supporting it.
>
> Overall I must admit that I don't really understand why this is
> such a contentious issue.

I think that is not a contentious issue.
Just some one has that suggestion, then we discussed it.
So I am going to delete ARM support.
If we have this hardware in the future, we can add it by then.

>
> 5) Revision support
>
> While it is difficult to predict the future, it is common practice
> in the industry to make future revisions of a standard (and chip)
> as much backward compatible as possible, and to only add functionality.
> As such, I don't see a reason to restrict support to revision 0
> of the standard.

Totally agree, there is not this problem in my patchset.

>
> 6) A note about driver messages
>
> Implementation defined registers are just that, implementation
> defined registers. I don't think it makes sense to display any
> of those, not even for debugging purposes.

in this patchset, I have totally deleted all the debug message, only keep:
(1)3 error messages
(2)2 warning messages
reason:
   1. if system reset by watchdog, we need to inform user (WCS: store
watchdog status, WCV: store the timestamp of the last reboot, maybe
these can provide some basic info of reboot )
   2. if watchdog has been enabled before register, there is something
wrong we need to inform user. (WCS: store watchdog status)
(3)1 info message
reason: if watchdog has been successfully registered, we log it.

Please let me know if there is any redundant massage, I will fix it.

>
> ---
>
> Again, please correct me if any of those statements is wrong.
> When doing so, please reference the specification, to make sure
> that we all know what we are talking about.

Great thanks for your help , those help me a lot.

So, for now , this only big problem in my patchset is "pretimeout",
but I have some doubt above, would you help me out ? :-) Thanks


>
> My hope is that we can use this as a starting point to converge
> on a single driver.
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
