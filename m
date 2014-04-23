Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.130]:56457 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475AbaDWQBS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Apr 2014 12:01:18 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: wim@iguana.be, dbaryshkov@gmail.com, dwmw2@infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 4/5] ARM: sunxi: Remove reset code from the platform
Date: Wed, 23 Apr 2014 18:00:24 +0200
Message-ID: <10836281.Wx7YzfuubV@wuerfel>
In-Reply-To: <1398265476-29373-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1398265476-29373-1-git-send-email-maxime.ripard@free-electrons.com> <1398265476-29373-5-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wednesday 23 April 2014 17:04:35 Maxime Ripard wrote:
> Now that reset is handled either by the watchdog driver for the sun4i, sun5i
> and sun7i, and by a driver of its own for sun6i, we can remove it from the
> platform code.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-sunxi/sunxi.c | 98 ---------------------------------------------
>  1 file changed, 98 deletions(-)
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
