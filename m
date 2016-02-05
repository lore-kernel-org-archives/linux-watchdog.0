Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36053 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbcBEJUb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Feb 2016 04:20:31 -0500
Received: by mail-ob0-f174.google.com with SMTP id ba1so84007096obb.3
        for <linux-watchdog@vger.kernel.org>; Fri, 05 Feb 2016 01:20:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56B37FA0.5000209@codeaurora.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
	<1454519923-25230-6-git-send-email-fu.wei@linaro.org>
	<CANLsYkyLBfSKFM6CCyPP+Eaua2B+n80wL2hnQVSvfUNMPd3OdQ@mail.gmail.com>
	<56B37FA0.5000209@codeaurora.org>
Date: Fri, 5 Feb 2016 17:20:29 +0800
Message-ID: <CADyBb7uUK-vTpm9gtxNqtbS6gxbpZdKNKspqzX8wGTNHbdH_HQ@mail.gmail.com>
Subject: Re: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
From: Fu Wei <fu.wei@linaro.org>
To: Timur Tabi <timur@codeaurora.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
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
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
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

On 5 February 2016 at 00:43, Timur Tabi <timur@codeaurora.org> wrote:
> Mathieu Poirier wrote:
>>>
>>> >+#ifdef CONFIG_ARM_SBSA_WATCHDOG_PANIC
>>> >+       irq = platform_get_irq(pdev, 0);
>>> >+       if (irq < 0) {
>>> >+               dev_err(dev, "unable to get ws0 interrupt.\n");
>>> >+               return irq;
>>> >+       }
>>> >+#endif
>>> >+
>>
>> Can't the driver revert to single stage mode if platform_get_irq()
>> fails?  That way the value of 'irq' can be tested throughout the
>> _probe() function and the #ifdefs removed.
>
>
> I like that idea.  The same can be done with the devm_request_irq() call.
> It should definitely still display a warning if the command-line option is
> set but no interrupt is available.

Yes, I agree with that too, brilliant idea, this will be in v11 patchset



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
