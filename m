Return-path: <pebolle@tiscali.nl>
Message-ID: <1423052553.30076.6.camel@tiscali.nl>
Subject: Re: watchdog: SOC_MT7621?
From: Paul Bolle <pebolle@tiscali.nl>
To: John Crispin <blogic@openwrt.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, Ralf Baechle <ralf@linux-mips.org>,
 Valentin Rothberg <valentinrothberg@gmail.com>, Guenter Roeck
 <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Feb 2015 13:22:33 +0100
In-Reply-To: <54D1FE0F.3030308@openwrt.org>
References: <1423044809.23894.65.camel@x220> <54D1F248.4090406@openwrt.org>
	 <1423047893.23022.13.camel@x220> <54D1FE0F.3030308@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

John Crispin schreef op wo 04-02-2015 om 12:10 [+0100]:
> i think wim should just drop it and we leave it in openwrt with the
> other 1/2 million patches that we have. i prefer to upstream the stuff
> without feeling pressured to hurry up, that kills the fun.

Once code is mainlined you'll get fixes written for you, updates done
for you, etc. But you'll also get pointed at defects that require you to
fix them yourself, or see the code removed eventually.

> @Wim, can you drop the patch please ?

Why should Wim drop more than the
    || SOC_MT7621

snippet?


Paul Bolle
