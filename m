Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36778 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189AbbEWTkd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 23 May 2015 15:40:33 -0400
Message-ID: <5560D7AC.50009@codeaurora.org>
Date: Sat, 23 May 2015 14:40:28 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Fu Wei <fu.wei@linaro.org>
CC: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
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
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org>	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>	<555DFCD4.3040701@codeaurora.org> <CADyBb7vpC6ihvkrRG-htCS8-_xRkjtny=9ZGQsCsmK7-ng5AxA@mail.gmail.com>
In-Reply-To: <CADyBb7vpC6ihvkrRG-htCS8-_xRkjtny=9ZGQsCsmK7-ng5AxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fu Wei wrote:
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

I use emergency_restart(), because the watchdog-api.txt documentation 
says this:

"If userspace fails (RAM error, kernel bug, whatever), the
notifications cease to occur, and the hardware watchdog will reset the
system (causing a reboot) after the timeout occurs."

Maybe I'm reading this too literally, but to me this means that when the 
timeout expires, the system has to reset immediately.

However, maybe panic() is better, since it can do the same thing and more.

> So WS0 is a warning, but not a reset. the WS1 maybe a reset, or a
> interrupt to higher agent.

The watchdog documentation says that the system should reset when the 
timeout occurs.  Therefore, WCV needs to be programming for one-half the 
timeout value, so that WS1 can occur when the watchdog expires.  If the 
application says, "set timeout to 10 second", then the system has to 
reboot after 10 second (if the watchdog is pinged).

If the user does not specify a pre-timeout, and if he sets the watchdog 
to 10 seconds, then WC1 will occur in 20 seconds.  You will still call 
panic() in 10 seconds (during WS0 interrupt), however, so I don't 
understand how pre-timeout is supposed to work.

That's why I'm confused.  I can't tell if you're programming WCV correctly.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
