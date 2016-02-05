Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35437 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbcBEIw4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Feb 2016 03:52:56 -0500
Received: by mail-ob0-f176.google.com with SMTP id xk3so83253163obc.2
        for <linux-watchdog@vger.kernel.org>; Fri, 05 Feb 2016 00:52:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56B38079.10607@roeck-us.net>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
	<1454519923-25230-5-git-send-email-fu.wei@linaro.org>
	<20160204163101.GH17257@arm.com>
	<56B37E52.300@codeaurora.org>
	<56B38079.10607@roeck-us.net>
Date: Fri, 5 Feb 2016 16:52:55 +0800
Message-ID: <CADyBb7u1rN9f8A+eeC4-BgLyjnhYbgyQfepRDy0OmMmMWxD6sQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Timur Tabi <timur@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	=?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
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

Hi

On 5 February 2016 at 00:46, Guenter Roeck <linux@roeck-us.net> wrote:
> On 02/04/2016 08:37 AM, Timur Tabi wrote:
>>
>> Will Deacon wrote:
>>>>
>>>> +static int sbsa_gwdt_keepalive(struct watchdog_device *wdd)
>>>> >+{
>>>> >+    struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>>>> >+
>>>> >+    /*
>>>> >+    * Writing WRR for an explicit watchdog refresh.
>>>> >+    * You can write anyting(like 0xc0ffee).
>>>> >+    */
>>>> >+    writel(0xc0ffee, gwdt->refresh_base + SBSA_GWDT_WRR);
>>>> >+
>>>> >+    return 0;
>>>> >+}
>>>
>>> You might get in trouble for that. 0xd09f00d is probably less poisonous.
>>>
>>> http://www.petpoisonhelpline.com/poison/caffeine/
>>
>>
>> Any reason why we can't just keep it simple and write 0?
>
>
> +1

yes, we can, just "0" would be fine, will do.

Thanks :-)

>
> Guenter
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
