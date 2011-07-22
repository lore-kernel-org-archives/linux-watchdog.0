Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:43635 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753830Ab1GVRrS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 Jul 2011 13:47:18 -0400
Date: Fri, 22 Jul 2011 19:47:09 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Alejandro Cabrera <acabrera@udio.cujae.edu.cu>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] Add Xilinx watchdog timer driver
Message-ID: <20110722174709.GA31767@infomag.iguana.be>
References: <201106022213.11201.acabrera@udio.cujae.edu.cu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201106022213.11201.acabrera@udio.cujae.edu.cu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alejandro,

> Watchdog timer device driver for Xilinx xps_timebase_wdt compatible ip cores.
> It takes watchdog timer configuration from device tree and it needs that its
> parent has defined the property "clock-frecuency".
> It is compatible with watchdog timer kernel API, so user apps like watchdogd
> may talk with it.
> 
> Signed-off-by: Alejandro Cabrera <aldaya@gmail.com>
> ---
>  drivers/watchdog/Kconfig         |   14 ++
>  drivers/watchdog/Makefile        |    3 +
>  drivers/watchdog/of_xilinx_wdt.c |  433 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 450 nsertions(+), 0 deletions(-)
>  create mode 100644 drivers/watchdog/of_xilinx_wdt.c

Added to linux-2.6-watchdog-next. (Made 1 small change: misc_deregister should be called before iounmap en release_region).

Kind regards,
Wim.

