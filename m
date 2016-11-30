Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:51339
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755180AbcK3Mlm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 30 Nov 2016 07:41:42 -0500
Subject: Re: [PATCH] watchdog: meson: Remove unneeded platform MODULE_ALIAS
To: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
References: <1476906582-14241-1-git-send-email-javier@osg.samsung.com>
 <20161020222833.GA27421@roeck-us.net>
 <d7149198-b513-4022-5fbc-10067d420191@osg.samsung.com>
 <66487a0e-1d20-519f-6cbf-645f8bfd33da@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <ef0f36c3-a36b-b01d-f4ef-07f89f3320c3@osg.samsung.com>
Date: Wed, 30 Nov 2016 09:41:32 -0300
MIME-Version: 1.0
In-Reply-To: <66487a0e-1d20-519f-6cbf-645f8bfd33da@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Guenter,

On 11/30/2016 07:59 AM, Guenter Roeck wrote:
> On 11/29/2016 06:57 AM, Javier Martinez Canillas wrote:
>> Hello Wim,
>>
>> On 10/20/2016 07:28 PM, Guenter Roeck wrote:
>>> On Wed, Oct 19, 2016 at 04:49:42PM -0300, Javier Martinez Canillas wrote:
>>>> The Amlogic Meson is a DT-only platform, which means the devices are
>>>> registered via OF and not using the legacy platform devices support.
>>>>
>>>> So there's no need to have a MODULE_ALIAS("platform:meson-gxbb-wdt")
>>>> since the reported uevent MODALIAS to user-space will be the OF one.
>>>>
>>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>
>> Any comments about this patch? There are other two similar fixes for
>> watchdog drivers that were also reviewed by Guenter but never picked:
>>
>> https://lkml.org/lkml/2016/10/14/412
>> https://lkml.org/lkml/2016/10/14/413
>>
>> Best regards,
>>
> The patches are all in my watchdog-next branch, so Wim will hopefully
> pick them up for the next release.
>

Great, thanks a lot for the info.
 
> Guenter
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
