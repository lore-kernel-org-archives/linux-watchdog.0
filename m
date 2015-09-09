Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52627 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751119AbbIIViO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 9 Sep 2015 17:38:14 -0400
Date: Wed, 9 Sep 2015 23:38:10 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Ariel D'Alessandro <ariel@vanguardiasur.com.ar>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Fengguang Wu <fengguang.wu@intel.com>,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	Greta Zhang <greta.zhang@mediatek.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Pratyush Anand <panand@redhat.com>,
	Timur Tabi <timur@codeaurora.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Wenyou Yang <wenyou.yang@atmel.com>
Subject: Re: [GIT PULL REQUEST] watchdog - v4.3-rc1 merge window
Message-ID: <20150909213810.GL3237@piout.net>
References: <20150909195838.GA12688@spo001.leaseweb.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150909195838.GA12688@spo001.leaseweb.nl>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

On 09/09/2015 at 21:58:38 +0200, Wim Van Sebroeck wrote :
> commit ab54d7f017772e89964d4040937a83cd4468562a
> Author: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Date:   Fri Jul 31 11:39:39 2015 +0200
> 
>     Documentation: watchdog: at91sam9_wdt: add clocks property
>     
>     The watchdog has an input clock, the slow clock. It is required as it will
>     not function without it.
>     
>     Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>     Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 

Actually, that patch went through the at91 and then the arm-soc tree and
has already been pulled by Linus.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
