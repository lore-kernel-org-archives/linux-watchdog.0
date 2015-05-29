Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33677 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757258AbbE2WK4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 29 May 2015 18:10:56 -0400
Message-ID: <5568E3E8.7070008@roeck-us.net>
Date: Fri, 29 May 2015 15:10:48 -0700
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
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 5/6] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org>	<1432548193-19569-1-git-send-email-fu.wei@linaro.org>	<1432548193-19569-6-git-send-email-fu.wei@linaro.org>	<5564A44A.5000606@codeaurora.org>	<CADyBb7uQCPoerjyiGT3uUxXJk6XVTEkEuOdEB+-w6G-=RrdTmA@mail.gmail.com>	<55686960.5010503@codeaurora.org> <CADyBb7tdoajU4crdjrjCf68_Lz=8KbxAX4+Gd_H15aNaimHXww@mail.gmail.com> <556889D9.5070707@codeaurora.org>
In-Reply-To: <556889D9.5070707@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/29/2015 08:46 AM, Timur Tabi wrote:
> On 05/29/2015 09:32 AM, Fu Wei wrote:
>> It is a SPI, every CPU can get it,
>> But maybe I miss something, but please let me know if other CPU can
>> not get the interrupt.
>
> There's only one watchdog device, so there's only one interrupt.  I don't know which CPU will get the interrupt, but the watchdog is not a per-CPU device.
>
Plus, that one interrupt is not shared, and the driver returns
IRQ_HANDLED even if the bit is not set. So _something_ is definitely
wrong. Either the interrupt is shared, then it needs to be requested
as shared and the handler should only return IRQ_HANDLED if it actually
handles the interrupt. Or it is not shared and the handler should always
handle it.

Guenter

