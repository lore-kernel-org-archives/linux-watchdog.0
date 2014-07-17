Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65278 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbaGQSJ0 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 17 Jul 2014 14:09:26 -0400
Message-ID: <53C8114D.30601@nod.at>
Date: Thu, 17 Jul 2014 20:09:17 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, Lars-Peter Clausen <lars@metafoo.de>
CC: Chen Gang <gang.chen.5i5j@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
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
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
References: <201407130545.23004.marex@denx.de> <6823014.2plXDE9VA9@wuerfel> <53C7A819.40403@metafoo.de> <6485666.LVFO2YCEQx@wuerfel>
In-Reply-To: <6485666.LVFO2YCEQx@wuerfel>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Am 17.07.2014 12:48, schrieb Arnd Bergmann:
> AFAICT, NO_IOMEM only has a real purpose on UML these days. Could we take
> a shortcut here and make COMPILE_TEST depend on !UML? Getting random stuff
> to build on UML seems pointless to me and we special-case it in a number of
> places already.

If UML is the only arch without io memory the dependency on !UML seems
reasonable to me. :-)

Thanks,
//richard
