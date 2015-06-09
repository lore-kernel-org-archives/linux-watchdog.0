Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from [208.91.199.152] ([208.91.199.152]:41239 "EHLO
	bh-25.webhostbox.net" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S932537AbbFIQXo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Jun 2015 12:23:44 -0400
Message-ID: <557712CF.8010802@roeck-us.net>
Date: Tue, 09 Jun 2015 09:22:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Fu Wei <fu.wei@linaro.org>
CC: Timur Tabi <timur@codeaurora.org>,
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
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org>	<1433217907-928-1-git-send-email-fu.wei@linaro.org>	<1433217907-928-6-git-send-email-fu.wei@linaro.org>	<556DCC95.806@codeaurora.org>	<CADyBb7sXiMNtrH+Eu1Qj00TPNLMMr5cCTPObzFmKnHLsbWH79Q@mail.gmail.com>	<556DE2D5.3090906@roeck-us.net>	<CADyBb7uT=gFJkK8s-QF1n4Z+Zov9Lurp1nvBO-C-qszTqbMYXQ@mail.gmail.com>	<5575DE48.8010308@roeck-us.net>	<CADyBb7sYPnvDVEJYVQm65B1JV=yvq10+ezs2x3f8F=TJCZ+OJA@mail.gmail.com>	<55766D74.2060401@roeck-us.net>	<CADyBb7vR-jP6ZjzMSnprrSXbNayk8umx+cXV3TsGypfhZcCwTw@mail.gmail.com>	<55769E0E.8060801@roeck-us.net> <CADyBb7skpSZ=3_ByW-RHM99=nbs7Z5xXFXtsKzkxOXAGjxF=3Q@mail.gmail.com>
In-Reply-To: <CADyBb7skpSZ=3_ByW-RHM99=nbs7Z5xXFXtsKzkxOXAGjxF=3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/09/2015 03:46 AM, Fu Wei wrote:

> Yes, if WOR only affect in TimeoutRefresh, we cat always make WOR == pretimeout
> But the problem is  if we enable watchdog (write 0x01 to WCS will
> cause an explicit watchdog refresh), then
> 1) if ExplicitRefresh = True:
>           CompareValue := SystemCounter + WOR
>           WS0 := True
> 2) TimeoutRefresh is True again, WS0 == True:
>           WS1 = True
>
> so once we enable watchdog, system reset, that is not what we want.
> this behavior is following SBSA spec.
>

Ok, I admit I am a bit slow ;-).

WS0 := True would be set the next time around, since

	if ExplicitRefresh == True
		WS0 = False
		WS1 = False

but I see your point. Essentially, the specification is broken
for all practical purposes, since, as you point out, enabling
the watchdog overwrites and explicitly sets WCV. Effectively
this means that just using WCV to program the timeout period
is not really possible.

I am not really sure how to address this. We can either only use WOR,
and forget about pretimeout, or we can enforce a minimum pretimeout.
In the latter case, we'll have to write WCV after writing WOR.

Thanks,
Guenter

