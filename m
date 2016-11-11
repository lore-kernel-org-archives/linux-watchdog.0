Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35282 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756602AbcKKN6W (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 11 Nov 2016 08:58:22 -0500
Received: by mail-pg0-f46.google.com with SMTP id p66so13349460pga.2
        for <linux-watchdog@vger.kernel.org>; Fri, 11 Nov 2016 05:58:22 -0800 (PST)
Message-ID: <5825CE69.1000501@linaro.org>
Date: Fri, 11 Nov 2016 21:58:01 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>, fu.wei@linaro.org
CC: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, marc.zyngier@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        timur@codeaurora.org, graeme.gregory@linaro.org,
        al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        tn@semihalf.com, christoffer.dall@linaro.org, julien.grall@arm.com
Subject: Re: [PATCH v14 4/9] acpi/arm64: Add GTDT table parse driver
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org> <1475086637-1914-5-git-send-email-fu.wei@linaro.org> <20161020163719.GC27598@leverpostej> <5825CBB5.8090104@linaro.org>
In-Reply-To: <5825CBB5.8090104@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/11/2016 09:46 PM, Hanjun Guo wrote:
> Hi Mark,
>
> Sorry for the late reply.
>
> On 10/21/2016 12:37 AM, Mark Rutland wrote:
>> Hi,
>>
>> As a heads-up, on v4.9-rc1 I see conflicts at least against
>> arch/arm64/Kconfig. Luckily git am -3 seems to be able to fix that up
>> automatically, but this will need to be rebased before the next posting
>> and/or merging.
>>
>> On Thu, Sep 29, 2016 at 02:17:12AM +0800, fu.wei@linaro.org wrote:
>>> +static int __init map_gt_gsi(u32 interrupt, u32 flags)
>>> +{
>>> +    int trigger, polarity;
>>> +
>>> +    if (!interrupt)
>>> +        return 0;
>>
>> Urgh.
>>
>> Only the secure interrupt (which we do not need) is optional in this
>> manner, and (hilariously), zero appears to also be a valid GSIV, per
>> figure 5-24 in the ACPI 6.1 spec.
>>
>> So, I think that:
>>
>> (a) we should not bother parsing the secure interrupt
>> (b) we should drop the check above
>> (c) we should report the spec issue to the ASWG
>
> Sorry, I willing to do that, but I need to figure out the issue here.
> What kind of issue in detail? do you mean that zero should not be valid
> for arch timer interrupts?

OK, I think you are referring to "we don't need the secure interrupt",
correct me if I'm wrong (still in jet lag...).

Thanks
Hanjun
