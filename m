Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1on0076.outbound.protection.outlook.com ([157.56.110.76]:31520
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753495AbbC3Tcr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Mar 2015 15:32:47 -0400
Message-ID: <55199CFC.5070307@caviumnetworks.com>
Date: Mon, 30 Mar 2015 11:59:08 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Aaro Koskinen <aaro.koskinen@iki.fi>
CC: David Daney <ddaney.cavm@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	David Daney <david.daney@cavium.com>,
	<linux-watchdog@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/3] watchdog: octeon: convert to WATCHDOG_CORE API
References: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi> <551992F0.5050809@gmail.com> <20150330185150.GD571@fuloong-minipc.musicnaut.iki.fi>
In-Reply-To: <20150330185150.GD571@fuloong-minipc.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/30/2015 11:51 AM, Aaro Koskinen wrote:
[...]
>
>> Thanks for doing this, I had been meaning to make the conversion myself.
>
> One further improvement idea would be to get the register dump logged
> also with printk() or panic() so that it could be captured with netconsole
> or mtdoops (at least in some cases). Not sure what it would require.
> Calling printk() or panic() from the NMI handler didn't quite produce
> an expected result...

In the handler we are running with a private stack, and at 
CP0_Status[ERL].  The result is that no access to the current task 
structure is possible, and interrupts are disabled.  So there is very 
little you can do.

Polling characters out of the UART works fine though.


>
> A.
>

