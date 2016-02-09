Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33335 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbcBIRr3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Feb 2016 12:47:29 -0500
Received: by mail-oi0-f44.google.com with SMTP id w5so19683202oie.0
        for <linux-watchdog@vger.kernel.org>; Tue, 09 Feb 2016 09:47:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56BA244E.1020402@codeaurora.org>
References: <1455037240-16192-1-git-send-email-fu.wei@linaro.org>
	<1455037240-16192-5-git-send-email-fu.wei@linaro.org>
	<56BA244E.1020402@codeaurora.org>
Date: Wed, 10 Feb 2016 01:47:28 +0800
Message-ID: <CADyBb7sqKiFfrwkKUYOAXY3JCZzEM2jtR3Xac_ihafxf_McsLg@mail.gmail.com>
Subject: Re: [PATCH v11 4/4] Watchdog: introduce ARM SBSA watchdog driver
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

Hi Timur,

On 10 February 2016 at 01:39, Timur Tabi <timur@codeaurora.org> wrote:
> fu.wei@linaro.org wrote:
>
>> +               if (!action)
>> +                       dev_warn(dev, "fall back to signle stage
>> mode.\n");
>
>
> "falling back to single stage mode"

Thanks for your correction.  :-)
Will fixed it

>
> Acked-by: Timur Tabi <timur@codeaurora.org>
>

Thanks, will add this

> The whole "calculate the timeouts different if 'action' is enabled" seems
> clunky to me, but I can't think of a better way to handle it.
>
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum, a Linux Foundation collaborative project.



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
