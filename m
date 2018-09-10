Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35894 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbeIJSVG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 10 Sep 2018 14:21:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1-v6so10492434pgo.3
        for <linux-watchdog@vger.kernel.org>; Mon, 10 Sep 2018 06:27:01 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] wdt: lantiq: Convert to watchdog_device
To: Hauke Mehrtens <hauke@hauke-m.de>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, john@phrozen.org, dev@kresin.me
References: <20180902113233.29113-1-hauke@hauke-m.de>
 <20180902113233.29113-3-hauke@hauke-m.de>
 <7c475c33-72c9-1217-7655-c8063683b3fc@roeck-us.net>
 <6315a579-3249-e83b-69ea-54ac13b15799@hauke-m.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <6fe2a9bf-4b8d-5958-6737-18c78368f495@roeck-us.net>
Date: Mon, 10 Sep 2018 06:26:58 -0700
MIME-Version: 1.0
In-Reply-To: <6315a579-3249-e83b-69ea-54ac13b15799@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/09/2018 02:07 PM, Hauke Mehrtens wrote:
[ ... ]>
>>> +    if (!priv->clk_rate) {
>>> +        dev_err(dev, "clock has wrong value of 0");
>>
>> This is misleading: It is not known if the clock rate is indeed 0.
>> It is only known that the clock rate is below LTQ_WDT_DIVIDER.
> 
> Ok I will update this.
> 
>>> +        return -EIO;
>>
>> I am not happy with EIO in this case. There is no indication
>> of an I/O error.
> 
> Is -EINVAL better?
> 

Yes.

Thanks,
Guenter
