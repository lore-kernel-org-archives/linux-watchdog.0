Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49367 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536AbbEUN2I (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 May 2015 09:28:08 -0400
Message-ID: <555DDD63.9070705@roeck-us.net>
Date: Thu, 21 May 2015 06:28:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
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
	Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	"mark.rutland" <mark.rutland@arm.com>
Subject: Re: [PATCH v2 5/7] Watchdog: introduce "pretimeout" into framework
References: <=fu.wei@linaro.org>	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>	<1432197156-16947-6-git-send-email-fu.wei@linaro.org>	<555D9FA8.9060106@roeck-us.net>	<CADyBb7vKgnij6d+akVo1cQmrO4s67BBCr1HPr3n+Z4G0W-KqgA@mail.gmail.com>	<555DB0B8.9000503@roeck-us.net> <CADyBb7sOEBQ-+ApZUPCrxPb0Eoa3FiZHPtNcYZk24VUxM-nieg@mail.gmail.com>
In-Reply-To: <CADyBb7sOEBQ-+ApZUPCrxPb0Eoa3FiZHPtNcYZk24VUxM-nieg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/21/2015 03:50 AM, Fu Wei wrote:
> Hi Guenter,
>
> Great thanks, I have got your review feedback, I will fix the problems :-)
> For update_limits, I also don't want to have that in the watchdog
> driver, and you can't find it in my last version.
> And this version, I integrate the watchdog_init_timeout and
> watchdog_init_pretimeout. so I can not add a  driver specific
> "update_limits" between them.
> I think maybe we can not make this "update_limits" after calling
> init_timeouts, because we need to test and verify the timeout setting
> right after init_pretimeout by max_timeout and min_timeout. that is

Don't you have to do that in set_pretimeout as well, and even adjust
timeout if necessary ?

> why I call update_limits right after init_pretimeout and before
> init_timeout.
>
> any suggestion ?  Great thanks !  :-)
>

Any sequence of
	set_timeout()
	set_pretimeout()
can result in an invalid timeout, since the practical timeout limits
changed. Therefore, you'll have to validate (and possibly update)
the timeout after or during each call to set_pretimeout().
Changing min_timeout and max_timeout won't help there, that
validation still has to happen.

Given this, some other driver developer may choose to not change the
timeout limits at all, validate (and if necessary silently adjust)
the timeout value in the set_timeout function, and call the set_timeout
function from set_pretimeout to ensure that the timeout is still
valid after the call to set_pretimeout. At least I would most likely
implement it that way.

This means your choice of continuously updating the timeout limits
is really a driver developer choice, not something that is needed
in the driver core. It might even be problematic, since driver
developers might forget to re-validate the current timeout after
changing the pretimeout in a similar situation.

Having said that, and looking through the SBSA driver code, it seems
to me that it does not re-validate the current timeout after setting
a new pretimeout. Unless I am missing something,
	set_timeout(10);
	set_pretimeout(20);
might therefore result in an invalid / unexpected timeout value.
Setting
	set_timeout(10);
	set_pretimeout(10);
might have even more interesting results. Can you try what happens
with your driver if you set those values ?

Thanks,
Guenter

