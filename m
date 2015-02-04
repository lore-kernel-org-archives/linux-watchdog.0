Return-path: <blogic@openwrt.org>
Message-ID: <54D1FE0F.3030308@openwrt.org>
Date: Wed, 04 Feb 2015 12:10:07 +0100
From: John Crispin <blogic@openwrt.org>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>
CC: Wim Van Sebroeck <wim@iguana.be>, Ralf Baechle <ralf@linux-mips.org>,
 Valentin Rothberg <valentinrothberg@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: watchdog: SOC_MT7621?
References: <1423044809.23894.65.camel@x220> <54D1F248.4090406@openwrt.org> <1423047893.23022.13.camel@x220>
In-Reply-To: <1423047893.23022.13.camel@x220>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>



On 04/02/2015 12:04, Paul Bolle wrote:
> On Wed, 2015-02-04 at 11:19 +0100, John Crispin wrote:
>> On 04/02/2015 11:13, Paul Bolle wrote:
>>> Is SOC_MT7621 still being worked on?
>>
>> yes we dropped the series as it collided with the gic rework that
>> chromiun.org was working on. i hope to push it during the next merge
>> window. the 1004k support has just been flaky till now as there was
>> never any real silicon to test it on. the chromium people really did a
>> good job at making the gic code nicer.
> 
> Thanks for explaining this. Unless SOC_MT7621 takes a long time to land
> in linux-next I won't be bothering you again about this. (I think I'll
> use "by the end of the v3.20 series" as a definition of a long time.)
> 
>> quite an impressive Cc list you have there
> 
> Yes, that's the way it works with problems that span two (or more)
> subsystems (in this case watchdog and MIPS). Actually, much longer CC
> lists are used regularly on lkml.
> 
> Thanks!
> 
> 
> Paul Bolle
> 

i think wim should just drop it and we leave it in openwrt with the
other 1/2 million patches that we have. i prefer to upstream the stuff
without feeling pressured to hurry up, that kills the fun.

@Wim, can you drop the patch please ?

	John
