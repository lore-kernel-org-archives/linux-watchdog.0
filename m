Return-path: <lars@metafoo.de>
Message-ID: <54B26F5C.8050202@metafoo.de>
Date: Sun, 11 Jan 2015 13:41:00 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: =?windows-1252?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
CC: Guenter Roeck <linux@roeck-us.net>,
 Ralf Baechle <ralf@linux-mips.org>,
 Wim Van Sebroeck <wim@iguana.be>, Paul Burton <paul.burton@imgtec.com>,
 Paul Cercueil <paul@crapouillou.net>,
 Maarten ter Huurne <maarten@treewalker.org>, linux-mips@linux-mips.org,
 linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/3] MIPS: Use do_kernel_restart() as the default restart
 handler
References: <1420914550-18335-1-git-send-email-lars@metafoo.de>	<yw1xh9vyflfw.fsf@unicorn.mansr.com> <54B1CF9B.3060606@roeck-us.net>	<yw1xd26lfr93.fsf@unicorn.mansr.com> <54B26BB4.50707@metafoo.de> <yw1x8uh9fqj1.fsf@unicorn.mansr.com>
In-Reply-To: <yw1x8uh9fqj1.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

On 01/11/2015 01:30 PM, Måns Rullgård wrote:
> Lars-Peter Clausen <lars@metafoo.de> writes:
>
>> On 01/11/2015 01:15 PM, Måns Rullgård wrote:
>>> Guenter Roeck <linux@roeck-us.net> writes:
>>>
>>>> On 01/10/2015 12:08 PM, Måns Rullgård wrote:
>>>>> Lars-Peter Clausen <lars@metafoo.de> writes:
>>>>>
>>>>>> Use the recently introduced do_kernel_restart() function as the default restart
>>>>>> handler if the platform did not explicitly provide a restart handler. This
>>>>>> allows use restart handler that have been registered by device drivers to
>>>>>> restart the machine.
>>>>>>
>>>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>>>>> ---
>>>>>>     arch/mips/kernel/reset.c |    2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
>>>>>> index 07fc524..36cd80c 100644
>>>>>> --- a/arch/mips/kernel/reset.c
>>>>>> +++ b/arch/mips/kernel/reset.c
>>>>>> @@ -19,7 +19,7 @@
>>>>>>      * So handle all using function pointers to machine specific
>>>>>>      * functions.
>>>>>>      */
>>>>>> -void (*_machine_restart)(char *command);
>>>>>> +void (*_machine_restart)(char *command) = do_kernel_restart;
>>>>>>     void (*_machine_halt)(void);
>>>>>>     void (*pm_power_off)(void);
>>>>>
>>>>> There is already a similar patch posted by Kevin Cernekee:
>>>>> http://www.linux-mips.org/archives/linux-mips/2014-12/msg00410.html
>>>>>
>>>> Personally I prefer the earlier patch, though I guess that is personal
>>>> preference.
>>>
>>> They both achieve the same thing, though Kevin's is more in line with
>>> what ARM does.  Missing from both is a fallback while(1) loop in case no
>>> restart handlers are registered.  With the restart moved to the watchdog
>>> driver, there's a possibility that this might happen.
>>>
>>
>> In my opinion if such a fallback is needed it should be put into the
>> kernel core reboot implementation and not into individual restart
>> handler implementations.
>>
>> My first version of this patch was do_kernel_restart() followed by a
>> machine_halt() (so it goes to sleep instead of busy looping) as a
>> fallback. But I couldn't find a good reason why that should be done at
>> the individual restart handler level, so I dropped it.
>
> ARM does it its arch machine_restart() function.  MIPS should probably
> follow suit.
>

That's just cargo culting...

Either it is required, then it should probably be moved into the core 
kernel, or it is not required in which case it can be removed from the ARM 
machine_restart() implementation.
