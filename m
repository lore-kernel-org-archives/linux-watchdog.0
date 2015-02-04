Return-path: <blogic@openwrt.org>
Message-ID: <54D1F248.4090406@openwrt.org>
Date: Wed, 04 Feb 2015 11:19:52 +0100
From: John Crispin <blogic@openwrt.org>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>, Wim Van Sebroeck <wim@iguana.be>,
 Ralf Baechle <ralf@linux-mips.org>
CC: Valentin Rothberg <valentinrothberg@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>,
 linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
 linux-kernel@vger.kernel.org
Subject: Re: watchdog: SOC_MT7621?
References: <1423044809.23894.65.camel@x220>
In-Reply-To: <1423044809.23894.65.camel@x220>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>



On 04/02/2015 11:13, Paul Bolle wrote:
> messages. Since I haven't received replies on other, more serious
> issues in over three months I assume John has disappeared.)

into thin air, *pooff*

> Is SOC_MT7621 still being worked on?

yes we dropped the series as it collided with the gic rework that
chromiun.org was working on. i hope to push it during the next merge
window. the 1004k support has just been flaky till now as there was
never any real silicon to test it on. the chromium people really did a
good job at making the gic code nicer.

quite an impressive Cc list you have there

	John
