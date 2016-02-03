Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35303 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933731AbcBCRtD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Feb 2016 12:49:03 -0500
Received: by mail-ob0-f174.google.com with SMTP id xk3so40674808obc.2
        for <linux-watchdog@vger.kernel.org>; Wed, 03 Feb 2016 09:49:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56B23883.7000501@codeaurora.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
	<1454519923-25230-6-git-send-email-fu.wei@linaro.org>
	<56B23883.7000501@codeaurora.org>
Date: Thu, 4 Feb 2016 01:49:02 +0800
Message-ID: <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
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

Hi Timur,

Thanks for your rapid feedback :-)

On 4 February 2016 at 01:27, Timur Tabi <timur@codeaurora.org> wrote:
> fu.wei@linaro.org wrote:
>>
>> +#ifdef CONFIG_ARM_SBSA_WATCHDOG_PANIC
>> +static bool panic_enabled = true;
>
>
> I think this should default to 'false', because IMHO, this seems like an odd

yes, It make sense to make it default to 'false'.

> feature.  I'm not crazy about the fact that there's a Kconfig option for it
> either, but I'm not going to NACK this patch.
>
> I personally would prefer to drop this patch, and just wait for full-blown
> pre-timeout support.  It feels like a debugging feature that doesn't really

sorry, are you saying : using pre-timeout instead of this half timeout?

But even we have pre-timeout support, pre-timeout  == timeout / 2, it
can not be configured without touch timeout.

if you want pre-timeout  != timeout / 2, we have to modify WCV in the
interrupt routine.
 (because of the explicit watchdog refresh  mechanism)

Could you let me know why we need pre-timeout  here ?? :-)

> belong upstream.  But like I said, it's just my opinion, and I won't
> complain if I'm outvoted.

 I think this debugging feature is the  purpose of the two-stage
watchdog, if I understand correctly



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
