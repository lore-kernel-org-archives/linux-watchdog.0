Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:32963 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253AbbE2Pqh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 29 May 2015 11:46:37 -0400
Message-ID: <556889D9.5070707@codeaurora.org>
Date: Fri, 29 May 2015 10:46:33 -0500
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
References: <=fu.wei@linaro.org>	<1432548193-19569-1-git-send-email-fu.wei@linaro.org>	<1432548193-19569-6-git-send-email-fu.wei@linaro.org>	<5564A44A.5000606@codeaurora.org>	<CADyBb7uQCPoerjyiGT3uUxXJk6XVTEkEuOdEB+-w6G-=RrdTmA@mail.gmail.com>	<55686960.5010503@codeaurora.org> <CADyBb7tdoajU4crdjrjCf68_Lz=8KbxAX4+Gd_H15aNaimHXww@mail.gmail.com>
In-Reply-To: <CADyBb7tdoajU4crdjrjCf68_Lz=8KbxAX4+Gd_H15aNaimHXww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/29/2015 09:32 AM, Fu Wei wrote:
> It is a SPI, every CPU can get it,
> But maybe I miss something, but please let me know if other CPU can
> not get the interrupt.

There's only one watchdog device, so there's only one interrupt.  I 
don't know which CPU will get the interrupt, but the watchdog is not a 
per-CPU device.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
