Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sat, 8 Oct 2016 16:13:24 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
	linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 1/2] watchdog: txx9wdt: Add missing clock (un)prepare calls for CCF
Message-ID: <20161008141324.GH23290@spo001.leaseweb.nl>
References: <1473584398-12942-1-git-send-email-geert@linux-m68k.org> <1473584398-12942-2-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1473584398-12942-2-git-send-email-geert@linux-m68k.org>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Geert,

> While the custom minimal TXx9 clock implementation doesn't need or use
> clock (un)prepare calls (they are dummies if !CONFIG_HAVE_CLK_PREPARE),
> they are mandatory when using the Common Clock Framework.
> 
> Hence add them, to prepare for the advent of CCF.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

This patch was added to linux-watchdog-next almost 2 weeks ago.

Kind regards,
Wim.
