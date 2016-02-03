Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34319 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965689AbcBCShP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Feb 2016 13:37:15 -0500
Received: by mail-ob0-f176.google.com with SMTP id wb13so43518164obb.1
        for <linux-watchdog@vger.kernel.org>; Wed, 03 Feb 2016 10:37:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56B24642.8090105@codeaurora.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
	<1454519923-25230-6-git-send-email-fu.wei@linaro.org>
	<56B23883.7000501@codeaurora.org>
	<CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
	<56B23E99.1030604@codeaurora.org>
	<CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
	<56B2423B.1020109@codeaurora.org>
	<CADyBb7uULCn97ea19zH8dB4QX1QA8=AXL94d6gXgFxXM8haBNA@mail.gmail.com>
	<56B24642.8090105@codeaurora.org>
Date: Thu, 4 Feb 2016 02:37:14 +0800
Message-ID: <CADyBb7s_QeU=pYqN9G+5WMtx-L+=QC6uZR6N6ZWPOixnkHzPjw@mail.gmail.com>
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
	Leo Duran <leo.duran@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 4 February 2016 at 02:26, Timur Tabi <timur@codeaurora.org> wrote:
> Fu Wei wrote:
>>
>> Actually,
>> the SBSA watchdog driver should support only  half-timeout for panic
>> the user cannot configure the length of "panic time",  He can only
>> enable it, and it is automatically set to 1/2 timeout.
>>
>> we don't need pre-timeout here.
>>
>> Hope I understand you correctly:-)  sorry for your confusion
>>
>>> >
>>> >So when pre-timeout occurs, the interrupt handler calls panic() or
>>> > whatever
>>> >it's supposed to do.
>>
>> Actually,
>> So when 1/2 timeout occurs, the interrupt handler calls panic() or
>> whatever it's supposed to do.
>>
>
> I understand all that.  What I'm saying is that, in the future, when
> pre-timeout support is added to the watchdog layer, I think it makes sense
> to modify this driver to use pre-timeout support.

As you know I have made the pre-timeout support patch, If people like
it, i am happy to go on upstream it separately.

If we want to use pre-timeout here, user only can use get_pretimeout
and disable panic by setting pretimeout to 0
but user can not really set pretimeout, because "pre-timeout  ==
timeout / 2 (always)".
if user want to change pretimeout, he/she has to set_time instead.




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
