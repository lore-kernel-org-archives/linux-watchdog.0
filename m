Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from [208.91.199.152] ([208.91.199.152]:49112 "EHLO
	bh-25.webhostbox.net" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbbFIIFd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Jun 2015 04:05:33 -0400
Message-ID: <55769E0E.8060801@roeck-us.net>
Date: Tue, 09 Jun 2015 01:04:30 -0700
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
References: <=fu.wei@linaro.org>	<1433217907-928-1-git-send-email-fu.wei@linaro.org>	<1433217907-928-6-git-send-email-fu.wei@linaro.org>	<556DCC95.806@codeaurora.org>	<CADyBb7sXiMNtrH+Eu1Qj00TPNLMMr5cCTPObzFmKnHLsbWH79Q@mail.gmail.com>	<556DE2D5.3090906@roeck-us.net>	<CADyBb7uT=gFJkK8s-QF1n4Z+Zov9Lurp1nvBO-C-qszTqbMYXQ@mail.gmail.com>	<5575DE48.8010308@roeck-us.net>	<CADyBb7sYPnvDVEJYVQm65B1JV=yvq10+ezs2x3f8F=TJCZ+OJA@mail.gmail.com>	<55766D74.2060401@roeck-us.net> <CADyBb7vR-jP6ZjzMSnprrSXbNayk8umx+cXV3TsGypfhZcCwTw@mail.gmail.com>
In-Reply-To: <CADyBb7vR-jP6ZjzMSnprrSXbNayk8umx+cXV3TsGypfhZcCwTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/08/2015 11:37 PM, Fu Wei wrote:

>
> I would like to stress that  pretimeout == 0 should not happen in a
> real server system,  that is why we defined  a SBSA watchdog, but not
> a normal one

Clarification - In _your opinion_, a server should always use pretimeout.

> But we still need to thinking about the situation that administrator
> want to do this on a very special purpose.
>
I could as well argue that setting pretimeout is the special situation.
Some administrators may not want to bother but just want the system to reset
if  a watchdog timeout occurs. _Maybe_ if it happens multiple times,
they might want to set up pretimeout to figure out why.

Declaring that one _has_ to configure pretimeout is just a personal
opinion, nothing else. We don't know what server administrators want,
and we should not dictate anything unless technically necessary.

> maybe we can set min_pretimeout = 1 for this driver. that is just a suggestion.
>
No. It is not technically necessary.

>
>> if it must be set to a value > 0 I don't understand why
>> setting it to 1 (instead of 1 second) would not be sufficient.
>
> it don't have to be 1 second , it can be 0.1, 0.5 or 0.01 second. like
> I said before, we just need a time slot to setup WCV in
> sbsa_gwdt_start. I have commented this in sbsa_gwdt_set_pretimeout in
> this patchset.

I think what you really want to say is that you want to have time to
handle the interrupt. But handling the interrupt is not asked for if
pretimeout == 0.

> But I think the minimum time slot depend on implementation, the spec
> doesn't mention about this.

Yes, because a minimum value does not exist.

> If pretimeout == 0, and we set up WOR a little bigger,  it *ONLY*
> affect "the worst case" I mention above. in this case, a administrator
> set up pretimeout == 0 which should not happen in a real server, then
> the system goes very wrong. I don't think it is important that this
> server system reset in 1 second or 0.0001 second, at this time, this
> server can not provide any useful info anyway(because we don't use
> pretimeout).
> If system may go wrong,  the administrator should set up pretimeout >
> 0 to figure out what is wrong with it just like he always should do.
>

Yes, exactly. But otherwise, if pretimeout is set to 0, we want
to reset immediately as directed.

As I interpret the specification, WOR=0 forces WS1 immediately after WS0.

1) if TimeoutRefresh = True:
	CompareValue := SystemCounter + WOR (= SystemCounter
	WS0 := True
2) TimeoutRefresh is True again, WS0 == True:
	WS1 = True

This is exactly the behavior we want if pretimeout == 0. In this situation,
we don't want to handle the interrupt, we just want to reset the system as
fast as possible.

Having said that, have you tested what happens in your system if you
set WOR=0 ?

Thanks,
Guenter

