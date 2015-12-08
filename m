Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58845 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932744AbbLHHDe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 Dec 2015 02:03:34 -0500
Subject: Re: An issue about sp5100 watchdog
To: Huang Rui <ray.huang@amd.com>, Wim Van Sebroeck <wim@iguana.be>
References: <20151208054232.GC10759@hr-amur2>
Cc: Borislav Petkov <bp@alien8.de>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <566680C3.2000501@roeck-us.net>
Date: Mon, 7 Dec 2015 23:03:31 -0800
MIME-Version: 1.0
In-Reply-To: <20151208054232.GC10759@hr-amur2>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/07/2015 09:42 PM, Huang Rui wrote:
> Hi all,
>
> I found an issue in some of AMD platforms about sp5100, that the MMIO
> address (0x51413120) is already used by System RAM
> (00100000-7c2befff)...
>
> [   29.928096] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
> [   29.928302] sp5100_tco: PCI Vendor ID: 0x1022, Device ID: 0x790b, Revision ID: 0x4a
> [   29.928319] sp5100_tco: Got 0x51413120 from indirect I/O
> [   29.928323] sp5100_tco: MMIO address 0x51413120 already in use
> [   29.928332] sp5100_tco: SBResource_MMIO is disabled(0xe000a0)
> [   29.928333] sp5100_tco: failed to find MMIO address, giving up.
>
If I understand the code correctly, the problem is really "SBResource_MMIO is disabled".
Presumably that is done in the BIOS. No idea if anything can be done about that.

Guenter

> 00100000-7c2befff : System RAM
>    01000000-017b1ab3 : Kernel code
>    017b1ab4-01d4ce7f : Kernel data
>    01ec4000-02008fff : Kernel bss
> 7c2bf000-7c8befff : reserved
> 7c8bf000-7cbbefff : ACPI Non-volatile Storage
>    7cbb6000-7cbb9fff : MSFT0101:00
>    7cbba000-7cbbdfff : MSFT0101:00
> 7cbbf000-7cbfefff : ACPI Tables
> 7cbff000-7cbfffff : System RAM
> 7cc00000-7effffff : reserved
>
> Any idea?
>
> Thanks,
> Rui
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

