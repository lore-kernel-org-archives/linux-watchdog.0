Return-path: <timur@codeaurora.org>
Message-ID: <5577147B.2030900@codeaurora.org>
Date: Tue, 09 Jun 2015 11:29:47 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, Fu Wei <fu.wei@linaro.org>
CC: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Wei Fu <tekkamanninja@gmail.com>,
 G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>,
 Hanjun Guo <hanjun.guo@linaro.org>,
 Ashwin Chaugule <ashwin.chaugule@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>,
 vgandhi@codeaurora.org, wim@iguana.be, Jon Masters <jcm@redhat.com>,
 Leo Duran <leo.duran@amd.com>,
 Jon Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org>	<1433217907-928-1-git-send-email-fu.wei@linaro.org>	<1433217907-928-6-git-send-email-fu.wei@linaro.org>	<556DCC95.806@codeaurora.org>	<CADyBb7sXiMNtrH+Eu1Qj00TPNLMMr5cCTPObzFmKnHLsbWH79Q@mail.gmail.com>	<556DE2D5.3090906@roeck-us.net>	<CADyBb7uT=gFJkK8s-QF1n4Z+Zov9Lurp1nvBO-C-qszTqbMYXQ@mail.gmail.com>	<5575DE48.8010308@roeck-us.net>	<CADyBb7sYPnvDVEJYVQm65B1JV=yvq10+ezs2x3f8F=TJCZ+OJA@mail.gmail.com>	<55766D74.2060401@roeck-us.net>	<CADyBb7vR-jP6ZjzMSnprrSXbNayk8umx+cXV3TsGypfhZcCwTw@mail.gmail.com>	<55769E0E.8060801@roeck-us.net> <CADyBb7skpSZ=3_ByW-RHM99=nbs7Z5xXFXtsKzkxOXAGjxF=3Q@mail.gmail.com> <557712CF.8010802@roeck-us.net>
In-Reply-To: <557712CF.8010802@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 06/09/2015 11:22 AM, Guenter Roeck wrote:
>
>
> but I see your point. Essentially, the specification is broken
> for all practical purposes, since, as you point out, enabling
> the watchdog overwrites and explicitly sets WCV. Effectively
> this means that just using WCV to program the timeout period
> is not really possible.
>
> I am not really sure how to address this. We can either only use WOR,
> and forget about pretimeout, or we can enforce a minimum pretimeout.
> In the latter case, we'll have to write WCV after writing WOR.

In talking with our hardware engineers, using WCV to program the timeout 
period is not a valid operation.  This is why I keep arguing against the 
pre-timeout feature, and I don't agree that servers should always use 
pre-timeout.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
