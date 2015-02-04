Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39643 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932281AbbBDOAG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Feb 2015 09:00:06 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YJ0Uv-002ncY-Jh
	for linux-watchdog@vger.kernel.org; Wed, 04 Feb 2015 14:00:06 +0000
Message-ID: <54D225D6.6040603@roeck-us.net>
Date: Wed, 04 Feb 2015 05:59:50 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>, John Crispin <blogic@openwrt.org>
CC: Wim Van Sebroeck <wim@iguana.be>,
	Ralf Baechle <ralf@linux-mips.org>,
	Valentin Rothberg <valentinrothberg@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: watchdog: SOC_MT7621?
References: <1423044809.23894.65.camel@x220> <54D1F248.4090406@openwrt.org>	 <1423047893.23022.13.camel@x220> <54D1FE0F.3030308@openwrt.org> <1423052553.30076.6.camel@tiscali.nl>
In-Reply-To: <1423052553.30076.6.camel@tiscali.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/04/2015 04:22 AM, Paul Bolle wrote:
> John Crispin schreef op wo 04-02-2015 om 12:10 [+0100]:
>> i think wim should just drop it and we leave it in openwrt with the
>> other 1/2 million patches that we have. i prefer to upstream the stuff
>> without feeling pressured to hurry up, that kills the fun.
>
> Once code is mainlined you'll get fixes written for you, updates done
> for you, etc. But you'll also get pointed at defects that require you to
> fix them yourself, or see the code removed eventually.
>
>> @Wim, can you drop the patch please ?
>
> Why should Wim drop more than the
>      || SOC_MT7621
>
> snippet?
>

Question is if the driver works with MT7620 as advertised. Either case
it would be odd if the driver advertises itself as MT7621 but only works
for MT7620, so I think it should be dropped entirely for now.

Wim, should I possibly ask Stephen to include my watchdog-next branch
in his -next builds ? This would help us catching such problems earlier.

Thanks,
Guenter

