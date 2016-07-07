Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36372 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbcGGNMS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Jul 2016 09:12:18 -0400
Received: by mail-qk0-f194.google.com with SMTP id r68so1845278qka.3
        for <linux-watchdog@vger.kernel.org>; Thu, 07 Jul 2016 06:12:18 -0700 (PDT)
MIME-Version: 1.0
Reply-To: ioanm@linux.com
From: Ioan Moldovan <ioan.moldovan1999@gmail.com>
Date: Thu, 7 Jul 2016 16:12:17 +0300
Message-ID: <CAH2idReJfXsd3QWvpRKnaLpw_isURt2p81VdGpPEU9dPnPHQpA@mail.gmail.com>
Subject: I/O address 0x0cd6 already in use
To: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

At every boot of my PC I noticed the following error telling me the IO
address 0x0cd6 is already in use:

[    6.083233] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
[    6.083292] sp5100_tco: PCI Vendor ID: 0x1022, Device ID: 0x780b,
Revision ID: 0x16
[    6.083296] sp5100_tco: I/O address 0x0cd6 already in use

Not being a kernel developer, I have no way to fix this.

CPU Details:
vendor_id    : AuthenticAMD
cpu family    : 21
model        : 48
model name    : AMD Athlon(tm) X4 860K Quad Core Processor
stepping    : 1
microcode    : 0x6003104
