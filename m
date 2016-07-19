Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33939 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbcGSQVn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Jul 2016 12:21:43 -0400
Received: by mail-wm0-f47.google.com with SMTP id q128so17689057wma.1
        for <linux-watchdog@vger.kernel.org>; Tue, 19 Jul 2016 09:21:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160717221302.GA1111@laptop>
References: <CAAEAJfAEKvLCk2gjj6MR00t-Yg_-XEG1qb0ij6jse=FV3ez5bw@mail.gmail.com>
 <578A6C71.8080705@roeck-us.net> <20160717221302.GA1111@laptop>
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date: Tue, 19 Jul 2016 13:21:40 -0300
Message-ID: <CAAEAJfAxZy-57uM+XnvyiwE8k0eTx9iekzzHC5wGhCOMTR7qqg@mail.gmail.com>
Subject: Re: Can't query Intel's iTCO watchdog reboot reason
To: Guenter Roeck <linux@roeck-us.net>
Cc: dvhart@infradead.org, wim@iguana.be, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 17 July 2016 at 19:13, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
> Hi Guenter,
>
> Thanks a lot for the quick reply.
>
> On 16 Jul 10:18 AM, Guenter Roeck wrote:
>> On 07/15/2016 04:21 PM, Ezequiel Garcia wrote:
>> > Hi everyone,
>> >
>> > A large portion of my intel-based products are suffering from
>> > a nasty hardware freeze [1], and so I'm currently working this around
>> > enabling the iTCO watchdog -- which in any case, it's a good idea
>> > to have enabled.
>> >
>> > So, it would be interesting to find out on each boot if the machine was
>> > rebooted due to a watchdog timeout, but so far I'm not having any luck.
>> >
>> > As per Intel's appnote [2] the BIOS should update the WDDT ACPI table,
>> > so I added something like this to the iTCO driver:
>> >
>> >         status = acpi_get_table(ACPI_SIG_WDDT, 1,
>> >                                 (struct acpi_table_header **) &buf);
>> >         if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
>> >                 pr_err(FW_BUG "failed to get WDDT ACPI table\n");
>> >                 return;
>> >         }
>> >
>> > But it doesn't find the table. Strangely, reading TCO1_STS
>> > and TCO2_STS always gives 0x0.
>> >
>>
>> That sounds like either the BIOS resets those bits, or the reboots
>> are not caused by the watchdog. Are you sure that you see reboots
>> that are caused by the watchdog ?
>>
>
> Yes, I'm testing my patch forcing watchdog reboots. At least on my i5
> development machine, I haven't found any way of querying the reboot
> reason. I'm not even sure this is supposed to work.
>
> I'll see if I can test on other intel machines with TCO watchdogs.
>

FWIW, repeated this test on a Bay Trail SoC TCO device, with no luck.

Thanks,
-- 
Ezequiel García, VanguardiaSur
www.vanguardiasur.com.ar
