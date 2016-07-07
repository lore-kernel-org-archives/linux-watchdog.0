Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43257 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbcGGPOg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Jul 2016 11:14:36 -0400
Subject: Re: I/O address 0x0cd6 already in use
To: ioanm@linux.com, linux-watchdog@vger.kernel.org
References: <CAH2idReJfXsd3QWvpRKnaLpw_isURt2p81VdGpPEU9dPnPHQpA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <577E71D0.3030207@roeck-us.net>
Date: Thu, 7 Jul 2016 08:14:24 -0700
MIME-Version: 1.0
In-Reply-To: <CAH2idReJfXsd3QWvpRKnaLpw_isURt2p81VdGpPEU9dPnPHQpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/07/2016 06:12 AM, Ioan Moldovan wrote:
> At every boot of my PC I noticed the following error telling me the IO
> address 0x0cd6 is already in use:
>
> [    6.083233] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
> [    6.083292] sp5100_tco: PCI Vendor ID: 0x1022, Device ID: 0x780b,
> Revision ID: 0x16
> [    6.083296] sp5100_tco: I/O address 0x0cd6 already in use
>
> Not being a kernel developer, I have no way to fix this.
>

You probably won't be able to fix it. Try "sudo cat /proc/ioports";
it might tell you who is using that io address space.

Guenter

> CPU Details:
> vendor_id    : AuthenticAMD
> cpu family    : 21
> model        : 48
> model name    : AMD Athlon(tm) X4 860K Quad Core Processor
> stepping    : 1
> microcode    : 0x6003104
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

