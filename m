Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46280 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbbEXQu0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 24 May 2015 12:50:26 -0400
Message-ID: <5562014D.1090503@roeck-us.net>
Date: Sun, 24 May 2015 09:50:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Timur Tabi <timur@codeaurora.org>, Fu Wei <fu.wei@linaro.org>
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
References: <=fu.wei@linaro.org>	<1432197156-16947-1-git-send-email-fu.wei@linaro.org>	<1432197156-16947-7-git-send-email-fu.wei@linaro.org>	<555DFCD4.3040701@codeaurora.org>	<CADyBb7vpC6ihvkrRG-htCS8-_xRkjtny=9ZGQsCsmK7-ng5AxA@mail.gmail.com>	<5560D7AC.50009@codeaurora.org>	<5560DCB6.3090008@roeck-us.net>	<CADyBb7t7+aT=pF0we5umAGXJAJ0njU0zULFAZ-OHVpE0m=ueyg@mail.gmail.com>	<5561E7EA.5090702@codeaurora.org> <CADyBb7tYL7ATRKNAoRYTXo53LKdCiFZ2YDib4g0nZ8=YxTgO+A@mail.gmail.com> <5561F8A8.4080607@codeaurora.org> <5561FC70.5080802@roeck-us.net> <5561FFF0.5090108@codeaurora.org>
In-Reply-To: <5561FFF0.5090108@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/24/2015 09:44 AM, Timur Tabi wrote:
> Guenter Roeck wrote:
>
>> The current watchdog API suggests that the pretimeout "allows Linux
>> to record useful information (like panic information and kernel
>> coredumps) before it resets". The call to panic() would be the
>> means to make this happen.
>
> Now that I think about it, that does make sense.
>
> However, if a pre-timeout is not set, then the driver should never call panic().  That means that the interrupt handler should only be registered if sbsa_gwdt_set_pretimeout() is called.
>

This is a matter of opinion. Some watchdogs have two (or even more)
levels of timeouts without explicit pretimeout. The iTCO watchdog
in Intel systems is an example, but there are several others.

For such systems, there may be an initial interrupt followed
by a hard reset a little later. In such cases it does make sense
to wire up the interrupt and have it call panic(). If the system
gets stuck, the second timeout will reset it.

Guenter

