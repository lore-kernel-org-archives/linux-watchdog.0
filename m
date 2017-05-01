Return-path: <timur@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <40133281-90e2-1b9e-2f86-35c2d02eb168@roeck-us.net>
References: <1490730277-30200-1-git-send-email-timur@codeaurora.org> <40133281-90e2-1b9e-2f86-35c2d02eb168@roeck-us.net>
From: Timur Tabi <timur@codeaurora.org>
Date: Mon, 1 May 2017 13:45:18 -0500
Message-ID: <CAOZdJXXVmx3nqO8=8Cmxv2aZKyPEy7AC7Cpkn6UeTZ5O8N90gg@mail.gmail.com>
Subject: Re: [PATCH] selftests: watchdog: accept multiple params on command line
To: linux-kselftest@vger.kernel.org, shuahkh@osg.samsung.com
Cc: Arnd Bergmann <arnd@arndb.de>, linux-watchdog@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, Apr 16, 2017 at 8:13 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>
>> Watchdog drivers are not required to retain programming information,
>> such as timeouts, after the watchdog device is closed.  Therefore,
>> the watchdog test should be able to perform multiple actions after
>> opening the watchdog device.
>>
>> For example, to set the timeout to 10s and ping every 5s:
>>
>>         watchdog-test -t 10 -p 5 -e
>>
>> Also, display the periodic decimal point only if the keep-alive call
>> succeeds.
>>
>> Signed-off-by: Timur Tabi <timur@codeaurora.org>
>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Any chance of getting this into 4.12?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
