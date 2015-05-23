Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33338 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757985AbbEWQu5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 23 May 2015 12:50:57 -0400
Received: by obbnx5 with SMTP id nx5so31948431obb.0
        for <linux-watchdog@vger.kernel.org>; Sat, 23 May 2015 09:50:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADyBb7vpC6ihvkrRG-htCS8-_xRkjtny=9ZGQsCsmK7-ng5AxA@mail.gmail.com>
References: <=fu.wei@linaro.org>
	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>
	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>
	<555DFCD4.3040701@codeaurora.org>
	<CADyBb7vpC6ihvkrRG-htCS8-_xRkjtny=9ZGQsCsmK7-ng5AxA@mail.gmail.com>
Date: Sun, 24 May 2015 00:50:56 +0800
Message-ID: <CADyBb7tC3OHojSgAUdcHqrpw8SSrBNoFZ=t6tBCJiXg450Q4gA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Timur,


On 24 May 2015 at 00:28, Fu Wei <fu.wei@linaro.org> wrote:
> Hi Timur,
>
>
>
> On 21 May 2015 at 23:42, Timur Tabi <timur@codeaurora.org> wrote:
>> On 05/21/2015 03:32 AM, fu.wei@linaro.org wrote:
>>
>>> +static void reload_timeout_to_wcv(struct watchdog_device *wdd)
>>> +{
>>> +       struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>>> +       u64 wcv;
>>> +
>>> +       wcv = arch_counter_get_cntvct() +
>>> +               (u64)(wdd->timeout - wdd->pretimeout) * gwdt->clk;
>>> +
>>> +       sbsa_gwdt_set_wcv(wdd, wcv);
>>> +}
>>
>>
>> ...
>>
>>> +static int sbsa_gwdt_set_timeout(struct watchdog_device *wdd,
>>> +                                unsigned int timeout)
>>> +{
>>> +       wdd->timeout = timeout;
>>> +
>>> +       return 0;
>>> +}
>>
>>
>> ...
>>
>>> +static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
>>> +{
>>> +       struct sbsa_gwdt *gwdt = (struct sbsa_gwdt *)dev_id;
>>> +       struct watchdog_device *wdd = &gwdt->wdd;
>>> +       u32 status;
>>> +
>>> +       status = sbsa_gwdt_cf_read(SBSA_GWDT_WCS, wdd);
>>> +
>>> +       if (status & SBSA_GWDT_WCS_WS0)
>>> +               panic("SBSA Watchdog pre-timeout");
>>> +
>>> +       return IRQ_HANDLED;
>>> +}
>>
>>
>> There's one thing I don't understand about your driver.  The 'timeout' value
>> from the kernel is supposed to to be the number of seconds until the system
>> reboots.  You are programming the WCV with that value, which means that the
>> WS0 interrupt will fire when the timeout expires the first time.  However,
>> you don't reboot the system during this interrupt.  The "panic" will cause
>> the system to halt, but not reboot.  Instead, it will just sit there.
>
> the "panic" is not just  halt the system, please check the code :
> (1)It can trigger Kdump (not just print the panic message), if you
> enable this in the config. that can help server administrator to
> figure out why the system goes wrong.
> (2)panic also can trigger a reboot, if you set up "panic timeout".
>
> Obviously, it won't  just sit there, it can help user figure out the problem.
>
> At the beginning, I would like to make the first signal more useful,
> but for  simplifying the first version of driver , I decide to use
> panic(). but if there is better "alerts"  for a ARM server , I will go
> on maintaining this driver to make WS0 more useful.
>
>> You're waiting for the WS1 timeout for the system to reboot, but this is not
>> a clean reboot, and it occurs at 2*timeout seconds.
>>
>> That's why I like my driver better.  It doesn't have any of this pretimeout
>> stuff, and when the timeout expires during the WS0 interrupt, it calls
>> emergency_restart() which reboots the system properly.  The WS1 hard reset
>> is used as a "backup" reset in case emergency_restart() fails.
>
> OK, If you think so, I hope you can read the SBSA spec more carefully
> For the watchdog signal (WS0/WS1), SBSA say:
> "The initial signal is typically wired to an interrupt and alerts the
> system. The system can attempt to take corrective
> action that includes refreshing the watchdog within the second watch
> period. If the refresh is successful the
> system returns to the previous normal operation.

>From here, you can see, even a panic is not good enough. we even can
refreshing the watchdog.

But for simplifying the driver, I think, at least, panic() can help
user to backup system context, it is very helpful for a server
administrator.
Because server should be very stable and important , if its software
goes wrong, we must figure out the problem, we can not let it happen
again.

but in WS0 interrupt  routine ,  just simply  restart ,  it is not a
server watchdog should do.

> If it fails then the
> second watch period expires and a second
> signal is generated. The signal is fed to a higher agent as an
> interrupt or reset for it to take executive action."
>
> So WS0 is a warning, but not a reset. the WS1 maybe a reset, or a
> interrupt to higher agent.
>
> That is different from a normal watchdog use before. the two stage of
> WS are not just for reset , at least the first one is definitely not a
> reset. and the second one is not a backup.
>
> If you make SBSA watchdog work like a normal watchdog,:
> (1)why we need a new driver and new device? you can just use SP805 in
> the system.
> (2) why we need a two stages?  ( if the second hardware reset signal
> can work more reliably , why use emergency_restart() which is a
> software reset, does it clean the system and do some useful backup or
> sync?  )
>  the only useful thing done by emergency_restart() is
> kmsg_dump(KMSG_DUMP_EMERG);)
> (3)why the first WS is connect to a interrupt, but not a reset
> signal(I believe the direct reset signal is far more reliable than a
> interrupt to trigger a software reset )
>
> And because of WS0 is a warning,  so I decide to use a existing
> watchdog concept "pretimeout":
> -----------------
> Pretimeouts:
>
> Some watchdog timers can be set to have a trigger go off before the
> actual time they will reset the system.  This can be done with an NMI,
> interrupt, or other mechanism.  This allows Linux to record useful
> information (like panic information and kernel coredumps) before it
> resets.
> -----------------
>
>>
>> --
>> Qualcomm Innovation Center, Inc.
>> The Qualcomm Innovation Center, Inc. is a member of the
>> Code Aurora Forum, a Linux Foundation Collaborative Project.
>
>
>
> --
> Best regards,
>
> Fu Wei
> Software Engineer
> Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
> Ph: +86 21 61221326(direct)
> Ph: +86 186 2020 4684 (mobile)
> Room 1512, Regus One Corporate Avenue,Level 15,
> One Corporate Avenue,222 Hubin Road,Huangpu District,
> Shanghai,China 200021



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
