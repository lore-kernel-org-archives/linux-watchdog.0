Return-path: <timo.kokkonen@offcode.fi>
Message-ID: <555C1F88.90203@offcode.fi>
Date: Wed, 20 May 2015 08:45:44 +0300
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>,
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 boris.brezillon@free-electrons.com, nicolas.ferre@atmel.com,
 alexandre.belloni@free-electrons.com
CC: Wenyou.Yang@atmel.com
Subject: Re: [PATCHv8 03/10] watchdog: core: Introduce default watchdog policy
References: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi> <1432023969-20736-4-git-send-email-timo.kokkonen@offcode.fi> <555BDFD4.6050003@roeck-us.net>
In-Reply-To: <555BDFD4.6050003@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

On 20.05.2015 04:13, Guenter Roeck wrote:
> On 05/19/2015 01:26 AM, Timo Kokkonen wrote:
>> Traditionally there have been no such thing as a policy for
>> watchdogs. The watchdog timer was simply explicitly stopped at driver
>> probe time and there was nothing else to do. Now that we have ability
>> to work around HW disabilities in the watchdog core, it is time to
>> introduce more policy options.
>>
>> The default option is to shut down the watchdog driver, as
>> before. This ensures backward compatibility with current kernels and
>> hardware that might have a watchdog, but user has not set up a
>> watchdog daemon at all.
>>
>> A new option is introduced to keep the watchdog running or start it up
>> at boot up. This is useful on many production systems that rely on the
>> watchdog to reboot the device in case a crash. With this option even
>> early kernel crashes or early user space crashes will lead to a reboot
>> even though watchdog daemon has not opened and started the watchdog
>> device yet.
>>
>> The third introduced option is to not touch the hardware at all in
>> case bootloader have made an intelligent decision about the watchdog
>> state and does not know how to tell kernel about it. The watchdog
>> state is not touched until userspace takes over it.
>>
>> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
>
> Dislike. I don't think it is a good idea to have configuration options
> like this. This means users will have to deal with those "default"
> options for an entire distribution, which I don't think is desirable.
> Maybe for you, but not for everyone, and definitely not for me.

The configuration option was suggested by Uwe Kleine-König. I think it 
makes sense as there would not be otherwise any other way to enable the 
early-timeout-sec as device tree. I would think that for example in some 
server environment it would be good to enable watchdogs as early as 
possible and there probably are no device tree available.

> I think you are trying to do too much in your patch set.
> Can we possibly focus on getting early timeout to an acceptable form
> instead of trying to do everything at the same time.

I would be happy to do it the way that guarantees the inclusion, but I 
feel that I am getting conflicting feedback from different people giving 
review. I appreciate any concrete guidance you can give about the 
direction I should go with the patch set.

Thanks,
-Timo
