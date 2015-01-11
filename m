Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:60162 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbbAKMPO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 11 Jan 2015 07:15:14 -0500
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Paul Burton <paul.burton@imgtec.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Maarten ter Huurne <maarten@treewalker.org>,
	linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/3] MIPS: Use do_kernel_restart() as the default restart handler
References: <1420914550-18335-1-git-send-email-lars@metafoo.de>
	<yw1xh9vyflfw.fsf@unicorn.mansr.com> <54B1CF9B.3060606@roeck-us.net>
Date: Sun, 11 Jan 2015 12:15:04 +0000
In-Reply-To: <54B1CF9B.3060606@roeck-us.net> (Guenter Roeck's message of "Sat,
	10 Jan 2015 17:19:23 -0800")
Message-ID: <yw1xd26lfr93.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:

> On 01/10/2015 12:08 PM, Måns Rullgård wrote:
>> Lars-Peter Clausen <lars@metafoo.de> writes:
>>
>>> Use the recently introduced do_kernel_restart() function as the default restart
>>> handler if the platform did not explicitly provide a restart handler. This
>>> allows use restart handler that have been registered by device drivers to
>>> restart the machine.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>> ---
>>>   arch/mips/kernel/reset.c |    2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
>>> index 07fc524..36cd80c 100644
>>> --- a/arch/mips/kernel/reset.c
>>> +++ b/arch/mips/kernel/reset.c
>>> @@ -19,7 +19,7 @@
>>>    * So handle all using function pointers to machine specific
>>>    * functions.
>>>    */
>>> -void (*_machine_restart)(char *command);
>>> +void (*_machine_restart)(char *command) = do_kernel_restart;
>>>   void (*_machine_halt)(void);
>>>   void (*pm_power_off)(void);
>>
>> There is already a similar patch posted by Kevin Cernekee:
>> http://www.linux-mips.org/archives/linux-mips/2014-12/msg00410.html
>>
> Personally I prefer the earlier patch, though I guess that is personal
> preference.

They both achieve the same thing, though Kevin's is more in line with
what ARM does.  Missing from both is a fallback while(1) loop in case no
restart handlers are registered.  With the restart moved to the watchdog
driver, there's a possibility that this might happen.

-- 
Måns Rullgård
mans@mansr.com
