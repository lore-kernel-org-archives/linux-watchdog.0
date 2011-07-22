Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:5420 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751123Ab1GVSvU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 Jul 2011 14:51:20 -0400
Date: Fri, 22 Jul 2011 20:51:18 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] Add watchdog driver for Intel E6XX
Message-ID: <20110722185118.GH31767@infomag.iguana.be>
References: <20110701110002.GA9326@infomag.iguana.be> <1309786148-5138-2-git-send-email-alexander.stein@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1309786148-5138-2-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alexander,

> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
> Changes in v2:
> * Changed subject to use E6XX instead of tunnelcreek
> * Changed driver name to ie6xx_wdt
> 
>  drivers/watchdog/Kconfig     |   12 ++
>  drivers/watchdog/Makefile    |    1 +
>  drivers/watchdog/ie6xx_wtd.c |  446 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 459 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/watchdog/ie6xx_wtd.c

2 remarks:
1) please fix the lines that are over 80 characters. (please use scripts/checkpatch.pl)
2) on opening /dev/watchdog your watchdog should start working. Now you have to open the device
and write to it before it starts. That's not what the watchdog API says...

Kind regards,
Wim.

