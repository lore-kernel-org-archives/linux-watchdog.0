Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34229 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbbKBEKG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 1 Nov 2015 23:10:06 -0500
Received: by obbza9 with SMTP id za9so85185909obb.1
        for <linux-watchdog@vger.kernel.org>; Sun, 01 Nov 2015 20:10:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5633D514.4060102@codeaurora.org>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
	<1445961999-9506-2-git-send-email-fu.wei@linaro.org>
	<20151027162257.GJ3091@leverpostej>
	<CADyBb7sAcT4bXrkNo2GKx1Tw5wOuf8JeMgCoiAw=owHqvYx6ug@mail.gmail.com>
	<CAOZdJXVan3xaYAS_+150nDO1ogWh+PtkQAZvwrHusJhY4R1a4A@mail.gmail.com>
	<CADyBb7sPqsoQdYBUpHY2HvZ+iT7ABa9NoCX7Jax1NKugYOy1zQ@mail.gmail.com>
	<5633BCA4.1050400@codeaurora.org>
	<20151030190514.GD30791@leverpostej>
	<5633D514.4060102@codeaurora.org>
Date: Mon, 2 Nov 2015 12:10:05 +0800
Message-ID: <CADyBb7sfQ2=LuKx17Si1U_04P0-JC815wQTOUeC_FomSw5kwBg@mail.gmail.com>
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

Hi Timur.

On 31 October 2015 at 04:37, Timur Tabi <timur@codeaurora.org> wrote:
> On 10/30/2015 02:05 PM, Mark Rutland wrote:
>>
>> I was only asking why the interrupt was optional, and it seems per the
>> spec it's expected to be handed to an agent at a higher exception level.
>>
>> That implies that the OS should only care about WS0, assuming that I've
>> understood correctly.
>
>
> Yes, this my understand as well.  Apologies if I didn't get that across.

Sorry for misunderstanding your meaning.
maybe Linux don't need to handle WS1, but I am not sure if there is a
hardware with WS1 interrupt we need to handle.

>
>
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.



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
