Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35909 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965846AbbKEODi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Nov 2015 09:03:38 -0500
Received: by oiww189 with SMTP id w189so23520965oiw.3
        for <linux-watchdog@vger.kernel.org>; Thu, 05 Nov 2015 06:03:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <563B5DF9.6080102@codeaurora.org>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
	<1445961999-9506-6-git-send-email-fu.wei@linaro.org>
	<CAOZdJXV8x8EMQEZhdFS+34iO+6P9S==k9bQjt=67iXt6K2oSCw@mail.gmail.com>
	<563AE588.1080009@roeck-us.net>
	<563B5DF9.6080102@codeaurora.org>
Date: Thu, 5 Nov 2015 22:03:37 +0800
Message-ID: <CADyBb7sD2Y2kGj-suOs1UeUwXPjH39mvX_Sobn0Y7WfsJ9hF=Q@mail.gmail.com>
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

Hi Timur

On 5 November 2015 at 21:47, Timur Tabi <timur@codeaurora.org> wrote:
> Guenter Roeck wrote:
>>
>> I would feel much more comfortable if the driver would just use the
>> standard
>> watchdog timeout and live with (worst case) 20 seconds timeout for now.
>
>
> Actually, I'm wondering where the 20 seconds comes from.  When I load my
> driver on our hardware, it calculates a maximum timeout of 214 seconds, and
> that's just to WS0.

SBSA 2.3 Page 23 :
Note: the watchdog offset register is 32 bits wide. This gives a
maximum watch period of around 10s at a system
counter frequency of 400MHz. If a larger watch period is required then
the compare value can be programmed
directly into the compare value register.

214s means your system counter is approximately at 20MHz which is in
the range of (10MHz ~ 400MHz)

SBSA 2.3 Page 13 :
The System Counter (of the Generic Timer) shall run at a minimum
frequency of 10MHz and maximum of
400MHz.

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
