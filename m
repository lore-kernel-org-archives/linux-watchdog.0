Return-Path: <nix.or.die@gmail.com>
Return-path: <nix.or.die@gmail.com>
Subject: Re: [11/12] watchdog: sp5100-tco: Abort if watchdog is disabled by
 hardware
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lyude Paul <lyude@redhat.com>, Wim Van Sebroeck <wim@iguana.be>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?Wm9sdMOhbiBCw7ZzesO2cm3DqW55aQ==?= <zboszor@pr.hu>
References: <1514149457-20273-12-git-send-email-linux@roeck-us.net>
 <1515538687.4373.18.camel@redhat.com> <20180109233703.GD26819@roeck-us.net>
 <4b56f6ba-bf76-a500-087a-49f34cd4b5d5@gmail.com>
 <20180110000532.GA6500@roeck-us.net>
From: Gabriel C <nix.or.die@gmail.com>
Message-ID: <b40a3a8e-1791-5445-a0bb-c71a057b4e95@gmail.com>
Date: Wed, 10 Jan 2018 02:26:14 +0100
MIME-Version: 1.0
In-Reply-To: <20180110000532.GA6500@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

On 10.01.2018 01:05, Guenter Roeck wrote:
> Hi,
> 
> On Wed, Jan 10, 2018 at 12:58:00AM +0100, Gabriel C wrote:
>> On 10.01.2018 00:37, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Tue, Jan 09, 2018 at 05:58:07PM -0500, Lyude Paul wrote:
>>>> Hi! I'm the one from the Fedora bugzilla who said they'd help review these
>>>> patches. I might end up responding to this with a real review comment after
>>>> this message, but first:
>>>>
>>>> mind cc'ing me future versions of this patchset and also, is there any way you
>>>
>>> Sure.
>>>
>>>> know of that one could figure out whether or not the sp5100_tco wdt is
>>>> actually disabled by the OEM on a board? I tried testing these patches with my
>>>
>>> That is what the code is trying to do today.
>>>
>>>> system and it appears to be convinced that it's disabled on my system, but I'm
>>>> hoping something in this patch is just broken…
>>>>
>>>
>>> I tested the driver on three different boards. MSI B350M MORTAR,
>>> MSI B350 TOMAHAWK, and Gigabyte AB350M-Gaming 3. CPU is Ryzen 1700X
>>> on all boards.
>>>
>>> On the MSI boards, the watchdog is reported as disabled. Enabling it
>>> and letting it expire does not have an effect. I am using the Super-IO
>>> watchdog instead on those boards (and it works).
>>>
>>> On the Gigabyte board, the watchdog is reported as enabled, and it works
>>> (and the watchdog on the Super-IO chips does not work).
>>>
>>> Feel free to play with the driver. Maybe there is a means to enable the
>>> watchdog if it is disabled. Unfortunately, I was unable to figure out how
>>> to do it, so I thought it is better to report the fact and not instantiate
>>> the watchdog if it doesn't work.
>>>
>>
>> I haven an Supemricro H11DSi-NT with EPYCs CPUs..
>> I can set the watchdog ON/OFF in BIOS and also set in to reset or NMI
>> with the moatherboard jumpers.
>>
>> If you want I can give whatever patches for this driver an try ,
>> just let me know.
>>
> 
> It would be great if you can test the series, even more so if you can test it
> with the watchdog enabled and disabled . If you need to pull it from a git
> repository, it is available from
> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
> in branch watchdog-next.
> 

I've tested the branch ( on top latest linus/master ) with watchdog ON/OFF
in BIOS and jumper set to reset ( default on this board )

It seems no matter is enabled or disabled I always get a disabled message from the driver.

[    4.246280] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    4.247052] sp5100-tco sp5100-tco: Using 0xfed80b00 for watchdog MMIO address
[    4.247181] sp5100-tco sp5100-tco: Watchdog hardware is disabled

I got some strange NMI but this may not be related.

'Uhhuh. NMI received for unknown reason 3d on CPU 33' ( on all 64 CPUs )


Maybe on that board is meant to 'enable' the BMC watchdog ..but BIOS tells
'if you enable watchdog the 5 minutes timer is started until OS/SW takes over'

And a quick info shows there is no initial timer on the BMC Watchdog..

crazy@ant:~/sp5100_tco$ sudo bmc-watchdog -g
Timer Use:                   Reserved
Timer:                       Stopped
Logging:                     Enabled
Timeout Action:              None
Pre-Timeout Interrupt:       None
Pre-Timeout Interval:        0 seconds
Timer Use BIOS FRB2 Flag:    Clear
Timer Use BIOS POST Flag:    Clear
Timer Use BIOS OS Load Flag: Clear
Timer Use BIOS SMS/OS Flag:  Clear
Timer Use BIOS OEM Flag:     Clear
Initial Countdown:           0 seconds
Current Countdown:           0 seconds


I try to have a closer look tomorrow.


Regards,

Gabriel C
