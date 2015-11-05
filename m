Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35191 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965549AbbKEL6D (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Nov 2015 06:58:03 -0500
Received: by obctp1 with SMTP id tp1so63849556obc.2
        for <linux-watchdog@vger.kernel.org>; Thu, 05 Nov 2015 03:58:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <563AE588.1080009@roeck-us.net>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
	<1445961999-9506-6-git-send-email-fu.wei@linaro.org>
	<CAOZdJXV8x8EMQEZhdFS+34iO+6P9S==k9bQjt=67iXt6K2oSCw@mail.gmail.com>
	<563AE588.1080009@roeck-us.net>
Date: Thu, 5 Nov 2015 19:58:02 +0800
Message-ID: <CADyBb7tTf0Jz0sgKecSn-LgMEUMdueTb5Uxq_e5t39byOsJQEQ@mail.gmail.com>
Subject: Re: [Linaro-acpi] [PATCH v8 5/5] Watchdog: introduce ARM SBSA
 watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Timur Tabi <timur@codeaurora.org>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>, Jon Masters <jcm@redhat.com>,
	Pratyush Anand <panand@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Wei Fu <tekkamanninja@gmail.com>,
	Rob Herring <robherring2@gmail.com>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

Great thanks for your feedback!

On 5 November 2015 at 13:13, Guenter Roeck <linux@roeck-us.net> wrote:
> On 11/04/2015 05:59 PM, Timur Tabi wrote:
>>
>> On Tue, Oct 27, 2015 at 11:06 AM,  <fu.wei@linaro.org> wrote:
>>>
>>> +static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
>>> +{
>>> +       struct sbsa_gwdt *gwdt = (struct sbsa_gwdt *)dev_id;
>>> +       struct watchdog_device *wdd = &gwdt->wdd;
>>> +
>>> +       /* We don't use pretimeout, trigger WS1 now */
>>> +       if (!wdd->pretimeout)
>>> +               sbsa_gwdt_set_wcv(wdd, 0);
>>
>>
>> So I'm still concerned about the fact this driver depends on an
>> interrupt handler in order to properly program the hardware.  Unlike
>> some other devices, the SBSA watchdog does not need assistance to
>> reset on a timeout -- it is a "fire and forget" device.  What happens
>> if there is a hard lockup, and interrupts no longer work?

The reason for this design(program WCV in interrupt handler):
(1) if we don't, the second timeout stage(pretimeout) is only  (worst
case) 10 seconds
This short time is not enough for kexec(let alone kdump), that make
panic less useful.
(2)if  a hard lockup really happens, panic won't work too.But we still
can reboot system by the help of WS1
in this case, if clk is 400MHz, we just need to wait (worst case) 10
seconds for WS1 reboot system

>>
>> Keep in mind that 99% of watchdog daemons will not enable the
>> pre-timeout feature because it's new.

Answer:
(1)It is not new.
 pre-timeout concept has been used by two drivers before this driver.
and this concept has been in kernel documentation.

(2)even it's new, it doesn't mean we can not do this at this time.
Because according to the info I got, I believe that is right way to do.
After I make a "non-pretimeout" version. and compare with the original
pretimeout version, I still believe pretimeout is best solution for
now.

Reason for using pretimeout:
(1) if we don't, for this two stages timeout, we have to config them
by one value.
that means "the first stage timeout" have to be equal to "the second
stage timeout",
For example, if we need 60 second for  "the second stage timeout", 30
or less for "the first stage timeout".
then "the first stage timeout" have to be 60s too. I don't think it 's
good idea.

>>
> Same here, really.
>
> I would feel much more comfortable if the driver would just use the standard
> watchdog timeout and live with (worst case) 20 seconds timeout for now.

The worst case is 10s. like I said above, This short time is not
enough for kexec(let alone kdump), that make WS0(and panic, even this
two stages design) less useful

> This limitation will be gone once the infrastructure is in place to handle
> such short timeouts in the watchdog core. Until then, I would argue that the

unless WOR become 64 bit (or more then 32bit),  this limitation will be there.

> system designers asked for it if they really select the highest possible
> clock rate.
>

even we can make clk to be 100MHz or lower, it is not very helpful for
a really server which has big memory. they need more time for dumping
memory for debug/analysis


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
