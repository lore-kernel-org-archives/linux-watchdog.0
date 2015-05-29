Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51828 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbbE2Oy0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 29 May 2015 10:54:26 -0400
Message-ID: <55687D9A.8080409@roeck-us.net>
Date: Fri, 29 May 2015 07:54:18 -0700
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
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 5/6] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org>	<1432548193-19569-1-git-send-email-fu.wei@linaro.org>	<1432548193-19569-6-git-send-email-fu.wei@linaro.org>	<55637A6D.3080403@roeck-us.net> <CADyBb7t_OC0FwoCeOr-umZhjTMxXZ65g7U8Ca+SUgmiWwjvm2w@mail.gmail.com>
In-Reply-To: <CADyBb7t_OC0FwoCeOr-umZhjTMxXZ65g7U8Ca+SUgmiWwjvm2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/29/2015 02:11 AM, Fu Wei wrote:
[ ... ]

>>> +
>>> +       status = sbsa_gwdt_cf_read(SBSA_GWDT_WCS, wdd);
>>> +       if (status & SBSA_GWDT_WCS_WS1) {
>>> +               dev_warn(dev, "System reset by WDT(WCS: %x, WCV: %llx)\n",
>>> +                        status, sbsa_gwdt_get_wcv(wdd));
>>
>>
>> Does this message (specifically the WCS / WCV values) have any
>> useful meaning for the user ?
>
> I think so, according to SBSA spec:
> If WS0 is asserted and a timeout refresh occurs then the following must occur:
>      If the system is compliant to SBSA level 2 or higher the compare
> value must retain its current value. This means that the compare value
> records the time that WS1 is asserted.
>
> So, I think WCV can log the time when system reset by WDT, that may
> help user figure out the problem. but WCS can be delete I think.
>

How would that help ? It is just a number with no reference to anything.

Thanks,
Guenter

