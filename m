Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34590 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbbIODQ3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Sep 2015 23:16:29 -0400
Received: by oiev17 with SMTP id v17so87749558oie.1
        for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2015 20:16:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55F207FD.2030007@redhat.com>
References: <=fu.wei@linaro.org>
	<1433217907-928-1-git-send-email-fu.wei@linaro.org>
	<1433217907-928-6-git-send-email-fu.wei@linaro.org>
	<556F4489.6030206@codeaurora.org>
	<20150603182503.GD6460@roeck-us.net>
	<556F4D29.1080001@codeaurora.org>
	<55F207FD.2030007@redhat.com>
Date: Tue, 15 Sep 2015 11:16:28 +0800
Message-ID: <CADyBb7uLiTg=FDe=HzXnKCWgO0y4DtJTOSBtgpm+5FbTH-6WSQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Jon Masters <jcm@redhat.com>
Cc: Timur Tabi <timur@codeaurora.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jon,

On 11 September 2015 at 06:45, Jon Masters <jcm@redhat.com> wrote:
> On 06/03/2015 02:53 PM, Timur Tabi wrote:
>> On 06/03/2015 01:25 PM, Guenter Roeck wrote:
>>> In general the idea here would be to use a crashdump kernel, which,
>>> when loaded, would reset the watchdog before it fires. This kernel
>>> would then write a core dump to a specified location.
>>
>> What is the mechanism for resetting the watchdog?  The only code that
>> knows about the hardware registers is this driver.  Does the crashdump
>> kernel call the watchdog stop function?
>>
>>> If arm64 doesn't support a crashdump kernel, it might still be possible
>>> to log the backtrace somewhere (eg in nvram using pstore if that is
>>> supported via acpi or efi).
>
> Just to go back and explicitly answer this, arm64 does have support for
> crashdump, using the standard kexec/kdump approach, exactly as on x86.
> There's still some more work to be done to get the ACPI case fully
> upstream (e.g. on X-Gene platforms such as the HP ProLiant Moonshot m400
> we need non-PSCI CPU parking protocol offlining when booting in
> UEFI/ACPI mode), but it's what we are doing in RHEL(SA) and the goal is
> to help clean up the remaining pieces upstream there.

Great thanks for your info.

I have tried kexec/kdump on a real aarch64 hardware, that works well.
Although it's still under development and upstreaming, the support is there.

After discussing with some kexec/kdump  developer, I think this driver
can cooperate with kexec/kdump.

>
> Jon.
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
