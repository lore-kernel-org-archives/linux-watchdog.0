Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43468 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeHCRgm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Aug 2018 13:36:42 -0400
Subject: Re: linux-next: Tree for Aug 3 (watchdog/menz69_wdt.c)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        linux-watchdog@vger.kernel.org
References: <20180803192942.6975df0c@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9d17144d-6f19-781f-8abc-1ee1c6f840bd@infradead.org>
Date: Fri, 3 Aug 2018 08:39:48 -0700
MIME-Version: 1.0
In-Reply-To: <20180803192942.6975df0c@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/03/2018 02:29 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180802:
> 

Hi,

On i386 randconfig with COMPILE_TEST=y and MCB not enabled, I see:

drivers/watchdog/menz69_wdt.o: In function `men_z069_remove':
menz69_wdt.c:(.text+0xa6): undefined reference to `mcb_release_mem'
drivers/watchdog/menz69_wdt.o: In function `men_z069_probe':
menz69_wdt.c:(.text+0xdb): undefined reference to `mcb_request_mem'
menz69_wdt.c:(.text+0x14a): undefined reference to `mcb_release_mem'
drivers/watchdog/menz69_wdt.o: In function `men_z069_driver_init':
menz69_wdt.c:(.init.text+0x15): undefined reference to `__mcb_register_driver'
drivers/watchdog/menz69_wdt.o: In function `men_z069_driver_exit':
menz69_wdt.c:(.exit.text+0x9): undefined reference to `mcb_unregister_driver'


The Kconfig for MENZ069_WATCHDOG says:
config MENZ069_WATCHDOG
	tristate "MEN 16Z069 Watchdog"
	depends on MCB || COMPILE_TEST
	select WATCHDOG_CORE

Looks to me like the driver really depends on MCB, unless someone wants
to add stubs in <linux/mcb.h>.

-- 
~Randy
