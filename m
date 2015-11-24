Return-path: <damien.riegel@savoirfairelinux.com>
Date: Mon, 23 Nov 2015 21:55:45 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
	robh+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
	wim@iguana.be, sameo@linux.intel.com, dinh.linux@gmail.com,
	Arnd Bergmann <arnd@arndb.de>, kernel@savoirfairelinux.com
Subject: Re: [PATCH v4 3/5] watchdog: ts4800: add driver for TS-4800 watchdog
Message-ID: <20151124025544.GA5743@localhost>
References: <1448291861-28543-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448291861-28543-4-git-send-email-damien.riegel@savoirfairelinux.com>
 <5653CC2F.8080608@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5653CC2F.8080608@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Nov 23, 2015 at 06:32:15PM -0800, Guenter Roeck wrote:
> Hi Damien,
> 
> On 11/23/2015 07:17 AM, Damien Riegel wrote:
> >This watchdog is instantiated in a FPGA that is memory mapped. It is
> >made of only one register, called the feed register. Writing to this
> >register will re-arm the watchdog for a given time (and enable it if it
> >was disable). It can be disabled by writing a special value into it.
> >
> >It is part of a syscon block, and the watchdog register offset in this
> >block varies from board to board. This offset is passed in the syscon
> >property after the phandle to the syscon node.
> >
> >Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> >---
> 
> [ ... ]
> 
> >+
> >+static int ts4800_wdt_set_timeout(struct watchdog_device *wdd,
> >+				  unsigned int timeout)
> >+{
> >+	struct ts4800_wdt *wdt = watchdog_get_drvdata(wdd);
> >+	int i;
> >+
> >+	for (i = 0; i <= MAX_TIMEOUT_INDEX; i++) {
> >+		if (ts4800_wdt_map[i].timeout >= timeout)
> >+			break;
> >+	}
> 
> If the loop does not break, i will have a value of MAX_TIMEOUT_INDEX + 1,
> or 2, pointing after the end of the table. That should never happen,
> but still ...

That should never happen, but indeed it's not very elegant. I will
change that.

> 
> I preferred the earlier version, where you had an extra function.

As I have to set both wdd->timeout and wdt->feed_val, I found it easier
and shorter to iterate directly in the set_timeout function.

> Only my suggestion was to have that function return MAX_TIMEOUT_INDEX
> instead of an error. Alternatively, the check above needs to be
> "i < MAX_TIMEOUT_INDEX".

That would be a strange stop condition. Would this construct be ok for
you:

	for (i = 0; i < ARRAY_SIZE(ts4800_wdt_map; i++) {
		if (ts4800_wdt_map[i].timeout >= timeout)
			break;
	}

	if (i >= ARRAY_SIZE(ts4800_wdt_map)
		i = MAX_TIMEOUT_INDEX;

Thanks,
Damien
