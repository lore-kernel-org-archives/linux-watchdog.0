Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34311 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032945AbbKEPAK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Nov 2015 10:00:10 -0500
Received: by oies6 with SMTP id s6so5934243oie.1
        for <linux-watchdog@vger.kernel.org>; Thu, 05 Nov 2015 07:00:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <563B6A4B.7090400@codeaurora.org>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
	<1445961999-9506-6-git-send-email-fu.wei@linaro.org>
	<CAOZdJXV8x8EMQEZhdFS+34iO+6P9S==k9bQjt=67iXt6K2oSCw@mail.gmail.com>
	<563AE588.1080009@roeck-us.net>
	<563B5DF9.6080102@codeaurora.org>
	<CADyBb7sD2Y2kGj-suOs1UeUwXPjH39mvX_Sobn0Y7WfsJ9hF=Q@mail.gmail.com>
	<563B62F7.3050307@codeaurora.org>
	<CADyBb7vDf+KRi8gUGEt+iu-GpqVQgVq7nKTVt7O=3x78KCi+RQ@mail.gmail.com>
	<563B6A4B.7090400@codeaurora.org>
Date: Thu, 5 Nov 2015 23:00:09 +0800
Message-ID: <CADyBb7t6ovfrz1b3ZZykKq22HkZi1W0PWg7-wXihEjM9ciTgGg@mail.gmail.com>
Subject: Re: [Linaro-acpi] [PATCH v8 5/5] Watchdog: introduce ARM SBSA
 watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>, Jon Masters <jcm@redhat.com>,
	Pratyush Anand <panand@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Wei Fu <tekkamanninja@gmail.com>,
	Rob Herring <robherring2@gmail.com>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Timur,

On 5 November 2015 at 22:40, Timur Tabi <timur@codeaurora.org> wrote:
> Fu Wei wrote:
>>
>> Did you really read the "Note" above???????? OK, let me paste it again
>> and again:
>>
>> SBSA 2.3 Page 23 :
>> If a larger watch period is required then the compare value can be
>> programmed directly into the compare value register.
>
>
> Well, okay.  Sorry, I should have read what you pasted more closely. But I

Thanks for reading it again.

> think that means during initialization, not during the WS0 timeout.

I really don't see SBSA say "during initialization, not during the WS0 timeout",
please point it out the page number and the line number in SBSA spec.
maybe I miss it?
Thanks for your help in advance.

>
> Anyway, I still don't like the fact that you're programming WCV in the

"you don't like" doesn't mean "it is wrong" or "we can't do this", so
I will keep this way unless we have better idea to extend second stage
timeout.

> interrupt handler, but I'm not going to make a big deal about it any more.

Deal, Thanks a lot.

>
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the
> Code Aurora Forum, hosted by The Linux Foundation.



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
