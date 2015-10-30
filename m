Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35210 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760085AbbJ3Sfx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Oct 2015 14:35:53 -0400
Received: by obctp1 with SMTP id tp1so50926363obc.2
        for <linux-watchdog@vger.kernel.org>; Fri, 30 Oct 2015 11:35:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOZdJXVan3xaYAS_+150nDO1ogWh+PtkQAZvwrHusJhY4R1a4A@mail.gmail.com>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
	<1445961999-9506-2-git-send-email-fu.wei@linaro.org>
	<20151027162257.GJ3091@leverpostej>
	<CADyBb7sAcT4bXrkNo2GKx1Tw5wOuf8JeMgCoiAw=owHqvYx6ug@mail.gmail.com>
	<CAOZdJXVan3xaYAS_+150nDO1ogWh+PtkQAZvwrHusJhY4R1a4A@mail.gmail.com>
Date: Sat, 31 Oct 2015 02:35:52 +0800
Message-ID: <CADyBb7sPqsoQdYBUpHY2HvZ+iT7ABa9NoCX7Jax1NKugYOy1zQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] Documentation: add sbsa-gwdt driver documentation
From: Fu Wei <fu.wei@linaro.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>,
	Dave Young <dyoung@redhat.com>,
	Pratyush Anand <panand@redhat.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Rob Herring <robherring2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Timur

On 31 October 2015 at 01:46, Timur Tabi <timur@codeaurora.org> wrote:
> On Tue, Oct 27, 2015 at 11:10 PM, Fu Wei <fu.wei@linaro.org> wrote:
>>
>>> Why is WS1 optional?
>>
>> According to the description of WS1 in SBSA 2.3 (5.2 Watchdog Operation) page 21
>> -----------------
>> The signal is fed to a higher agent as an interrupt or reset for it to
>> take executive action.
>> ----------------
>>
>> So WS1 maybe a interrupt.
>>
>> In a real Hardware,  WS1 hooks to a  reset signal pin of BMC, if this
>> pin is triggered, BMC will do a real warm reset.
>> In this case, WS1 is a reset, Linux doesn't need to deal with that.
>>
>> For now , I haven't found a hardware use WS1 as  interrupt.
>> In <ARM v8-A Foundation Platform User Guide> 3.2 Interrupt maps  Page 22
>> Table 3-3 Shared peripheral interrupt assignments
>> IRQ ID       SPI offset      Device
>> 60               28              EL2 Generic Watchdog WS1
>>
>> But I don't have further info about it.
>>
>> Anyway,  because this signal could be interrupt or reset, Linux don't
>> need know this signal sometimes.
>> So I think it should be optional in binding info.
>>
>> Do I miss something? Any suggestion ? Please correct me, thanks.
>
> I think maybe Mark was asking why WS1 is optional, not the WS1

My answer is for "why WS1 is optional"!

> interrupt.  Maybe you can reword the documentation to make is clear
> that

I didn't say : "only the *interrupt* for WS1 is optional."

>
> However, the ACPI table only allows for one interrupt, and it's not
> clear whether that's the WS0 or WS1 interrupt.  So if both WS0 and WS1
> generate an interrupt, how does the driver handle that?

register a interrupt handle for both

>
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.



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
