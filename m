Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35544 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757436AbcB1OB4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 28 Feb 2016 09:01:56 -0500
Received: by mail-oi0-f49.google.com with SMTP id x143so20273120oix.2
        for <linux-watchdog@vger.kernel.org>; Sun, 28 Feb 2016 06:01:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56D0A72B.8020100@codeaurora.org>
References: <1455611785-2407-1-git-send-email-fu.wei@linaro.org>
	<1455611785-2407-5-git-send-email-fu.wei@linaro.org>
	<56D0A72B.8020100@codeaurora.org>
Date: Sun, 28 Feb 2016 22:01:55 +0800
Message-ID: <CADyBb7s9eX6mn6vkb3tn=m=TfD83d4R+U5=iLPADa+XHBE3kDw@mail.gmail.com>
Subject: Re: [PATCH v12 4/4] Watchdog: introduce ARM SBSA watchdog driver
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
	Richard Ruigrok <rruigrok@codeaurora.org>,
	"Abdulhamid, Harb" <harba@codeaurora.org>,
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

On 27 February 2016 at 03:27, Timur Tabi <timur@codeaurora.org> wrote:
> fu.wei@linaro.org wrote:
>>
>> +       if (action) {
>> +               irq = platform_get_irq(pdev, 0);
>> +               if (irq < 0) {
>> +                       action = 0;
>> +                       dev_warn(dev, "unable to get ws0 interrupt.\n");
>> +               } else {
>> +                       if (devm_request_irq(dev, irq,
>> sbsa_gwdt_interrupt, 0,
>> +                                            pdev->name, gwdt)) {
>> +                               action = 0;
>> +                               dev_warn(dev, "unable to request IRQ
>> %d.\n",
>> +                                        irq);
>> +                       }
>> +               }
>> +               if (!action)
>> +                       dev_warn(dev, "falling back to signle stage
>> mode.\n");
>> +       }
>> +
>> +       /*
>> +        * Get the frequency of system counter from the cp15 interface of
>> ARM
>> +        * Generic timer. We don't need to check it, because if it returns
>> "0",
>> +        * system would panic in very early stage.
>> +        */
>> +       gwdt->clk = arch_timer_get_cntfrq();
>> +       gwdt->refresh_base = rf_base;
>> +       gwdt->control_base = cf_base;
>
>
> I think you need to ping the watchdog before enabling the interrupt, in case
> there is a pending interrupt.  This just happened to me in testing, so I
> recommend this:
>
>>         /*
>>          * Get the frequency of system counter from the cp15 interface of
>> ARM
>>          * Generic timer. We don't need to check it, because if it returns
>> "0",
>>          * system would panic in very early stage.
>>          */
>>         gwdt->clk = arch_timer_get_cntfrq();
>>         gwdt->refresh_base = rf_base;
>>         gwdt->control_base = cf_base;
>>
>>         if (action) {
>>                 irq = platform_get_irq(pdev, 0);
>>                 if (irq < 0) {
>>                         action = 0;
>>                         dev_warn(dev, "unable to get ws0 interrupt.\n");
>>                 } else {
>>                         sbsa_gwdt_keepalive(&gwdt->wdd);
>>                         if (devm_request_irq(dev, irq,
>> sbsa_gwdt_interrupt, 0,
>>                                              pdev->name, gwdt)) {
>>                                 action = 0;
>>                                 dev_warn(dev, "unable to request IRQ
>> %d.\n",
>>                                          irq);
>>                         }
>>                 }
>>                 if (!action)
>>                         dev_warn(dev, "falling back to single stage
>> mode.\n");
>>         }
>
>
> In fact, I think you need to move the "if (action) {" block near the end of
> sbsa_gwdt_probe().  We don't want to enable the interrupt until the watchdog
> is fully initialized.
>

Good point! Thanks for your testing :-)

Will post v14 for this change.

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
