Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1on0089.outbound.protection.outlook.com ([157.56.110.89]:13488
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751471AbbLHF4l (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 Dec 2015 00:56:41 -0500
Date: Tue, 8 Dec 2015 13:42:33 +0800
From: Huang Rui <ray.huang@amd.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
CC: Borislav Petkov <bp@alien8.de>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: An issue about sp5100 watchdog
Message-ID: <20151208054232.GC10759@hr-amur2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi all,

I found an issue in some of AMD platforms about sp5100, that the MMIO
address (0x51413120) is already used by System RAM
(00100000-7c2befff)...

[   29.928096] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
[   29.928302] sp5100_tco: PCI Vendor ID: 0x1022, Device ID: 0x790b, Revision ID: 0x4a
[   29.928319] sp5100_tco: Got 0x51413120 from indirect I/O
[   29.928323] sp5100_tco: MMIO address 0x51413120 already in use
[   29.928332] sp5100_tco: SBResource_MMIO is disabled(0xe000a0)
[   29.928333] sp5100_tco: failed to find MMIO address, giving up.

00100000-7c2befff : System RAM
  01000000-017b1ab3 : Kernel code
  017b1ab4-01d4ce7f : Kernel data
  01ec4000-02008fff : Kernel bss
7c2bf000-7c8befff : reserved
7c8bf000-7cbbefff : ACPI Non-volatile Storage
  7cbb6000-7cbb9fff : MSFT0101:00
  7cbba000-7cbbdfff : MSFT0101:00
7cbbf000-7cbfefff : ACPI Tables
7cbff000-7cbfffff : System RAM
7cc00000-7effffff : reserved

Any idea?

Thanks,
Rui
