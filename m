Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33309 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965147AbcBCR50 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Feb 2016 12:57:26 -0500
Received: by mail-ob0-f174.google.com with SMTP id is5so40274208obc.0
        for <linux-watchdog@vger.kernel.org>; Wed, 03 Feb 2016 09:57:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56B23D61.2050001@codeaurora.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
	<1454519923-25230-5-git-send-email-fu.wei@linaro.org>
	<56B23D61.2050001@codeaurora.org>
Date: Thu, 4 Feb 2016 01:57:23 +0800
Message-ID: <CADyBb7tteV7VF9oxMaq5NprVdS2UBKobupxoyfSp+jQwp5wmQA@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] Watchdog: introduce ARM SBSA watchdog driver
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

On 4 February 2016 at 01:48, Timur Tabi <timur@codeaurora.org> wrote:
> fu.wei@linaro.org wrote:
>>
>> +static struct platform_driver sbsa_gwdt_driver = {
>> +       .driver = {
>> +               .name = "sbsa-gwdt",
>> +               .pm = &sbsa_gwdt_pm_ops,
>> +               .of_match_table = sbsa_gwdt_of_match,
>> +       },
>> +       .probe = sbsa_gwdt_probe,
>> +       .remove = sbsa_gwdt_remove,
>> +       .shutdown = sbsa_gwdt_shutdown,
>> +       .id_table = sbsa_gwdt_pdev_match,
>> +};
>
>
> I just noticed you dropped ACPI support.  Server platforms are supposed to
> use ACPI, so that seems like a critical omission to me.  You had a GTDT
> parser in an older version of this patch.  What happened to it?

I have posted  GTDT support separately : https://lkml.org/lkml/2016/2/1/660

devicetree driver and GTDT driver both export sbsa gwdt info to
"platform resource".

this driver get hardware info from platform resource.



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
