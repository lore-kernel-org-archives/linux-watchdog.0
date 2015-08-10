Return-path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <55C327B5.4050902@roeck-us.net>
References: <1438849919-27724-1-git-send-email-21cnbao@gmail.com> <55C327B5.4050902@roeck-us.net>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 10 Aug 2015 10:30:49 +0800
Message-ID: <CAGsJ_4xkuy5chFdF56RGi+_bYx7Px4Wvan2Zq6b-xpN8TE3djA@mail.gmail.com>
Subject: Re: [PATCH] watchdog : sirf: add support for CSR atlas7 SoC
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, William Wang <William.Wang@csr.com>,
	Guo Zeng <guo.zeng@csr.com>, Barry Song <Baohua.Song@csr.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

2015-08-06 17:24 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
>
> On 08/06/2015 01:31 AM, Barry Song wrote:
>>
>> From: William Wang <William.Wang@csr.com>
>>
>> This patch adds support for the new CSR atlas7 chips. prima2 and atlas7
>> are similar in chip design, but the register layout and flows have some
>> differences.
>>
>> This patch puts the differences including register layout and operations
>> in dt private data, so that one driver can be compatible for two chips.
>>
>> Signed-off-by: William Wang <William.Wang@csr.com>
>> Signed-off-by: Guo Zeng <guo.zeng@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
>
> You are pretty much doubling the size of this driver (from 225 to 446 LOC).
> I don't see the benefits of having a single driver, sorry. It just makes
> it very difficult to maintain. Please make this a separate driver.

the problem is that atlas7 and prima2 shares same watchdog IP, but the
way to implemen the driver has some differences due to different
authors.
we are going to unify the implementation of prima2 and atlas7, then
those callbacks can  be shared. and then the code size will not be
doubled.

>
> Thanks,
> Guenter
>

-barry
