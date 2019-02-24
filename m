Return-Path: <SRS0=aOtl=Q7=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A38C43381
	for <linux-watchdog@archiver.kernel.org>; Sun, 24 Feb 2019 16:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AD02063F
	for <linux-watchdog@archiver.kernel.org>; Sun, 24 Feb 2019 16:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBnYvsQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfBXQjV (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 24 Feb 2019 11:39:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40743 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbfBXQjU (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 24 Feb 2019 11:39:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id h1so3319119pfo.7;
        Sun, 24 Feb 2019 08:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0gTZ38hJ1HZv2DOrqwp7FBtlpY1Vt6N7SuJJOCX1prk=;
        b=jBnYvsQPZPcuXSrA008hPZKS9HYs2DVRXH9LbQpIw8J1wOcluzyZXQQ/sTg9p1JOYD
         WYJJZ9elTX41YZd93j8Z3wEhlsAJ9mtA2LKTV6+3OpcPlN5p7dzubRXwMPFpg9RpV093
         hgRVZrfBZ+1BSXu9eps5NlsmhrviA6x0tJuAqoGUcIIpBR/DEpJGfICkJykbrRXhSk4N
         bya54c0Lorew0SlozVi1BUD3hv/1kLma20F4ZCITfwDx3QfUw1bW9aJ/w38MegO/fRzA
         til6K+9vFRR/cazYFGzB+ozbpdsfvHJZDYB0txza6wnbjnr6H7e5w+s+ehbyl/I4axpg
         YDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0gTZ38hJ1HZv2DOrqwp7FBtlpY1Vt6N7SuJJOCX1prk=;
        b=PkYEbXF39p+g5zV3ZZadJ6eTu/HppjVn3spcRPAtV2j3BsJwEf9E9xTREcYKAECQWZ
         KH/4rOne+6SazKg+ZpYDIaqRQKVRkow01B6LbimO3tGVYK3Jfo183jeUwVlDXpNGtorZ
         dnYo7RghMt9IxIAim6QVcfctQWfRM78alpSIv/95HyyyOjn/OQpfauzsTRec6NC6tZEX
         8G5PGDXeMDHL/+7MvFxMc/l4wkpbPTYePQK7y3k7/XgMD8rdl7iuw48lOnWzcMyfZjhg
         2QYFapJn+Oa7VmJDR3RPVNdLe9/4dGQ28XIJbiaCVvDQs3uSkC3b+nYb9qZvf2DM2ewV
         8mVw==
X-Gm-Message-State: AHQUAuab5U69RaaiOuC5/UutJiOCZ0IVNCcWWglO7oMd/JAik7PTheaf
        aR7VwzPqL0lw2rhapXXn3ejJdoQJ
X-Google-Smtp-Source: AHgI3IbXlijkcgi8Mj2zF+wG1NL4GMi/Ahnp3gMiyPxl1Knea8Te/sDFrM0x+xybJXc3umsMV2vxOw==
X-Received: by 2002:a63:fc62:: with SMTP id r34mr14325012pgk.154.1551026359449;
        Sun, 24 Feb 2019 08:39:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o6sm16399400pgo.27.2019.02.24.08.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 08:39:18 -0800 (PST)
Subject: Re: [PATCH v4 2/3] watchdog: mlx-wdt: introduce a watchdog driver for
 Mellanox systems.
To:     Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Cc:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <20190220093424.5374-1-michaelsh@mellanox.com>
 <20190220093424.5374-3-michaelsh@mellanox.com>
 <a93993bf-cf72-83c0-0d44-d8f46230482c@roeck-us.net>
 <AM6PR05MB522419E0EF2BD6098A00FB8EA2790@AM6PR05MB5224.eurprd05.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f6038e0f-107d-f04f-af5c-e7fd822f8436@roeck-us.net>
Date:   Sun, 24 Feb 2019 08:39:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <AM6PR05MB522419E0EF2BD6098A00FB8EA2790@AM6PR05MB5224.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 2/24/19 3:36 AM, Vadim Pasternak wrote:
> 
> 
>> -----Original Message-----
>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
>> Sent: Saturday, February 23, 2019 7:13 PM
>> To: Michael Shych <michaelsh@mellanox.com>; wim@linux-watchdog.org;
>> andy@infradead.org; dvhart@infradead.org
>> Cc: linux-watchdog@vger.kernel.org; platform-driver-x86@vger.kernel.org;
>> Vadim Pasternak <vadimp@mellanox.com>
>> Subject: Re: [PATCH v4 2/3] watchdog: mlx-wdt: introduce a watchdog driver for
>> Mellanox systems.
>>
>> On 2/20/19 1:34 AM, michaelsh@mellanox.com wrote:
>>> From: Michael Shych <michaelsh@mellanox.com>
>>>
>>> Introduce watchdog driver for a various range of Mellanox Ethernet and
>>> Infiniband switch systems.
>>>
>>> Watchdog driver for Mellanox watchdog devices, implemented in
>>> programmable logic device.
>>>
>>> Main and auxiliary watchdog devices can exist on the same system.
>>> There are several actions that can be defined in the watchdog:
>>> system reset, start fans on full speed and increase a counter.
>>> The last 2 actions are performed without a system reset.
>>> Actions without reset are provided for auxiliary watchdog devices,
>>> which is optional.
>>> Access to HW registers is performed through generic regmap interface.
>>>
>>> There are 2 types of HW watchdog implementations.
>>> Type 1: actual HW timeout can be defined as power of 2 msec.
>>> e.g. timeout 20 sec will be rounded up to 32768 msec.; maximum timeout
>>> period is 32 sec (32768 msec.); get time-left isn't supported Type 2:
>>> actual HW timeout is defined in sec. and it's the same as user-defined
>>> timeout; maximum timeout is 255 sec; get time-left is supported;
>>>
>>> Watchdog driver is probed from the common mlx_platform driver.
>>>
>>> Signed-off-by: Michael Shych <michaelsh@mellanox.com>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>
>>>
> 
> Hi Guenter,
> 
> Thank you very much for your reviews.
> 
> How we should proceed for this patchset?
> 
> Who should take it to the next, watchdog or platform mainatainer?
> 
Good question. For now I added it to my watchdog-next branch. But then strictly
speaking (and as far as I know) we don't have an Ack from the platform maintainer,
so maybe I should not have done that. Maybe we should wait for the platform part
to be merged by the platform maintainer. Thoughts, anyone ?

Guenter
