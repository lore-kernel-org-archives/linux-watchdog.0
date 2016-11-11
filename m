Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:53563
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934770AbcKKVEf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 11 Nov 2016 16:04:35 -0500
Subject: Re: [PATCH 1/2] watchdog: bcm7038_wdt: fix module autoload
To: Guenter Roeck <linux@roeck-us.net>
References: <1476458631-29685-1-git-send-email-javier@osg.samsung.com>
 <20161014165548.GA21425@roeck-us.net>
 <6cd2fbb2-02b3-96b7-625e-e5701595b105@osg.samsung.com>
 <20161111194708.GA30151@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@iguana.be>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <26cfc6a9-8589-a64d-58b6-010c595eabdb@osg.samsung.com>
Date: Fri, 11 Nov 2016 18:02:03 -0300
MIME-Version: 1.0
In-Reply-To: <20161111194708.GA30151@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Guenter,

On 11/11/2016 04:47 PM, Guenter Roeck wrote:
> Hi Javier,
> 
> On Fri, Nov 11, 2016 at 04:43:37PM -0300, Javier Martinez Canillas wrote:
>> Hello Guenter,
>>
>> On 10/14/2016 01:55 PM, Guenter Roeck wrote:
>>> On Fri, Oct 14, 2016 at 12:23:50PM -0300, Javier Martinez Canillas wrote:
>>>> If the driver is built as a module, autoload won't work because the module
>>>> alias information is not filled. So user-space can't match the registered
>>>> device with the corresponding module.
>>>>
>>>> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
>>>>
>>>> Before this patch:
>>>>
>>>> $ modinfo drivers/watchdog/bcm7038_wdt.ko | grep alias
>>>> $
>>>>
>>>> After this patch:
>>>>
>>>> $ modinfo drivers/watchdog/bcm7038_wdt.ko | grep alias
>>>> alias:          of:N*T*Cbrcm,bcm7038-wdtC*
>>>> alias:          of:N*T*Cbrcm,bcm7038-wdt
>>>>
>>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>
>> Are you going to pick this (and patch 2/2)?
>>
>> I'm asking because you provided your r-b tag but the patch
>> was never merged, so I wonder who should I ping about it.
>>
> Wim would be the one to pick it.
> 
> Maybe it got lost.  I hope I'll find some time during the weekend
> to update my tracking branch.
> 

Ok, thanks a lot for the info.

> Guenter
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
