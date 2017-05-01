Return-path: <shuahkh@osg.samsung.com>
Subject: Re: [PATCH] selftests: watchdog: accept multiple params on command
 line
To: Timur Tabi <timur@codeaurora.org>, linux-kselftest@vger.kernel.org
References: <1490730277-30200-1-git-send-email-timur@codeaurora.org>
 <40133281-90e2-1b9e-2f86-35c2d02eb168@roeck-us.net>
 <CAOZdJXXVmx3nqO8=8Cmxv2aZKyPEy7AC7Cpkn6UeTZ5O8N90gg@mail.gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-watchdog@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Shuah Khan <shuahkh@osg.samsung.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <ae86bc00-1226-9c3b-9be3-6b163ac08ff5@osg.samsung.com>
Date: Mon, 1 May 2017 13:15:32 -0600
MIME-Version: 1.0
In-Reply-To: <CAOZdJXXVmx3nqO8=8Cmxv2aZKyPEy7AC7Cpkn6UeTZ5O8N90gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

On 05/01/2017 12:45 PM, Timur Tabi wrote:
> On Sun, Apr 16, 2017 at 8:13 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>>> Watchdog drivers are not required to retain programming information,
>>> such as timeouts, after the watchdog device is closed.  Therefore,
>>> the watchdog test should be able to perform multiple actions after
>>> opening the watchdog device.
>>>
>>> For example, to set the timeout to 10s and ping every 5s:
>>>
>>>         watchdog-test -t 10 -p 5 -e
>>>
>>> Also, display the periodic decimal point only if the keep-alive call
>>> succeeds.
>>>
>>> Signed-off-by: Timur Tabi <timur@codeaurora.org>
>>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Any chance of getting this into 4.12?
> 


Hi Timur,

I can't find the patch in my Inbox. Could you please send it to me.
I can get this into 4.12-rc1

thanks,
-- Shuah
