Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:60555 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757381Ab1FVSUN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jun 2011 14:20:13 -0400
Date: Wed, 22 Jun 2011 20:20:10 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-watchdog@vger.kernel.org,
	wdevicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
	kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org
Subject: Re: [PATCH] watchdog: s3c2410: Add support for device tree based
	probe
Message-ID: <20110622182010.GA7581@infomag.iguana.be>
References: <1308736472-22380-1-git-send-email-thomas.abraham@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1308736472-22380-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Thomas,

> This patch adds the of_match_table to enable s3c2410-wdt driver
> to be probed when watchdog device node is found in the device tree.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Added to linux-2.6-watchdog-next.

Kind regards,
Wim.

