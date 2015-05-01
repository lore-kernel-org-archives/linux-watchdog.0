Return-path: <timur@codeaurora.org>
Message-ID: <5543B7D0.706@codeaurora.org>
Date: Fri, 01 May 2015 12:28:48 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 Ashwin Chaugule <ashwin.chaugule@linaro.org>,
 Vipul Gandhi <vgandhi@codeaurora.org>, Fu Wei <fu.wei@linaro.org>,
 Al Stone <al.stone@linaro.org>,
 Wim Van Sebroeck <wim@iguana.be>, Hanjun Guo <hanjun.guo@linaro.org>,
 linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] watchdog: introduce the ARM64 SBSA watchdog driver
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org> <5542F33D.2020206@roeck-us.net> <5543A6E9.1090203@codeaurora.org>
In-Reply-To: <5543A6E9.1090203@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 05/01/2015 11:16 AM, Timur Tabi wrote:
>>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +    if (!res || !res->start) {
>>> +        dev_err(&pdev->dev, "could not get control address\n");
>>> +        return -ENOMEM;
>>> +    }
>>> +
>> devm_ioremap_resource already prints an error message if res is NULL.
>> And res->start can not be 0 unless there is a severe infrastructure
>> problem.
>
> Will fix.
>
>>> +    data->control = devm_ioremap_resource(&pdev->dev, res);
>>> +    if (!data->control)
>>> +        return -ENOMEM;
>>> +
>>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>> +    if (!res || !res->start) {
>>> +        dev_err(&pdev->dev, "could not get refresh address\n");
>>> +        return -ENOMEM;
>>> +    }
>> Same here.

So I must be missing something here.  I'm only printing an error message 
if platform_get_resource() fails.  I'm not printing a message if 
devm_ioremap_resource() fails.  Are you saying that I should not print 
an error message if platform_get_resource() fails?  What's wrong with that?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
