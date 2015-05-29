Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51368 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbbE2N2E (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 29 May 2015 09:28:04 -0400
Message-ID: <55686960.5010503@codeaurora.org>
Date: Fri, 29 May 2015 08:28:00 -0500
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
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 5/6] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org>	<1432548193-19569-1-git-send-email-fu.wei@linaro.org>	<1432548193-19569-6-git-send-email-fu.wei@linaro.org>	<5564A44A.5000606@codeaurora.org> <CADyBb7uQCPoerjyiGT3uUxXJk6XVTEkEuOdEB+-w6G-=RrdTmA@mail.gmail.com>
In-Reply-To: <CADyBb7uQCPoerjyiGT3uUxXJk6XVTEkEuOdEB+-w6G-=RrdTmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fu Wei wrote:
>> This should always be true.  Instead of reading WCS, I think you should just
>> >panic().

> I thinks I need to confirm it , in case this has been cleaned.

I don't see how it's possible for you to receive the interrupt and have 
WCS be cleared.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
