Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] watchdog fixes for COMPILE_TEST change
Date: Tue, 28 Feb 2017 22:01:15 +0100
Message-Id: <20170228210123.3404816-1-arnd@arndb.de>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

I noticed your change to enable lots of watchdog drivers for compile
testing in linux-next today. While this is generally a great idea,
I'm not entirely sure why this appeared during the merge window.

I case you plan to have this merged into v4.11, please make sure
to get the fixups in. I found eight drivers that now have incorrect
dependencies. For two of them I changed the MFD code, for the others
I just adapted the Kconfig dependencies, mostly by reverting
part of your patch.

    Arnd
