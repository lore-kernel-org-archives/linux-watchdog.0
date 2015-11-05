Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <563B9907.7020608@codeaurora.org>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
	<1445961999-9506-6-git-send-email-fu.wei@linaro.org>
	<CAOZdJXV8x8EMQEZhdFS+34iO+6P9S==k9bQjt=67iXt6K2oSCw@mail.gmail.com>
	<563AE588.1080009@roeck-us.net>
	<563B5DF9.6080102@codeaurora.org>
	<CADyBb7sD2Y2kGj-suOs1UeUwXPjH39mvX_Sobn0Y7WfsJ9hF=Q@mail.gmail.com>
	<563B62F7.3050307@codeaurora.org>
	<CADyBb7vDf+KRi8gUGEt+iu-GpqVQgVq7nKTVt7O=3x78KCi+RQ@mail.gmail.com>
	<563B6A4B.7090400@codeaurora.org>
	<CADyBb7t6ovfrz1b3ZZykKq22HkZi1W0PWg7-wXihEjM9ciTgGg@mail.gmail.com>
	<563B869F.2010004@roeck-us.net>
	<563B9907.7020608@codeaurora.org>
Date: Fri, 6 Nov 2015 02:04:44 +0800
Message-ID: <CADyBb7tkELuJgmo81ypZf2dzgVqxBYTyKLV-xJ1QZbxK7pmuLQ@mail.gmail.com>
Subject: Re: [Linaro-acpi] [PATCH v8 5/5] Watchdog: introduce ARM SBSA
 watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
	linux-doc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Jon Masters <jcm@redhat.com>,
	Pratyush Anand <panand@redhat.com>, Will Deacon <will.deacon@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>,
	Wei Fu <tekkamanninja@gmail.com>, Rob Herring <robherring2@gmail.com>,
	Vipul Gandhi <vgandhi@codeaurora.org>, Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

Hi Timur

On 6 November 2015 at 01:59, Timur Tabi <timur@codeaurora.org> wrote:
> On 11/05/2015 10:41 AM, Guenter Roeck wrote:
>>
>>
>> Ultimately, you'll have to decide if you want a simple driver accepted, or
>> a complex driver hanging in the review queue forever.
>
>
> Please note that I did post such a driver back in May:
>
>         http://www.spinics.net/lists/linux-watchdog/msg06567.html
>
> Officially I withdrew it in favor of Fu's, but the decision which driver to
> pick up is not mine to make.  I can resubmit driver if you'd like.

I totally  can not  agree with "make WS1 as backup",
and that not a SBSA watchdog dirver, because that just have one stage

And the short timeout is useless for kexec/kdump in real practice.

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
