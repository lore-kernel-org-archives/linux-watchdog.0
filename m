Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58624 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbbAKBTZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 10 Jan 2015 20:19:25 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YA7Bd-004LSY-R2
	for linux-watchdog@vger.kernel.org; Sun, 11 Jan 2015 01:19:26 +0000
Message-ID: <54B1CF9B.3060606@roeck-us.net>
Date: Sat, 10 Jan 2015 17:19:23 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?windows-1252?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Ralf Baechle <ralf@linux-mips.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Paul Burton <paul.burton@imgtec.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Maarten ter Huurne <maarten@treewalker.org>,
	linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/3] MIPS: Use do_kernel_restart() as the default restart
 handler
References: <1420914550-18335-1-git-send-email-lars@metafoo.de> <yw1xh9vyflfw.fsf@unicorn.mansr.com>
In-Reply-To: <yw1xh9vyflfw.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/10/2015 12:08 PM, M=E5ns Rullg=E5rd wrote:
> Lars-Peter Clausen <lars@metafoo.de> writes:
>
>> Use the recently introduced do_kernel_restart() function as the defa=
ult restart
>> handler if the platform did not explicitly provide a restart handler=
=2E This
>> allows use restart handler that have been registered by device drive=
rs to
>> restart the machine.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>   arch/mips/kernel/reset.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
>> index 07fc524..36cd80c 100644
>> --- a/arch/mips/kernel/reset.c
>> +++ b/arch/mips/kernel/reset.c
>> @@ -19,7 +19,7 @@
>>    * So handle all using function pointers to machine specific
>>    * functions.
>>    */
>> -void (*_machine_restart)(char *command);
>> +void (*_machine_restart)(char *command) =3D do_kernel_restart;
>>   void (*_machine_halt)(void);
>>   void (*pm_power_off)(void);
>
> There is already a similar patch posted by Kevin Cernekee:
> http://www.linux-mips.org/archives/linux-mips/2014-12/msg00410.html
>
Personally I prefer the earlier patch, though I guess that is personal =
preference.

Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
