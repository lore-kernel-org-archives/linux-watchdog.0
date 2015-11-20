Return-path: <timur@codeaurora.org>
Subject: Re: [Linaro-acpi] [PATCH v8 5/5] Watchdog: introduce ARM SBSA
 watchdog driver
To: Al Stone <al.stone@linaro.org>, Guenter Roeck <linux@roeck-us.net>,
 Fu Wei <fu.wei@linaro.org>
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
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
 <1445961999-9506-6-git-send-email-fu.wei@linaro.org>
 <CAOZdJXV8x8EMQEZhdFS+34iO+6P9S==k9bQjt=67iXt6K2oSCw@mail.gmail.com>
 <563AE588.1080009@roeck-us.net> <563B5DF9.6080102@codeaurora.org>
 <CADyBb7sD2Y2kGj-suOs1UeUwXPjH39mvX_Sobn0Y7WfsJ9hF=Q@mail.gmail.com>
 <563B62F7.3050307@codeaurora.org>
 <CADyBb7vDf+KRi8gUGEt+iu-GpqVQgVq7nKTVt7O=3x78KCi+RQ@mail.gmail.com>
 <563B6A4B.7090400@codeaurora.org>
 <CADyBb7t6ovfrz1b3ZZykKq22HkZi1W0PWg7-wXihEjM9ciTgGg@mail.gmail.com>
 <563B869F.2010004@roeck-us.net> <56452970.4070209@linaro.org>
 <56452E10.5060705@roeck-us.net> <564E654B.2060000@linaro.org>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <564E68C4.3070709@codeaurora.org>
Date: Thu, 19 Nov 2015 18:26:44 -0600
MIME-Version: 1.0
In-Reply-To: <564E654B.2060000@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Al Stone wrote:
>>> The issue for me in that case is that the SBSA requires a two stage timeout,
>> >
>> >Hmm - really ? This makes me want to step back a bit and re-read the specification
>> >to understand where it says that, and what the reasoning might be for such a
>> >requirement.
> As far as I can tell, that's what the SBSA is requiring.  My understanding is
> that the hardware is to first assert a WS0 signal when the timer expires.  If
> the timer expires and WS0 has already been asserted, the WS1 signal is to be
> asserted.  When WS1 is asserted, the system is to do a hard reset (Section 5.2,
> "Server Base System Architecture", ARM-DEN-0029 Version 2.3).  I'm interpreting
> the occurrence of WS0 as the first stage and WS1 as the second.
>
> To me, at least, this makes sense in a server environment.  The WS0 occurs,
> which gives me some time to save key info or try to recover before WS1 occurs
> (or kexec, or any other cleverness).

I'm having some problem with the word "requires".

I think it applies only to the hardware.  That is, there must be a WS0 
timeout/event, and then after that there must be a WS1 timeout/event.

I don't think there is any "requirement" for software to do anything 
with WS0.  That's why I don't think pre-timeout is necessary for the 
driver to be SBSA-compliant.  All of the drivers for existing two-stage 
watchdog devices treat the device as a one-stage device, because the 
watchdog API does not support pre-timeout.  Are all of them also 
"broken"?  No.  So it would not be broken for an SBSA watchdog driver to 
ignore WS0.

I would have no problem with the following sequence of events:

1) We merge in a driver that treats the SBSA watchdog as a single-stage 
watchdog that does a hard reset at WS1 and ignores WS0.  My driver, with 
a few changes, would qualify.

2) We add support for pre-timeout to the Watchdog interface.  Fu can 
take all the time in the world (as far as I'm concerned) getting this 
perfected.  My only request is that the new pre-timeout API supports 
hardware where the timeout between stages must be equal.  That is, if 
timeout to stage 1 (call it T1) is X seconds, then the timeout to stage 
2 (call it T2) is another X seconds.  T2 = T1.  Of course, the API 
should also support hardware where T2 != T1.

3) The existing SBSA watchdog driver is updated to support the new 
pre-timeout API.  It would enforce the requirement that T2 = T1.

This approach will allow us to get a working SBSA watchdog driver into 
4.5 without much fuss.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
