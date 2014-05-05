Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 0/5] watchdog: Add reboot API
Date: Mon, 5 May 2014 20:26:32 +0200
Cc: linux-watchdog@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Wim Van Sebroeck <wim@iguana.be>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Will Deacon <will.deacon@arm.com>,
 Russell King <linux@arm.linux.org.uk>,
 Jonas Jensen <jonas.jensen@gmail.com>,
 linux-kernel@vger.kernel.org
References: <1398958893-30049-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1398958893-30049-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201405052026.32666.arnd@arndb.de>
List-ID: <linux-watchdog@vger.kernel.org>

On Thursday 01 May 2014, Guenter Roeck wrote:
> 
> Some hardware implements reboot through its watchdog hardware, for example
> by triggering a watchdog timeout or by writing into its watchdog register
> set. Platform specific code starts to spread into watchdog drivers,
> typically by setting pointers to a callback function which is then called
> from the architecture's reset handler.

Looks very nice to me, thanks for starting this!

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
