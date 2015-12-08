Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2on0060.outbound.protection.outlook.com ([65.55.169.60]:55072
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932837AbbLHIOg (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 Dec 2015 03:14:36 -0500
Date: Tue, 8 Dec 2015 16:15:25 +0800
From: Huang Rui <ray.huang@amd.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, Borislav Petkov <bp@alien8.de>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: An issue about sp5100 watchdog
Message-ID: <20151208081523.GA12973@hr-amur2>
References: <20151208054232.GC10759@hr-amur2>
 <566680C3.2000501@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <566680C3.2000501@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Dec 07, 2015 at 11:03:31PM -0800, Guenter Roeck wrote:
> On 12/07/2015 09:42 PM, Huang Rui wrote:
> >Hi all,
> >
> >I found an issue in some of AMD platforms about sp5100, that the MMIO
> >address (0x51413120) is already used by System RAM
> >(00100000-7c2befff)...
> >
> >[   29.928096] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
> >[   29.928302] sp5100_tco: PCI Vendor ID: 0x1022, Device ID: 0x790b, Revision ID: 0x4a
> >[   29.928319] sp5100_tco: Got 0x51413120 from indirect I/O
> >[   29.928323] sp5100_tco: MMIO address 0x51413120 already in use
> >[   29.928332] sp5100_tco: SBResource_MMIO is disabled(0xe000a0)
> >[   29.928333] sp5100_tco: failed to find MMIO address, giving up.
> >
> If I understand the code correctly, the problem is really "SBResource_MMIO is disabled".
> Presumably that is done in the BIOS. No idea if anything can be done about that.
> 

Thank you.

Compared with correct message:

00100000-3e4befff : System RAM
  01000000-017b1ab3 : Kernel code
  017b1ab4-01d4ce7f : Kernel data
  01ec4000-02008fff : Kernel bss
3e4bf000-3e8befff : reserved
3e8bf000-3ebbefff : ACPI Non-volatile Storage
3ebqbf000-3ebfefff : ACPI Tables
3ebff000-3ebfffff : System RAM
3ec00000-7effffff : reserved
  51413120-51413127 : SB800 TCO         <- here
7f000000-f7ffffff : PCI Bus 0000:00

SB800 TCO area is reserved. Then it doesn't find MMIO address from
SBResource_MMIO register...

Thanks,
Rui

> Guenter
> 
> >00100000-7c2befff : System RAM
> >   01000000-017b1ab3 : Kernel code
> >   017b1ab4-01d4ce7f : Kernel data
> >   01ec4000-02008fff : Kernel bss
> >7c2bf000-7c8befff : reserved
> >7c8bf000-7cbbefff : ACPI Non-volatile Storage
> >   7cbb6000-7cbb9fff : MSFT0101:00
> >   7cbba000-7cbbdfff : MSFT0101:00
> >7cbbf000-7cbfefff : ACPI Tables
> >7cbff000-7cbfffff : System RAM
> >7cc00000-7effffff : reserved
> >
> >Any idea?
> >
> >Thanks,
> >Rui
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
