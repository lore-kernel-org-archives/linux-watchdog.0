Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35572 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbbFKFdU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 11 Jun 2015 01:33:20 -0400
Received: by obbgp2 with SMTP id gp2so48105717obb.2
        for <linux-watchdog@vger.kernel.org>; Wed, 10 Jun 2015 22:33:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5579190E.8000803@roeck-us.net>
References: <=fu.wei@linaro.org>
	<1433217907-928-1-git-send-email-fu.wei@linaro.org>
	<1433217907-928-6-git-send-email-fu.wei@linaro.org>
	<556DCC95.806@codeaurora.org>
	<CADyBb7sXiMNtrH+Eu1Qj00TPNLMMr5cCTPObzFmKnHLsbWH79Q@mail.gmail.com>
	<556DE2D5.3090906@roeck-us.net>
	<CADyBb7uT=gFJkK8s-QF1n4Z+Zov9Lurp1nvBO-C-qszTqbMYXQ@mail.gmail.com>
	<5575DE48.8010308@roeck-us.net>
	<CADyBb7sYPnvDVEJYVQm65B1JV=yvq10+ezs2x3f8F=TJCZ+OJA@mail.gmail.com>
	<55766D74.2060401@roeck-us.net>
	<CADyBb7vR-jP6ZjzMSnprrSXbNayk8umx+cXV3TsGypfhZcCwTw@mail.gmail.com>
	<55769E0E.8060801@roeck-us.net>
	<CADyBb7skpSZ=3_ByW-RHM99=nbs7Z5xXFXtsKzkxOXAGjxF=3Q@mail.gmail.com>
	<557712CF.8010802@roeck-us.net>
	<5577147B.2030900@codeaurora.org>
	<5577180E.4070804@roeck-us.net>
	<CADyBb7sVd5nLwb3eHRPiNt-WTynfaJonOyuE_bD694dayyvevA@mail.gmail.com>
	<5578D4D5.3070109@codeaurora.org>
	<CADyBb7s-02-m54P54GAQbfX_RMh1vXBg+RjVypuW1GOEFO1LKQ@mail.gmail.com>
	<55790455.7090809@codeaurora.org>
	<5579190E.8000803@roeck-us.net>
Date: Thu, 11 Jun 2015 13:33:19 +0800
Message-ID: <CADyBb7s3=0oK5mmuO5-nSvVtgpqNdCb6gtnn3UDX-DthWcXphw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Timur Tabi <timur@codeaurora.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter

On 11 June 2015 at 13:13, Guenter Roeck <linux@roeck-us.net> wrote:
> On 06/10/2015 08:45 PM, Timur Tabi wrote:
>>
>> Fu Wei wrote:
>>>
>>> Could you suggest a good way to use WS0, so we can follow SBSA spec?
>>
>>
>> To avoid the timeout/2 problem, WS0 calls panic, which is the "real"
>> timeout/reset.  WS1 is then a "backup" that is ignored by the driver. That
>> is, the driver doesn't do anything with WS1 and it doesn't tell the kernel
>> about WS1.
>>
>> I know you don't like the idea of WS1 as a backup timeout, but this is one
>> way to solve the problem.
>>
> This is what I would do.

If so, Please check the non-pretimeout version.  Thanks

>
> Guenter
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
