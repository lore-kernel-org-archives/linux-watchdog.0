Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay010.isp.belgacom.be ([195.238.6.177]:27349 "EHLO
	mailrelay010.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751758Ab1KNMmM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Nov 2011 07:42:12 -0500
Date: Mon, 14 Nov 2011 13:39:14 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 10/12] ARM: at91: make watchdog drivers soc independent
Message-ID: <20111114123914.GG11844@infomag.iguana.be>
References: <20111113180954.GD15318@game.jcrosoft.org> <1321207952-13556-10-git-send-email-plagnioj@jcrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1321207952-13556-10-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jean-Christophe,

> switch the watchdog drivers to resource and pass it via platform_device
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: linux-watchdog@vger.kernel.org
> ---
> HI Wim,
> 
> 	this is part of a at91 cleanup
> 	if you don't mind I'll apply via at91 tree
> 

You have my signed-off-by for the watchdog part. This should indeed go via the at91 tree.

Kind regards,
Wim.

