Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:39300 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751774Ab3J2Hjg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Oct 2013 03:39:36 -0400
Date: Tue, 29 Oct 2013 08:39:35 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: John Crispin <blogic@openwrt.org>
Cc: linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] watchdog: MIPS: add ralink watchdog driver
Message-ID: <20131029073935.GD19569@spo001.leaseweb.com>
References: <1375954303-28830-1-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1375954303-28830-1-git-send-email-blogic@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi John,

> Add a driver for the watchdog timer found on Ralink SoC
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---
>  drivers/watchdog/Kconfig      |    7 ++
>  drivers/watchdog/Makefile     |    1 +
>  drivers/watchdog/rt2880_wdt.c |  208 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 216 insertions(+)
>  create mode 100644 drivers/watchdog/rt2880_wdt.c

This patch (together with the DT binding part) has been added as 1 patch to linux-watchdog-next.

Kind regards,
Wim.

