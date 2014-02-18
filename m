Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:55352 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbaBRQcU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Feb 2014 11:32:20 -0500
Message-ID: <53038B13.2000709@roeck-us.net>
Date: Tue, 18 Feb 2014 08:32:19 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Fabio Estevam <fabio.estevam@freescale.com>, wim@iguana.be
CC: olof@lixom.net, festevam@gmail.com, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: orion_wdt: Use %pa to print 'phys_addr_t'
References: <1392726234-16977-1-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1392726234-16977-1-git-send-email-fabio.estevam@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/18/2014 04:23 AM, Fabio Estevam wrote:
> When building an ARM multi_v7_defconfig with LPAE option selected we get the
> following build warning:
>
> drivers/watchdog/orion_wdt.c:272:2: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'phys_addr_t' [-Wformat=]
>
> Fix it by using %pa to print 'phys_addr_t'.
>
> Reported-by: Olof's autobuilder <build@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

