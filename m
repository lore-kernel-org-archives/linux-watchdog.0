Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59230 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbbEUQdG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 May 2015 12:33:06 -0400
Message-ID: <555E08BD.9010603@codeaurora.org>
Date: Thu, 21 May 2015 11:33:01 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Fu Wei <fu.wei@linaro.org>, Guenter Roeck <linux@roeck-us.net>
CC: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
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
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org>	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>	<555DB4C4.5090606@roeck-us.net>	<CADyBb7vbcHG69cpnx6sUwaT7abS7w3Er62+50D6PUrGHVnG9vQ@mail.gmail.com>	<20150521151847.GA16668@roeck-us.net>	<CADyBb7tPjZrty-B=Lis_zdObxM1_MRcKCinOx3K73=6juxsikw@mail.gmail.com>	<20150521155950.GA18300@roeck-us.net> <CADyBb7vwGcdxeOE+QEzgmF5=2dsk83F4WyfJvp2ccZ12w1qYHQ@mail.gmail.com>
In-Reply-To: <CADyBb7vwGcdxeOE+QEzgmF5=2dsk83F4WyfJvp2ccZ12w1qYHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/21/2015 11:12 AM, Fu Wei wrote:
>> >
>> >Having said that, my personal preference would be for the counter
>> >and rate to be exported through the clock subsystem (ie with
>> >clk_get_rate). But that would still not provide the current counter
>> >value, so maybe that isn't even possible.
> I will try to make a patch for this, If the arm maintainers don't like
> exporting "arch_timer_get_rate();"
>
> But your thought is good,  the clk_get_rate is the best way to do for now

The rate isn't the problem.  It's the current timestamp counter.  The 
only way to get that is with either arch_counter_get_cntvct() or 
arch_timer_read_counter().  I'm not sure which of the two functions is 
better.  However, arch_timer_read_counter() is really just a function 
pointer that points to arch_counter_get_cntvct().

Also, clk_get_rate() only works if you have a real clk object.  I've 
said this before many times, but on my ACPI platform, there are no clk 
objects.  Clocks are handled by UEFI.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
