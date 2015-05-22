Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35437 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbbEVFFk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 May 2015 01:05:40 -0400
Received: by obcus9 with SMTP id us9so5688477obc.2
        for <linux-watchdog@vger.kernel.org>; Thu, 21 May 2015 22:05:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <555E08BD.9010603@codeaurora.org>
References: <=fu.wei@linaro.org>
	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>
	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>
	<555DB4C4.5090606@roeck-us.net>
	<CADyBb7vbcHG69cpnx6sUwaT7abS7w3Er62+50D6PUrGHVnG9vQ@mail.gmail.com>
	<20150521151847.GA16668@roeck-us.net>
	<CADyBb7tPjZrty-B=Lis_zdObxM1_MRcKCinOx3K73=6juxsikw@mail.gmail.com>
	<20150521155950.GA18300@roeck-us.net>
	<CADyBb7vwGcdxeOE+QEzgmF5=2dsk83F4WyfJvp2ccZ12w1qYHQ@mail.gmail.com>
	<555E08BD.9010603@codeaurora.org>
Date: Fri, 22 May 2015 13:05:38 +0800
Message-ID: <CADyBb7sboCUrsgKtLO1NgfBAwoQCs30RCHtrJ3RmL1Jw_Ry9hw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Timur.

On 22 May 2015 at 00:33, Timur Tabi <timur@codeaurora.org> wrote:
> On 05/21/2015 11:12 AM, Fu Wei wrote:
>>>
>>> >
>>> >Having said that, my personal preference would be for the counter
>>> >and rate to be exported through the clock subsystem (ie with
>>> >clk_get_rate). But that would still not provide the current counter
>>> >value, so maybe that isn't even possible.
>>
>> I will try to make a patch for this, If the arm maintainers don't like
>> exporting "arch_timer_get_rate();"
>>
>> But your thought is good,  the clk_get_rate is the best way to do for now
>
>
> The rate isn't the problem.  It's the current timestamp counter.  The only
> way to get that is with either arch_counter_get_cntvct() or
> arch_timer_read_counter().  I'm not sure which of the two functions is
> better.  However, arch_timer_read_counter() is really just a function
> pointer that points to arch_counter_get_cntvct().
>
> Also, clk_get_rate() only works if you have a real clk object.  I've said
> this before many times, but on my ACPI platform, there are no clk objects.
> Clocks are handled by UEFI.

Thanks for your info,
I think : right now , do what we can do, export the interface of arch_timer,
If the arm maintainers don't like this way,  we can find another way
later or find a option as plan B.

>
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.



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
