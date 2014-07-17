Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:63492 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072AbaGQKjM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 17 Jul 2014 06:39:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Richard Weinberger <richard@nod.at>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dmitry.torokhov@gmail.com, linux-iio@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, teg@jklm.no,
	Thierry Reding <thierry.reding@gmail.com>,
	Lennox Wu <lennox.wu@gmail.com>, Marek Vasut <marex@denx.de>,
	Liqin Chen <liqin.linux@gmail.com>, msalter@redhat.com,
	linux-pwm@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	knaack.h@gmx.de, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Mischa.Jonker@synopsys.com, jic23@kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for 'devm_ioremap_resource'
Date: Thu, 17 Jul 2014 12:38:47 +0200
Message-ID: <7018119.hVYUML2rzD@wuerfel>
In-Reply-To: <53C7977B.9090903@gmail.com>
References: <201407130545.23004.marex@denx.de> <6823014.2plXDE9VA9@wuerfel> <53C7977B.9090903@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thursday 17 July 2014 17:29:31 Chen Gang wrote:
> > 
> > COMPILE_TEST is a great tool in general, but it has its limits.
> > In particular, the case for !CONFIG_IOMEM is completely obscure
> > and we won't find any bugs by allowing more drivers to be built
> > in those configurations, but attempting to do it would cause
> > endless churn by changing each instance of 'depends on HAS_IOMEM'
> > to 'depends on HAS_IOMEM || COMPILE_TEST'.
> >
> 
> Architecture members and driver members really have different tastes,
> they are different roles. It really need additional discussion.
> 
> For me, I only want to change devm_io*map*, not touch so much.

But what do you gain from that? All drivers that need these
functions should already 'depends on HAS_IOMEM' and if they don't,
we should fix /that/ instead. I don't see this dependency as any
different from a lot of others (PCI, DMAENGINE, HAVE_CLK, ...)
that we use to intentionally annotate drivers that need a particular
feature to be present for compilation. Do you want to do the
same hack to those?

> Welcome any other members' idea or suggestions.

> > Note that s390 no has gained support for IOMEM, tile has it most
> > of the time (when PCI is enabled, so you get it in half the
> > test builds already), score should set HAS_IOMEM and doesn't
> > even have public compilers, and uml doesn't even compile in
> > latest mainline. Nothing else ever sets NO_IOMEM.
> > 
> 
> In latest gcc and binutils, can compile score cross compiler
> successfully for building kernel (but I am not quite sure whether the
> compiling result are really OK, but I guess so).

Ok. Would you mind sending a patch that enables HAS_IOMEM on
score?
 
> And next (maybe after finish allmodconfig for microblaze), I shall try
> to let uml pass allmodconfig for linux-next tree.

That is a fair goal, but it seems better to do that by ensuring
we don't build any code that tries to call the MMIO functions
rather than trying to make them build.

	Arnd
