Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:37766 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbbC3Sv6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Mar 2015 14:51:58 -0400
Date: Mon, 30 Mar 2015 21:51:50 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: David Daney <ddaney.cavm@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	David Daney <david.daney@cavium.com>,
	linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] watchdog: octeon: convert to WATCHDOG_CORE API
Message-ID: <20150330185150.GD571@fuloong-minipc.musicnaut.iki.fi>
References: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi>
 <551992F0.5050809@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551992F0.5050809@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On Mon, Mar 30, 2015 at 11:16:16AM -0700, David Daney wrote:
> On 03/28/2015 11:05 AM, Aaro Koskinen wrote:
> >Convert OCTEON watchdog to WATCHDOG_CORE API. This enables support
> >for multiple watchdogs on OCTEON boards.
> >
> >Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> >---
> >  drivers/watchdog/Kconfig           |   1 +
> >  drivers/watchdog/octeon-wdt-main.c | 185 ++++++++-----------------------------
> >  2 files changed, 39 insertions(+), 147 deletions(-)
> >
> [...]
> 
> You didn't seem to say how it was tested.
> 
> If you have verified that "echo > /dev/watchdog" produces register dumps and
> reboots the board, then the whole series:
> 
> Acked-by: David Daney <david.daney@cavium.com>

Yes, that was exactly my test case:

	root@dsr-1000n:~$ cat /dev/watchdog
	cat: read error: Invalid argument[   44.835019] watchdog watchdog0: watchdog did not stop!

	root@dsr-1000n:~$
	*** NMI Watchdog interrupt on Core 0x0 ***
	        $0      0x0000000000000000      at      0x0000000010008ce0
	[...]
	        sum0    0x0100000000000000      en0     0x01206f4500008000
	*** Chip soft reset soon ***


	U-Boot 1.1.1 (Development build, svnversion: exported) (Build time: Mar 22 2010
- 12:14:14)

	Warning: Board descriptor tuple not found in eeprom, using defaults
	CUST_DSR1000 board revision major:2, minor:0, serial #: unknown
	OCTEON CN5010-SCP pass 1.1, Core clock: 500 MHz, DDR clock: 200 MHz (400 Mhz data rate)

> Thanks for doing this, I had been meaning to make the conversion myself.

One further improvement idea would be to get the register dump logged
also with printk() or panic() so that it could be captured with netconsole
or mtdoops (at least in some cases). Not sure what it would require.
Calling printk() or panic() from the NMI handler didn't quite produce
an expected result...

A.
