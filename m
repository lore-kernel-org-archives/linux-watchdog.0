Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:32987 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933145AbbFJOlF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 10 Jun 2015 10:41:05 -0400
Received: by obcej4 with SMTP id ej4so36687261obc.0
        for <linux-watchdog@vger.kernel.org>; Wed, 10 Jun 2015 07:41:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADyBb7sT=NbtNVfR4wPYi2gbWq73CDY-fu+XAURS_yTY6sL_mQ@mail.gmail.com>
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
	<CADyBb7s7NpQJFiFFGbbjCTQ0+bNCZoVMC4KwaZbWwGs_Wa=mLg@mail.gmail.com>
	<5578482E.70307@codeaurora.org>
	<CADyBb7sT=NbtNVfR4wPYi2gbWq73CDY-fu+XAURS_yTY6sL_mQ@mail.gmail.com>
Date: Wed, 10 Jun 2015 22:41:04 +0800
Message-ID: <CADyBb7tQMXt5_-15GKj91=ztT+Qbi2rV+gaG-=phVxbrF8Jgmw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10 June 2015 at 22:36, Fu Wei <fu.wei@linaro.org> wrote:
> On 10 June 2015 at 22:22, Timur Tabi <timur@codeaurora.org> wrote:
>> Fu Wei wrote:
>>>
>>> Another weakness of only using WOR is the timeout limited by this
>>> 32bit register.
>>> 10s @400MHz generic Timer
>>>
>>> I don't think this limit is good for a server, once the server is i=
n a
>>> heavy load
>>
>>
>> Perhaps, but if that's the limitation of the hardware, then so be it=
=2E
>
> it is not the real limitation, if we use WCV, SBSA spec has mentioned=
 that.
>
> ------ SBSA 2.3-------Page 23 ----------
> Note: the watchdog offset register is 32 bits wide. This gives a
> maximum watch period of around 10s at a system
> counter frequency of 400MHz. If a larger watch period is required the=
n
> the compare value can be programmed
> directly into the compare value register
> ------ SBSA 2.3-------Page 23 ----------

------ SBSA 2.3-------Page 24 ----------
0x010 =E2=80=93 0x013 WCV[31:0]
0x014 =E2=80=93 0x017 WCV[63:32]
Watchdog compare value.
*Read/Write* registers
containing the current value in the watchdog compare
register.
------ SBSA 2.3-------Page 24 ----------

>
> if some hardware doesn't support writing WCV,
> that means this hardware is non-standard SBSA watchdog.
>
>>
>> --
>> Sent by an employee of the Qualcomm Innovation Center, Inc.
>> The Qualcomm Innovation Center, Inc. is a member of the
>> Code Aurora Forum, hosted by The Linux Foundation.
>
>
>
> --
> Best regards,
>
> Fu Wei
> Software Engineer
> Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
> Ph: +86 21 61221326(direct)
> Ph: +86 186 2020 4684 (mobile)
> Room 1512, Regus One Corporate Avenue,Level 15,
> One Corporate Avenue,222 Hubin Road,Huangpu District,
> Shanghai,China 200021



--=20
Best regards,

=46u Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
