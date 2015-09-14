Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47549 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbbINSFW (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Sep 2015 14:05:22 -0400
Message-ID: <55F70C5B.8040508@arm.com>
Date: Mon, 14 Sep 2015 19:05:15 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Fu Wei <fu.wei@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
CC: Hanjun Guo <hanjun.guo@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>, dyoung@redhat.com,
	panand@redhat.com, Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v7 8/8] clocksource: simplify ACPI code in arm_arch_timer.c
References: <=fu.wei@linaro.org>	<1440435683-7343-1-git-send-email-fu.wei@linaro.org>	<1440435683-7343-9-git-send-email-fu.wei@linaro.org>	<alpine.DEB.2.11.1508241942450.3873@nanos>	<CADyBb7sVGePKtU45_DBGd74fykAPVshmbnRQJDDOrrvoHTGcKQ@mail.gmail.com>	<alpine.DEB.2.11.1508252113590.15006@nanos>	<55DEFC54.4090904@linaro.org>	<alpine.DEB.2.11.1508271405330.15006@nanos>	<55DF025F.2050102@linaro.org>	<55DF1257.9090303@linaro.org>	<alpine.DEB.2.11.1508271539560.15006@nanos> <CADyBb7vKQq_T_P27hZQs+6-TJo2YD=QXjVseQ8dOvixwSHwL5A@mail.gmail.com>
In-Reply-To: <CADyBb7vKQq_T_P27hZQs+6-TJo2YD=QXjVseQ8dOvixwSHwL5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 27/08/15 14:51, Fu Wei wrote:
> Hi Thomas, Hanjun
> 
> On 27 August 2015 at 21:40, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Thu, 27 Aug 2015, Hanjun Guo wrote:
>>>> [1]: https://lkml.org/lkml/2015/7/29/236
>>>>
>>>> If that is ok with you, we will introduce similar DECLARE_ thing
>>>> for clock declare.
>>
>> Yes.
> 
> Thanks
> 
>>
>>> Or we can drop this patch from this patch set, and clean up this
>>> patch when the ACPI_DECLARE() infrastructure is ready for upstream.
>>
>> Works either way. I just noticed that hard coded init thing and
>> decided to rant about it :)
> 
> OK, good idea, this patch will be improve by DECLARE_ thing, then upstream.
> drop this from this patchset.
> 
> Great thanks for your help

You probably want to keep an eye on this:

https://lwn.net/Articles/657238/

which implements the necessary infrastructure. I'd appreciate if you
could give it a go to find out if it works for you.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
