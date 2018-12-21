Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37533 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390930AbeLUXY2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 21 Dec 2018 18:24:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so3132484plr.4
        for <linux-watchdog@vger.kernel.org>; Fri, 21 Dec 2018 15:24:28 -0800 (PST)
Subject: Re: [v3] watchdog: mtx-1: Convert to use GPIO descriptor
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <20181211120412.27773-1-linus.walleij@linaro.org>
 <20181215163125.GA14086@roeck-us.net>
 <CACRpkdY5W-ZOX7X-KmVNcxVBJp1en4j=wrO8x0hGcDkwOOHQ2A@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e0da671e-a312-5ad4-c60a-05629762cce6@roeck-us.net>
Date: Fri, 21 Dec 2018 15:24:25 -0800
MIME-Version: 1.0
In-Reply-To: <CACRpkdY5W-ZOX7X-KmVNcxVBJp1en4j=wrO8x0hGcDkwOOHQ2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/21/18 2:22 AM, Linus Walleij wrote:
> On Sat, Dec 15, 2018 at 5:31 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Tue, Dec 11, 2018 at 01:04:12PM +0100, Linus Walleij wrote:
> 
>>> This converts the MTX-1 driver to grab a GPIO descriptor
>>> associated with the device instead of using a resource with
>>> a global GPIO number.
>>>
>>> The board using this driver appears to be out-of-tree
>>> (OpenWRT), but the users can be easily augmented by adding a
>>> machine descriptor table before registering the device.
>>>
>> Is that still accurate, given the discussion and mips specific changes ?
>>
>>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> We'll need an Acked-by: from a mips maintainer to land this.
> 
> Florian is a MIPS (subarch) maintainer, tell me if you want
> to resend this with the collected reviewed-by and also
> include the toplevel MIPS maintainers.
> 
Should be ok on that side then. What about my question above ?

Guenter
