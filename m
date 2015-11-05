Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <563B869F.2010004@roeck-us.net>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
	<1445961999-9506-6-git-send-email-fu.wei@linaro.org>
	<CAOZdJXV8x8EMQEZhdFS+34iO+6P9S==k9bQjt=67iXt6K2oSCw@mail.gmail.com>
	<563AE588.1080009@roeck-us.net>
	<563B5DF9.6080102@codeaurora.org>
	<CADyBb7sD2Y2kGj-suOs1UeUwXPjH39mvX_Sobn0Y7WfsJ9hF=Q@mail.gmail.com>
	<563B62F7.3050307@codeaurora.org>
	<CADyBb7vDf+KRi8gUGEt+iu-GpqVQgVq7nKTVt7O=3x78KCi+RQ@mail.gmail.com>
	<563B6A4B.7090400@codeaurora.org>
	<CADyBb7t6ovfrz1b3ZZykKq22HkZi1W0PWg7-wXihEjM9ciTgGg@mail.gmail.com>
	<563B869F.2010004@roeck-us.net>
Date: Fri, 6 Nov 2015 01:58:12 +0800
Message-ID: <CADyBb7vNp9+A+mZvg_3+N1p7ZC_DBBWBP99hzAKBwcdiDut3SQ@mail.gmail.com>
Subject: Re: [Linaro-acpi] [PATCH v8 5/5] Watchdog: introduce ARM SBSA
 watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Timur Tabi <timur@codeaurora.org>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
	linux-doc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Jon Masters <jcm@redhat.com>,
	Pratyush Anand <panand@redhat.com>, Will Deacon <will.deacon@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>,
	Wei Fu <tekkamanninja@gmail.com>, Rob Herring <robherring2@gmail.com>,
	Vipul Gandhi <vgandhi@codeaurora.org>, Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

Great thanks for that you are still reviewing this patchset, thanks
for your patient.

On 6 November 2015 at 00:41, Guenter Roeck <linux@roeck-us.net> wrote:
> On 11/05/2015 07:00 AM, Fu Wei wrote:
>>
>> Hi Timur,
>>
>> On 5 November 2015 at 22:40, Timur Tabi <timur@codeaurora.org> wrote:
>>>
>>> Fu Wei wrote:
>>>>
>>>>
>>>> Did you really read the "Note" above???????? OK, let me paste it again
>>>> and again:
>>>>
>>>> SBSA 2.3 Page 23 :
>>>> If a larger watch period is required then the compare value can be
>>>> programmed directly into the compare value register.
>>>
>>>
>>>
>>> Well, okay.  Sorry, I should have read what you pasted more closely. But
>>> I
>>
>>
>> Thanks for reading it again.
>>
>>> think that means during initialization, not during the WS0 timeout.
>>
>>
>> I really don't see SBSA say "during initialization, not during the WS0
>> timeout",
>> please point it out the page number and the line number in SBSA spec.
>> maybe I miss it?
>> Thanks for your help in advance.
>>
>>>
>>> Anyway, I still don't like the fact that you're programming WCV in the
>>
>>
>> "you don't like" doesn't mean "it is wrong" or "we can't do this", so
>> I will keep this way unless we have better idea to extend second stage
>> timeout.
>>
>>> interrupt handler, but I'm not going to make a big deal about it any
>>> more.
>>
>>
>> Deal, Thanks a lot.
>>
>
> The problem with your driver, as I see it, is that dealing with WS0/WS1
> and pretimeout makes the driver so complex that, at least for my part,
> I am very wary about it. The driver could long since have been accepted
> if it were not for that. Besides that, I really believe that any system
> designer
> using the highest permitted frequency should be willing to live with the
> consequences, and not force the implementation of a a complex driver.

yes, comparing with those "one stage" watchdogs driver, I admit my
SBSA driver is a little complex
this complex come from :
(1) In SBSA spec, there are two stage.

because of these two stages, I looked for the solution in the kernel,
then I found "pretimeout".
I have explained a lot why I decide to use pretimeout which is
existing concept in Linux kernel
I just tried to introduce a existing concept  into watchdog framework.
Maybe people will say, there is only two or one drivers use that, but
it doesn't mean we can't have more in the future.
Maybe people will say, let's do this when we have more  two stages
watchdog. But if I need this now,  why not just make it this time.

if we use this driver as one stage watchdog,  it violates the SBSA
spec, and it can not be call SBSA watchdog driver.

(2) in SBSA watchdog, WOR is a 32bit register, we have a timeout limitation.

first of all, according to kernel documentation,
Documentation/watchdog/watchdog-api.txt
-------------
Pretimeouts:

Some watchdog timers can be set to have a trigger go off before the
actual time they will reset the system.  This can be done with an NMI,
interrupt, or other mechanism.  This allows Linux to record useful
information (like panic information and kernel coredumps) before it
resets.
---------------
So I decide to use panic() in first timeout handler, then we can use kdump

But in the real practice, 10s is not enough for kexec(let alone
kdump), even we can have 100s, 200s, it is not enough for a real
server which has huge ram to finish kdump.
So I decide to reprogram WCV for longer timer value.

except this two point, there is not more complex than other watchdog drivers.

And for these two complex point, I have explained the reason.
And this driver has been test on two platforms

Foundation model
Seattle

and will be more.

And this driver has been test with kdump, and works.

>
> Ultimately, you'll have to decide if you want a simple driver accepted, or
> a complex driver hanging in the review queue forever.

I have tried to simplify this driver, and I understand why we need a
simple driver, and why you are wary about it.
Even we want "simple" driver,  but we can't ignore the SBSA watchdog
feature in the spec.

If I can find a better way to solve these two complex point to make
this driver simple, I will absolutely do it.
But before we get better solution, I can not make a "simple" non-SBSA
watchdog driver to be accepted just for "my driver be accepted".
at least I need to convince myself: my driver is not just a simple
driver, but also a right driver for target device.
Maybe it will take a very long time,  but at least for now, I believe
I am doing the right way.

If you have suggestion to make this driver simple, I absolutely listen
to it and try to do it just like previous review.

Again, I appreciate your help and review very much. :-)


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
