Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:59399 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbcEAV1A (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 1 May 2016 17:27:00 -0400
Date: Sun, 1 May 2016 14:26:57 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: tglx@linutronix.de, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, wim@iguana.be,
	linux@roeck-us.net, linus.walleij@linaro.org, gnurou@gmail.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 00/10] Use the ISA bus driver for PC/104 and ISA devices
Message-ID: <20160501212657.GC8337@kroah.com>
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1460040201.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Apr 07, 2016 at 10:47:21AM -0400, William Breathitt Gray wrote:
> This patchset is based on top of commit 3a3a5fece6f2 ("fs: kernfs: Replace
> CURRENT_TIME by current_fs_time()") of the driver-core-next branch of the
> driver-core repository.
> 
> Two new ISA bus driver macros are introduced in this patchset:
> module_isa_driver and max_num_isa_dev.
> 
> The module_isa_driver macro is a helper macro for ISA drivers which do not
> do anything special in module init/exit. This macro is modelled after the
> module_pci_driver macro and eliminates a lot of module init/exit
> boilerplate code.
> 
> The max_num_isa_dev macro is used to determine the maximum possible number
> of ISA devices which may be registered in the I/O port address space given
> the address extent of the ISA devices. This macro is useful for computing
> the maximum number of elements necessary to hold the base addresses and
> interrupt line numbers of ISA devices for the respective ISA driver.
> 
> Lacking other documentation, I often found myself repeatedly returning to
> the commit message of the initial commit for drivers/base/isa.c authored by
> Rene Herman. A verbatim copy of this commit message has been added to
> Documentation/isa.txt, along with descriptions for the module_isa driver
> and max_num_isa_dev macros, for posterity.
> 
> The Apex Embedded Systems STX104 may be used on 64-bit X86 systems. This
> patchset allows the Apex Embedded Systems STX104 DAC driver to be compiled
> for both 32-bit and 64-bit X86 systems by depending on the ISA_BUS
> configuration option rather than the ISA configuration option.
> 
> Similarly, many PC/104 and ISA devices may also be used on 64-bit X86
> systems. The platform driver had been used to enable support for these
> devices on 64-bit X86 systems. With the introduction of the ISA_BUS
> configuration option, the respective drivers for these devices may now
> utilize the ISA bus driver without restricting support to only 32-bit X86
> systems; the following drivers now utilize the ISA bus driver over the
> platform driver:
> 
>  * WinSystems EBC-C384 watchdog timer
>  * ACCES 104-DIO-48E GPIO driver
>  * ACCES 104-IDI-48 GPIO driver
>  * ACCES 104-IDIO-16 GPIO driver
>  * WinSystems WS16C48 GPIO driver
> 
> With the utilization of the ISA bus driver, the GPIO drivers in this
> patchset may now support multiple devices for each of their respective ISA
> drivers. A naming convention for module array parameters has been set based
> on the Apex Embedded Systems STX104 DAC driver.
> 
> The "base" array module parameter sets the I/O port base address of each
> device. The "irq" array module parameter sets the interrupt line number of
> each device. Each element of the "base" array corresponds to a discrete
> device; each element of the "irq" array corresponds to the respective
> device addressed in the respective "base" array element.

Can you fix up the MAINTAINERS patch, add the ACKs you received, and
resend this series so that I can apply it?

thanks,

greg k-h
