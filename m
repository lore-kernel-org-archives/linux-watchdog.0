Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33329 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967683AbeF2DAT (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 28 Jun 2018 23:00:19 -0400
Subject: Re: [PATCH v4 1/6] Documentation: DT: Consolidate SP805 binding docs
To: Ray Jui <ray.jui@broadcom.com>
Cc: Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <1527530497-10392-2-git-send-email-ray.jui@broadcom.com>
 <20180605194124.GA26885@rob-hp-laptop>
 <e91c75f3-f7a4-6f51-9911-7e22d5d05084@roeck-us.net>
 <CABGGisxEvWDy16SKE2RG-vhUHBZHSCCHyfwJsPY16B1fQS-=cA@mail.gmail.com>
 <09c870cd-0a44-6634-58d8-f57f9fcd0cb5@broadcom.com>
 <46ca340f-4347-94ca-6463-d38bece820e2@broadcom.com>
 <20180627183327.GD16753@roeck-us.net>
 <a18733e2-be06-4ea9-dbfb-1d4f756a97e7@broadcom.com>
 <20180627184234.GA19538@roeck-us.net>
 <8483f675-0c7d-4b0f-25fd-a5eff4bc7937@broadcom.com>
 <20180627185529.GB19743@roeck-us.net>
 <42b856bf-2dc1-f69b-44e1-f5a04715f673@broadcom.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <08e99a9e-1d87-f8c3-f566-73ef8cbf1111@roeck-us.net>
Date: Thu, 28 Jun 2018 20:00:15 -0700
MIME-Version: 1.0
In-Reply-To: <42b856bf-2dc1-f69b-44e1-f5a04715f673@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/28/2018 04:50 PM, Ray Jui wrote:
> Hi Guenter/Florian,
> 
> On 6/27/2018 11:55 AM, Guenter Roeck wrote:
>> On Wed, Jun 27, 2018 at 11:47:21AM -0700, Ray Jui wrote:
>>>
>>>
>>> On 6/27/2018 11:42 AM, Guenter Roeck wrote:
>>>> On Wed, Jun 27, 2018 at 11:38:48AM -0700, Ray Jui wrote:
>>>>>
>>>>>
>>>>> On 6/27/2018 11:33 AM, Guenter Roeck wrote:
>>>>>> On Wed, Jun 20, 2018 at 10:39:16AM -0700, Ray Jui wrote:
>>>>>>> Hi Guenter/Rob,
>>>>>>>
>>>>>>> Kindly let me know how you want to proceed with this?
>>>>>>>
>>>>>>
>>>>>> If I recall correctly, the patch series does not add a new problem
>>>>>> but merely exposes one. Is my recollection correct ? If so, maybe
>>>>>> we should just add a note somewhere indicating what might be wrong
>>>>>> and otherwise apply the series.
>>>>>>
>>>>>> Does this make sense ?
>>>>>
>>>>> Yes this makes a lot of sense to me. This patch series exposes potential
>>>>> problems in some SoCs that they might not be feeding the correct clock into
>>>>> WDT, at least based on clock names from their DT entries.
>>>>>
>>>>> This patch series does not change/affect how SP805 works on those systems.
>>>>>
>>>>> Where should the note be added?
>>>>>
>>>>
>>>> I would suggest to add a note into the driver where the clock is used,
>>>> with the details discussed here.
>>>
>>> I assume you meant adding the notes to the SP805 driver where the clock is
>>> used.
>>>
>>> If so, I think that makes sense. That notes deserves its own patch because
>>> it really has nothing to do with any of the change in this patch series.
>>>
>>> Do you want me to 1) embed that patch into this patch series and send out
>>> v5; or 2) leave the patch series as it is and send out a separate patch to
>>> add the notes to the driver?
>>>
>> 2) is fine. I don't have the series here right now; if I recall correctly
>> all patches in the series are all marked as Reviewed-by: and/or Acked-by:.
>> If so, I'll apply them to my tree tonight, or at least the ones that will
>> go in through the watchdog tree.
>>
>> Guenter
>>
> 
> Guenter, please let us know once you take the first 4 patches.
> 

Patches are in my tree. Wim, it would be great if you can pick up the tree
so it shows up in -next.

Thanks,
Guenter

> Florian, could you please help with the last 2, once Guenter confirmed the first 4 are merged.
> 
> Thanks!
> 
> Ray
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

