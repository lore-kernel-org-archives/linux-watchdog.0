Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34079 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbbH0Nv6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Aug 2015 09:51:58 -0400
Received: by obbfr1 with SMTP id fr1so18914674obb.1
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2015 06:51:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1508271539560.15006@nanos>
References: <=fu.wei@linaro.org>
	<1440435683-7343-1-git-send-email-fu.wei@linaro.org>
	<1440435683-7343-9-git-send-email-fu.wei@linaro.org>
	<alpine.DEB.2.11.1508241942450.3873@nanos>
	<CADyBb7sVGePKtU45_DBGd74fykAPVshmbnRQJDDOrrvoHTGcKQ@mail.gmail.com>
	<alpine.DEB.2.11.1508252113590.15006@nanos>
	<55DEFC54.4090904@linaro.org>
	<alpine.DEB.2.11.1508271405330.15006@nanos>
	<55DF025F.2050102@linaro.org>
	<55DF1257.9090303@linaro.org>
	<alpine.DEB.2.11.1508271539560.15006@nanos>
Date: Thu, 27 Aug 2015 21:51:57 +0800
Message-ID: <CADyBb7vKQq_T_P27hZQs+6-TJo2YD=QXjVseQ8dOvixwSHwL5A@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] clocksource: simplify ACPI code in arm_arch_timer.c
From: Fu Wei <fu.wei@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Hanjun Guo <hanjun.guo@linaro.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>, dyoung@redhat.com,
	panand@redhat.com, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Thomas, Hanjun

On 27 August 2015 at 21:40, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 27 Aug 2015, Hanjun Guo wrote:
>> > [1]: https://lkml.org/lkml/2015/7/29/236
>> >
>> > If that is ok with you, we will introduce similar DECLARE_ thing
>> > for clock declare.
>
> Yes.

Thanks

>
>> Or we can drop this patch from this patch set, and clean up this
>> patch when the ACPI_DECLARE() infrastructure is ready for upstream.
>
> Works either way. I just noticed that hard coded init thing and
> decided to rant about it :)

OK, good idea, this patch will be improve by DECLARE_ thing, then upstream.
drop this from this patchset.

Great thanks for your help


>
> Thanks,
>
>         tglx
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



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
