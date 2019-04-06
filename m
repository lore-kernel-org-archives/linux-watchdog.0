Return-Path: <SRS0=HvdG=SI=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E446C10F06
	for <linux-watchdog@archiver.kernel.org>; Sat,  6 Apr 2019 15:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C80B213A2
	for <linux-watchdog@archiver.kernel.org>; Sat,  6 Apr 2019 15:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOIy4rY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfDFPqM (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 6 Apr 2019 11:46:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34995 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfDFPqM (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 6 Apr 2019 11:46:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so4718464plp.2
        for <linux-watchdog@vger.kernel.org>; Sat, 06 Apr 2019 08:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tIWqmq9LUwllUdWISzHpaYdwmF3IpXMBVDEt0zexj7c=;
        b=eOIy4rY5p63jGwpKUXsKGvY+HdugNMhPR8OCwhZfeKhzhSZDoWQh9PTITd8yn7JWYc
         t1a35ei6dmdnSmra1PFW5gOvTPgMTCXRMiglkE5ngokHiqOZe0GuzGZ9+dIG93OmmQPF
         +JAgP0dkLA8Iz7WXePmGYv2rU4CpmJrPKeJT8CK6hbZQIl/VwTXVrBKKu9HMic65ApYr
         vCoC6utF7sHIGel/XA8I3psPWGPY0g+C8CLy8AEy/rOjEea1Nzio66wwEBk1cDC7yFwt
         uOLY4ZQ1R9Z5V5CIDqUBqTHbOZ/8ZK76yreVHM5SM1Qye/eDe97CjGViAT2NinIX9y/y
         AaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tIWqmq9LUwllUdWISzHpaYdwmF3IpXMBVDEt0zexj7c=;
        b=GpzY3XneL+JVxgMS3VDCVSUz1dPXVt+0GNsiHh9k7Aby7y93QH8iIiWl/flVhqCTGH
         1590LVdv4syh9c7bLJSUvxJ59HUttAoF2FAoHYdI4dvZ0S0ZyEeCTP/PHp5AHm1jiqDI
         8zJiBnS0XbUIjEP7rbeDV3OCkPXQokcn2ak/lr9ngdEThwL6CidWNFkk9V/AgxBpEU8H
         gsygExW6yA+DaPrfViQ/dnNIV2bD8CfXd2R/2B51JOyaOu1m00YkwhxVmGdSqIkjRjUj
         eDdYoE0fmsoYc7gvG1+PzI/DsuR8Xbw8dwh248KiRIVcDdmBjQbKm3Kmxy+dN9VkZ1EN
         xUOw==
X-Gm-Message-State: APjAAAXw7HpmsdGpAQ3E251KACbikWSj5MizPsK3cZ3X7SU4hDa/40XY
        5oFsrteuxeirsCjHcb0br/InU4pn
X-Google-Smtp-Source: APXvYqwVLbPFDUEEoRdUDHxIiuE6pd2PCoJPywQ7zKrmiIUPUdVal9eMTNk0k+6KdQx9fl89SUWhgg==
X-Received: by 2002:a17:902:e683:: with SMTP id cn3mr19515923plb.115.1554565570927;
        Sat, 06 Apr 2019 08:46:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u17sm34967473pfn.19.2019.04.06.08.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 08:46:09 -0700 (PDT)
Subject: Re: [PATCH] Fix set_timeout for big timeout values
To:     Georg Hofmann <georg@hofmannsweb.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org
References: <1274287303.1911.1554545863744.JavaMail.zimbra@hofmannsweb.com>
 <2a7af85e-486d-26dc-17bf-9f6e2c3ddf8a@roeck-us.net>
 <2141975119.2003.1554560224141.JavaMail.zimbra@hofmannsweb.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6e80717e-bbd9-1089-59ce-cbe24cf10218@roeck-us.net>
Date:   Sat, 6 Apr 2019 08:46:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2141975119.2003.1554560224141.JavaMail.zimbra@hofmannsweb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 4/6/19 7:17 AM, Georg Hofmann wrote:
> ----- Original Message -----
>> From: "Guenter Roeck" <linux@roeck-us.net>
>> To: "Georg Hofmann" <georg@hofmannsweb.com>, wim@linux-watchdog.org
>> Cc: linux-watchdog@vger.kernel.org
>> Sent: Saturday, April 6, 2019 3:25:44 PM
>> Subject: Re: [PATCH] Fix set_timeout for big timeout values
> 
>> On 4/6/19 3:17 AM, Georg Hofmann wrote:
>>> This patch implements the documented behavior: if max_hw_heartbeat_ms is
>>> implemented, the minimum of the set_timeout argument and
>>> max_hw_heartbeat_ms should be used.
>>> Previously only the first 7 bits were used and the input argument was
>>> returned.
>>>
>>> Signed-off-by: Georg Hofmann <georg@hofmannsweb.com>
>>> ---
>>>    drivers/watchdog/imx2_wdt.c | 6 ++++--
>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
>>> index 2b52514..3c13adc 100644
>>> --- a/drivers/watchdog/imx2_wdt.c
>>> +++ b/drivers/watchdog/imx2_wdt.c
>>> @@ -178,9 +178,11 @@ static void __imx2_wdt_set_timeout(struct watchdog_device
>>> *wdog,
>>>    static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
>>>    				unsigned int new_timeout)
>>>    {
>>> -	__imx2_wdt_set_timeout(wdog, new_timeout);
>>> +	unsigned int actual;
>>>    
>>> -	wdog->timeout = new_timeout;
>>> +	actual = min(new_timeout, wdog->max_hw_heartbeat_ms * 1000);
>>> +	__imx2_wdt_set_timeout(wdog, actual);
>>> +	wdog->timeout = actual;
>>
>> That defeats the purpose of having an internal maximum. wdog->timeout
>> should still be set to the requested value.
>>
>> Guenter
> 
> Hi,
> 
> I don't understand, the internal maximum is max_hw_heartbeat_ms.
> I have used the same code as other watchdog drivers
> (e.g. aspeed_wdt.c, loongson1_wdt.c, ...).
> 
> I have submitted this patch because I was writing a userspace
>   program and I expected a different behavior on the ioctl.
> The watchdog documentation says (Documentation/watchdog/watchdog-api.txt):
> Setting and getting the timeout:
> 
> For some drivers it is possible to modify the watchdog timeout on the
> fly with the SETTIMEOUT ioctl, those drivers have the WDIOF_SETTIMEOUT
> flag set in their option field.  The argument is an integer
> representing the timeout in seconds.  The driver returns the real
> timeout used in the same variable, and this timeout might differ from
> the requested one due to limitation of the hardware.
> 
>      int timeout = 45;
>      ioctl(fd, WDIOC_SETTIMEOUT, &timeout);
>      printf("The timeout was set to %d seconds\n", timeout);
> 
> This example might actually print "The timeout was set to 60 seconds"
> if the device has a granularity of minutes for its timeout.
> 
> As the watchdog core driver reads the timeout just after write, I have
> to set the applied value to timeout.
> 
> Initially I thought I should get a error message if the timeout can't
> be applied, but the documentation describes another behavior.
> 

The whole point of max_hw_heartbeat_ms is to be able to specify a larger
timeout than the maximum supported by the hardware. In extreme cases,
max_hw_heartbeat_ms could be as low as 1 second (or less). Limiting
wdog->timeout to that value is identical to not having max_hw_heartbeat_ms
in the first place, and thus quite pointless.

aspeed_wdt.c does _not_ set wdd->timeout to the 'actual' value.
loongson1_wdt.c doesn't do it either. If any other driver does it,
it is wrong.

Your patch is almost correct, except it should keep
"wdog->timeout = new_timeout;".

Guenter
