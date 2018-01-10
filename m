Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39073 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933614AbeAJCmX (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 9 Jan 2018 21:42:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180110020925.GA11487@roeck-us.net>
References: <1514149457-20273-12-git-send-email-linux@roeck-us.net>
 <1515538687.4373.18.camel@redhat.com> <20180109233703.GD26819@roeck-us.net>
 <4b56f6ba-bf76-a500-087a-49f34cd4b5d5@gmail.com> <20180110000532.GA6500@roeck-us.net>
 <b40a3a8e-1791-5445-a0bb-c71a057b4e95@gmail.com> <20180110020925.GA11487@roeck-us.net>
From: Gabriel C <nix.or.die@gmail.com>
Date: Wed, 10 Jan 2018 03:41:51 +0100
Message-ID: <CAEJqkgj=cGKXSE+jN01FW+GMmL2rT0O_i8V6S7kxBnirLBEC-g@mail.gmail.com>
Subject: Re: [11/12] watchdog: sp5100-tco: Abort if watchdog is disabled by hardware
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lyude Paul <lyude@redhat.com>, Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?Wm9sdMOhbiBCw7ZzesO2cm3DqW55aQ==?= <zboszor@pr.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

2018-01-10 3:09 GMT+01:00 Guenter Roeck <linux@roeck-us.net>:
> On Wed, Jan 10, 2018 at 02:26:14AM +0100, Gabriel C wrote:
>> On 10.01.2018 01:05, Guenter Roeck wrote:
>> >Hi,
>> >
>> >On Wed, Jan 10, 2018 at 12:58:00AM +0100, Gabriel C wrote:
>> >>On 10.01.2018 00:37, Guenter Roeck wrote:
>> >>>Hi,
>> >>>
>> >>>On Tue, Jan 09, 2018 at 05:58:07PM -0500, Lyude Paul wrote:
>> >>>>Hi! I'm the one from the Fedora bugzilla who said they'd help review=
 these
>> >>>>patches. I might end up responding to this with a real review commen=
t after
>> >>>>this message, but first:
>> >>>>
>> >>>>mind cc'ing me future versions of this patchset and also, is there a=
ny way you
>> >>>
>> >>>Sure.
>> >>>
>> >>>>know of that one could figure out whether or not the sp5100_tco wdt =
is
>> >>>>actually disabled by the OEM on a board? I tried testing these patch=
es with my
>> >>>
>> >>>That is what the code is trying to do today.
>> >>>
>> >>>>system and it appears to be convinced that it's disabled on my syste=
m, but I'm
>> >>>>hoping something in this patch is just broken=E2=80=A6
>> >>>>
>> >>>
>> >>>I tested the driver on three different boards. MSI B350M MORTAR,
>> >>>MSI B350 TOMAHAWK, and Gigabyte AB350M-Gaming 3. CPU is Ryzen 1700X
>> >>>on all boards.
>> >>>
>> >>>On the MSI boards, the watchdog is reported as disabled. Enabling it
>> >>>and letting it expire does not have an effect. I am using the Super-I=
O
>> >>>watchdog instead on those boards (and it works).
>> >>>
>> >>>On the Gigabyte board, the watchdog is reported as enabled, and it wo=
rks
>> >>>(and the watchdog on the Super-IO chips does not work).
>> >>>
>> >>>Feel free to play with the driver. Maybe there is a means to enable t=
he
>> >>>watchdog if it is disabled. Unfortunately, I was unable to figure out=
 how
>> >>>to do it, so I thought it is better to report the fact and not instan=
tiate
>> >>>the watchdog if it doesn't work.
>> >>>
>> >>
>> >>I haven an Supemricro H11DSi-NT with EPYCs CPUs..
>> >>I can set the watchdog ON/OFF in BIOS and also set in to reset or NMI
>> >>with the moatherboard jumpers.
>> >>
>> >>If you want I can give whatever patches for this driver an try ,
>> >>just let me know.
>> >>
>> >
>> >It would be great if you can test the series, even more so if you can t=
est it
>> >with the watchdog enabled and disabled . If you need to pull it from a =
git
>> >repository, it is available from
>> >git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
>> >in branch watchdog-next.
>> >
>>
>> I've tested the branch ( on top latest linus/master ) with watchdog ON/O=
FF
>> in BIOS and jumper set to reset ( default on this board )
>>
>> It seems no matter is enabled or disabled I always get a disabled messag=
e from the driver.
>>
>> [    4.246280] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
>> [    4.247052] sp5100-tco sp5100-tco: Using 0xfed80b00 for watchdog MMIO=
 address
>> [    4.247181] sp5100-tco sp5100-tco: Watchdog hardware is disabled
>>
>> I got some strange NMI but this may not be related.
>>
>> 'Uhhuh. NMI received for unknown reason 3d on CPU 33' ( on all 64 CPUs )
>>
>>
>> Maybe on that board is meant to 'enable' the BMC watchdog ..but BIOS tel=
ls
>> 'if you enable watchdog the 5 minutes timer is started until OS/SW takes=
 over'
>>
>> And a quick info shows there is no initial timer on the BMC Watchdog..
>>
>> crazy@ant:~/sp5100_tco$ sudo bmc-watchdog -g
>> Timer Use:                   Reserved
>> Timer:                       Stopped
>> Logging:                     Enabled
>> Timeout Action:              None
>> Pre-Timeout Interrupt:       None
>> Pre-Timeout Interval:        0 seconds
>> Timer Use BIOS FRB2 Flag:    Clear
>> Timer Use BIOS POST Flag:    Clear
>> Timer Use BIOS OS Load Flag: Clear
>> Timer Use BIOS SMS/OS Flag:  Clear
>> Timer Use BIOS OEM Flag:     Clear
>> Initial Countdown:           0 seconds
>> Current Countdown:           0 seconds
>>
>>
>> I try to have a closer look tomorrow.
>>
>
> Can you run sensors-detect and provide the output ?
> Maybe the board uses the watchdog from a Super-IO chip,
> similar to the MSI boards.
>

Only k10temp and IPMI BMC KCS is detected.
Also the board seems to have 2 jumpers to enable/disable
i2c SMB or something on SMB , which seems to be set to disabled by default.

>From the manual:

Use Jumpers JI2C1/JI2C2 to enable PCI SMB (System Management Bus)
support to improve system
management for the PCI slots. See the table on the right for jumper setting=
s.


Default is marked Disabled. I'll switch the jumpers tomorrow to on
and see whatever things changes.



Anyway here the output :

 odule cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
AMD Family 15h thermal sensors...                           No
AMD Family 16h thermal sensors...                           No
AMD Family 17h thermal sensors...                           Success!
   (driver `k10temp')
AMD Family 15h power sensors...                             No
AMD Family 16h power sensors...                             No
Intel digital thermal sensor...                             No
Intel AMB FB-DIMM thermal sensor...                         No
Intel 5500/5520/X58 thermal sensor...                       No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):
Found `IPMI BMC KCS' at 0xca2...                            Success!
   (confidence 8, driver `to-be-written')

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-piix4' for device 0000:00:14.0: AMD KERNCZ SMBus
Module i2c-piix4 loaded successfully.
Module i2c-dev loaded successfully.

Next adapter: SMBus PIIX4 adapter port 0 at 0b00 (i2c-0)
Do you want to scan it? (YES/no/selectively):

Next adapter: SMBus PIIX4 adapter port 2 at 0b00 (i2c-1)
Do you want to scan it? (YES/no/selectively):

Next adapter: SMBus PIIX4 adapter port 3 at 0b00 (i2c-2)
Do you want to scan it? (YES/no/selectively):

Next adapter: SMBus PIIX4 adapter port 4 at 0b00 (i2c-3)
Do you want to scan it? (YES/no/selectively):


Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `k10temp' (autoloaded):
 * Chip `AMD Family 17h thermal sensors' (confidence: 9)

Driver `to-be-written':
 * ISA bus, address 0xca2
   Chip `IPMI BMC KCS' (confidence: 8)
