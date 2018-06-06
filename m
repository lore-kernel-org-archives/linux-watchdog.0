Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44635 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752854AbeFFQTX (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 6 Jun 2018 12:19:23 -0400
Subject: Re: [PATCH v4 1/6] Documentation: DT: Consolidate SP805 binding docs
To: Rob Herring <robh@kernel.org>, Ray Jui <ray.jui@broadcom.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
 <1527530497-10392-2-git-send-email-ray.jui@broadcom.com>
 <20180605194124.GA26885@rob-hp-laptop>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e91c75f3-f7a4-6f51-9911-7e22d5d05084@roeck-us.net>
Date: Wed, 6 Jun 2018 09:19:19 -0700
MIME-Version: 1.0
In-Reply-To: <20180605194124.GA26885@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/05/2018 12:41 PM, Rob Herring wrote:
> On Mon, May 28, 2018 at 11:01:32AM -0700, Ray Jui wrote:
>> Consolidate two SP805 binding documents "arm,sp805.txt" and
>> "sp805-wdt.txt" into "arm,sp805.txt" that matches the naming of the
>> desired compatible string to be used
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> ---
>>   .../devicetree/bindings/watchdog/arm,sp805.txt     | 27 ++++++++++++++-----
>>   .../devicetree/bindings/watchdog/sp805-wdt.txt     | 31 ----------------------
>>   2 files changed, 20 insertions(+), 38 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
> 
> Would be good to get a ACK from FSL/NXP person on this. It looks to me
> like the driver fetches the wrong clock as it gets the first one and the
> driver really wants 'wdog_clk'. In any case, their dts files should be
> updated.
>

This is really confusing, since he deleted file lists apb_pclk first.
Does the watchdog driver need apb_pclk or wdog_clk ? That isn't clear to me.
arch/arm64/boot/dts/hisilicon/hi3660.dtsi only provides apb_pclk, or at least
it says so. The fsl dts files all have apb_pclk first.

Either case, why are two clocks asked for in the first place ? Are there
situations where the second clock is actually used/useful ?

Guenter

> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

