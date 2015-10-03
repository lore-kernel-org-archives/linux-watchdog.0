Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:43049 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752075AbbJCP5N (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 3 Oct 2015 11:57:13 -0400
Date: Sat, 3 Oct 2015 17:57:09 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Harald Geyer <harald@ccbib.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Wim Van Sebroeck <wim@iguana.be>, rtc-linux@googlegroups.com,
	linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] rtc: stmp3xxx: unify register access macros
Message-ID: <20151003155709.GE2694@piout.net>
References: <1443817082-24370-1-git-send-email-harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1443817082-24370-1-git-send-email-harald@ccbib.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/10/2015 at 20:18:01 +0000, Harald Geyer wrote :
> Use STMP_OFFSET_REG_(SET|CLR) instead of defining _SET and _CLR for
> STMP3XXX_RTC_CTRL and STMP3XXX_RTC_PERSISTENT0 - no functional changes.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
>  drivers/rtc/rtc-stmp3xxx.c |   27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
