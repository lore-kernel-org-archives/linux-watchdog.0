Return-path: <al.stone@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v8 5/5] Watchdog: introduce ARM SBSA
 watchdog driver
To: Guenter Roeck <linux@roeck-us.net>, Fu Wei <fu.wei@linaro.org>,
 Timur Tabi <timur@codeaurora.org>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
 <1445961999-9506-6-git-send-email-fu.wei@linaro.org>
 <CAOZdJXV8x8EMQEZhdFS+34iO+6P9S==k9bQjt=67iXt6K2oSCw@mail.gmail.com>
 <563AE588.1080009@roeck-us.net> <563B5DF9.6080102@codeaurora.org>
 <CADyBb7sD2Y2kGj-suOs1UeUwXPjH39mvX_Sobn0Y7WfsJ9hF=Q@mail.gmail.com>
 <563B62F7.3050307@codeaurora.org>
 <CADyBb7vDf+KRi8gUGEt+iu-GpqVQgVq7nKTVt7O=3x78KCi+RQ@mail.gmail.com>
 <563B6A4B.7090400@codeaurora.org>
 <CADyBb7t6ovfrz1b3ZZykKq22HkZi1W0PWg7-wXihEjM9ciTgGg@mail.gmail.com>
 <563B869F.2010004@roeck-us.net>
Cc: Pratyush Anand <panand@redhat.com>, devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-doc@vger.kernel.org, Jon Masters <jcm@redhat.com>,
 Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml
 <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
 Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robherring2@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Wei Fu <tekkamanninja@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Dave Young <dyoung@redhat.com>,
 Vipul Gandhi <vgandhi@codeaurora.org>
From: Al Stone <al.stone@linaro.org>
Message-ID: <56452970.4070209@linaro.org>
Date: Thu, 12 Nov 2015 17:06:08 -0700
MIME-Version: 1.0
In-Reply-To: <563B869F.2010004@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 11/05/2015 09:41 AM, Guenter Roeck wrote:
> On 11/05/2015 07:00 AM, Fu Wei wrote:
>> Hi Timur,
>>
>> On 5 November 2015 at 22:40, Timur Tabi <timur@codeaurora.org> wrote:
>>> Fu Wei wrote:
>>>>
>>>> Did you really read the "Note" above???????? OK, let me paste it again
>>>> and again:
>>>>
>>>> SBSA 2.3 Page 23 :
>>>> If a larger watch period is required then the compare value can be
>>>> programmed directly into the compare value register.
>>>
>>>
>>> Well, okay.  Sorry, I should have read what you pasted more closely. But I
>>
>> Thanks for reading it again.
>>
>>> think that means during initialization, not during the WS0 timeout.
>>
>> I really don't see SBSA say "during initialization, not during the WS0 timeout",
>> please point it out the page number and the line number in SBSA spec.
>> maybe I miss it?
>> Thanks for your help in advance.
>>
>>>
>>> Anyway, I still don't like the fact that you're programming WCV in the
>>
>> "you don't like" doesn't mean "it is wrong" or "we can't do this", so
>> I will keep this way unless we have better idea to extend second stage
>> timeout.
>>
>>> interrupt handler, but I'm not going to make a big deal about it any more.
>>
>> Deal, Thanks a lot.
>>
> 
> The problem with your driver, as I see it, is that dealing with WS0/WS1
> and pretimeout makes the driver so complex that, at least for my part,
> I am very wary about it. The driver could long since have been accepted
> if it were not for that. Besides that, I really believe that any system designer
> using the highest permitted frequency should be willing to live with the
> consequences, and not force the implementation of a a complex driver.
> 
> Ultimately, you'll have to decide if you want a simple driver accepted, or
> a complex driver hanging in the review queue forever.
> 
> Thanks,
> Guenter

Sorry to poke my head in late like this, but I do have a vested interest in the
outcome so I'm very curious.  For my work, I need to have an ACPI-supported,
SBSA-compliant watchdog timer for arm64, and this series is one of the key
pieces to getting there.  The plan for me has been: (1) get an FDT based SBSA
watchdog timer, (2) add in kernel code to handle the ACPI GTDT table describing
timers, then (3) munge the SBSA watchdog timer for use by ACPI.

So, is this an actual NAK of the patch series as is?  I think it is, but I want
it to be clear, and it has not been explicit yet.

If it is a NAK, that's fine, but I also want to be sure I understand what the
objections are.  Based on my understanding of the discussion so far over the
multiple versions, I think the primary objection is that the use of pretimeout
makes this driver too complex, and indeed complex enough that there is some
concern that it could destabilize a running system.  Do I have that right?

The other possible item I could conclude out of the discussion is that we do
not want to have the pretimeout code as part of the watchdog framework; is that
also the case or did I misunderstand?

And finally, a simpler, single stage timeout watchdog driver would be a
reasonable thing to accept, yes?  I can see where that would make sense.

The issue for me in that case is that the SBSA requires a two stage timeout,
so a single stage driver has no real value for me.  Now, if I can later add in
changes to make the driver into a two stage driver so it is SBSA-compliant,
that would also work, but it will make the driver more complex again.  At that
point, I think I've now gone in a logical circle and the changes would not be
accepted so I could never get to my goal of an SBSA-compliant driver.  I don't
think that's what was meant, so what did I miss?

Thanks in advance for any clarifications that can be provided.....I really do
appreciate it.  Email is not always the clearest mechanism for communication
so sometimes I have to ask odd questions like these so I can understand what
is happening.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
