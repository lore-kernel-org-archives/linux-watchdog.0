Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59769 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab3FAI4Q (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 1 Jun 2013 04:56:16 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Johannes Thumshirn <johannes.thumshirn@men.de>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] watchdog: New watchdog driver for MEN A21 watchdogs
Date: Sat, 01 Jun 2013 10:56:16 +0200
Message-ID: <2637599.Z6OQQQSYxb@wuerfel>
In-Reply-To: <20130531085842.GA8572@jtlinux>
References: <20130531085842.GA8572@jtlinux>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Friday 31 May 2013 10:58:48 Johannes Thumshirn wrote:
> This patch adds the driver for the watchdog devices found on MEN Mikro
> Elektronik A21 VMEbus CPU Carrier Boards. It has DT-support and uses the
> watchdog framework.
> 

It seems the DT support is rather incomplete


> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@men.de>
> ---
>  MAINTAINERS                   |    6 ++
>  drivers/watchdog/Kconfig      |    8 ++
>  drivers/watchdog/Makefile     |    1 +

Please add a binding document to Documentation/devicetree/bindings/

> +
> +#define GPIO_WD_ENAB	169
> +#define GPIO_WD_FAST	170
> +#define GPIO_WD_TRIG	171
> +
> +#define GPIO_RST_CAUSE_BASE 166

You should never hardwire GPIO numbers like this. There is a DT binding
for GPIO, so use that to get the number of the tree.

	Arnd
