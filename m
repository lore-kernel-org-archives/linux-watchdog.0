Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35594 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030185AbbEONz3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 May 2015 09:55:29 -0400
Message-ID: <5555FACD.6000408@codeaurora.org>
Date: Fri, 15 May 2015 08:55:25 -0500
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
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>
Subject: Re: [PATCH 4/6] Watchdog: introdouce "pretimeout" into framework
References: <=fu.wei@linaro.org>	<1431689090-3125-1-git-send-email-fu.wei@linaro.org>	<5555F5C5.8050806@roeck-us.net> <CADyBb7sC5a6vC6CqQsfCqOaxz1P8gKNkZi5qEHtXL7efv42-=Q@mail.gmail.com>
In-Reply-To: <CADyBb7sC5a6vC6CqQsfCqOaxz1P8gKNkZi5qEHtXL7efv42-=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fu Wei wrote:
>> >The new API function also needs to be documented in
>> >Documentation/watchdog/watchdog-kernel-api.txt.
> good point, thanks will do

Yes, please, since my driver does not use or need any pre-timeout 
support, so I don't understand why this patch exists.  What is 
pre-timeout anyway?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
