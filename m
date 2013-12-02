Return-Path: <wd@denx.de>
To: Guenter Roeck <linux@roeck-us.net>
cc: Christophe Leroy <christophe.leroy@c-s.fr>,
    Wim Van Sebroeck <wim@iguana.be>, scottwood@freescale.com,
    linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
    linux-watchdog@vger.kernel.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] watchdog: mpc8xxx_wdt: MPC8xx is HW enabled
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <529B9152.9090106@roeck-us.net>
References: <20131130154540.E83D743E15@localhost.localdomain> <529B9152.9090106@roeck-us.net>
Date: Mon, 02 Dec 2013 07:14:17 +0100
Message-Id: <20131202061418.05A11380BFE@gemini.denx.de>
List-ID: <linux-watchdog@vger.kernel.org>

Dear Guenter,

In message <529B9152.9090106@roeck-us.net> you wrote:
> On 11/30/2013 07:45 AM, Christophe Leroy wrote:
> > MPC8xx watchdog is enabled at startup by HW.
> > If the bootloader disables it, it cannot be reenabled.
> 
> Is that true for all variants of 8xx, especially for 823 ? I am a bit concerned
> about breaking compatibility with some chips ... assuming there was a reason
> for not setting this flag originally.

This is correct, and applies for all variants of the MPC8xx, including
the MPC823 / MPC823E.  From the UM:

	"The software watchdog timer can be disabled or its timeout
	period can be changed in the SYPCR. Once the SYPCR is written,
	it cannot be written again until a system reset."

Actually this is the only correct behaviour.  Any watchdog that can be
disabled by software is not worth it's name, and unsuitable for any
kind of aplications where security / reliability are required.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Ninety-Ninety Rule of Project Schedules:
        The first ninety percent of the task takes ninety percent of
the time, and the last ten percent takes the other ninety percent.
