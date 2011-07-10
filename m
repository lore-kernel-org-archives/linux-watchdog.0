Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33826 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628Ab1GJKm3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 10 Jul 2011 06:42:29 -0400
Date: Sun, 10 Jul 2011 11:42:15 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: vkuzmichev@mvista.com, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>, arm@kernel.org,
	linux-kernel@vger.kernel.org, John Stultz <johnstul@us.ibm.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 6/6] mpcore_wdt: Move declarations in a separate
	header
Message-ID: <20110710104215.GC4812@n2100.arm.linux.org.uk>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com> <201107061358.48496.arnd@arndb.de> <4E1456D9.8090003@mvista.com> <201107061448.49092.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201107061448.49092.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jul 06, 2011 at 02:48:48PM +0200, Arnd Bergmann wrote:
> An obvious choice would be arch/arm/include/asm/smp_twd.h.

Not if its moving out of arch/arm, but that's a separate debate to be
had.
