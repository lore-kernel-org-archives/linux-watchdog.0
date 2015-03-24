Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:56254 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751713AbbCXITq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Mar 2015 04:19:46 -0400
Date: Tue, 24 Mar 2015 09:19:44 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-watchdog@vger.kernel.org, James Hogan <james@albanarts.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	Jude Abraham <Jude.Abraham@imgtec.com>
Subject: Re: [PATCH 0/2] watchdog: imgpdc: Runtime fixes
Message-ID: <20150324081944.GB1716@spo001.leaseweb.nl>
References: <1424475945-30009-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424475945-30009-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi James,

> A couple of basic runtime fixes for the IMG PDC watchdog driver. These
> were found by attempting to enable the driver for TZ1090 and running
> under Meta QEMU. Note that QEMU doesn't emulate the actual watchdog
> functionality beyond the soft reset register, so I cannot claim to have
> tested the driver's watchdog timer functionality yet.
> 
> James Hogan (2):
>   watchdog: imgpdc: Fix probe NULL pointer dereference
>   watchdog: imgpdc: Fix default heartbeat
> 
>  drivers/watchdog/imgpdc_wdt.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Cc: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> Cc: Jude Abraham <Jude.Abraham@imgtec.com>
> Cc: linux-watchdog@vger.kernel.org

Both patches added to linux-watchdog-next. Will go upstream in 2 days.

Kind regards,
Wim.

