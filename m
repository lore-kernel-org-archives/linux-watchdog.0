Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:37090 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbcEWTED (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 May 2016 15:04:03 -0400
MIME-Version: 1.0
In-Reply-To: <484d20f0a177f48a6d9a93520933b830d4412cca.1464014576.git.vilhelm.gray@gmail.com>
References: <cover.1464014576.git.vilhelm.gray@gmail.com>
	<484d20f0a177f48a6d9a93520933b830d4412cca.1464014576.git.vilhelm.gray@gmail.com>
Date: Mon, 23 May 2016 11:03:14 -0700
Message-ID: <CA+55aFxQqxPUP1ppvsR4XOg9x7P-uTUXt6gjHd0actsJKdY1-w@mail.gmail.com>
Subject: Re: [PATCH 1/4] isa: Allow ISA-style drivers on modern systems
From: Linus Torvalds <torvalds@linux-foundation.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"the arch/x86 maintainers" <x86@kernel.org>,
	linux-next <linux-next@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, May 23, 2016 at 7:58 AM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> For now, the ISA_BUS Kconfig option is only be available on X86
> architectures. Support for other architectures may be added as required.

So I'd prefer to see that

> +config ISA_BUS_API
> +       def_bool ISA

part in arch/Kconfig.

Why?

Because other architectures _already_ define that ISA symbol, and we
want the "ISA_BUS_API" to be a complete superset of ISA.

So whenever ISA is enabled, ISA_BUS_API should be enabled.

And the way you did that, that's not true. Now, if you were to enable
ISA on ARM, you'd not get ISA_BUS_API. And that sounds insane to me.
It also sounds *wrong* because it effectively changes the meaning of
this:

  --- a/drivers/base/Makefile
  +++ b/drivers/base/Makefile
  @@ -10,7 +10,7 @@ obj-$(CONFIG_DMA_CMA) += dma-contiguous.o
  -obj-$(CONFIG_ISA)      += isa.o
  +obj-$(CONFIG_ISA_BUS_API)      += isa.o

where now that "isa.c" file gets built only on x86, whereas it *used*
to get built whenever ISA was enabled.

So the reason I suggested a separate ISA_BUS_API config option (that
then a particular architecture can choose to enable, in this case the
x86 choice of selecting ISA_BUS) was _exactly_ this issue. The plain
"ISA" config variable is not limited to x86, and the new subset of it
(the ISA_BUS_API) thus also must not be limited to just x86.

               Linus
