Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34378 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161473AbbKEOf6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Nov 2015 09:35:58 -0500
Received: by obbza9 with SMTP id za9so67481921obb.1
        for <linux-watchdog@vger.kernel.org>; Thu, 05 Nov 2015 06:35:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <563B62F7.3050307@codeaurora.org>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
	<1445961999-9506-6-git-send-email-fu.wei@linaro.org>
	<CAOZdJXV8x8EMQEZhdFS+34iO+6P9S==k9bQjt=67iXt6K2oSCw@mail.gmail.com>
	<563AE588.1080009@roeck-us.net>
	<563B5DF9.6080102@codeaurora.org>
	<CADyBb7sD2Y2kGj-suOs1UeUwXPjH39mvX_Sobn0Y7WfsJ9hF=Q@mail.gmail.com>
	<563B62F7.3050307@codeaurora.org>
Date: Thu, 5 Nov 2015 22:35:57 +0800
Message-ID: <CADyBb7vDf+KRi8gUGEt+iu-GpqVQgVq7nKTVt7O=3x78KCi+RQ@mail.gmail.com>
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

On 5 November 2015 at 22:08, Timur Tabi <timur@codeaurora.org> wrote:
> Fu Wei wrote:
>>
>> SBSA 2.3 Page 23 :
>> Note: the watchdog offset register is 32 bits wide. This gives a
>> maximum watch period of around 10s at a system
>> counter frequency of 400MHz. If a larger watch period is required then
>> the compare value can be programmed
>> directly into the compare value register.
>>
>> 214s means your system counter is approximately at 20MHz which is in
>> the range of (10MHz ~ 400MHz)
>>
>> SBSA 2.3 Page 13 :
>> The System Counter (of the Generic Timer) shall run at a minimum
>> frequency of 10MHz and maximum of
>> 400MHz.
>
>
> Thanks, that explains a lot.
>
> If we expected customers to have a lower system counter frequency, then we
> wouldn't have to worry about the timeouts being too short.  It seems to me
> that the SBSA spec says that if you want a longer timeout, you have to lower
> the frequency.

Did you really read the "Note" above???????? OK, let me paste it again
and again:

SBSA 2.3 Page 23 :
If a larger watch period is required then the compare value can be
programmed directly into the compare value register.

> We shouldn't be complicating the driver because some
> customers might not follow the spec.

OK it this customer might not follow the spec, that watchdog is not a
SBSA watchdog,
So please don't use SBSA watchdog driver on that non-SBSA watchdog
device, Thanks a lot

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
