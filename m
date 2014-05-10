Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:54699 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754716AbaEJAiD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 9 May 2014 20:38:03 -0400
Message-ID: <536D74E3.8010609@infradead.org>
Date: Fri, 09 May 2014 17:37:55 -0700
From: Randy Dunlap <rdunlap@infradead.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
CC: Wim Van Sebroeck <wim@iguana.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Russell King <linux@arm.linux.org.uk>,
	Jonas Jensen <jonas.jensen@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] watchdog: Add reboot API
References: <1399681883-891-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1399681883-891-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/09/2014 05:31 PM, Guenter Roeck wrote:
> Some hardware implements reboot through its watchdog hardware, for example
> by triggering a watchdog timeout or by writing into its watchdog register
> set. Platform specific code starts to spread into watchdog drivers,
> typically by setting pointers to a callback function which is then called
> from the architecture's reset handler.

No updates to Documentation/watchdog/ ?

-- 
~Randy
