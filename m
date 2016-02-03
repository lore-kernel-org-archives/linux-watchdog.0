Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33568 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965344AbcBCSGE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Feb 2016 13:06:04 -0500
Received: by mail-ob0-f177.google.com with SMTP id is5so40628588obc.0
        for <linux-watchdog@vger.kernel.org>; Wed, 03 Feb 2016 10:06:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56B23E99.1030604@codeaurora.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
	<1454519923-25230-6-git-send-email-fu.wei@linaro.org>
	<56B23883.7000501@codeaurora.org>
	<CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
	<56B23E99.1030604@codeaurora.org>
Date: Thu, 4 Feb 2016 02:06:02 +0800
Message-ID: <CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
Subject: Re: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
From: Fu Wei <fu.wei@linaro.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Jon Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@codeaurora.org>,
	Christopher Covington <cov@codeaurora.org>,
	Dave Young <dyoung@redhat.com>,
	Pratyush Anand <panand@redhat.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Leo Duran <leo.duran@amd.com>, sudeep.holla@arm.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Timur

On 4 February 2016 at 01:53, Timur Tabi <timur@codeaurora.org> wrote:
> Fu Wei wrote:
>>
>> sorry, are you saying : using pre-timeout instead of this half timeout?
>>
>> But even we have pre-timeout support, pre-timeout  == timeout / 2, it
>> can not be configured without touch timeout.
>>
>> if you want pre-timeout  != timeout / 2, we have to modify WCV in the
>> interrupt routine.
>>   (because of the explicit watchdog refresh  mechanism)
>>
>> Could you let me know why we need pre-timeout  here ??:-)
>
>
> What I meant was that if we had full-blown pre-timeout support in the
> watchdog layer, then you could use that to implement the
> panic-on-half-timeout feature.
>
> When pre-timeout is implemented, will you modify the interrupt handler to
> use it?

Sorry I am little confused.

Actually I am taking your suggestion to avoid touching WCV in
interrupt routine.
So even we have pre-timeout support , it is useless for this
panic-on-half-timeout feature,
because pre-timeout  == timeout / 2 (always).

So maybe I misunderstand your suggestion,
could you let me know : why we want pre-timeout here?


>
>>> >belong upstream.  But like I said, it's just my opinion, and I won't
>>> >complain if I'm outvoted.
>>
>>   I think this debugging feature is the  purpose of the two-stage
>> watchdog, if I understand correctly
>
>
> Hmmm... that make sense.  I think maybe you should drop the Kconfig option,
> and just have "static bool panic_enabled = false;"  Also, then do this:
>
> if (panic_enabled) {
>         ret = devm_request_irq(dev, irq, sbsa_gwdt_interrupt, 0,
>                                pdev->name, gwdt);
>         if (ret) {
>                 dev_err(dev, "unable to request IRQ %d\n", irq);
>                 return ret;
>         }
> }

yes, agree

>
> That way, the interrupt handler is never registered if the command-line
> parameter is not specified.
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
